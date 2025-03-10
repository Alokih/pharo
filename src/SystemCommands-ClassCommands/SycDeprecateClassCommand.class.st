"
I am a command to deprecate given class.

Internal Representation and Key Implementation Points.

    Instance Variables
	newName:		<String>
"
Class {
	#name : 'SycDeprecateClassCommand',
	#superclass : 'SycSingleClassCommand',
	#instVars : [
		'newName'
	],
	#category : 'SystemCommands-ClassCommands',
	#package : 'SystemCommands-ClassCommands'
}

{ #category : 'testing' }
SycDeprecateClassCommand class >> canBeExecutedInContext: aToolContext [

	^ (super canBeExecutedInContext: aToolContext) and: [
		  aToolContext lastSelectedClass realClass isDeprecated not ]
]

{ #category : 'converting' }
SycDeprecateClassCommand >> asRefactorings [
    | deprecatedClass newClass |
    deprecatedClass := targetClass realClass.
    newClass := newName realClass.
    deprecatedClass deprecatedAliases: { newClass name }.

    self inform: 'Class ', deprecatedClass name, ' has been deprecated. Use ', newClass name, ' instead.'.

    ^ { }
]

{ #category : 'accessing' }
SycDeprecateClassCommand >> defaultMenuIconName [
	^ #bug
]

{ #category : 'accessing' }
SycDeprecateClassCommand >> defaultMenuItemName [
	^'Deprecate'
]

{ #category : 'execution' }
SycDeprecateClassCommand >> execute [

	self asRefactorings do: [ :ref | ref execute ]
]

{ #category : 'testing' }
SycDeprecateClassCommand >> isComplexRefactoring [
	^ true
]

{ #category : 'execution' }
SycDeprecateClassCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	newName := aToolContext requestSingleClass: 'Choose new class'
]
