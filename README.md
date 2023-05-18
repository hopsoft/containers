# Containers (WIP)

## Docker Container Orchestration

### Configuration

You can configure your project with a `.containers.yml` file.

This file can be generated by running:

```sh
containers generate config
```

```yaml
---
organization:
  name: my-organization

app:
  name: my-project
  directory: .

docker:
  directory: .
  default_service:
  compose_files:
    - docker-compose.yml
```

## TODOs

- [ ] recipes _(punt for now)_

    ```sh
    containers add RECIPE [URL]
    containers remove RECIPE
    ```

    Where should we store recipes? `./.containers/recipes`?

    Should add/remove recipe modify `compose_files` in `.containers.yml`?

  - sinatra?
  - rails?
  - anycable?
  - actioncable?
  - caching? (redis)
  - background jobs?
    - backend? (sidekiq, ...)
