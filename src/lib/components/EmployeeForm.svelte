<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import type { Employee, StaffCategory, SkillLevel, ContractType } from '$lib/types';
  import { getValidationRule } from '$lib/validationRules';
  
  export let employee: Partial<Employee> = {};
  export let staffCategories: StaffCategory[] = [];
  export let skillLevels: SkillLevel[] = [];
  export let contractTypes: ContractType[] = [];
  
  const dispatch = createEventDispatcher();
  
  let selectedStaffCategory = employee.staffCategory?.id || '';
  let selectedSkillLevel = employee.skillLevel?.id || '';
  let selectedContractType = employee.contractType?.id || '';
  let isPartTime = employee.contractType?.isPartTime || false;
  
  let validationRule = employee.id 
    ? getValidationRule(
        employee.staffCategory?.name || '',
        employee.skillLevel?.name || '',
        employee.contractType?.name || '',
        isPartTime
      )
    : undefined;
  
  function updateValidationRule() {
    const staffCategory = staffCategories.find(c => c.id === selectedStaffCategory);
    const skillLevel = skillLevels.find(s => s.id === selectedSkillLevel);
    const contractType = contractTypes.find(c => c.id === selectedContractType);
    
    if (staffCategory && skillLevel && contractType) {
      validationRule = getValidationRule(
        staffCategory.name,
        skillLevel.name,
        contractType.name,
        isPartTime
      );
    } else {
      validationRule = undefined;
    }
  }
  
  function handleSubmit() {
    const staffCategory = staffCategories.find(c => c.id === selectedStaffCategory);
    const skillLevel = skillLevels.find(s => s.id === selectedSkillLevel);
    const contractType = contractTypes.find(c => c.id === selectedContractType);
    
    const updatedEmployee = {
      ...employee,
      staffCategory,
      skillLevel,
      contractType: {
        ...contractType,
        isPartTime
      }
    };
    
    dispatch('submit', updatedEmployee);
  }
  
  $: if (selectedStaffCategory || selectedSkillLevel || selectedContractType || isPartTime) {
    updateValidationRule();
  }
</script>

