# Containers

### Configuration

You can configure your project with a `.containers.yml` file.
This file can be generated by running: `containers generate config`

```yaml
---
organization_name: my-organization
project_name: my-project
app_directory: .
docker_directory: .
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
