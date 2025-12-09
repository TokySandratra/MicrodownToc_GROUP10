Class {
	#name : 'SimpleTOCGeneratorTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-Visitor',
	#package : 'Microdown-Tests',
	#tag : 'Visitor'
}

{ #category : 'tests' }
SimpleTOCGeneratorTest >> testTOCNumberedWithFilter [
	| miniDoc vis |
	miniDoc := '# Microdown
## Architecture
### Visitors
### A builder'.

	vis := SimpleTOCGenerator new.
	vis showOnlyAbove: 1.
	vis numbered.
	vis visit: (Microdown parse: miniDoc).

	self assert: vis contents equals: '
1 Architecture
2 Visitors
3 A builder'

]

{ #category : 'tests' }
SimpleTOCGeneratorTest >> testTOCNumberedWithoutFilter [
	| miniDoc vis |
	miniDoc := '# Microdown
## Architecture
### Visitors
### A builder'.

	vis := SimpleTOCGenerator new.
	vis numbered.
	vis visit: (Microdown parse: miniDoc).

	self assert: vis contents equals: '
1 Microdown
2 Architecture
3 Visitors
4 A builder'

]

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
