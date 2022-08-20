# Containers

### Configuration

You are able to configure the generator defaults by adding a `.containers.yml` file to your root folder.

```yaml
docker_dir: "."
app_dir: "."
project_name: "my-project"
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
