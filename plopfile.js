const fs = require('fs');
const path = require('path');
const basePath = path.resolve('.');
const templatePath = path.resolve('./.denver/templates');
const projectTemplatePath = `${templatePath}/project`;
const nonProjects = [
  '.git',
  '.denver'
];
const updatableFiles = {
  '.denver/bin/bin': '.denver/bin/{{snakeCase name}}',
  '.env': '.env',
  '.dockerignore': '.dockerignore',
  '.gitignore': '.gitignore',
  'README.md': 'README.md'
};

module.exports = function (plop) {
  plop.setGenerator('update', {
    description: 'update files for projects',
    prompts: [
      {
        type: 'input',
        name: 'projects',
        message: 'What is the name of projects that should be updated? (comma separated or all)'
      }
    ],
    actions: [
      function updateProject (data) {
        process.chdir(plop.getPlopfilePath());

        let projects = (data.projects || 'all')
          .split(',')
          .map(p => p.trim());

        if (projects[0] === 'all') {
          projects = fs
            .readdirSync(__dirname)
            .filter(f => nonProjects.indexOf(f) < 0)
            .filter(f => fs.lstatSync(f).isDirectory());
        }

        projects.forEach(name => {
          const projectSettings = require(
            plop.renderString(
              './{{dashCase name}}/.denver/project.json',
              {name}
            )
          );

          Object.keys(updatableFiles).forEach(template => {
            const file = updatableFiles[template];
            const filePath = path.resolve(
              plop.renderString(
                `./{{dashCase name}}/${file}`,
                projectSettings
              )
            );
            const templateString = plop.renderString(
              fs.readFileSync(`${projectTemplatePath}/${template}`).toString(),
              projectSettings
            );

            fs.truncateSync(filePath, 0);
            fs.writeFileSync(filePath, templateString);
          });
        });

        return `Updated projects: ${projects.join(', ')}`;
      }
    ]
  });

  plop.setGenerator('project', {
    description: 'create basic project',
    prompts: [
      {
        type: 'input',
        name: 'name',
        message: 'What is the name of your project?'
      },{
        type: 'input',
        name: 'title',
        message: 'What is the title of your project?'
      },{
        type: 'input',
        name: 'description',
        message: 'What is the description of your project?'
      }
    ],
    actions: [
      {
        type: 'add',
        path: '{{dashCase name}}/.denver/bin/{{snakeCase name}}',
        templateFile: `${projectTemplatePath}/.denver/bin/bin`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/.denver/project.json',
        templateFile: `${projectTemplatePath}/.denver/project.json`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/rootfs/bin/{{snakeCase name}}_entrypoint',
        templateFile: `${projectTemplatePath}/rootfs/bin/entrypoint`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/.dockerignore',
        templateFile: `${projectTemplatePath}/.dockerignore`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/.env',
        templateFile: `${projectTemplatePath}/.env`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/.gitignore',
        templateFile: `${projectTemplatePath}/.gitignore`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/Dockerfile',
        templateFile: `${projectTemplatePath}/Dockerfile`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/README.md',
        templateFile: `${projectTemplatePath}/README.md`
      },
      {
        type: 'add',
        path: '{{dashCase name}}/UNLICENSE',
        templateFile: `${projectTemplatePath}/UNLICENSE`
      },
      function chmodBinFile (data) {
        process.chdir(plop.getPlopfilePath());
        const file = path.resolve('./' + plop.renderString(
          '{{dashCase name}}/.denver/bin/{{snakeCase name}}',
          data
        ));
        fs.chmodSync(file, 0755);
        return `${file.replace(basePath, '')} is now executable`;
      },
      function chmodEntryFile (data) {
        process.chdir(plop.getPlopfilePath());
        const file = path.resolve('./' + plop.renderString(
          '{{dashCase name}}/rootfs/bin/{{snakeCase name}}_entrypoint',
          data
        ));
        fs.chmodSync(file, 0755);
        return `${file.replace(basePath, '')} is now executable`;
      }
    ]
  });
};
