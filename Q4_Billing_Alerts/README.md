# Q4 - Billing & Free Tier Cost Monitoring
**Approach (4-6 lines)**
Billing alarms use CloudWatch's `AWS/Billing` namespace (available in `us-east-1`) to detect estimated charges. Budgets can send Free Tier usage alerts and monthly thresholds. Enabling alerts helps beginners avoid unexpected bills; budgets/alarms should be paired with SNS notifications for delivery.

**Notes**
- Billing metrics are provided in USD and are available only in us-east-1 for most accounts.
- Terraform may require account-level permissions to create budgets and billing alarms.
- Update thresholds and SNS ARNs before applying.
