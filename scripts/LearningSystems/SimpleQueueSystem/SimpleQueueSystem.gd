extends LearningSystem

class_name SimpleQueueSystem 

func get_words_for_this_session():
	return VocabularyManager.get_all_words().slice(0,10)

func increment_session():
	pass
	#for word in words_for_this_session:
##		word.upgrade_card()
		#word.leitnerIndex += 1 
	#UserSettingsManager.update_session_number()
	#VocabularyManager.save_vocabulary()
	
