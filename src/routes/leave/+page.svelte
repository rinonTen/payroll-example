<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  
  // Mock data for leave requests
  let leaveRequests = [
    {
      id: '1',
      employee: { id: '1', firstName: 'John', lastName: 'Doe' },
      type: 'annual',
      startDate: '2025-07-10',
      endDate: '2025-07-15',
      totalDays: 6,
      reason: 'Family vacation',
      status: 'pending',
      createdAt: '2025-06-15'
    },
    {
      id: '2',
      employee: { id: '2', firstName: 'Jane', lastName: 'Smith' },
      type: 'sick',
      startDate: '2025-06-20',
      endDate: '2025-06-22',
      totalDays: 3,
      reason: 'Flu',
      status: 'approved',
      createdAt: '2025-06-10'
    },
    {
      id: '3',
      employee: { id: '3', firstName: 'Michael', lastName: 'Johnson' },
      type: 'unpaid',
      startDate: '2025-08-01',
      endDate: '2025-08-15',
      totalDays: 15,
      reason: 'Personal matters',
      status: 'rejected',
      createdAt: '2025-06-05'
    }
  ];
  
  let statusFilter = 'all';
  let typeFilter = 'all';
  
  $: filteredLeaveRequests = leaveRequests.filter(request => {
    const matchesStatus = statusFilter === 'all' || request.status === statusFilter;
    const matchesType = typeFilter === 'all' || request.type === typeFilter;
    
    return matchesStatus && matchesType;
  });
  
  function handleNewLeaveRequest() {
    goto('/leave/new');
  }
  
  function handleViewLeaveRequest(id: string) {
    goto(`/leave/${id}`);
  }
  
  function handleApproveLeaveRequest(id: string) {
    // In a real app, this would update the database
    leaveRequests = leaveRequests.map(request => 
      request.id === id ? { ...request, status: 'approved' } : request
    );
    
    toast.success('Leave request approved');
  }
  
  function handleRejectLeaveRequest(id: string) {
    // In a real app, this would update the database
    leaveRequests = leaveRequests.map(request => 
      request.id === id ? { ...request, status: 'rejected' } : request
    );
    
    toast.success('Leave request rejected');
  }
  
  function getLeaveTypeName(type: string) {
    switch (type) {
      case 'annual':
        return 'Annual Leave';
      case 'sick':
        return 'Sick Leave';
      case 'maternity':
        return 'Maternity Leave';
      case 'paternity':
        return 'Paternity Leave';
      case 'unpaid':
        return 'Unpaid Leave';
      default:
        return type.charAt(0).toUpperCase() + type.slice(1);
    }
  }
  
  function getStatusBadgeClass(status: string) {
    switch (status) {
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'approved':
        return 'bg-green-100 text-green-800';
      case 'rejected':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  }
</script>

<svelte:head>
  <title>Leave Management | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Leave Management</h1>
      <p class="mt-1 text-sm text-gray-500">Manage employee leave requests</p>
    </div>
    <button class="btn btn-primary" on:click={handleNewLeaveRequest}>
      New Leave Request
    </button>
  </div>
  
  <div class="card">
    <div class="flex flex-col sm:flex-row justify-between space-y-3 sm:space-y-0 sm:space-x-4 mb-6">
      <div class="sm:w-48">
        <select bind:value={statusFilter} class="form-input">
          <option value="all">All Status</option>
          <option value="pending">Pending</option>
          <option value="approved">Approved</option>
          <option value="rejected">Rejected</option>
        </select>
      </div>
      
      <div class="sm:w-48">
        <select bind:value={typeFilter} class="form-input">
          <option value="all">All Types</option>
          <option value="annual">Annual Leave</option>
          <option value="sick">Sick Leave</option>
          <option value="maternity">Maternity Leave</option>
          <option value="paternity">Paternity Leave</option>
          <option value="unpaid">Unpaid Leave</option>
        </select>
      </div>
    </div>
    
    <div class="table-container">
      <table class="table">
        <thead class="table-header">
          <tr>
            <th class="table-header-cell">Employee</th>
            <th class="table-header-cell">Type</th>
            <th class="table-header-cell">Date Range</th>
            <th class="table-header-cell">Days</th>
            <th class="table-header-cell">Reason</th>
            <th class="table-header-cell">Status</th>
            <th class="table-header-cell">Actions</th>
          </tr>
        </thead>
        <tbody class="table-body">
          {#each filteredLeaveRequests as request}
            <tr class="table-row">
              <td class="table-cell font-medium text-gray-900">
                {request.employee.firstName} {request.employee.lastName}
              </td>
              <td class="table-cell">{getLeaveTypeName(request.type)}</td>
              <td class="table-cell">{request.startDate} to {request.endDate}</td>
              <td class="table-cell">{request.totalDays}</td>
              <td class="table-cell">{request.reason}</td>
              <td class="table-cell">
                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full {getStatusBadgeClass(request.status)}">
                  {request.status.charAt(0).toUpperCase() + request.status.slice(1)}
                </span>
              </td>
              <td class="table-cell">
                <div class="flex space-x-2">
                  <button 
                    class="text-primary-600 hover:text-primary-900"
                    on:click={() => handleViewLeaveRequest(request.id)}
                  >
                    View
                  </button>
                  
                  {#if request.status === 'pending'}
                    <button 
                      class="text-green-600 hover:text-green-900"
                      on:click={() => handleApproveLeaveRequest(request.id)}
                    >
                      Approve
                    </button>
                    <button 
                      class="text-red-600 hover:text-red-900"
                      on:click={() => handleRejectLeaveRequest(request.id)}
                    >
                      Reject
                    </button>
                  {/if}
                </div>
              </td>
            </tr>
          {/each}
          
          {#if filteredLeaveRequests.length === 0}
            <tr>
              <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                No leave requests found matching your criteria.
              </td>
            </tr>
          {/if}
        </tbody>
      </table>
    </div>
  </div>
  
  <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Leave Summary</h2>
      <div class="space-y-4">
        <div class="flex justify-between">
          <span class="text-gray-500">Pending Requests:</span>
          <span class="font-medium">1</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Approved Requests:</span>
          <span class="font-medium">1</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Rejected Requests:</span>
          <span class="font-medium">1</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Total Leave Days (This Month):</span>
          <span class="font-medium">9</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Total Leave Days (Year to Date):</span>
          <span class="font-medium">24</span>
        </div>
      </div>
    </div>
    
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Leave Balance Overview</h2>
      <div class="space-y-4">
        <div>
          <div class="flex justify-between mb-1">
            <span class="text-sm font-medium text-gray-700">Annual Leave</span>
            <span class="text-sm font-medium text-gray-700">15/20 days used</span>
          </div>
          <div class="w-full bg-gray-200 rounded-full h-2.5">
            <div class="bg-primary-600 h-2.5 rounded-full" style="width: 75%"></div>
          </div>
        </div>
        
        <div>
          <div class="flex justify-between mb-1">
            <span class="text-sm font-medium text-gray-700">Sick Leave</span>
            <span class="text-sm font-medium text-gray-700">3/10 days used</span>
          </div>
          <div class="w-full bg-gray-200 rounded-full h-2.5">
            <div class="bg-primary-600 h-2.5 rounded-full" style="width: 30%"></div>
          </div>
        </div>
        
        <div>
          <div class="flex justify-between mb-1">
            <span class="text-sm font-medium text-gray-700">Maternity Leave</span>
            <span class="text-sm font-medium text-gray-700">0/90 days used</span>
          </div>
          <div class="w-full bg-gray-200 rounded-full h-2.5">
            <div class="bg-primary-600 h-2.5 rounded-full" style="width: 0%"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>