component extends="Controller" {

	public void function config() {
		super.config();
		provides("json")
	}

	public void function index() {
		var person = {}
		person["name"] = "Justin"
		person["age"] = "55"
		renderWith(person)
		return
	}
}
