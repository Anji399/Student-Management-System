package com.burak.studentmanagement.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.burak.studentmanagement.dao.RoleDao;
import com.burak.studentmanagement.entity.Role;
import com.burak.studentmanagement.service.StudentService;
import com.burak.studentmanagement.service.TeacherService;
import com.burak.studentmanagement.user.UserDto;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private RoleDao roleDao;

    // This method trims whitespace from all incoming string parameters
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    // Displays the registration form
    @GetMapping("/showRegistrationForm")
    public String showRegistrationForm(Model theModel) {
        theModel.addAttribute("userDto", new UserDto());
        return "registration/registration-form";
    }

    // Processes the registration form after submission
    @PostMapping("/processRegistrationForm")
    public String processRegistrationForm(
            @Valid @ModelAttribute("userDto") UserDto user,
            BindingResult theBindingResult,
            @RequestParam(value = "role") String roleName,
            Model theModel) {

        // If there are validation errors, return to the registration form
        if (theBindingResult.hasErrors()) {
            return "registration/registration-form";
        }

        String userName = user.getUserName();

        // Handle registration for students
        if (roleName.equals("ROLE_STUDENT")) {
            // Check if the username already exists in the student database
            if (studentService.findByStudentName(userName) != null) {
                theModel.addAttribute("userDto", new UserDto());
                theModel.addAttribute("registrationError", "User name already exists!");
                return "registration/registration-form";
            }

            // Assign the student role and save the user
            Role role = roleDao.findRoleByName(roleName);
            user.setRole(role);
            studentService.save(user); // save() method converts UserDto to Student and saves it in the database

        // Handle registration for teachers
        } else if (roleName.equals("ROLE_TEACHER")) {
            // Check if the username already exists in the teacher database
            if (teacherService.findByTeacherName(userName) != null) {
                theModel.addAttribute("userDto", new UserDto());
                theModel.addAttribute("registrationError", "User name already exists!");
                return "registration/registration-form";
            }

            // Assign the teacher role and save the user
            Role role = roleDao.findRoleByName(roleName);
            user.setRole(role);
            teacherService.save(user); // save() method converts UserDto to Teacher and saves it in the database
        }

        // Registration was successful, redirect to the confirmation page
        return "registration/registration-confirmation";
    }
}
