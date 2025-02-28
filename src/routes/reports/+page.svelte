<script lang="ts">
  import { onMount } from 'svelte';
  
  // Mock data for reports
  let reports = [
    {
      id: '1',
      name: 'Payroll Summary',
      description: 'Summary of all payroll transactions for a specific period',
      lastGenerated: '2025-06-15',
      format: 'PDF, Excel'
    },
    {
      id: '2',
      name: 'Tax Withholding',
      description: 'Details of tax withholding for all employees',
      lastGenerated: '2025-06-10',
      format: 'PDF, Excel'
    },
    {
      id: '3',
      name: 'Leave Balance',
      description: 'Current leave balances for all employees',
      lastGenerated: '2025-06-05',
      format: 'PDF, Excel'
    },
    {
      id: '4',
      name: 'Overtime Report',
      description: 'Summary of overtime hours worked by employees',
      lastGenerated: '2025-06-01',
      format: 'PDF, Excel'
    },
    {
      id: '5',
      name: 'Employee Census',
      description: 'Demographic information about your workforce',
      lastGenerated: '2025-05-15',
      format: 'PDF, Excel'
    }
  ];
  
  let selectedReport = '';
  let startDate = '';
  let endDate = '';
  let reportFormat = 'pdf';
  
  function handleGenerateReport() {
    // In a real app, this would generate the report
    console.log('Generating report:', {
      reportId: selectedReport,
      startDate,
      endDate,
      format: reportFormat
    });
    
    // Mock success message
    alert('Report generated successfully!');
  }
</script>

<svelte:head>
  <title>Reports | PayrollPro</title>
</svelte:head>

<div class="space-y-6">
  <div>
    <h1 class="text-2xl font-semibold text-gray-900">Reports</h1>
    <p class="mt-1 text-sm text-gray-500">Generate and view payroll reports</p>
  </div>
  
  <div class="grid grid-cols-1 gap-6 lg:grid-cols-3">
    <div class="lg:col-span-2">
      <div class="card">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Available Reports</h2>
        
        <div class="table-container">
          <table class="table">
            <thead class="table-header">
              <tr>
                <th class="table-header-cell">Report Name</th>
                <th class="table-header-cell">Description</th>
                <th class="table-header-cell">Last Generated</th>
                <th class="table-header-cell">Format</th>
                <th class="table-header-cell">Actions</th>
              </tr>
            </thead>
            <tbody class="table-body">
              {#each reports as report}
                <tr class="table-row">
                  <td class="table-cell font-medium text-gray-900">{report.name}</td>
                  <td class="table-cell">{report.description}</td>
                  <td class="table-cell">{report.lastGenerated}</td>
                  <td class="table-cell">{report.format}</td>
                  <td class="table-cell">
                    <button 
                      class="text-primary-600 hover:text-primary-900"
                      on:click={() => selectedReport = report.id}
                    >
                      Generate
                    </button>
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      </div>
    </div>
    
    <div>
      <div class="card">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Generate Report</h2>
        
        <form on:submit|preventDefault={handleGenerateReport} class="space-y-4">
          <div class="form-group">
            <label for="reportType" class="form-label">Report Type</label>
            <select 
              id="reportType" 
              bind:value={selectedReport} 
              class="form-input" 
              required
            >
              <option value="">Select a report</option>
              {#each reports as report}
                <option value={report.id}>{report.name}</option>
              {/each}
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
            <label class="form-label">Format</label>
            <div class="mt-1 space-y-2">
              <label class="inline-flex items-center">
                <input 
                  type="radio" 
                  bind:group={reportFormat} 
                  value="pdf" 
                  class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300"
                />
                <span class="ml-2">PDF</span>
              </label>
              <label class="inline-flex items-center">
                <input 
                  type="radio" 
                  bind:group={reportFormat} 
                  value="excel" 
                  class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300"
                />
                <span class="ml-2">Excel</span>
              </label>
              <label class="inline-flex items-center">
                <input 
                  type="radio" 
                  bind:group={reportFormat} 
                  value="csv" 
                  class="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300"
                />
                <span class="ml-2">CSV</span>
              </label>
            </div>
          </div>
          
          <button 
            type="submit" 
            class="btn btn-primary w-full"
            disabled={!selectedReport || !startDate || !endDate}
          >
            Generate Report
          </button>
        </form>
      </div>
      
      <div class="mt-6 card">
        <h2 class="text-lg font-medium text-gray-900 mb-4">Recent Reports</h2>
        
        <div class="space-y-4">
          <div class="flex items-start">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <p class="text-sm font-medium text-gray-900">Payroll Summary - June 2025</p>
              <p class="text-sm text-gray-500">Generated on June 15, 2025</p>
              <a href="#" class="text-sm text-primary-600 hover:text-primary-900">Download PDF</a>
            </div>
          </div>
          
          <div class="flex items-start">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <p class="text-sm font-medium text-gray-900">Tax Withholding - Q2 2025</p>
              <p class="text-sm text-gray-500">Generated on June 10, 2025</p>
              <a href="#" class="text-sm text-primary-600 hover:text-primary-900">Download Excel</a>
            </div>
          </div>
          
          <div class="flex items-start">
            <div class="flex-shrink-0">
              <svg class="h-5 w-5 text-primary-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clip-rule="evenodd" />
              </svg>
            </div>
            <div class="ml-3">
              <p class="text-sm font-medium text-gray-900">Leave Balance - June 2025</p>
              <p class="text-sm text-gray-500">Generated on June 5, 2025</p>
              <a href="#" class="text-sm text-primary-600 hover:text-primary-900">Download PDF</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>