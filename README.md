# CyberWorld Landing Site

## Getting Started

We're using docker to run commands so that you don't have to worry about your local version of npm. This way 
as the number of projects we support grows and the node version is not always the same, you won't have to switch
node versions. Also, this give us the ability to document and package most of the software tooling into the container
instead of trying to instruct you on how to install it on your machine because who knows what all the nuances are
on your machine, espeacially if you have multiple development machines. Putting it all in docker tends to make the 
onboarding and collaboration process much more simple.

First, build the docker container:
```bash
docker-compose build
```

Next, run the development server:

```bash
docker compose run nextjs npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `pages/index.js`. The page auto-updates as you edit the file.

[API routes](https://nextjs.org/docs/api-routes/introduction) can be accessed on [http://localhost:3000/api/hello](http://localhost:3000/api/hello). This endpoint can be edited in `pages/api/hello.js`.

The `pages/api` directory is mapped to `/api/*`. Files in this directory are treated as [API routes](https://nextjs.org/docs/api-routes/introduction) instead of React pages.

This project uses [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) to automatically optimize and load Inter, a custom Google Font.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js/) - your feedback and contributions are welcome!

## Deploy with Terraform
(COMMING SOON)
