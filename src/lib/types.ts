export interface Employee {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phoneNumber: string;
  dateOfBirth: string;
  dateHired: string;
  staffCategory: StaffCategory;
  skillLevel: SkillLevel;
  contractType: ContractType;
  taxDetails: TaxDetails;
  bankDetails: BankDetails;
  status: 'active' | 'inactive';
  createdAt: string;
  updatedAt: string;
}

export interface StaffCategory {
  id: string;
  name: string; // 'Malagasy via BVF', 'Malagasy Cash', 'International via WISE'
  currencyType: 'local' | 'foreign';
  paymentMethod: string; // 'BVF', 'Cash', 'WISE'
}

export interface SkillLevel {
  id: string;
  name: string; // 'Skilled - Dev', 'Skilled - Non Dev', 'Unskilled', 'Skilled'
}

export interface ContractType {
  id: string;
  name: string; // 'Permanent / Fixed term', 'Contractor', 'Contract', 'Volunteer'
  isPartTime: boolean;
}

export interface TaxDetails {
  taxRate: string; // 'up to 20% Tiered', '5%', 'N/A'
  taxId: string;
}

export interface BankDetails {
  bankName: string;
  accountNumber: string;
  branchCode: string;
}

export interface PayrollPeriod {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
  payDate: string;
  status: 'open' | 'processing' | 'processed' | 'closed';
  createdAt: string;
  updatedAt: string;
}

export interface PayItem {
  id: string;
  employeeId: string;
  payrollPeriodId: string;
  type: 'salary' | 'allowance' | 'bonus' | 'deduction' | 'tax';
  description: string;
  amount: number;
  createdAt: string;
  updatedAt: string;
}

export interface Entitlement {
  id: string;
  employeeId: string;
  type: 'annual_leave' | 'maternity_payment' | 'extra_hour' | 'child_support' | 'meal_plan';
  value: string | boolean | number;
  status: 'active' | 'inactive';
  createdAt: string;
  updatedAt: string;
}

export interface LeaveRequest {
  id: string;
  employeeId: string;
  type: 'annual' | 'sick' | 'maternity' | 'paternity' | 'unpaid';
  startDate: string;
  endDate: string;
  totalDays: number;
  reason: string;
  status: 'pending' | 'approved' | 'rejected';
  createdAt: string;
  updatedAt: string;
}

export interface OvertimeRequest {
  id: string;
  employeeId: string;
  date: string;
  hours: number;
  reason: string;
  status: 'pending' | 'approved' | 'rejected';
  createdAt: string;
  updatedAt: string;
}

export interface ValidationRule {
  staffCategory: string;
  skillLevel: string;
  contractType: string;
  isPartTime: boolean;
  annualLeave: boolean;
  cnaps: boolean;
  taxRate: string;
  maternityPayment: boolean;
  extraHour15Months: boolean;
  childSupport: boolean;
  leaveType: string;
  rent: boolean;
  overtime: boolean;
  pubHolidayPay: boolean;
  mealCostAdj: boolean;
  monthlyMealPlan: boolean;
  adHoc: boolean;
}