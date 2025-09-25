# Senior Place API Samples

<img src="https://seniorplace-public.s3.us-west-2.amazonaws.com/docs/padded-logo.png" alt="Senior Place Logo" width="200">

This repository contains sample scripts and examples for working with the Senior Place API.

**Visit [seniorplace.com](https://seniorplace.com) to learn more about our platform.**

## About Senior Place

Senior Place is streamlined placement software built for professionals helping seniors find the right care communities. Our platform helps placement professionals stay organized, track client progress, and deliver better results for families.

## API Documentation

Full API documentation is available at: https://seniorplace-public.s3.us-west-2.amazonaws.com/docs/index.html

## Getting Started

### API Key

To use the Senior Place API, you'll need an API key. Please contact **support@seniorplace.com** to request access.

### Sample Scripts

This repository includes ready-to-run scripts that demonstrate how to:

**Client Management**

- **create-client.sh** - Create a new client in the system
- **list-client-statuses.sh** - Fetch available client statuses (new, in progress, moved, etc)
- **list-attributes.sh** - Retrieve client attributes

**Referral Management**

- **create-referral-organization.sh** - Create a new referral organization
- **create-referral-contact.sh** - Create a referral contact for an organization
- **list-referral-organizations.sh** - List all referral organizations
- **list-referral-contacts.sh** - List all referral contacts

**User Management**

- **list-users.sh** - List all users

### Usage

Each script requires your API key to be set as an environment variable:

```bash
export API_KEY="your_api_key_here"
```

#### Quick Start

**Prerequisites**

- `jq` - Command-line JSON processor ([installation guide](https://jqlang.github.io/jq/download/))
- Valid API key (see [Getting Started](#getting-started))

**1. Create a Client**

```bash
./create-client.sh
```

After creation, verify the client appears in your [dashboard](https://staging.seniorplace.com).

**2. Create a Referral Organization**

```bash
./create-referral-organization.sh
```

Save the returned `organization_id` - you'll need it for the next step.

**3. Create a Referral Contact**

```bash
./create-referral-contact.sh --organization-id <organization_id>
```

Replace `<organization_id>` with the ID from step 2.

## Support

For questions about the API or assistance with implementation, please email **support@seniorplace.com**.
