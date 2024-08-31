package com.burak.studentmanagement.service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.burak.studentmanagement.dao.RoleDao;
import com.burak.studentmanagement.dao.TeacherDao;
import com.burak.studentmanagement.entity.Role;
import com.burak.studentmanagement.entity.Teacher;
import com.burak.studentmanagement.user.UserDto;

@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherDao teacherDao;

    @Autowired
    private RoleDao roleDao;

    @Override
    @Transactional
    public Teacher findByTeacherName(String teacherName) {
        return teacherDao.findByTeacherName(teacherName);
    }

    @Override
    @Transactional
    public void save(UserDto userDto) {
        Teacher teacher = new Teacher();
        teacher.setUserName(userDto.getUserName());
        teacher.setPassword(new BCryptPasswordEncoder().encode(userDto.getPassword()));
        teacher.setFirstName(userDto.getFirstName());
        teacher.setLastName(userDto.getLastName());
        teacher.setEmail(userDto.getEmail());

        Role role = userDto.getRole();
        if (role == null || role.getName() == null) {
            throw new RuntimeException("Role cannot be null for teacher: " + userDto.getUserName());
        }

        Role existingRole = roleDao.findRoleByName(role.getName());
        if (existingRole != null) {
            teacher.setRole(existingRole);
        } else {
            throw new RuntimeException("Role not found: " + role.getName());
        }

        teacherDao.save(teacher);
    }

    @Override
    @Transactional
    public void save(Teacher teacher) {
        if (teacher.getRole() == null) {
            throw new RuntimeException("Role cannot be null for teacher: " + teacher.getUserName());
        }
        teacherDao.save(teacher);
    }

    @Override
    @Transactional
    public List<Teacher> findAllTeachers() {
        return teacherDao.findAllTeachers();
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Teacher teacher = teacherDao.findByTeacherName(username);
        if (teacher == null) {
            throw new UsernameNotFoundException("Invalid username or password.");
        }

        if (teacher.getRole() == null) {
            throw new RuntimeException("Role cannot be null for teacher: " + username);
        }

        return new org.springframework.security.core.userdetails.User(
                teacher.getUserName(),
                teacher.getPassword(),
                mapRolesToAuthorities(teacher.getRole())
        );
    }

    private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Role role) {
        return role != null ? 
            List.of(new SimpleGrantedAuthority(role.getName())) :
            List.of();
    }

    @Override
    @Transactional
    public Teacher findByTeacherId(int id) {
        return teacherDao.findByTeacherId(id);
    }

    @Override
    @Transactional
    public void deleteTeacherById(int id) {
        teacherDao.deleteTeacherById(id);
    }
}


