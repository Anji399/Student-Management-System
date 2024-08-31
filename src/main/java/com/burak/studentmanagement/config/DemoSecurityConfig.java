package com.burak.studentmanagement.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.burak.studentmanagement.service.StudentService;
import com.burak.studentmanagement.service.TeacherService;

@Configuration
@EnableWebSecurity
public class DemoSecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private TeacherService teacherService;

    @Autowired
    private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // Configure authentication for students and teachers
        auth.userDetailsService(studentService)
            .passwordEncoder(passwordEncoder());

        auth.userDetailsService(teacherService)
            .passwordEncoder(passwordEncoder());

        // Configure admin authentication (in-memory)
        auth.inMemoryAuthentication()
            .withUser("admin")
            .password(passwordEncoder().encode("admin123"))
            .roles("ADMIN");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
            .antMatchers("/").authenticated()
            .antMatchers("/admin/**").hasRole("ADMIN")
            .antMatchers("/student/**").hasRole("STUDENT")
            .antMatchers("/teacher/**").hasRole("TEACHER")
            .and()
            .formLogin()
                .loginPage("/showLoginPage")
                .loginProcessingUrl("/authenticateTheUser")
                .successHandler(customAuthenticationSuccessHandler)
                .permitAll()
            .and()
            .logout().permitAll()
            .and()
            .exceptionHandling().accessDeniedPage("/access-denied");
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