<form on:submit|preventDefault={handleSubmit} class="space-y-6">
  <div class="grid grid-cols-1 gap-6 sm:grid-cols-2">
    <!-- Personal Information -->
    <div class="form-group">
      <label for="firstName" class="form-label">First Name</label>
      <input 
        type="text" 
        id="firstName" 
        bind:value={employee.firstName} 
        class="form-input" 
        required
      />
    </div>
    
    <div class="form-group">
      <label for="lastName" class="form-label">Last Name</label>
      <input 
        type="text" 
        id="lastName" 
        bind:value={employee.lastName} 
        class="form-input" 
        required
      />
    </div>
    
    <div class="form-group">
      <label for="email" class="form-label">Email</label>
      <input 
        type="email" 
        id="email" 
        bind:value={employee.email} 
        class="form-input" 
        required
      />
    </div>
    
    <div class="form-group">
      <label for="phoneNumber" class="form-label">Phone Number</label>
      <input 
        type="tel" 
        id="phoneNumber" 
        bind:value={employee.phoneNumber} 
        class="form-input"
      />
    </div>
    
    <div class="form-group">
      <label for="dateOfBirth" class="form-label">Date of Birth</label>
      <input 
        type="date" 
        id="dateOfBirth" 
        bind:value={employee.dateOfBirth} 
        class="form-input"
      />
    </div>
    
    <div class="form-group">
      <label for="dateHired" class="form-label">Date Hired</label>
      <input 
        type="date" 
        id="dateHired" 
        bind:value={employee.dateHired} 
        class="form-input" 
        required
      />
    </div>
    
    <!-- Employment Details -->
    <div class="form-group">
      <label for="staffCategory" class="form-label">Staff Category</label>
      <select 
        id="staffCategory" 
        bind:value={selectedStaffCategory} 
        class="form-input" 
        required
      >
        <option value="">Select Staff Category</option>
        {#each staffCategories as category}
          <option value={category.id}>{category.name}</option>
        {/each}
      </select>
    </div>
    
    <div class="form-group">
      <label for="skillLevel" class="form-label">Skill Level</label>
      <select 
        id="skillLevel" 
        bind:value={selectedSkillLevel} 
        class="form-input" 
        required
      >
        <option value="">Select Skill Level</option>
        {#each skillLevels as level}
          <option value={level.id}>{level.name}</option>
        {/each}
      </select>
    </div>
    
    <div class="form-group">
      <label for="contractType" class="form-label">Contract Type</label>
      <select 
        id="contractType" 
        bind:value={selectedContractType} 
        class="form-input" 
        required
      >
        <option value="">Select Contract Type</option>
        {#each contractTypes as type}
          <option value={type.id}>{type.name}</option>
        {/each}
      </select>
    </div>
    
    <div class="form-group">
      <label class="form-label flex items-center">
        <input 
          type="checkbox" 
          bind:checked={isPartTime} 
          class="mr-2 h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300 rounded"
        />
        <span>Part Time</span>
      </label>
    </div>
    
    <!-- Tax Details -->
    <div class="form-group">
      <label for="taxId" class="form-label">Tax ID</label>
      <input 
        type="text" 
        id="taxId" 
        value={employee.taxDetails?.taxId} 
        class="form-input"
      />
    </div>
    
    <!-- Bank Details -->
    <div class="form-group">
      <label for="bankName" class="form-label">Bank Name</label>
      <input 
        type="text" 
        id="bankName" 
        value={employee.bankDetails?.bankName} 
        class="form-input"
      />
    </div>
    
    <div class="form-group">
      <label for="accountNumber" class="form-label">Account Number</label>
      <input 
        type="text" 
        id="accountNumber" 
        value={employee.bankDetails?.accountNumber} 
        class="form-input"
      />
    </div>
    
    <div class="form-group">
      <label for="branchCode" class="form-label">Branch Code</label>
      <input 
        type="text" 
        id="branchCode" 
        value={employee.bankDetails?.branchCode} 
        class="form-input"
      />
    </div>
  </div>
  
  {#if validationRule}
    <div class="card bg-gray-50">
      <h3 class="text-lg font-medium text-gray-900 mb-4">Entitlements Based on Employee Category</h3>
      
      <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3">
        <div>
          <p class="text-sm font-medium text-gray-500">Annual Leave</p>
          <p class="text-base font-medium">{validationRule.annualLeave ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">CNAPS</p>
          <p class="text-base font-medium">{validationRule.cnaps ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Tax Rate</p>
          <p class="text-base font-medium">{validationRule.taxRate}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Maternity Payment</p>
          <p class="text-base font-medium">{validationRule.maternityPayment ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">15 Months Extra Hour</p>
          <p class="text-base font-medium">{validationRule.extraHour15Months ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Child Support</p>
          <p class="text-base font-medium">{validationRule.childSupport ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Leave Type</p>
          <p class="text-base font-medium">{validationRule.leaveType}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Rent</p>
          <p class="text-base font-medium">{validationRule.rent ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Overtime</p>
          <p class="text-base font-medium">{validationRule.overtime ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Public Holiday Extra Pay</p>
          <p class="text-base font-medium">{validationRule.pubHolidayPay ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Meal Cost Adjustment</p>
          <p class="text-base font-medium">{validationRule.mealCostAdj ? 'Yes' : 'No'}</p>
        </div>
        
        <div>
          <p class="text-sm font-medium text-gray-500">Monthly Meal Plan</p>
          <p class="text-base font-medium">{validationRule.monthlyMealPlan ? 'Yes' : 'No'}</p>
        </div>
      </div>
    </div>
  {/if}
  
  <div class="flex justify-end space-x-3">
    <button type="button" class="btn btn-secondary" on:click={() => dispatch('cancel')}>
      Cancel
    </button>
    <button type="submit" class="btn btn-primary">
      {employee.id ? 'Update Employee' : 'Create Employee'}
    </button>
  </div>
</form>