component extends="wheels.tests.Test" {

	function test_automatic_validations_should_validate_primary_keys() {
		user = model("UserAutoMaticValidations").new(
			username = 'tonyp1',
			password = 'tonyp123',
			firstname = 'Tony',
			lastname = 'Petruzzi',
			address = '123 Petruzzi St.',
			city = 'SomeWhere1',
			state = 'TX',
			zipcode = '11111',
			phone = '1235551212',
			fax = '4565551212',
			birthday = '11/01/1975',
			birthdaymonth = 11,
			birthdayyear = 1975,
			isactive = 1
		);

		/* should be valid since id is not passed in */
		assert('user.valid()');

		/* should _not_ be valid since id is not a number */
		user.id = 'ABC';
		assert('!user.valid()');

		/* should be valid since id is blank */
		user.id = '';
		assert('user.valid()');

		/* should be valid since id is a number */
		user.id = 1;
		assert('user.valid()');
	}

	function test_automatic_validations_on_create_should_not_validate_presence_of_default_value_columns() {
		transaction {
			user = model("UserAutoMaticValidations").create(
				username = 'oscargrouch',
				password = 'oscarg123',
				firstname = 'Oscar',
				lastname = 'The Grouch',
				address = '123 Sesame St.',
				city = 'New York',
				state = 'NY',
				zipcode = '11111',
				phone = '1235551212',
				fax = '4565551212',
				birthday = '01/01/1969',
				birthdaymonth = 01,
				birthdayyear = 1969,
				isactive = 1
			);
			transaction action="rollback";
		}

		// debug("user.valid()", true);
		// debug("user.allErrors()", true);

		/* should be valid since birthtime has a column default */
		assert('user.valid()');
	}

	function test_automatic_validations_can_be_turned_off_for_property() {
		user = model("UserAutoMaticValidationsOff").new(
			username = 'tonyp1',
			password = 'tonyp123',
			firstname = 'Tony',
			lastname = 'Petruzzi',
			address = '123 Petruzzi St.',
			city = 'SomeWhere1',
			state = 'TX',
			zipcode = '11111',
			phone = '1235551212',
			fax = '4565551212',
			birthday = '11/01/1975',
			birthdaymonth = 11,
			birthdayyear = 1975,
			isactive = 1
		);

		/* should be valid even though id is not a number because we have turned off automatic validations for the id property */
		user.id = 'ABC';
		assert('user.valid()');
	}

}
