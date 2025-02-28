<script lang="ts">
  import { onMount } from 'svelte';
  
  // Mock data for dashboard
  let stats = [
    { name: 'Total Employees', value: 42 },
    { name: 'Active Payroll Periods', value: 1 },
    { name: 'Pending Leave Requests', value: 5 },
    { name: 'Pending Overtime Approvals', value: 3 }
  ];
  
  let recentActivities = [
    { type: 'Payroll', description: 'June 2025 payroll processed', date: '2025-06-15', status: 'Completed' },
    { type: 'Leave', description: 'John Doe requested annual leave', date: '2025-06-14', status: 'Pending' },
    { type: 'Employee', description: 'New employee Sarah Smith added', date: '2025-06-12', status: 'Completed' },
    { type: 'Overtime', description: 'James Wilson submitted overtime hours', date: '2025-06-10', status: 'Approved' }
  ];
  
  let upcomingEvents = [
    { title: 'July Payroll Processing', date: '2025-07-15' },
    { title: 'Tax Filing Deadline', date: '2025-07-20' },
    { title: 'Quarterly Review', date: '2025-07-30' }
  ];
</script>

<svelte:head>
  <title>Dashboard | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">Dashboard</h1>
    <p class="mt-1 text-sm text-gray-500">Overview of your payroll system</p>
  </div>
  
  <!-- Stats -->
  <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
    {#each stats as stat}
      <div class="card">
        <p class="text-sm font-medium text-gray-500 truncate">{stat.name}</p>
        <p class="mt-1 text-3xl font-semibold text-gray-900">{stat.value}</p>
      </div>
    {/each}
  </div>
  
  <div class="grid grid-cols-1 gap-5 lg:grid-cols-3">
    <!-- Recent Activity -->
    <div class="lg:col-span-2">
      <div class="card h-full">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Recent Activity</h2>
        <div class="table-container">
          <table class="table">
            <thead class="table-header">
              <tr>
                <th class="table-header-cell">Type</th>
                <th class="table-header-cell">Description</th>
                <th class="table-header-cell">Date</th>
                <th class="table-header-cell">Status</th>
              </tr>
            </thead>
            <tbody class="table-body">
              {#each recentActivities as activity}
                <tr class="table-row">
                  <td class="table-cell">{activity.type}</td>
                  <td class="table-cell">{activity.description}</td>
                  <td class="table-cell">{activity.date}</td>
                  <td class="table-cell">
                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                      {activity.status === 'Completed' ? 'bg-green-100 text-green-800' : 
                        activity.status === 'Pending' ? 'bg-yellow-100 text-yellow-800' : 
                        'bg-blue-100 text-blue-800'}">
                      {activity.status}
                    </span>
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <!-- Upcoming Events -->
    <div>
      <div class="card h-full">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Upcoming Events</h2>
        <div class="space-y-4">
          {#each upcomingEvents as event}
            <div class="flex items-start">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <p class="text-sm font-medium text-gray-900">{event.title}</p>
                <p class="text-sm text-gray-500">{event.date}</p>
              </div>
            </div>
          {/each}
        </div>
      </div>
    </div>
  </div>
  
  <!-- Quick Actions -->
  <div class="card">
    <h2 class="text-lg font-medium text-gray-900 mb-4">Quick Actions</h2>
    <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-4">
      <a href="/employees/new" class="btn btn-primary text-center">Add Employee</a>
      <a href="/payroll/new" class="btn btn-primary text-center">Start Payroll Run</a>
      <a href="/leave/approve" class="btn btn-primary text-center">Review Leave Requests</a>
      <a href="/reports" class="btn btn-primary text-center">Generate Reports</a>
    </div>
  </div>
</div>