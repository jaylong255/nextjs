// route request: /about

import { useRouter } from 'next/router'

export default function Page() {
  const router = useRouter()
  
  return (
    <button type="button" onClick={() => router.push('/about')}>
        Go to About
    </button>
}