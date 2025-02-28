<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  
  // Mock data for payroll periods
  let payrollPeriods = [
    {
      id: '1',
      name: 'June 2025',
      startDate: '2025-06-01',
      endDate: '2025-06-30',
      payDate: '2025-07-05',
      status: 'processed',
      employeeCount: 42,
      totalAmount: 125000.00
    },
    {
      id: '2',
      name: 'July 2025',
      startDate: '2025-07-01',
      endDate: '2025-07-31',
      payDate: '2025-08-05',
      status: 'open',
      employeeCount: 45,
      totalAmount: 0
    }
  ];
  
  function handleNewPayrollPeriod() {
    goto('/payroll/new');
  }
  
  function handleViewPayrollPeriod(id: string) {
    goto(`/payroll/${id}`);
  }
  
  function getStatusBadgeClass(status: string) {
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
</script>

<svelte:head>
  <title>Payroll | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div class="flex justify-between items-center">
    <div>
      <h1 class="text-2xl font-semibold text-gray-900">Payroll</h1>
      <p class="mt-1 text-sm text-gray-500">Manage payroll periods and processing</p>
    </div>
    <button class="btn btn-primary" on:click={handleNewPayrollPeriod}>
      New Payroll Period
    </button>
  </div>
  
  <div class="card">
    <h2 class="text-lg font-medium text-gray-900 mb-4">Payroll Periods</h2>
    
    <div class="table-container">
      <table class="table">
        <thead class="table-header">
          <tr>
            <th class="table-header-cell">Period</th>
            <th class="table-header-cell">Date Range</th>
            <th class="table-header-cell">Pay Date</th>
            <th class="table-header-cell">Status</th>
            <th class="table-header-cell">Employees</th>
            <th class="table-header-cell">Total Amount</th>
            <th class="table-header-cell">Actions</th>
          </tr>
        </thead>
        <tbody class="table-body">
          {#each payrollPeriods as period}
            <tr class="table-row">
              <td class="table-cell font-medium text-gray-900">{period.name}</td>
              <td class="table-cell">{period.startDate} to {period.endDate}</td>
              <td class="table-cell">{period.payDate}</td>
              <td class="table-cell">
                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full {getStatusBadgeClass(period.status)}">
                  {period.status.charAt(0).toUpperCase() + period.status.slice(1)}
                </span>
              </td>
              <td class="table-cell">{period.employeeCount}</td>
              <td class="table-cell">
                {period.status === 'open' ? '—' : `$${period.totalAmount.toLocaleString('en-US', { minimumFractionDigits: 2 })}`}
              </td>
              <td class="table-cell">
                <button 
                  class="text-primary-600 hover:text-primary-900"
                  on:click={() => handleViewPayrollPeriod(period.id)}
                >
                  {period.status === 'open' ? 'Process' : 'View'}
                </button>
              </td>
            </tr>
          {/each}
          
          {#if payrollPeriods.length === 0}
            <tr>
              <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                No payroll periods found.
              </td>
            </tr>
          {/if}
        </tbody>
      </table>
    </div>
  </div>
  
  <div class="grid grid-cols-1 gap-6 lg:grid-cols-2">
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Payroll Summary</h2>
      <div class="space-y-4">
        <div class="flex justify-between">
          <span class="text-gray-500">Last Processed Payroll:</span>
          <span class="font-medium">June 2025</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Total Employees Paid:</span>
          <span class="font-medium">42</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Total Amount Paid:</span>
          <span class="font-medium">$125,000.00</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Total Tax Withheld:</span>
          <span class="font-medium">$18,750.00</span>
        </div>
        <div class="flex justify-between">
          <span class="text-gray-500">Next Pay Date:</span>
          <span class="font-medium">August 5, 2025</span>
        </div>
      </div>
    </div>
    
    <div class="card">
      <h2 class="text-lg font-medium text-gray-900 mb-4">Quick Actions</h2>
      <div class="space-y-3">
        <button class="btn btn-primary w-full text-left">Process Current Payroll</button>
        <button class="btn btn-secondary w-full text-left">Generate Payslips</button>
        <button class="btn btn-secondary w-full text-left">Export Payroll Data</button>
        <button class="btn btn-secondary w-full text-left">Tax Filing Report</button>
      </div>
    </div>
  </div>
</div>