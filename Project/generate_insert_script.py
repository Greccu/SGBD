import random

order = ["-locations", "-universities", "-faculties", "-students", "-professors", "-classes", "-classes_students"]
format_text = {
    "-locations": "INSERT INTO locations (location_id,street_adress,postal_code,city,state_region,country) VALUES (seq_location.nextval,'{}','{}','{}','{}','{}');\n",
    "-universities": "INSERT INTO universities (university_id, university_name,location_id) VALUES (seq_university.nextval,'{}',{});\n",
    "-faculties": "INSERT INTO faculties (faculty_id,faculty_name,university_id,location_id) VALUES (seq_faculty.nextval,'{}',{},{});\n",
    "-students": "INSERT INTO students (student_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_student.nextval,'{}','{}','{}','{}',{});\n",
    "-professors": "INSERT INTO professors (professor_id,first_name,last_name,email,phone_number,faculty_id) VALUES (seq_professor.nextval,'{}','{}','{}','{}',{});\n",
    "-classes": "INSERT INTO classes (class_id,class_name,professor_id) VALUES (seq_class.nextval,'{}',{});\n",
    "-classes_students": "INSERT INTO classes_students (student_id,class_id) VALUES ({},{});\n"
}
values = {i: [[]] for i in order}
with open("input.txt", "r") as f:
    lines = [x.replace("\n", "") for x in f.readlines()]
    count = 0
    category = ""
    nrmaterii = 6
    profindex = 0
    indexmaterie = 0
    for c in lines:
        if (category == "-students" or category == "-professors") and c and c[0] != '-':
            name = c.split()
            values[category][-1].append(name[0])
            values[category][-1].append(name[1])
            if (category == "-professors"):
                faculty = values["-faculties"][profindex//nrmaterii]
                profindex += 1
            else:
                faculty = values["-faculties"][random.randint(0,len(values['-faculties'])-2)]
            email = name[0].lower() + "." + name[1].lower() + "@" + category[1] + "." + faculty[3]
            values[category][-1].append(email)
            phone = "07" + str(random.randint(10000000, 19999999))
            values[category][-1].append(phone)
            values[category][-1].append(values["-faculties"].index(faculty)+1)
            values[category].append([])
            print(values[category])
        elif (category == "-classes"):
            if c:
                values[category][-1].append(c)
                values[category][-1].append(indexmaterie+1)
                indexmaterie += 1
                values[category].append([])
        else:
            if c == "" and category:
                values[category].append([])
            else:
                if c[0] == "-":
                    category = c
                else:
                    values[category][-1].append(c)
            # print(c)
values['-classes_students'] = []
nrclasses = 6
print(nrclasses)
for i in range(len(values['-students'])):
    if values['-students'][i]:
        f = values['-students'][i][4] - 1
        classes = random.sample(range(nrclasses*f,nrclasses*(f+1)-1 ), 3)
        print(f,classes)
        for j in classes:
            values['-classes_students'].append([])
            values['-classes_students'][-1].append(i+1)
            values['-classes_students'][-1].append(j+1)
print(values)
with open("output.txt", "w") as g:
    for i in order:
        g.write("-" + i + "\n")
        for j in values[i]:
            if j:
                g.write(format_text[i].format(*j))
print(values)
print(values['-faculties'])
print(len(values['-faculties']))

print(len('Facultatea de Contabilitate si Informatica de Gestiune'))