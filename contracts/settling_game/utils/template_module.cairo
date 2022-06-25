#-----------------------------------
# Module Template
#   Use this template when you want to make a new module.
#   See directions below (____MODULE_XXX___BUILDING_STATE)
#
# MIT License
#-----------------------------------

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.upgrades.library import (
    Proxy_initializer,
    Proxy_only_admin,
    Proxy_set_implementation,
)

from contracts.settling_game.interfaces.IModules import IModuleController
from contracts.settling_game.library.library_module import Module

# ____MODULE_XXX___BUILDING_STATE
#
# This module [module functional description]
#
# It predominantly is used by modules [] and uses modules [].
#

# Steps - Copy and modify this template contract for new modules.
# 1. Assign the new module the next available number in the contracts/ folder.
# 2. Add to namespace within game_structs
# 3. Increase module controller and arbiter contract functions to include new module. (Only if before game is live)
# 4. Import any module dependencies from interfaces.imodules (above).
# 5. Document which modules this module will interact with (above).
# 6. Document which modules this module requires write access to.
# 7. Write tests in testing/XX_test.py and add to scripts/test.
# 8. +/- Add useful interfaces for this module to interfaces/imodules.cairo.
# 9. Delete this set of instructions.

#-----------------------------------
# CONSTRUCTOR #
#-----------------------------------

#@notice Module initializer
#@param address_of_controller: Controller/arbiter address
#@proxy_admin: Proxy admin address
@external
func initializer{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    address_of_controller : felt, proxy_admin : felt
):
    Module.initializer(address_of_controller)
    Proxy_initializer(proxy_admin)
    return ()
end

#-----------------------------------
# EXTERNAL #
#-----------------------------------

#@notice Set new proxy implementation
#@dev Can only be set by the arbiter
#@param new_implementation: New implementation contract address
@external
func upgrade{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    new_implementation : felt
):
    Proxy_only_admin()
    Proxy_set_implementation(new_implementation)
    return ()
end

#@notice alled by another module to update a global variable
#@dev Can only be set by the arbiter
#@param new_implementation: New implementation contract address
@external
func update_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    # TODO Customise.
    Module.only_approved()
    return ()
end

#-----------------------------------
# GETTERS #
#-----------------------------------


#-----------------------------------
# SETTERS #
#-----------------------------------
