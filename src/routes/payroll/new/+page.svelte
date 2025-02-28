<script lang="ts">
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  
  let name = '';
  let startDate = '';
  let endDate = '';
  let payDate = '';
  
  function handleSubmit() {
    // In a real app, this would save to the database
    const payrollPeriod = {
      name,
      startDate,
      endDate,
      payDate,
      status: 'open'
    };
    
    console.log('Creating payroll period:', payrollPeriod);
    
    toast.success('Payroll period created successfully!');
    goto('/payroll');
  }
  
  function handleCancel() {
    goto('/payroll');
  }
</script>

<svelte:head>
  <title>New Payroll Period | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">New Payroll Period</h1>
    <p class="mt-1 text-sm text-gray-500">Create a new payroll period</p>
  </div>
  
  <div class="card">
    <form on:submit|preventDefault={handleSubmit} class="space-y-6">
      <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
        <div class="form-group sm:col-span-2">
          <label for="name" class="form-label">Period Name</label>
          <input 
            type="text" 
            id="name" 
            bind:value={name} 
            placeholder="e.g., July 2025" 
            class="form-input" 
            required
          />
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
          <label for="payDate" class="form-label">Pay Date</label>
          <input 
            type="date" 
            id="payDate" 
            bind:value={payDate} 
            class="form-input" 
            required
          />
        </div>
      </div>
      
      <div class="flex justify-end space-x-3">
        <button type="button" class="btn btn-secondary" on:click={handleCancel}>
          Cancel
        </button>
        <button type="submit" class="btn btn-primary">
          Create Payroll Period
        </button>
      </div>
    </form>
  </div>
</div>