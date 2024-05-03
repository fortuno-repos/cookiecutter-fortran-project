# {{ cookiecutter.project_name }}

{{ cookiecutter.description }}

## To do

Go through the check list below before making your project public. Delete this
section once all items had been resolved.

### Generic tasks

* **License**:

  - Add appropriate license file(s) to your project

  - Adapt the License section further down according to your license

{% if cookiecutter.__fpm_build == "True" -%}
### Fpm related tasks

* **Manifest**: Enter your personal date in the ``fpm.toml`` file

{%- endif %}

## License

{{ cookiecutter.project_name }} is licensed under the [NAME_OF_YOUR_LICENSE]
license. The SPDX license identifier for this project is
[SPDX_IDENTIFIER_OF_YOUR_LICENSE].