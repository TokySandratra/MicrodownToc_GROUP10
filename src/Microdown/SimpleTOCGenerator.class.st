Class {
	#name : 'SimpleTOCGenerator',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'contents',
		'minLevel'
	],
	#category : 'Microdown-Visitor',
	#package : 'Microdown',
	#tag : 'Visitor'
}

{ #category : 'initialization' }
SimpleTOCGenerator >> contents [ 
	^ contents contents 
	
]

{ #category : 'initialization' }
SimpleTOCGenerator >> initialize [ 
	super initialize. 
	contents := String new writeStream.
	minLevel := 0.
]

{ #category : 'initialization' }
SimpleTOCGenerator >> showOnlyAbove: aLevel [
	minLevel  := aLevel 
]

{ #category : 'visiting' }
SimpleTOCGenerator >> visitHeader: aHeader [
	| level |
	level := aHeader level.
	(level > minLevel) ifTrue: [
		contents cr.
		
		"Indentation en fonction du niveau"
		1 to: level - 1 do: [ :i | contents nextPutAll: '  ' ].

		"Texte du titre (adapte la méthode selon ce que fournit ta classe de header)"
		contents nextPutAll: aHeader header ].  "ou aHeader text, aHeader label..."

	"On continue à visiter les enfants comme dans MicrodownVisitor"
	aHeader headerElements do: [ :each | each accept: self ]

]
