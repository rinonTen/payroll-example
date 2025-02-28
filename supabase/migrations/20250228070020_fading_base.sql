/*
  # Initial Schema for Payroll Management System

  1. New Tables
    - `staff_categories` - Categories of staff (Malagasy via BVF, Malagasy Cash, International via WISE)
    - `skill_levels` - Skill levels (Skilled - Dev, Skilled - Non Dev, Unskilled, Skilled)
    - `contract_types` - Contract types (Permanent / Fixed term, Contractor, Contract, Volunteer)
    - `employees` - Employee information
    - `payroll_periods` - Payroll periods
    - `pay_items` - Salary, allowances, bonuses, deductions
    - `entitlements` - Employee entitlements
    - `leave_requests` - Employee leave requests
    - `overtime_requests` - Employee overtime requests
  
  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Staff Categories
CREATE TABLE IF NOT EXISTS staff_categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  currency_type text NOT NULL,
  payment_method text NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE staff_categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Staff categories are viewable by authenticated users"
  ON staff_categories
  FOR SELECT
  TO authenticated
  USING (true);

-- Skill Levels
CREATE TABLE IF NOT EXISTS skill_levels (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE skill_levels ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Skill levels are viewable by authenticated users"
  ON skill_levels
  FOR SELECT
  TO authenticated
  USING (true);

-- Contract Types
CREATE TABLE IF NOT EXISTS contract_types (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  is_part_time boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE contract_types ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Contract types are viewable by authenticated users"
  ON contract_types
  FOR SELECT
  TO authenticated
  USING (true);

-- Employees
CREATE TABLE IF NOT EXISTS employees (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name text NOT NULL,
  last_name text NOT NULL,
  email text UNIQUE NOT NULL,
  phone_number text,
  date_of_birth date,
  date_hired date NOT NULL,
  staff_category_id uuid REFERENCES staff_categories(id) NOT NULL,
  skill_level_id uuid REFERENCES skill_levels(id) NOT NULL,
  contract_type_id uuid REFERENCES contract_types(id) NOT NULL,
  is_part_time boolean DEFAULT false,
  tax_rate text,
  tax_id text,
  bank_name text,
  account_number text,
  branch_code text,
  status text DEFAULT 'active',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Employees are viewable by authenticated users"
  ON employees
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Employees can be inserted by authenticated users"
  ON employees
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Employees can be updated by authenticated users"
  ON employees
  FOR UPDATE
  TO authenticated
  USING (true);

-- Payroll Periods
CREATE TABLE IF NOT EXISTS payroll_periods (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  pay_date date NOT NULL,
  status text DEFAULT 'open',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE payroll_periods ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Payroll periods are viewable by authenticated users"
  ON payroll_periods
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Payroll periods can be inserted by authenticated users"
  ON payroll_periods
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Payroll periods can be updated by authenticated users"
  ON payroll_periods
  FOR UPDATE
  TO authenticated
  USING (true);

-- Pay Items
CREATE TABLE IF NOT EXISTS pay_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id uuid REFERENCES employees(id) NOT NULL,
  payroll_period_id uuid REFERENCES payroll_periods(id) NOT NULL,
  type text NOT NULL,
  description text NOT NULL,
  amount numeric(10, 2) NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE pay_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Pay items are viewable by authenticated users"
  ON pay_items
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Pay items can be inserted by authenticated users"
  ON pay_items
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Pay items can be updated by authenticated users"
  ON pay_items
  FOR UPDATE
  TO authenticated
  USING (true);

-- Entitlements
CREATE TABLE IF NOT EXISTS entitlements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id uuid REFERENCES employees(id) NOT NULL,
  type text NOT NULL,
  value jsonb NOT NULL,
  status text DEFAULT 'active',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE entitlements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Entitlements are viewable by authenticated users"
  ON entitlements
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Entitlements can be inserted by authenticated users"
  ON entitlements
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Entitlements can be updated by authenticated users"
  ON entitlements
  FOR UPDATE
  TO authenticated
  USING (true);

-- Leave Requests
CREATE TABLE IF NOT EXISTS leave_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id uuid REFERENCES employees(id) NOT NULL,
  type text NOT NULL,
  start_date date NOT NULL,
  end_date date NOT NULL,
  total_days integer NOT NULL,
  reason text,
  status text DEFAULT 'pending',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE leave_requests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leave requests are viewable by authenticated users"
  ON leave_requests
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Leave requests can be inserted by authenticated users"
  ON leave_requests
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Leave requests can be updated by authenticated users"
  ON leave_requests
  FOR UPDATE
  TO authenticated
  USING (true);

-- Overtime Requests
CREATE TABLE IF NOT EXISTS overtime_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id uuid REFERENCES employees(id) NOT NULL,
  date date NOT NULL,
  hours numeric(5, 2) NOT NULL,
  reason text,
  status text DEFAULT 'pending',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE overtime_requests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Overtime requests are viewable by authenticated users"
  ON overtime_requests
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Overtime requests can be inserted by authenticated users"
  ON overtime_requests
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Overtime requests can be updated by authenticated users"
  ON overtime_requests
  FOR UPDATE
  TO authenticated
  USING (true);

-- Insert initial data for lookup tables
INSERT INTO staff_categories (name, currency_type, payment_method)
VALUES 
  ('Malagasy (local currency) via BVF', 'local', 'BVF'),
  ('Malagasy (local currency) Cash', 'local', 'Cash'),
  ('International (foreign currency) via WISE', 'foreign', 'WISE');

INSERT INTO skill_levels (name)
VALUES 
  ('Skilled - Dev'),
  ('Skilled - Non Dev'),
  ('Unskilled'),
  ('Skilled');

INSERT INTO contract_types (name, is_part_time)
VALUES 
  ('Permanent / Fixed term', false),
  ('Contractor', false),
  ('Contract', false),
  ('Volunteer', false);