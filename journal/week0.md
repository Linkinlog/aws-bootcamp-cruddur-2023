# Week 0 — Billing and Architecture

## Homework Assignments:

- [x] Watched Week 0 - Live Streamed Video
- [x] Watched Chirag's Week 0 - Spend Considerations
- [ ] Watched Ashish's Week 0 - Security Considerations
- [ ] Recreate Conceptual Diagram in Lucid Charts or on a Napkin
- [ ] Recreate Logical Architectual Diagram in Lucid charts
- [x] Create an Admin User
- [ ] Use CloudShell
- [ ] Installed AWS CLI
- [x] Generate AWS credentials
- [x] Create a Billing Alarm
- [x] Create a Budget

## Homework Challenges:

- [x] Destroy your root account credentials, Set MFA, IAM role
- [ ] Use Eventbridge to hookup health dashboard to sns and send notification when there is a service health issue.
- [ ] Review all the questions of each pillar in the well architected tool (no specialized lens)
- [ ] Create an architectural diagram (to the best of your ability) the ci/cd logical pipeline in lucid charts
- [ ] Research the technical and service limits of specific services and how they could impact the technical path for technical flexibility.
- [ ] Open a support ticket and request a service limit

## Proof of Work:

### User creation
- First I created a new IAM user for myself and gave it access to the billing console. I did this by signing in on my root user and going to the IAM section, I created a new user and then made a new policy that is only for IAM/Billing. I then restricted that access to having MFA set up as well using the same policy. 
  - ![MFA Setup](../_docs/assets/week0/MFA.png)
  - ![Policy Setup](../_docs/assets/week0/read_only_aws_policy.png)

### Billing alert creation
- I then went into the cloudwatch management console, after adding that as a permission to my IAM user.
- I created a billing alarm so I could be alerted anytime the bill exceeds 1 it will email my personal email.
- I then went into the budgets section and created a zero spend budget
    - ![Zero Spend](../_docs/assets/week0/zero-spend.png)

