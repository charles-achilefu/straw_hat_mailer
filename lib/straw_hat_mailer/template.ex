defmodule StrawHat.Mailer.Template do
  import Ecto.Query, only: [from: 2]

  alias StrawHat.Mailer.Repo
  alias StrawHat.Mailer.Schema.Template

  def list_templates(params), do: Repo.paginate(Template, params)

  def list_template_by_service(service, params) do
    query =
      from template in Template,
      where: ^[service: service]

    Repo.paginate(query, params)
  end

  def create_template(params) do
    %Template{}
    |> Template.changeset(params)
    |> Repo.insert()
  end

  def update_template(%Template{} = template, params) do
    template
    |> Template.changeset(params)
    |> Repo.update()
  end

  def destroy_template(%Template{} = template), do: Repo.delete(template)

  def find_template(id) do
    case get_template(id) do
      nil -> {:error, {:not_found, "Template #{id} not found"}}
      template -> {:ok, template}
    end
  end

  def get_template(id), do: Repo.get(Template, id)

  def template(name) do
    query =
      from template in Template,
      where: ^[name: name]

    case Repo.one(query) do
      nil -> {:error, "Not found template by name #{name}"}
      template -> {:ok, template}
    end
  end
end