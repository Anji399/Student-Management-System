package com.burak.studentmanagement.user;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.burak.studentmanagement.entity.Role;

public class UserDto {

    @NotBlank(message = "Username is required")
    @Size(min = 1, message = "Username is required")
    private String userName;

    @NotBlank(message = "Password is required")
    @Size(min = 1, message = "Password is required")
    private String password;

    @NotBlank(message = "First name is required")
    @Size(min = 1, message = "First name is required")
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(min = 1, message = "Last name is required")
    private String lastName;

    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    private String email;

    private Role role;

    public UserDto() {
    }

    // Getters and Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", role=" + (role != null ? role.getName() : "null") +
                '}';
    }
}

