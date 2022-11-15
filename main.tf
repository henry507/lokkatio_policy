data "azurerm_subscription" "current" {}

resource "azurerm_management_group" "lokapoly2025" {
  display_name = "lokapoly2025"
}

resource "azurerm_policy_definition" "lokapoly2025" {
  name         = "lokapoly2025"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Allowed resource types"

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "in": ["westeurope","northeurope"]
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE
}

resource "azurerm_subscription_policy_assignment" "lokapoly2025" {
  display_name = "name"
  name                 = "example"
  policy_definition_id = azurerm_policy_definition.lokapoly2025.id
  subscription_id      = data.azurerm_subscription.current.id
  non_compliance_message {
           content                        = "Resources must be in West Europe or North Europe." 
           policy_definition_reference_id = "Allowed locations (HSL)_1" 
        }
        non_compliance_message {
           content                        = "Resource groups must be West Europe or North Europe." 
           policy_definition_reference_id = "Allowed locations for resource groups (HSL)_1" 
        }

      timeouts {}
       metadata             = jsonencode(
            {
               assignedBy      = "Jyrki Ruuskanen"
               createdBy       = "99f6fc3d-1e8e-4890-8fd5-281c29119d03"
               createdOn       = "2020-09-29T07:09:47.3946761Z"
               parameterScopes = {
                   allowedLocations = "/providers/Microsoft.Management/managementGroups/hsl-2020-09-28"
                }
               updatedBy       = "a86d6b41-0842-4c25-98ad-28f1314e24f6"
              updatedOn       = "2022-05-18T09:11:23.2997495Z"
}
    )
}
