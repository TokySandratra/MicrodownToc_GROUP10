Class {
	#name : 'SimpleTOCGenerator',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'contents',
		'minLevel',
		'numberingEnabled',
		'currentNumber',
		'entries'
	],
	#category : 'Microdown-Visitor',
	#package : 'Microdown',
	#tag : 'Visitor'
}

{ #category : 'as yet unclassified' }
SimpleTOCGenerator >> anchorFromTitle: aString [
	^ '#' , ((aString asLowercase copyReplaceAll: ' ' with: '-'))

]

{ #category : 'initialization' }
SimpleTOCGenerator >> contents [ 
	^ contents contents 
	
]

{ #category : 'accessing' }
SimpleTOCGenerator >> entries [
    ^ entries
]

{ #category : 'as yet unclassified' }
SimpleTOCGenerator >> htmlTOC [
    | builder |
    builder := String new writeStream.
    builder nextPutAll: '<ul>'; cr.

    entries do: [ :each |
        builder nextPutAll: '<li>';
            nextPutAll: '<a href="';
            nextPutAll: each link;
            nextPutAll: '">';
            nextPutAll: each title;
            nextPutAll: '</a>';
            nextPutAll: '</li>'; cr ].

    builder nextPutAll: '</ul>'.
    ^ builder contents

]

{ #category : 'initialization' }
SimpleTOCGenerator >> initialize [ 
	super initialize. 
	contents := String new writeStream.
	minLevel := 0.
	numberingEnabled := false.
	currentNumber := 0.
	entries := OrderedCollection new
]

{ #category : 'as yet unclassified' }
SimpleTOCGenerator >> microdownTOC [
	| builder |
	builder := String new writeStream.

	(self contents lines) do: [ :eachLine |
		| trimmed |
		trimmed := eachLine trimBoth.
		trimmed isEmpty ifFalse: [
			builder
				cr;
				nextPutAll: '# ';
				nextPutAll: trimmed ] ].

	^ builder contents

]

{ #category : 'as yet unclassified' }
SimpleTOCGenerator >> numbered [
	numberingEnabled := true
]

{ #category : 'initialization' }
SimpleTOCGenerator >> showOnlyAbove: aLevel [
	minLevel  := aLevel 
]

{ #category : 'visiting' }
SimpleTOCGenerator >> visitHeader: aHeader [
	| level |
	level := aHeader level.
	(minLevel = 0 or: [level <= minLevel ]) ifTrue: [
		"Créer une entrée de TOC"
       entries add: (TocEntry new
            title: aHeader header;
            level: level;
				link: (self anchorFromTitle: aHeader header);
            yourself).

		contents cr.
		
		numberingEnabled 
			ifTrue: [ 
				currentNumber := currentNumber + 1.
				contents
					nextPutAll: currentNumber asString;
					nextPut: Character space;
					nextPutAll: aHeader header
				 ]
			ifFalse: [ 
				"Version de TOC indenté"
				1 to: level - 1 do: [ :i | contents nextPutAll: '  ' ].
				"Texte du titre "
				contents nextPutAll: aHeader header ]  "ou aHeader text, aHeader label..."
			].
		

		
	"On continue à visiter les enfants comme dans MicrodownVisitor"
	aHeader headerElements do: [ :each | each accept: self ]

]
