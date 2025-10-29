# Supabase Migration Guide

This guide explains how to update components to use Supabase instead of mock data.

## What We've Done

1. **Created Supabase client** - [frontend/src/lib/supabase.ts](frontend/src/lib/supabase.ts)
2. **Updated services to async** - All services now return Promises
   - [frontend/src/data/services/userService.ts](frontend/src/data/services/userService.ts)
   - [frontend/src/data/services/listingService.ts](frontend/src/data/services/listingService.ts)
3. **Created React hooks** - [frontend/src/hooks/use-listings.ts](frontend/src/hooks/use-listings.ts)
4. **Created display helpers** - [frontend/src/lib/display-helpers.ts](frontend/src/lib/display-helpers.ts)

## How to Migrate a Component

### Before (Mock Data):
```typescript
import { mockSaleListings, mockWantedListings } from "@/data";

function MyComponent() {
  const saleListings = mockSaleListings; // Synchronous
  const wantedListings = mockWantedListings; // Synchronous

  return (
    <div>
      {saleListings.map(listing => (
        <div key={listing.id}>{listing.title}</div>
      ))}
    </div>
  );
}
```

### After (Supabase):
```typescript
import { useSaleListings, useWantedListings } from "@/hooks/use-listings";

function MyComponent() {
  const { listings: saleListings, loading: saleLoading } = useSaleListings();
  const { listings: wantedListings, loading: wantedLoading } = useWantedListings();

  if (saleLoading) {
    return <div>Loading...</div>;
  }

  return (
    <div>
      {saleListings.map(listing => (
        <div key={listing.id}>{listing.title}</div>
      ))}
    </div>
  );
}
```

## Available Hooks

### Listings
- `useListings()` - Fetch all listings
- `useSaleListings()` - Fetch sale listings only
- `useWantedListings()` - Fetch wanted listings only
- `useUserListings(userId, type?)` - Fetch listings by user
- `useCategoryListings(category)` - Fetch listings by category

All hooks return:
```typescript
{
  listings: Listing[],
  loading: boolean,
  error: Error | null
}
```

## Display Helpers

### Show "You" for own listings:
```typescript
import { getSellerDisplayName } from '@/lib/display-helpers';
import { useAuth } from '@/lib/auth';

const { user } = useAuth();
const displayName = getSellerDisplayName(
  listing.userId,
  listing.seller.name,
  user?.id
);
// Returns: "You" if it's your listing, otherwise the seller's name
```

### Check if listing belongs to current user:
```typescript
import { isOwnListing } from '@/lib/display-helpers';

const canEdit = isOwnListing(listing.userId, user?.id);
```

## Example: Updated Component

See [frontend/src/app/listings/page.tsx](frontend/src/app/listings/page.tsx) for a complete example.

## Components to Migrate

The following 25 components still use mock data and need to be updated:

1. `/app/listings/page.tsx` ✅ (DONE)
2. `/app/threads/[threadCategory]/page.tsx`
3. `/app/threads/[threadCategory]/[listingId]/page.tsx`
4. `/app/listings/[listingId]/matches/page.tsx`
5. `/app/profile/page.tsx`
6. `/components/matching/desktop/AIMatchingKanban.tsx`
7. `/components/threads/ThreadCard.tsx`
8. `/components/threads/ThreadsGrid.tsx`
9. `/components/threads/category/ListingCard.tsx`
10. ... (see full list in git grep output)

## Testing

1. **Run the seed data in Supabase**
   - Open Supabase SQL Editor
   - Run [database/seed-data.sql](database/seed-data.sql)

2. **Test the connection**
   - Navigate to `/listings` page
   - Should see loading spinner, then listings from Supabase
   - Check browser console for any errors

3. **Verify data**
   - Listings should show "You" for logged-in user's own listings
   - Data should match what's in Supabase

## Future: Migrating to GCP + pgAdmin

When ready to move from Supabase to GCP:

1. **Update only one file**: [frontend/src/lib/supabase.ts](frontend/src/lib/supabase.ts)
2. Change the connection URL to GCP PostgreSQL
3. Everything else stays the same!

```typescript
// Just update these two lines:
const supabaseUrl = process.env.NEXT_PUBLIC_GCP_DB_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_GCP_DB_KEY!;
```

That's it! The same SQL queries work because both use PostgreSQL.
