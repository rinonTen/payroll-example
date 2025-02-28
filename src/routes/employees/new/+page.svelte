<script lang="ts">
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import EmployeeForm from '$lib/components/EmployeeForm.svelte';
  
  // Mock data for dropdowns
  const staffCategories = [
    { id: '1', name: 'Malagasy (local currency) via BVF', currencyType: 'local', paymentMethod: 'BVF' },
    { id: '2', name: 'Malagasy (local currency) Cash', currencyType: 'local', paymentMethod: 'Cash' },
    { id: '3', name: 'International (foreign currency) via WISE', currencyType: 'foreign', paymentMethod: 'WISE' }
  ];
  
  const skillLevels = [
    { id: '1', name: 'Skilled - Dev' },
    { id: '2', name: 'Skilled - Non Dev' },
    { id: '3', name: 'Unskilled' },
    { id: '4', name: 'Skilled' }
  ];
  
  const contractTypes = [
    { id: '1', name: 'Permanent / Fixed term', isPartTime: false },
    { id: '2', name: 'Contractor', isPartTime: false },
    { id: '3', name: 'Contract', isPartTime: false },
    { id: '4', name: 'Volunteer', isPartTime: false }
  ];
  
  function handleSubmit(event) {
    // In a real app, this would save to the database
    console.log('Creating employee:', event.detail);
    
    toast.success('Employee created successfully!');
    goto('/employees');
  }
  
  function handleCancel() {
    goto('/employees');
  }
</script>

<svelte:head>
  <title>Add Employee | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">Add New Employee</h1>
    <p class="mt-1 text-sm text-gray-500">Create a new employee record</p>
  </div>
  
  <div class="card">
    <EmployeeForm 
      {staffCategories}
      {skillLevels}
      {contractTypes}
      on:submit={handleSubmit}
      on:cancel={handleCancel}
    />
  </div>
</div>