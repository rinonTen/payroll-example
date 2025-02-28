<script lang="ts">
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  
  // Mock data for employees
  let employees = [
    { id: '1', firstName: 'John', lastName: 'Doe' },
    { id: '2', firstName: 'Jane', lastName: 'Smith' },
    { id: '3', firstName: 'Michael', lastName: 'Johnson' }
  ];
  
  let selectedEmployee = '';
  let leaveType = '';
  let startDate = '';
  let endDate = '';
  let totalDays = 0;
  let reason = '';
  
  function calculateTotalDays() {
    if (startDate && endDate) {
      const start = new Date(startDate);
      const end = new Date(endDate);
      const diffTime = Math.abs(end.getTime() - start.getTime());
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end days
      totalDays = diffDays;
    } else {
      totalDays = 0;
    }
  }
  
  function handleSubmit() {
    // In a real app, this would save to the database
    const leaveRequest = {
      employeeId: selectedEmployee,
      type: leaveType,
      startDate,
      endDate,
      totalDays,
      reason,
      status: 'pending'
    };
    
    console.log('Creating leave request:', leaveRequest);
    
    toast.success('Leave request submitted successfully!');
    goto('/leave');
  }
  
  function handleCancel() {
    goto('/leave');
  }
  
  $: if (startDate || endDate) {
    calculateTotalDays();
  }
</script>

<svelte:head>
  <title>New Leave Request | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">New Leave Request</h1>
    <p class="mt-1 text-sm text-gray-500">Submit a new leave request</p>
  </div>
  
  <div class="card">
    <form on:submit|preventDefault={handleSubmit} class="space-y-6">
      <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
        <div class="form-group">
          <label for="employee" class="form-label">Employee</label>
          <select 
            id="employee" 
            bind:value={selectedEmployee} 
            class="form-input" 
            required
          >
            <option value="">Select Employee</option>
            {#each employees as employee}
              <option value={employee.id}>{employee.firstName} {employee.lastName}</option>
            {/each}
            }
          </select>
        </div>
        
        <div class="form-group">
          <label for="leaveType" class="form-label">Leave Type</label>
          <select 
            id="leaveType" 
            bind:value={leaveType} 
            class="form-input" 
            required
          >
            <option value="">Select Leave Type</option>
            <option value="annual">Annual Leave</option>
            <option value="sick">Sick Leave</option>
            <option value="maternity">Maternity Leave</option>
            <option value="paternity">Paternity Leave</option>
            <option value="unpaid">Unpaid Leave</option>
          </select>
        </div>
        
        <div class="form-group">
          <label for="startDate" class="form-label">Start Date</label>
          <input 
            type="date" 
            id="startDate" 
            bind:value={startDate} 
            class="form-input" 
            required
          />
        </div>
        
        <div class="form-group">
          <label for="endDate" class="form-label">End Date</label>
          <input 
            type="date" 
            id="endDate" 
            bind:value={endDate} 
            class="form-input" 
            required
          />
        </div>
        
        <div class="form-group">
          <label for="totalDays" class="form-label">Total Days</label>
          <input 
            type="number" 
            id="totalDays" 
            bind:value={totalDays} 
            class="form-input" 
            readonly
          />
        </div>
        
        <div class="form-group sm:col-span-2">
          <label for="reason" class="form-label">Reason</label>
          <textarea 
            id="reason" 
            bind:value={reason} 
            class="form-input h-24" 
            required
          ></textarea>
        </div>
      </div>
      
      <div class="flex justify-end space-x-3">
        <button type="button" class="btn btn-secondary" on:click={handleCancel}>
          Cancel
        </button>
        <button type="submit" class="btn btn-primary">
          Submit Request
        </button>
      </div>
    </form>
  </div>
</div>