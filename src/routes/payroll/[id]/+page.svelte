<script lang="ts">
  import { page } from '$app/stores';
  import { goto } from '$app/navigation';
  import toast from 'svelte-french-toast';
  import { onMount } from 'svelte';
  
  let payrollPeriod = null;
  let payItems = [];
  let loading = true;
  
  onMount(async () => {
    // In a real app, this would fetch from the database
    // Simulate API call delay
    setTimeout(() => {
      const payrollId = $page.params.id;
      
      // Mock payroll period data
      payrollPeriod = {
        id: payrollId,
        name: 'July 2025',
        startDate: '2025-07-01',
        endDate: '2025-07-31',
        payDate: '2025-08-05',
        status: 'open',
        employeeCount: 45,
        totalAmount: 0
      };
      
      // Mock pay items data
      payItems = [
        {
          id: '1',
          employee: { id: '1', firstName: 'John', lastName: 'Doe' },
          type: 'salary',
          description: 'Base Salary',
          amount: 5000.00,
          status: 'pending'
        },
        {
          id: '2',
          employee: { id: '1', firstName: 'John', lastName: 'Doe' },
          type: 'allowance',
          description: 'Transportation Allowance',
          amount: 200.00,
          status: 'pending'
        },
        {
          id: '3',
          employee: { id: '2', firstName: 'Jane', lastName: 'Smith' },
          type: 'salary',
          description: 'Base Salary',
          amount: 4500.00,
          status: 'pending'
        },
        {
          id: '4',
          employee: { id: '3', firstName: 'Michael', lastName: 'Johnson' },
          type: 'salary',
          description: 'Base Salary',
          amount: 6000.00,
          status: 'pending'
        },
        {
          id: '5',
          employee: { id: '3', firstName: 'Michael', lastName: 'Johnson' },
          type: 'bonus',
          description: 'Performance Bonus',
          amount: 1000.00,
          status: 'pending'
        }
      ];
      
      loading = false;
    }, 500);
  });
  
  function handleBack() {
    goto('/payroll');
  }
  
  function handleProcessPayroll() {
    // In a real app, this would update the database
    if (payrollPeriod) {
      payrollPeriod.status = 'processing';
      
      // Simulate processing
      setTimeout(() => {
        payrollPeriod.status = 'processed';
        payrollPeriod.totalAmount = payItems.reduce((total, item) => total + item.amount, 0);
        
        toast.success('Payroll processed successfully!');
      }, 1500);
    }
  }
  
  function handleAddPayItem() {
    // In a real app, this would open a modal or navigate to a form
    toast.success('Feature coming soon!');
  }
  
  function getStatusBadgeClass(status) {
    switch (status) {
      case 'open':
        return 'bg-blue-100 text-blue-800';
      case 'processing':
        return 'bg-yellow-100 text-yellow-800';
      case 'processed':
        return 'bg-green-100 text-green-800';
      case 'closed':
        return 'bg-gray-100 text-gray-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  }
  
  function getPayItemTypeClass(type) {
    switch (type) {
      case 'salary':
        return 'text-blue-600';
      case 'allowance':
        return 'text-green-600';
      case 'bonus':
        return 'text-purple-600';
      case 'deduction':
        return 'text-red-600';
      case 'tax':
        return 'text-orange-600';
      default:
        return 'text-gray-600';
    }
  }
</script>

<svelte:head>
  <title>Payroll Period Details | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Payroll Period Details</h1>
      <p class="mt-1 text-sm text-gray-500">View and process payroll</p>
    </div>
    <div class="flex space-x-3">
      <button class="btn btn-secondary" on:click={handleBack}>
        Back to Payroll
      </button>
      {#if payrollPeriod && payrollPeriod.status === 'open'}
        <button class="btn btn-primary" on:click={handleProcessPayroll}>
          Process Payroll
        </button>
      {/if}
    </div>
  </div>
  
  {#if loading}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Loading payroll details...</p>
    </div>
  {:else if payrollPeriod}
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Payroll Period Information</h2>
      
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4 mb-6">
        <div>
          <p class="text-sm font-medium text-gray-500">Period Name</p>
          <p class="text-base font-medium">{payrollPeriod.name}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Date Range</p>
          <p class="text-base font-medium">{payrollPeriod.startDate} to {payrollPeriod.endDate}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Pay Date</p>
          <p class="text-base font-medium">{payrollPeriod.payDate}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Status</p>
          <p class="text-base">
            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full {getStatusBadgeClass(payrollPeriod.status)}">
              {payrollPeriod.status.charAt(0).toUpperCase() + payrollPeriod.status.slice(1)}
            </span>
          </p>
        </div>
      </div>
      
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-medium text-gray-900">Pay Items</h3>
        
        {#if payrollPeriod.status === 'open'}
          <button class="btn btn-secondary" on:click={handleAddPayItem}>
            Add Pay Item
          </button>
        {/if}
      </div>
      
      <div class="table-container">
        <table class="table">
          <thead class="table-header">
            <tr>
              <th class="table-header-cell">Employee</th>
              <th class="table-header-cell">Type</th>
              <th class="table-header-cell">Description</th>
              <th class="table-header-cell">Amount</th>
              <th class="table-header-cell">Status</th>
            </tr>
          </thead>
          <tbody class="table-body">
            {#each payItems as item}
              <tr class="table-row">
                <td class="table-cell font-medium text-gray-900">
                  {item.employee.firstName} {item.employee.lastName}
                </td>
                <td class="table-cell">
                  <span class={getPayItemTypeClass(item.type)}>
                    {item.type.charAt(0).toUpperCase() + item.type.slice(1)}
                  </span>
                </td>
                <td class="table-cell">{item.description}</td>
                <td class="table-cell font-medium text-gray-900">
                  ${item.amount.toLocaleString('en-US', { minimumFractionDigits: 2 })}
                </td>
                <td class="table-cell">
                  <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                    {payrollPeriod.status === 'processed' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}">
                    {payrollPeriod.status === 'processed' ? 'Processed' : 'Pending'}
                  </span>
                </td>
              </tr>
            {/each}
            
            {#if payItems.length === 0}
              <tr>
                <td colspan="5" class="px-6 py-10 text-center text-gray-500">
                  No pay items found for this payroll period.
                </td>
              </tr>
            {/if}
          </tbody>
          {#if payItems.length > 0}
            <tfoot class="bg-gray-50">
              <tr>
                <td colspan="3" class="px-6 py-3 text-right font-medium">Total:</td>
                <td class="px-6 py-3 font-bold text-gray-900">
                  ${payItems.reduce((total, item) => total + item.amount, 0).toLocaleString('en-US', { minimumFractionDigits: 2 })}
                </td>
                <td></td>
              </tr>
            </tfoot>
          {/if}
        </table>
      </div>
    </div>
    
    {#if payrollPeriod.status === 'processed'}
      <div class="card">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Payroll Summary</h2>
        
        <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <div>
            <p class="text-sm font-medium text-gray-500">Total Employees</p>
            <p class="text-xl font-medium">{payrollPeriod.employeeCount}</p>
          </div>
          
          <div>
            <p class="text-sm font-medium text-gray-500">Total Gross Amount</p>
            <p class="text-xl font-medium">
              ${payItems.reduce((total, item) => total + item.amount, 0).toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </p>
          </div>
          
          <div>
            <p class="text-sm font-medium text-gray-500">Total Tax Withheld</p>
            <p class="text-xl font-medium">
              ${(payItems.reduce((total, item) => total + item.amount, 0) * 0.15).toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </p>
          </div>
          
          <div>
            <p class="text-sm font-medium text-gray-500">Total Net Amount</p>
            <p class="text-xl font-medium">
              ${(payItems.reduce((total, item) => total + item.amount, 0) * 0.85).toLocaleString('en-US', { minimumFractionDigits: 2 })}
            </p>
          </div>
        </div>
        
        <div class="mt-6 flex space-x-4">
          <button class="btn btn-primary">Generate Payslips</button>
          <button class="btn btn-secondary">Export Payroll Data</button>
        </div>
      </div>
    {/if}
  {:else}
    <div class="card flex justify-center items-center py-12">
      <p class="text-gray-500">Payroll period not found</p>
    </div>
  {/if}
</div>