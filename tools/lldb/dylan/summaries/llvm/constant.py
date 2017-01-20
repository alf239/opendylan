from dylan.accessors import *
from dylan import summaries

@summaries.register('<llvm-float-constant>', 'llvm', 'llvm')
def llvm_float_constant_summary(value, internal_dict):
  type_value = dylan_slot_element_by_name(value, 'llvm-value-type')
  type_name = summaries.summary(type_value)
  float_value = dylan_slot_element_by_name(value, 'llvm-float-constant-float')
  return '%s %s' % (type_name, dylan_float_data(float_value))

@summaries.register('<llvm-integer-constant>', 'llvm', 'llvm')
def llvm_integer_constant_summary(value, internal_dict):
  type_value = dylan_slot_element_by_name(value, 'llvm-value-type')
  type_name = summaries.summary(type_value)
  integer_value = dylan_slot_element_by_name(value, 'llvm-integer-constant-integer')
  return '%s %s' % (type_name, dylan_integer_value(integer_value))
