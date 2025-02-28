import type { ValidationRule } from './types';

export const validationRules: ValidationRule[] = [
  {
    staffCategory: 'Malagasy (local currency) via BVF',
    skillLevel: 'Skilled - Dev',
    contractType: 'Permanent / Fixed term',
    isPartTime: false,
    annualLeave: true,
    cnaps: true,
    taxRate: 'up to 20% Tiered',
    maternityPayment: true,
    extraHour15Months: true,
    childSupport: true,
    leaveType: 'check balance',
    rent: true,
    overtime: false,
    pubHolidayPay: true,
    mealCostAdj: true,
    monthlyMealPlan: true,
    adHoc: true
  },
  {
    staffCategory: 'Malagasy (local currency) via BVF',
    skillLevel: 'Skilled - Non Dev',
    contractType: 'Permanent / Fixed term',
    isPartTime: true,
    annualLeave: true,
    cnaps: true,
    taxRate: 'up to 20% Tiered',
    maternityPayment: true,
    extraHour15Months: false,
    childSupport: true,
    leaveType: 'check balance',
    rent: true,
    overtime: false,
    pubHolidayPay: false,
    mealCostAdj: true,
    monthlyMealPlan: true,
    adHoc: true
  },
  {
    staffCategory: 'Malagasy (local currency) via BVF',
    skillLevel: 'Skilled - Non Dev',
    contractType: 'Contractor',
    isPartTime: true,
    annualLeave: false,
    cnaps: false,
    taxRate: '5%',
    maternityPayment: false,
    extraHour15Months: false,
    childSupport: false,
    leaveType: 'unpaid',
    rent: true,
    overtime: false,
    pubHolidayPay: false,
    mealCostAdj: true,
    monthlyMealPlan: true,
    adHoc: true
  },
  {
    staffCategory: 'Malagasy (local currency) Cash',
    skillLevel: 'Unskilled',
    contractType: 'Permanent / Fixed term',
    isPartTime: true,
    annualLeave: true,
    cnaps: true,
    taxRate: 'up to 20% Tiered',
    maternityPayment: true,
    extraHour15Months: false,
    childSupport: true,
    leaveType: 'check balance',
    rent: true,
    overtime: true,
    pubHolidayPay: true,
    mealCostAdj: true,
    monthlyMealPlan: true,
    adHoc: true
  },
  {
    staffCategory: 'Malagasy (local currency) Cash',
    skillLevel: 'Unskilled',
    contractType: 'Contractor',
    isPartTime: true,
    annualLeave: false,
    cnaps: false,
    taxRate: '5%',
    maternityPayment: false,
    extraHour15Months: false,
    childSupport: false,
    leaveType: 'unpaid',
    rent: true,
    overtime: true,
    pubHolidayPay: true,
    mealCostAdj: true,
    monthlyMealPlan: true,
    adHoc: true
  },
  {
    staffCategory: 'International (foreign currency) via WISE',
    skillLevel: 'Skilled',
    contractType: 'Contract',
    isPartTime: false,
    annualLeave: false,
    cnaps: false,
    taxRate: '5%',
    maternityPayment: false,
    extraHour15Months: false,
    childSupport: false,
    leaveType: 'unpaid',
    rent: false,
    overtime: false,
    pubHolidayPay: false,
    mealCostAdj: false,
    monthlyMealPlan: false,
    adHoc: false
  },
  {
    staffCategory: 'International (foreign currency) via WISE',
    skillLevel: 'Skilled',
    contractType: 'Volunteer',
    isPartTime: false,
    annualLeave: true,
    cnaps: false,
    taxRate: 'N/A',
    maternityPayment: false,
    extraHour15Months: false,
    childSupport: false,
    leaveType: 'unlimited',
    rent: false,
    overtime: false,
    pubHolidayPay: false,
    mealCostAdj: false,
    monthlyMealPlan: false,
    adHoc: false
  }
];

export function getValidationRule(
  staffCategory: string,
  skillLevel: string,
  contractType: string,
  isPartTime: boolean
): ValidationRule | undefined {
  return validationRules.find(
    rule => 
      rule.staffCategory === staffCategory &&
      rule.skillLevel === skillLevel &&
      rule.contractType === contractType &&
      rule.isPartTime === isPartTime
  );
}