# Contributing to Next.js template

Thank you for your interest in contributing to the Next.js template! This guide will help you understand our project structure, coding conventions, and development workflow.

**Before you begin**: Please read the [README.md](README.md) for an overview of the project, its features, and setup instructions.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)
3. [Code Style and Conventions](#code-style-and-conventions)
4. [Git Workflow](#git-workflow)
5. [Backend Development](#backend-development)
6. [Component Development](#component-development)
7. [Hooks Development](#hooks-development)
8. [Server Actions](#server-actions)
9. [Type Definitions](#type-definitions)
10. [Schema Definitions](#schema-definitions)
11. [Additional Resources](#additional-resources)

## Getting Started

### Prerequisites

- **Node.js**: Version 18 or higher
- **pnpm**: Version 10.33.0 (specified in `package.json`)
- **Git**: For version control
- **Docker**: For Supabase local development

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/LarryLing/nextjs-template.git
   cd nextjs-template
   ```

2. Install dependencies:

   ```bash
   pnpm install
   ```

3. Set up environment variables:

   Copy `.env.example` to create a `.env.local` file. We **strongly** recommend setting up two remote Supabase environments (development and production) before filling these in — see [Backend Development](#backend-development) for setup instructions. Your development environment variables go here:

   ```env
   NEXT_PUBLIC_SUPABASE_URL=
   NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=

   APP_ENV=development
   ```

### Development Server

Start the development server:

```bash
pnpm run dev
```

The application will be available at `http://localhost:3000`.

### Available Scripts

- `pnpm run dev` - Start the development server
- `pnpm run build` - Build the application for production
- `pnpm run start` - Start the production server
- `pnpm run type-check` - Run type check
- `pnpm run lint` - Run linter to check for code issues
- `pnpm run lint:fix` - Automatically fix lint issues
- `pnpm run format` - Format code with Biome
- `pnpm run check` - Check for lint and format issues
- `pnpm run check:fix` - Fix lint and format issues
- `pnpm run prepare` - Run husky

## Project Structure

### Root-Level Folders

```
nextjs-template/
├── app/                    # Next.js App Router directory
├── components/             # Shared React components
│   └── ui/                 # ShadCN/ui components (do not modify manually)
├── supabase/               # Supabase config and database migrations
├── constants/              # Application-wide constants
├── hooks/                  # Shared React hooks
├── lib/                    # Utility functions and libraries
└── types/                  # Shared TypeScript type definitions
```

### Feature Organization Pattern

Each feature (route segment) follows this structure:

- `_components/` - React components specific to this feature
- `_hooks/` - Custom React hooks for this feature
- `_lib/` - Feature-specific library files (table columns, complex utilities, etc.) (optional)
- `actions.ts` - Server actions for database operations (if applicable)
- `schemas.ts` - Zod validation schemas (if applicable)
- `constants.ts` - Constants specific to this feature (optional)
- `lib.ts` or `lib.tsx` - Simple utility functions for this feature (optional, use `_lib/` if you have multiple library files)
- `types.ts` - TypeScript type definitions for this feature (optional)
- `page.tsx` - Next.js page component
- `loading.tsx` - Loading UI (optional)
- `error.tsx` - Error UI (optional)

**Note**:

- Folders prefixed with `_` are private and not part of the URL routing
- `constants.ts`, `types.ts`, and `lib.ts` are single files (not folders) and are optional
- Use `lib.tsx` instead of `lib.ts` if the file contains JSX/TSX code
- Use `_lib/` folder when you have multiple library files (e.g., table column definitions, calendar utilities, multiple related functions)
- You can use `_lib/` exclusively for all library files in a feature, even if you don't have a top-level `lib.ts` or `lib.tsx`
- Use top-level `lib.ts` or `lib.tsx` for simple, single-file utility functions when you only have one or two utility functions

## Code Style and Conventions

### Naming Conventions

#### Files

- **Components**: `kebab-case.tsx` (e.g., `edit-feature-form.tsx`)
- **Hooks**: `use-kebab-case.ts` (e.g., `use-edit-feature-form.ts`)
- **Types**: `types.ts` (single file per feature, e.g., `app/dashboard/my-feature/types.ts`)
- **Constants**: `constants.ts` (single file per feature, e.g., `app/dashboard/my-feature/constants.ts`)
- **Actions**: `actions.ts` (e.g., `app/dashboard/my-feature/actions.ts`)
- **Schemas**: `schemas.ts` (e.g., `app/dashboard/my-feature/schemas.ts`)
- **Utilities**: `lib.ts` or `lib.tsx` (single file per feature, e.g., `app/dashboard/my-feature/lib.ts`)

#### Code

- **Components**: `PascalCase` (e.g., `EditFeatureForm`)
- **Hooks**: `camelCase` with `use` prefix (e.g., `useEditFeatureForm`)
- **Types**: `PascalCase` (e.g., `MyFeature`, `UseEditFeatureFormReturn`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `MY_FEATURE_FIELDS`)
- **Functions**: `camelCase` (e.g., `getFeatureDocSnapshot`)
- **Variables**: `camelCase` (e.g., `featureId`)
- **Literal Object Members** `camelCase` (e.g., `fullName`)

### Linting and Formatting

The project uses [Biome](https://biomejs.dev) to handle code linting and formatting.

#### Lint Rules

All recommended lint rules have been enabled along with those specific to the [React](https://biomejs.dev/linter/domains/#react) and [Next.js](https://biomejs.dev/linter/domains/#next) domains. For further performance and style enforcement, the following JavaScript rules have also been enabled:

- **noUselessStringConcat**: "warn"
- **noUselessUndefined**: "warn"
- **noNextAsyncClientComponent**: "error"
- **useExplicitReturnType**: "warn"
- **noBarrelFile**: "error"
- **noAwaitInLoops**: "error"
- **noEnum**: "error"
- **noMagicNumbers**: "error"
- **noNestedTernary**: "error"
- **noUnusedTemplateLiteral**: "warn"
- **useConsistentCurlyBraces**: "warn"
- **useNamingConvention**: "warn"
- **useSelfClosingElements**: "warn"
- **noUnknownAtRules**: "off"
- **useAwait**: "warn"

A full list of JavaScript rules can be found [here](https://biomejs.dev/linter/javascript/rules/)

#### Format Rules

The following formatting rules have been applied:

##### General

- **indentStyle**: "space"
- **indentWidth**: 2
- **lineWidth**: 120
- **lineEnding**: "lf"

##### JavaScript

- **arrowParenthesis**: "Always"
- **bracketSameLine**: false
- **bracketSpacing**: true
- **jsxQuoteStyle**: "double"
- **quoteProperties**: "asNeeded"
- **semicolons**: "always"
- **trailingCommas**: "es5"

##### JSON

- **trailingCommas**: "es5"

##### CSS

- **tailwindDirectives**: true

A full list of formatting rules can be found [here](https://biomejs.dev/reference/configuration/#formatter)

## Git Workflow

### Branch Structure

This project uses a two-branch promotion model:

| Branch    | Purpose                                                                                        |
| --------- | ---------------------------------------------------------------------------------------------- |
| `main`    | Production — always reflects what is live. Protected; never commit directly.                   |
| `develop` | Development — integration branch for all completed features. Protected; never commit directly. |

Feature branches are always cut from `develop` and merged back into `develop` first. Changes only reach `main` via a PR from `develop` once the development environment has been verified.

### Branch Naming

Use descriptive branch names with your GitHub username:

- `feature/<github-username>/add-user-profile` — New features
- `fix/<github-username>/login-redirect-issue` — Bug fixes
- `refactor/<github-username>/improve-schedule-hooks` — Refactoring
- `docs/<github-username>/update-contributing-guide` — Documentation

### Commit Messages

Follow conventional commit format:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Examples:**

```
feat(schedule): add event creation dialog

fix(auth): resolve session expiration issue

docs: update contributing guide with barrel import examples
```

Commit messages are validated with [commitlint](https://commitlint.js.org).

### Husky Commit Hooks

This template uses [Husky](https://typicode.github.io/husky/) and [lint-staged](https://github.com/lint-staged/lint-staged) for pre-commit and pre-build hooks.

During the pre-commit step, Husky will invoke Biome's `check` command to apply lint and format fixes. Any lint errors that could not be fixed will be raised and the commit process will abort.

During the pre-build step, Husky will invoke the type check command. If any TypeScript errors exist, they will be raised and the commit process will abort.

### Pull Request Process

#### Feature development (feature branch → `develop`)

1. **Create a branch** from `develop`:

   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/your-username/feature-name
   ```

2. **Make your changes** following this guide and coding standards.

3. **Commit your changes** with descriptive conventional commit messages:

   ```bash
   git add .
   git commit -m "feat(scope): add new feature"
   ```

4. **Push to your branch** and open a Pull Request targeting `develop`:

   ```bash
   git push origin feature/your-username/feature-name
   ```

5. **Ensure CI passes** — The CI workflow will validate linting, formatting, type checking, and run your migrations against a local Supabase instance.

6. **Address review feedback** — Make requested changes and push updates to your branch.

7. **Keep your branch up to date** — Rebase or merge `develop` into your branch if needed:

   ```bash
   git checkout develop
   git pull origin develop
   git checkout feature/your-username/feature-name
   git rebase develop # or git merge develop
   ```

On merge, the release workflow automatically deploys your migrations to the **development** remote Supabase project.

#### Promoting to production (`develop` → `main`)

Once the development environment has been verified:

1. Open a Pull Request from `develop` into `main`.
2. Ensure the development Supabase project is healthy and all features are working as expected.
3. On merge, the release workflow automatically deploys migrations to the **production** remote Supabase project and Vercel promotes the build.

> **Never** delete the `develop` branch. This will break the CI/CD process.

> **Never** open a PR directly from a feature branch into `main`. All changes must flow through `develop` first.

### Code Review Expectations

When submitting a Pull Request, ensure:

- [ ] All code passes linting and formatting checks
- [ ] Follow the project's code style and conventions
- [ ] Include appropriate type definitions (no `any` types)
- [ ] Add comments for complex logic or non-obvious code
- [ ] Ensure components are accessible (ARIA labels, keyboard navigation)
- [ ] Test your changes locally before submitting
- [ ] Update documentation if adding new features or changing behavior
- [ ] Keep commits focused and atomic (one logical change per commit)
- [ ] Write clear commit messages following conventional commit format
- [ ] If schema changes are included, confirm `supabase db reset` passes locally

## Backend Development

Backend operations are handled using [Supabase](https://supabase.com/docs).

### Environment Overview

This project uses **three Supabase environments**:

| Environment     | Purpose               | When to use                                            |
| --------------- | --------------------- | ------------------------------------------------------ |
| **Production**  | Live user-facing data | Deployed automatically via CI/CD on merge to `main`    |
| **Development** | Shared remote staging | Deployed automatically via CI/CD on merge to `develop` |
| **Local**       | Personal sandbox      | Daily development — required for all contributors      |

Contributors should **never** push schema changes directly to the production or development remote projects. All schema changes must go through the local → development → production pipeline described below.

### Vercel Environment

We recommend handling deployment with Vercel given its close integration with Next.js and ease of configuration, especially with environment variables.

Configure the Vercel project so that your **production** environment variables are only accessible from the production deployment, and your **development** environment variables are only accessible on preview or development deployments.

More information on environment variable management can be found [here](https://vercel.com/docs/environment-variables).

### Getting Started With Local Development

This template includes the Supabase CLI package, which allows for local database changes without affecting your remote environments.

The `/supabase` directory contains migrations, functions, config, and seed data. It keeps your local repository in sync with your backend environments.

**Prerequisites**: Ensure [Docker](https://www.docker.com/get-started/) is installed and the daemon is running before proceeding.

1. **Pull the production schema into your local migrations directory:**

   Your `<project_id>` can be retrieved from the project dashboard URL: `https://supabase.com/dashboard/project/<project-id>`

   ```bash
   pnpx supabase login
   pnpx supabase link --project-ref <PROD_PROJECT_ID>
   pnpx supabase db pull
   ```

   This creates a `supabase/migrations/<timestamp>_remote_schema.sql` file reflecting the current production schema.

   > **Warning**: Never run `supabase db push` while linked to the production project. Run `pnpx supabase status` to verify which project you are currently linked to.

2. **Sync the pulled schema to the development remote:**

   ```bash
   pnpx supabase link --project-ref <DEV_PROJECT_ID>
   pnpx supabase db push
   ```

   Your development environment is now in sync with production.

3. **Start local Supabase services:**

   ```bash
   pnpx supabase start
   ```

   This will print local URLs and keys for your running Supabase instance. Copy the `API URL` and `anon key` values into your `.env.local`:

   ```env
   NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
   NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=<anon key from output>
   APP_ENV=development
   ```

4. **Stop local services when done:**

   ```bash
   pnpx supabase stop
   ```

### Migration Workflow

All schema changes must be authored locally and promoted through development before reaching production.

1. **Create a new migration:**

   ```bash
   pnpx supabase migration new example_migration_name
   ```

   This creates `supabase/migrations/<timestamp>_example_migration_name.sql`. Write your DDL statements in this file.

   Alternatively, make changes via Supabase Studio (`localhost:54323`) and auto-generate the migration:

   ```bash
   pnpx supabase db diff -f example_migration_name
   ```

   > **Important**: Our Supabase environment variable names are prefixed with `NEXT_PUBLIC_`, meaning they are exposed to the browser. You **must** add [Row Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security) policies to any new tables, or your data will be publicly accessible.

2. **Add seed data (if applicable):**

   Provide mock data in `/supabase/seed.sql`. This file is tracked by Git and will be applied automatically when other contributors run `db reset`.

3. **Test your migration locally:**

   ```bash
   pnpx supabase db reset
   ```

   This wipes the local database, re-applies all migrations in `/supabase/migrations` in order, and re-seeds from `seed.sql`. If `reset` succeeds locally, the migration is safe to promote.

4. **Promote to development, then production:**

   Follow the [Pull Request Process](#pull-request-process) — open a PR into `develop`, verify the development environment, then PR into `main` for production.

5. **Rebase if a teammate merges a migration first:**

   If a new migration lands on `develop` while you have local changes, rename your migration file with a later timestamp so it applies after:

   ```bash
   git pull
   # Get a fresh timestamp
   date +%Y%m%d%H%M%S
   # Rename your migration file to the new timestamp
   mv supabase/migrations/<old_timestamp>_your_feature.sql supabase/migrations/<new_timestamp>_your_feature.sql
   pnpx supabase db reset
   ```

The full Supabase CLI reference can be found [here](https://supabase.com/docs/reference/cli/supabase-db).

### Row-Level Security Policies

All tables must have RLS enabled. See the [Supabase RLS docs](https://supabase.com/docs/guides/database/postgres/row-level-security) for guidance on writing policies.

## Component Development

### Server Components vs Client Components

**Server Components** (default in Next.js App Router):

- No `"use client"` directive
- Can directly access server resources (databases, APIs)
- Cannot use React hooks or browser APIs
- Better performance (rendered on server)

**Client Components**:

- Must include `"use client"` directive at the top
- Can use React hooks (`useState`, `useEffect`, etc.)
- Can access browser APIs
- Required for interactivity

### Component Structure

**Example Server Component:**

```typescript
import { redirect } from "next/navigation";

import { verifySession } from "@/lib";
import { DASHBOARD_PATH, LOGIN_PATH } from "@/constants";

const MyPage = async () => {
  const userId = await verifySession();
  if (!userId) redirect(LOGIN_PATH);

  return <div>Content</div>;
};

export default MyPage;
```

**Example Client Component:**

```typescript
"use client";

import { useState } from "react";

import { Button } from "@/components/ui/button";

const MyComponent = () => {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <Button onClick={() => setCount(count + 1)}>Increment</Button>
    </div>
  );
};

export default MyComponent;
```

### Props Typing

Always define explicit prop types:

```typescript
type EditFeatureFormProps = {
  feature: MyFeature;
  userId: User["id"];
  onSuccess?: () => void;
};

const EditFeatureForm = ({
  feature,
  userId,
  onSuccess,
}: EditFeatureFormProps) => {
  // Component implementation
};
```

### ShadCN/ui Components

UI styling and components are handled with the [ShadCN/ui component library](https://ui.shadcn.com/docs).

See the [component docs](https://ui.shadcn.com/docs/components) for a list of available components.

**Important**: Do not modify files in `components/ui/` directly. If you need to customize a component, create a wrapper component.

#### Custom Theming

To customize colors, borders, fonts, etc., use the [TweakCN theme editor](https://tweakcn.com/editor/theme). Click _Code_, then copy and run the `pnpm` command to apply your theme.

#### Icons

Use the [Lucide icon library](https://lucide.dev/icons/) for consistency. Exceptions are acceptable only if an icon doesn't exist in Lucide.

#### Skills and MCP

This template includes the ShadCN/ui builder skill and Cursor MCP server for finding, installing, and composing components.

Example prompts:

- "Add a login form with email and password fields."
- "Create a settings page with a profile update form."
- "Build a dashboard with a sidebar, stats cards, and a data table."

To enable, open _Cursor Settings_ and enable the MCP server. See the [skill docs](https://ui.shadcn.com/docs/skills) and [MCP docs](https://ui.shadcn.com/docs/mcp) for more details.

## Hooks Development

### Hook Patterns

Custom hooks should:

1. Start with `use` prefix
2. Be exported as named exports
3. Export their return type
4. Include `"use client"` directive if they use React hooks

**Example:**

```typescript
"use client";

import { useState, useEffect } from "react";

export type UseMyHookReturn = {
  data: string | null;
  isLoading: boolean;
  error: Error | null;
};

export const useMyHook = (param: string): UseMyHookReturn => {
  const [data, setData] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    // Hook implementation
  }, [param]);

  return { data, isLoading, error };
};
```

## Type Definitions

### Type vs Interface

Prefer `type` over `interface` for consistency:

```typescript
// Good
export type MyFeature = BaseModel & {
  name: string;
  description: string;
};

// Also acceptable, but prefer type
export interface MyFeature extends BaseModel {
  name: string;
  description: string;
}
```

### Export Patterns

**Always use named exports** for types:

```typescript
// Good
export type { MyFeature, FeatureItem } from "./types";

// Bad
export type { default as MyFeature } from "./types";
```

**Importing types:**

```typescript
import type { MyFeature } from "@/app/dashboard/my-feature/types";
```

This is enforced by the lint rules.

## Schema Definitions

Validation schemas use Zod and are located in the `schemas.ts` file:

```typescript
import { z } from "zod";

import {
  plainTextMultiLineSchema,
  plainTextSingleLineSchema,
  secureUrlSchema,
} from "@/lib/validation";

export const sampleFormSchema = z.object({
  single_line: plainTextSingleLineSchema.min(
    1,
    "Single line field is required",
  ),
  multi_line: plainTextMultiLineSchema.min(1, "Multi line field is required"),
  url: secureUrlSchema.optional().or(z.literal("")),
});

export type SampleFormSchema = z.infer<typeof sampleFormSchema>;
```

**Pattern**: Export both the schema and the inferred type.

### Validation Utilities

The project provides reusable validation schemas in `lib/validation` for common security and validation needs:

- **`secureUrlSchema`**: Validates URLs and only allows `http://` and `https://` protocols. Prevents XSS attacks from dangerous protocols like `javascript:`, `data:`, `file:`, etc.

  ```typescript
  import { secureUrlSchema } from "@/lib/validation";

  const schema = z.object({
    url: secureUrlSchema,
  });
  ```

- **`plainTextSingleLineSchema`**: Validates plain text for single-line fields (no newlines). Rejects HTML tags and control characters. Use for names, titles, and other single-line text fields.

  ```typescript
  import { plainTextSingleLineSchema } from "@/lib/validation";

  const schema = z.object({
    title: plainTextSingleLineSchema.min(1, "Title is required"),
  });
  ```

- **`plainTextMultiLineSchema`**: Validates plain text for multi-line fields (allows newlines). Rejects HTML tags and control characters. Use for descriptions, bodies, and other multi-line content.

  ```typescript
  import { plainTextMultiLineSchema } from "@/lib/validation";

  const schema = z.object({
    description: plainTextMultiLineSchema.min(1, "Description is required"),
  });
  ```

## Additional Resources

### Documentation

- [Next.js Documentation](https://nextjs.org/docs) - App Router, Server Actions, and more
- [React Documentation](https://react.dev) - React 19 features and hooks
- [TypeScript Handbook](https://www.typescriptlang.org/docs/) - TypeScript best practices
- [Tailwind CSS Documentation](https://tailwindcss.com/docs) - Utility classes and configuration
- [ShadCN UI Documentation](https://ui.shadcn.com) - Component library and customization
- [Zod Documentation](https://zod.dev) - Schema validation and type inference
- [React Hook Form Documentation](https://react-hook-form.com) - Form state management

If you need help or have questions:

1. Check this contributing guide and the README
2. Review existing code for similar patterns
3. Search existing issues and pull requests
4. Ask questions in your pull request
5. Contact the project maintainers

---

Thank you for contributing to the Next.js template!

Your contributions help make the template experience better for everyone.
