/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    unoptimized: true, //TODO: Remove this when we have a proper image optimization solution
  }
}

module.exports = nextConfig
