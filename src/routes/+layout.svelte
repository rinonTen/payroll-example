<script lang="ts">
  import '../app.css';
  import { page } from '$app/stores';
  import { Toaster } from 'svelte-french-toast';
</script>

<div class="min-h-screen flex flex-col">
  <header class="bg-white shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16">
        <div class="flex">
          <div class="flex-shrink-0 flex items-center">
            <a href="/" class="text-2xl font-bold text-primary-600">PayrollPro</a>
          </div>
          <nav class="ml-6 flex space-x-8">
            <a 
              href="/" 
              class="inline-flex items-center px-1 pt-1 border-b-2 {$page.url.pathname === '/' ? 'border-primary-500 text-gray-900' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'}"
            >
              Dashboard
            </a>
            <a 
              href="/employees" 
              class="inline-flex items-center px-1 pt-1 border-b-2 {$page.url.pathname.startsWith('/employees') ? 'border-primary-500 text-gray-900' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'}"
            >
              Employees
            </a>
            <a 
              href="/payroll" 
              class="inline-flex items-center px-1 pt-1 border-b-2 {$page.url.pathname.startsWith('/payroll') ? 'border-primary-500 text-gray-900' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'}"
            >
              Payroll
            </a>
            <a 
              href="/leave" 
              class="inline-flex items-center px-1 pt-1 border-b-2 {$page.url.pathname.startsWith('/leave') ? 'border-primary-500 text-gray-900' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'}"
            >
              Leave
            </a>
            <a 
              href="/reports" 
              class="inline-flex items-center px-1 pt-1 border-b-2 {$page.url.pathname.startsWith('/reports') ? 'border-primary-500 text-gray-900' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'}"
            >
              Reports
            </a>
          </nav>
        </div>
        <div class="flex items-center">
          <div class="ml-3 relative">
            <div>
              <button type="button" class="flex text-sm rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">
                <span class="sr-only">Open user menu</span>
                <div class="h-8 w-8 rounded-full bg-primary-600 flex items-center justify-center text-white">
                  A
                </div>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>

  <main class="flex-1 py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <slot />
    </div>
  </main>

  <footer class="bg-white border-t border-gray-200">
    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <p class="text-center text-sm text-gray-500">
        &copy; 2025 PayrollPro. All rights reserved.
      </p>
    </div>
  </footer>

  <Toaster />
</div>