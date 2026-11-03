# ROUTEX89 — Android-First Product Blueprint
Version 1.0 | 03 November 2026

## Confirmed decisions
- App/product brand: ROUTEX89
- Tagline: Moving India Forward.
- First platform: Android
- Market ambition: Pan-India; start operations with verified pilot routes, initially Bhiwandi–Mumbai.
- Brand palette: Deep Navy #101F3B, Orange #F28C28, White #FFFFFF.
- Product: Freight Marketplace + Transport Management System / Transport ERP.
- Architecture: one role-based Flutter Android app; responsive web admin.

## User roles
1. Customer/Shipper — post loads, receive quotes, book, view trips and documents.
2. Broker — manage customer loads, source own/market vehicles, coordinate trips and ledger.
3. Transporter/Fleet Owner — manage vehicles/drivers, accept loads and view trip/settlement status.
4. Driver — assigned trips only, milestone updates, consent-based location sharing and POD upload.
5. Operations Admin — KYC review, assignment, charge approvals, POD and disputes.
6. Finance Admin — reconciliation and settlement preparation; separate checker approves payouts.
7. Super Admin — roles/configuration and audited access.

## First MVP scope
- Brand splash and navigation
- Role selection and profile foundation
- Pan-India pickup/delivery fields
- Vehicle catalogue
- Load posting and booking enquiry
- Partner vehicle registration with Own Fleet / Market Vehicle
- Offer and manual assignment workflow
- Trip status timeline
- LR, invoice and POD document workflow
- Basic income/expense and settlement ledger
- Admin review, audit logs and reports

## Included in this prototype
- ROUTEX89 branding/theme
- Dashboard
- Demo load posting
- Own/market fleet list and add vehicle
- Business module placeholders
- Local in-memory demo only; no live backend

## Main workflow
Load posted → partner offer → verified vehicle/driver assignment → trip milestones → LR/POD → settlement review → close.

Trip statuses: BOOKED → ASSIGNED → ARRIVED_LOADING → LOADED → IN_TRANSIT → ARRIVED_DELIVERY → DELIVERED → POD_PENDING → POD_VERIFIED → SETTLEMENT_PENDING → SETTLED → CLOSED. Exceptions: CANCELLED, FAILED, DISPUTED.

## Recommended architecture
- Flutter Android app
- Supabase Auth + PostgreSQL + private Storage + server-side access policies
- Responsive web admin
- Maps/GPS only after driver consent and active-trip controls
- Separate development/staging/production environments; secrets never committed to Git.

## Core data model
users, companies, memberships, kyc_documents, vehicles, vehicle_documents, drivers, vehicle_assignments, vehicle_types, locations, bookings, booking_offers, trips, trip_events, location_points, charges, commission_rules, payments, settlements, payouts, documents, invoices, webhook_events, audit_logs, support_tickets.

## Security and financial guardrails
- Enforce role and record-level access on server.
- Keep KYC files private; mask PAN/licence/bank identifiers.
- Track driver location only on assigned active trips with clear consent.
- Never trust client-submitted commission, KYC status, payment status or owner payable.
- Use provider-approved payment/settlement flow; do not claim escrow or wallet without legal/provider approval.
- Use maker-checker for payouts and append-only financial audit records.
- CA/legal review for GST, TDS/TCS, invoice issuer and marketplace obligations.

## Deferred
iOS, automated matching, advanced route optimisation, dedicated GPS devices, automated KYC, automatic split payouts, full accounting/GST integrations.

## Pilot KPIs
Booking-to-assignment time, fulfilment rate, trip completion, POD verification time, repeat bookings, owner settlement time, disputes/cancellations and contribution per completed trip.

## Prototype acceptance
Tester can create a demo load, see it in the load list, add vehicles, distinguish own and market fleet, and navigate the four tabs. This does not establish production readiness.
