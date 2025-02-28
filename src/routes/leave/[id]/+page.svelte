<script lang="ts">
  import { page } from '$app/stores';
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  
  let leaveRequest = null;
  let loading = true;
  
  onMount(async () => {
    // In a real app, this would fetch from the database
    // Simulate API call delay
    setTimeout(() => {
      const leaveId = $page.params.id;
      
      // Mock leave request data
      leaveRequest = {
        id: leaveId,
        employee: { id: '1', firstName: 'John', lastName: 'Doe' },
        type: 'annual',
        startDate: '2025-07-10',
        endDate: '2025-07-15',
        totalDays: 6,
        reason: 'Family vacation',
        status: 'pending',
        createdAt: '2025-06-15'
      };
      
      loading = false;
    }, 500);
  });
  
  function handleBack() {
    goto('/leave');
  }
  
  function handleApprove() {
    // In a real app, this would update the database
    if (leaveRequest) {
      leaveRequest.status = 'approved';
      toast.success('Leave request approved');
    }
  }
  
  function handleReject() {
    // In a real app, this would update the database
    if (leaveRequest) {
      leaveRequest.status = 'rejected';
      toast.success('Leave request rejected');
    }
  }
  
  function getLeaveTypeName(type) {
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
  
  function getStatusBadgeClass(status) {
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
  <title>Leave Request Details | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Leave Request Details</h1>
      <p class="mt-1 text-sm text-gray-500">View and manage leave request</p>
    </div>
    <button class="btn btn-secondary" on:click={handleBack}>
      Back to Leave Requests
    </button>
  </div>
  
  {#if loading}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Loading leave request details...</p>
    </div>
  {:else if leaveRequest}
    <div class="card">
      <div class="flex justify-between items-start mb-6">
        <div>
          <h2 class="text-lg font-medium text-gray-900">
            {getLeaveTypeName(leaveRequest.type)} Request
          </h2>
          <p class="text-sm text-gray-500">
            Submitted on {new Date(leaveRequest.createdAt).toLocaleDateString()}
          </p>
        </div>
        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full {getStatusBadgeClass(leaveRequest.status)}">
          {leaveRequest.status.charAt(0).toUpperCase() + leaveRequest.status.slice(1)}
        </span>
      </div>
      
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 mb-6">
        <div>
          <p class="text-sm font-medium text-gray-500">Employee</p>
          <p class="text-base font-medium">{leaveRequest.employee.firstName} {leaveRequest.employee.lastName}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Leave Type</p>
          <p class="text-base font-medium">{getLeaveTypeName(leaveRequest.type)}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Date Range</p>
          <p class="text-base font-medium">{leaveRequest.startDate} to {leaveRequest.endDate}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Total Days</p>
          <p class="text-base font-medium">{leaveRequest.totalDays}</p>
        </div>
      </div>
      
      <div class="mb-6">
        <p class="text-sm font-medium text-gray-500">Reason</p>
        <p class="text-base mt-1">{leaveRequest.reason}</p>
      </div>
      
      {#if leaveRequest.status === 'pending'}
        <div class="flex space-x-3">
          <button class="btn btn-primary" on:click={handleApprove}>
            Approve Request
          </button>
          <button class="btn btn-danger" on:click={handleReject}>
            Reject Request
          </button>
        </div>
      {/if}
      }
    </div>
    
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Leave Balance</h2>
      
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
  {:else}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Leave request not found</p>
    </div>
  {/if}
  }
</div>