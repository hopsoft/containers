# Containers

### Configuration

You can configure your project with a `.containers.yml` file.
This file can be generated by running: `containers generate config`

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

### Questions to prompt on generate

- [ ] container logging?
- [ ] admin tooling?

#### Punt on these for now

```
containers generate compose
containers add RECIPE [URL]
containers remove RECIPE
```

- [ ] sinatra?
- [ ] rails?
- [ ] anycable?
- [ ] actioncable?
- [ ] caching? (redis)
- [ ] background jobs?
  - [ ] backend? (sidekiq, ...)
