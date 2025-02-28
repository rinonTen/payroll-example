<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  
  // Mock data for employees
  let employees = [
    {
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      staffCategory: { name: 'Malagasy (local currency) via BVF' },
      skillLevel: { name: 'Skilled - Dev' },
      contractType: { name: 'Permanent / Fixed term', isPartTime: false },
      status: 'active'
    },
    {
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane.smith@example.com',
      staffCategory: { name: 'Malagasy (local currency) Cash' },
      skillLevel: { name: 'Unskilled' },
      contractType: { name: 'Contractor', isPartTime: true },
      status: 'active'
    },
    {
      id: '3',
      firstName: 'Michael',
      lastName: 'Johnson',
      email: 'michael.johnson@example.com',
      staffCategory: { name: 'International (foreign currency) via WISE' },
      skillLevel: { name: 'Skilled' },
      contractType: { name: 'Contract', isPartTime: false },
      status: 'inactive'
    }
  ];
  
  let searchTerm = '';
  let statusFilter = 'all';
  
  $: filteredEmployees = employees.filter(employee => {
    const matchesSearch = 
      employee.firstName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      employee.lastName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      employee.email.toLowerCase().includes(searchTerm.toLowerCase());
    
    const matchesStatus = 
      statusFilter === 'all' || 
      employee.status === statusFilter;
    
    return matchesSearch && matchesStatus;
  });
  
  function handleAddEmployee() {
    goto('/employees/new');
  }
  
  function handleEditEmployee(id: string) {
    goto(`/employees/${id}/edit`);
  }
  
  function handleViewEmployee(id: string) {
    goto(`/employees/${id}`);
  }
</script>

<svelte:head>
  <title>Employees | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Employees</h1>
      <p class="mt-1 text-sm text-gray-500">Manage your employee records</p>
    </div>
    <button class="btn btn-primary" on:click={handleAddEmployee}>
      Add Employee
    </button>
  </div>
  
  <div class="card">
    <div class="flex flex-col sm:flex-row justify-between space-y-3 sm:space-y-0 sm:space-x-4 mb-6">
      <div class="relative flex-1">
        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
          </svg>
        </div>
        <input
          type="text"
          bind:value={searchTerm}
          placeholder="Search employees..."
          class="form-input pl-10"
        />
      </div>
      
      <div class="sm:w-48">
        <select bind:value={statusFilter} class="form-input">
          <option value="all">All Status</option>
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
      </div>
    </div>
    
    <div class="table-container">
      <table class="table">
        <thead class="table-header">
          <tr>
            <th class="table-header-cell">Name</th>
            <th class="table-header-cell">Email</th>
            <th class="table-header-cell">Staff Category</th>
            <th class="table-header-cell">Skill Level</th>
            <th class="table-header-cell">Contract Type</th>
            <th class="table-header-cell">Status</th>
            <th class="table-header-cell">Actions</th>
          </tr>
        </thead>
        <tbody class="table-body">
          {#each filteredEmployees as employee}
            <tr class="table-row">
              <td class="table-cell font-medium text-gray-900">
                {employee.firstName} {employee.lastName}
              </td>
              <td class="table-cell">{employee.email}</td>
              <td class="table-cell">{employee.staffCategory.name}</td>
              <td class="table-cell">{employee.skillLevel.name}</td>
              <td class="table-cell">
                {employee.contractType.name}
                {#if employee.contractType.isPartTime}
                  <span class="text-xs text-gray-500">(Part Time)</span>
                {/if}
    
              </td>
              <td class="table-cell">
                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                  {employee.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                  {employee.status === 'active' ? 'Active' : 'Inactive'}
                </span>
              </td>
              <td class="table-cell">
                <div class="flex space-x-2">
                  <button 
                    class="text-primary-600 hover:text-primary-900"
                    on:click={() => handleViewEmployee(employee.id)}
                  >
                    View
                  </button>
                  <button 
                    class="text-primary-600 hover:text-primary-900"
                    on:click={() => handleEditEmployee(employee.id)}
                  >
                    Edit
                  </button>
                </div>
              </td>
            </tr>
          {/each}
          
          {#if filteredEmployees.length === 0}
            <tr>
              <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                No employees found matching your search criteria.
              </td>
            </tr>
          {/if}
        </tbody>
      </table>
    </div>
  </div>
</div>