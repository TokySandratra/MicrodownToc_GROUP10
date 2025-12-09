Class {
	#name : 'TocEntry',
	#superclass : 'Object',
	#instVars : [
		'title',
		'level',
		'link'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'accessing' }
TocEntry >> level [
	^ level 
]

{ #category : 'accessing' }
TocEntry >> level: anInteger [
    level := anInteger
]

{ #category : 'accessing' }
TocEntry >> link [
	^ link 
]

{ #category : 'accessing' }
TocEntry >> link: aStringOrUrl [
    link := aStringOrUrl
]

{ #category : 'accessing' }
TocEntry >> title [
	^ title 
]

{ #category : 'accessing' }
TocEntry >> title: aString [
    title := aString
]
