<script lang="ts">
  import { page } from '$app/stores';
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  import EmployeeForm from '$lib/components/EmployeeForm.svelte';
  import type { Employee } from '$lib/types';
  
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
  
  let employee: Employee | null = null;
  let loading = true;
  
  onMount(async () => {
    // In a real app, this would fetch from the database
    // Simulate API call delay
    setTimeout(() => {
      const employeeId = $page.params.id;
      
      // Mock employee data
      employee = {
        id: employeeId,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phoneNumber: '+1234567890',
        dateOfBirth: '1990-01-15',
        dateHired: '2023-05-10',
        staffCategory: { 
          id: '1', 
          name: 'Malagasy (local currency) via BVF',
          currencyType: 'local',
          paymentMethod: 'BVF'
        },
        skillLevel: { 
          id: '1', 
          name: 'Skilled - Dev' 
        },
        contractType: { 
          id: '1', 
          name: 'Permanent / Fixed term',
          isPartTime: false
        },
        taxDetails: {
          taxRate: 'up to 20% Tiered',
          taxId: 'TX123456'
        },
        bankDetails: {
          bankName: 'Example Bank',
          accountNumber: '1234567890',
          branchCode: 'BR001'
        },
        status: 'active',
        createdAt: '2023-05-10T10:00:00Z',
        updatedAt: '2023-06-15T14:30:00Z'
      };
      
      loading = false;
    }, 500);
  });
  
  function handleSubmit(event) {
    // In a real app, this would update the database
    console.log('Updating employee:', event.detail);
    
    toast.success('Employee updated successfully!');
    goto(`/employees/${employee?.id}`);
  }
  
  function handleCancel() {
    goto(`/employees/${employee?.id}`);
  }
</script>

<svelte:head>
  <title>Edit Employee | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">Edit Employee</h1>
    <p class="mt-1 text-sm text-gray-500">Update employee information</p>
  </div>
  
  {#if loading}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Loading employee details...</p>
    </div>
  {:else if employee}
    <div class="card">
      <EmployeeForm 
        employee={employee}
        {staffCategories}
        {skillLevels}
        {contractTypes}
        on:submit={handleSubmit}
        on:cancel={handleCancel}
      />
    </div>
  {:else}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Employee not found</p>
    </div>
  {/if}

</div>