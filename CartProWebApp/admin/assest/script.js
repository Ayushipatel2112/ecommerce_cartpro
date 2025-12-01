function validateForm() {
    let email = document.getElementById("email").value.trim();
    let password = document.getElementById("password").value.trim();

    if (email === "" || password === "") {
        alert("Please fill all fields.");
        return false;
    }

    if (!email.includes("@") || !email.includes(".")) {
        alert("Please enter a valid email address.");
        return false;
    }

    if (password.length < 4) {
        alert("Password must be at least 4 characters.");
        return false;
    }

    return true;
}
function validateRegister() {
  let name = document.getElementById("name").value.trim();
  let email = document.getElementById("email").value.trim();
  let password = document.getElementById("password").value.trim();
  let confirm = document.getElementById("confirm").value.trim();

  if (name === "" || email === "" || password === "" || confirm === "") {
    alert("Please fill all fields!");
    return false;
  }

  let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
  if (!email.match(emailPattern)) {
    alert("Please enter a valid email address!");
    return false;
  }

  if (password.length < 6) {
    alert("Password must be at least 6 characters long!");
    return false;
  }

  if (password !== confirm) {
    alert("Passwords do not match!");
    return false;
  }

  return true;
}
