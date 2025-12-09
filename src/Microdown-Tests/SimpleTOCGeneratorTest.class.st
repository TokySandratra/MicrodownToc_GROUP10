Class {
	#name : 'SimpleTOCGeneratorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Visitor',
	#package : 'Microdown-Tests',
	#tag : 'Visitor'
}

{ #category : 'tests' }
SimpleTOCGeneratorTest >> testTOCWithFilter [ "Avec un level comme parametre"
	| miniDoc vis |
	miniDoc := '# Microdown
## Architecture
### Visitors
### A builder'.

	vis := SimpleTOCGenerator new.
	vis showOnlyAbove: 1.
	vis visit: (Microdown parse: miniDoc).

	self assert: vis contents equals: '
  Architecture
    Visitors
    A builder'

]

{ #category : 'tests' }
SimpleTOCGeneratorTest >> testTOCWithoutFilter [  "sans ajouter un Level"
	| miniDoc vis |
	miniDoc := '# Microdown
## Architecture
### Visitors
### A builder'.

	vis := SimpleTOCGenerator new.
	vis visit: (Microdown parse: miniDoc).

	self assert: vis contents equals: '
Microdown
  Architecture
    Visitors
    A builder'

]
