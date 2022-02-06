// main validation function
function validateForm() {
	var valid = 1; // 1 - validating is OK
	var validateResults = [];
	// validating name fields for empty or invalid value
	validateResults[0] = validationResultHandler(document.getElementById('firstName'), document.getElementById("firstName_validation")); 
	validateResults[1] = validationResultHandler(document.getElementById('secondName'), document.getElementById("secondName_validation"));
	validateResults[2] = validationResultHandler(document.getElementById('middleName'), document.getElementById("middleName_validation"));

validateResults[4] = validationResultHandler(document.querySelector('input[type="checkbox"]'), document.getElementById("preferences_validation"));
 
	for(var i=0; i<validateResults.length; i++){
		valid = valid && validateResults[i];
	}

	if(!valid) return false; // Validation not passed
}

// function for validate elements
function validationResultHandler( element, element_validation) {
	var validate = 1;// 1 - validating is OK
	var filter = /^([a-zA-Zа-яА-я]{1,})/; // regular expression for textfield

	switch(element.type){

		case 'text':// textfield handler
			
			if (!filter.test(element.value)){ // Validating by regular expression
				if(element.value === "") element_validation.innerHTML = "Field required / Поле не заполнено"; // Empty text field
				else element_validation.innerHTML = "Invalid value / Некорректное значение"; // invalid values in text field
				validate = 0; // validating not passed
			}
			break;
		case 'checkbox':
			var preferencesArray = document.querySelectorAll('input[type="checkbox"]'); // array of checkboxes
			var count = 0; // checked checkboxes count

			for(var i=0; i<preferencesArray.length; i++){ 
				if(preferencesArray[i].checked) count++;
			}
			// if count bigger than 3, validating not passed
			if(count > 3) { 
				element_validation.innerHTML = "Maximum 3 checked points / Можно выбрать максимум 3 варианта";
				validate = 0; // validating not passed
			}
			break;
	}

	// element block handler
	if (!validate) {
		element_validation.style.display = "block";
		element_validation.parentNode.style.backgroundColor = "#013220";
	    return 0;
	} else {
		element_validation.style.display = "none";
		element_validation.parentNode.style.backgroundColor = "transparent";
		return 1;
	}
}



