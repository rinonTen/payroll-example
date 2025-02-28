<script lang="ts">
  import { page } from '$app/stores';
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  import type { Employee } from '$lib/types';
  
  // Mock data for a single employee
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
  
  function handleEdit() {
    goto(`/employees/${employee?.id}/edit`);
  }
  
  function handleBack() {
    goto('/employees');
  }
  
  function handleToggleStatus() {
    if (employee) {
      const newStatus = employee.status === 'active' ? 'inactive' : 'active';
      employee = { ...employee, status: newStatus };
      
      // In a real app, this would update the database
      toast.success(`Employee status changed to ${newStatus}`);
    }
  }
</script>

<svelte:head>
  <title>Employee Details | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Employee Details</h1>
      <p class="mt-1 text-sm text-gray-500">View employee information</p>
    </div>
    <div class="flex space-x-3">
      <button class="btn btn-secondary" on:click={handleBack}>
        Back to Employees
      </button>
      {#if employee}
        <button class="btn btn-primary" on:click={handleEdit}>
          Edit Employee
        </button>
      {/if}

    </div>
  </div>
  
  {#if loading}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Loading employee details...</p>
    </div>
  {:else if employee}
    <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
      <!-- Employee Overview -->
      <div class="card lg:col-span-1">
        <div class="flex flex-col items-center">
          <div class="h-24 w-24 rounded-full bg-primary-600 flex items-center justify-center text-white text-2xl font-bold mb-4">
            {employee.firstName.charAt(0)}{employee.lastName.charAt(0)}
          </div>
          
          <h2 class="text-xl font-semibold text-gray-900">{employee.firstName} {employee.lastName}</h2>
          <p class="text-gray-500">{employee.email}</p>
          
          <div class="mt-4 w-full">
            <div class="flex justify-between py-2 border-b border-gray-200">
              <span class="text-gray-500">Status</span>
              <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                {employee.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                {employee.status === 'active' ? 'Active' : 'Inactive'}
              </span>
            </div>
            
            <div class="flex justify-between py-2 border-b border-gray-200">
              <span class="text-gray-500">Staff Category</span>
              <span class="text-gray-900">{employee.staffCategory.name}</span>
            </div>
            
            <div class="flex justify-between py-2 border-b border-gray-200">
              <span class="text-gray-500">Skill Level</span>
              <span class="text-gray-900">{employee.skillLevel.name}</span>
            </div>
            
            <div class="flex justify-between py-2 border-b border-gray-200">
              <span class="text-gray-500">Contract Type</span>
              <span class="text-gray-900">
                {employee.contractType.name}
                {#if employee.contractType.isPartTime}
                  <span class="text-xs text-gray-500">(Part Time)</span>
                {/if}
          
              </span>
            </div>
            
            <div class="flex justify-between py-2 border-b border-gray-200">
              <span class="text-gray-500">Date Hired</span>
              <span class="text-gray-900">{employee.dateHired}</span>
            </div>
          </div>
          
          <div class="mt-6 w-full">
            <button 
              class="btn w-full {employee.status === 'active' ? 'btn-danger' : 'btn-primary'}"
              on:click={handleToggleStatus}
            >
              {employee.status === 'active' ? 'Deactivate Employee' : 'Activate Employee'}
            </button>
          </div>
        </div>
      </div>
      
      <!-- Employee Details -->
      <div class="lg:col-span-2 space-y-6">
        <!-- Personal Information -->
        <div class="card">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Personal Information</h3>
          
          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <p class="text-sm font-medium text-gray-500">Full Name</p>
              <p class="text-base font-medium">{employee.firstName} {employee.lastName}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Email</p>
              <p class="text-base font-medium">{employee.email}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Phone Number</p>
              <p class="text-base font-medium">{employee.phoneNumber || 'Not provided'}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Date of Birth</p>
              <p class="text-base font-medium">{employee.dateOfBirth || 'Not provided'}</p>
            </div>
          </div>
        </div>
        
        <!-- Employment Details -->
        <div class="card">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Employment Details</h3>
          
          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <p class="text-sm font-medium text-gray-500">Staff Category</p>
              <p class="text-base font-medium">{employee.staffCategory.name}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Skill Level</p>
              <p class="text-base font-medium">{employee.skillLevel.name}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Contract Type</p>
              <p class="text-base font-medium">
                {employee.contractType.name}
                {#if employee.contractType.isPartTime}
                  <span class="text-xs text-gray-500">(Part Time)</span>
                {/if}
          
              </p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Date Hired</p>
              <p class="text-base font-medium">{employee.dateHired}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Tax Rate</p>
              <p class="text-base font-medium">{employee.taxDetails.taxRate}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Tax ID</p>
              <p class="text-base font-medium">{employee.taxDetails.taxId || 'Not provided'}</p>
            </div>
          </div>
        </div>
        
        <!-- Bank Details -->
        <div class="card">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Bank Details</h3>
          
          <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <p class="text-sm font-medium text-gray-500">Bank Name</p>
              <p class="text-base font-medium">{employee.bankDetails.bankName || 'Not provided'}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Account Number</p>
              <p class="text-base font-medium">{employee.bankDetails.accountNumber || 'Not provided'}</p>
            </div>
            
            <div>
              <p class="text-sm font-medium text-gray-500">Branch Code</p>
              <p class="text-base font-medium">{employee.bankDetails.branchCode || 'Not provided'}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  {:else}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Employee not found</p>
    </div>
  {/if}
</div>