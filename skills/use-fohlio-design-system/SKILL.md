---
name: use-fohlio-design-system
description: Teaches how to use the Fohlio UI Kit, a React component library built with Headless UI, Floating UI, and Tailwind CSS v4.
---

# Use Fohlio Design System Skill

## When to Use This Skill

- You need to build or modify UI components for Fohlio applications.
- You are implementing new features that require buttons, inputs, modals, or other UI primitives.
- You are importing components from `@fohlio/ui-kit`.
- You need to ensure consistent styling, accessibility, and iconography across the codebase.
- You are working with Tailwind CSS v4 in the context of the Fohlio UI Kit.

## Overview

The Fohlio UI Kit provides a cohesive set of React components for building enterprise applications. It uses:

- **Headless UI** for accessible, unstyled primitives (buttons, dialogs, inputs)
- **Floating UI** for positioning (tooltips, popovers, dropdowns)
- **Tailwind CSS v4** with a custom `fui:` prefix for scoped styling
- **MUI Icons** for iconography (prefer outlined variants)
- **Roboto** as the primary font family

## Installation & Setup

### Importing the Library

```tsx
// Import components and types
import {
  Button,
  Input,
  Modal,
  Alert,
  Tag,
  Dropdown,
  Tooltip,
  // ... other components
} from '@fohlio/ui-kit';

// Import styles (required)
import '@fohlio/ui-kit/styles';

// Import color utilities (optional)
import { Color, ColorHEX } from '@fohlio/ui-kit';
```

### InitProvider

Wrap your application with `InitProvider` to ensure styles are loaded:

```tsx
import { InitProvider } from '@fohlio/ui-kit';

function App() {
  return (
    <InitProvider>
      {/* Your app content */}
    </InitProvider>
  );
}
```

## The `fui:` Prefix

All Tailwind classes in this library use the `fui:` prefix to prevent conflicts with host application styles.

```tsx
// Correct - use fui: prefix
<div className="fui:flex fui:items-center fui:gap-2 fui:text-primary-black">

// Wrong - no prefix
<div className="flex items-center gap-2 text-primary-black">
```

When extending or customizing components, always use the `fui:` prefix for Tailwind utilities.

## Color System

### CSS Variables

Colors are defined as CSS custom properties in `:root` and referenced through Tailwind's theme. The source of truth is `src/setup/styles/colors.css`.

**Primary Colors:**
- `--primary-green: #84b54f` - Main brand/action color
- `--primary-blue: #0b49b5` - Secondary brand color
- `--primary-black: #102048` - Primary text color
- `--primary-white: #ffffff` - Background/inverse text

**Secondary Colors:**
- `--secondary-grey: #828695` - Muted text, icons
- `--secondary-blue: #0878e8` - Info states, links

**Color Scales:**
Each color has a scale (50-600) for different use cases:
- `green-600` to `green-50` (darkest to lightest)
- `blue-600` to `blue-50`
- `red-400` to `red-50`
- `yellow-300` to `yellow-50`
- `grey-400` to `grey-100`

### Using Colors in Tailwind

```tsx
// Background colors
<div className="fui:bg-primary-green" />
<div className="fui:bg-green-dim-100" />  // Light green background
<div className="fui:bg-grey-100" />

// Text colors
<span className="fui:text-primary-black" />
<span className="fui:text-secondary-grey" />
<span className="fui:text-red-200" />  // Error/danger text

// Border colors
<div className="fui:border fui:border-grey-300" />
<div className="fui:border fui:border-primary-green" />
```

### Color Constants for Inline Styles

For inline styles, use the `Color` constant (CSS variables) or `ColorHEX` (raw hex values):

```tsx
import { Color, ColorHEX } from 'fohlio-ui-kit';

// CSS variable references (preferred)
<div style={{ backgroundColor: Color.primaryGreen }}>
  {/* Uses var(--primary-green) */}
</div>

// Raw HEX values (for SVG, canvas, charts)
<svg fill={ColorHEX.primaryGreen}>
  {/* Uses #84b54f directly */}
</svg>
```

**Available Color Keys:**
- `primaryGreen`, `primaryBlue`, `primaryWhite`, `primaryBlack`
- `secondaryBlack`, `secondaryGrey`, `secondaryBlue`
- `green600` through `green50`, `greenDim100`
- `blue600` through `blue50`, `blueCyan`
- `red400` through `red50`
- `yellow300` through `yellow50`
- `purple200`, `purple100`, `pink200`, `pink100`, `cyan200`, `cyan100`
- `grey400` through `grey100`
- `yellowText`, `purpleText`, `pinkText`, `cyanText` (semantic tag text colors)

## Icon Usage

### MUI Icons Sizing

MUI icons use `width: 1em; height: 1em` with default `font-size: 1.5rem` (24px). To set a specific size, you must override `font-size`.

**Option 1: CSS with `!important` (preferred - no runtime overhead)**
```tsx
// Use !important to override MUI's font-size: 1.5rem
// Apply on parent element targeting descendant SVGs
const iconSizeClasses = {
  small: 'fui:[&_svg]:!text-[14px]',
  middle: 'fui:[&_svg]:!text-[16px]',
  large: 'fui:[&_svg]:!text-[18px]',
};

<button className={iconSizeClasses.large}>
  <SearchIcon /> {/* Will be 18px */}
</button>
```

**Option 2: Inline styles (when CSS doesn't work)**
```tsx
// Direct inline style on the icon element
<CheckCircleOutlinedIcon style={{ fontSize: '18px', width: '18px', height: '18px' }} />
```

**What doesn't work:**
```tsx
// Wrong - Tailwind width/height classes alone won't override MUI
<CheckCircleOutlinedIcon className="fui:w-[18px] fui:h-[18px]" />

// Wrong - Parent font-size inheritance doesn't work (MUI sets font-size directly on SVG)
<span style={{ fontSize: 18 }}><SearchIcon /></span>
```

### Icon Variants

Prefer outlined icons over filled icons for better design consistency:
- `CheckCircleOutlinedIcon` (not `CheckCircleIcon`)
- `InfoOutlinedIcon` (not `InfoIcon`)
- `WarningAmberIcon` (outlined triangle)
- `ErrorOutlineIcon` (not `ErrorIcon`)
- `CloseOutlinedIcon` (not `CloseIcon`)

### Icon Component

Use the `Icon` wrapper component for consistent sizing and styling:

```tsx
import { Icon } from '@fohlio/ui-kit';
import DeleteIcon from '@mui/icons-material/DeleteOutlined';

// Basic usage
<Icon component={DeleteIcon} size="md" color="secondary-grey" />

// Interactive icon
<Icon component={DeleteIcon} size="md" color="red" onClick={handleDelete} />

// With badge
<Icon component={NotificationsIcon} size="lg" badge badgeColor="red" />

// With spin animation
<Icon component={RefreshIcon} size="md" spin />
```

**Icon Sizes:**
- `xs`: 10px
- `sm`: 12px
- `md`: 14px (default)
- `lg`: 16px
- `xl`: 18px

**Icon Colors:**
- `inherit`, `primary-green`, `primary-black`, `primary-blue`
- `secondary-grey`, `grey-400`, `grey-300`, `red`, `white`

## Component API Reference

### Button

```tsx
import { Button } from '@fohlio/ui-kit';
import AddIcon from '@mui/icons-material/Add';

// Primary (filled) button
<Button type="primary">Save</Button>

// Default (outline) button
<Button type="default">Cancel</Button>

// Ghost button (no background)
<Button type="ghost">More Options</Button>

// Danger button
<Button type="primary" danger>Delete</Button>

// With icon
<Button type="primary" icon={<AddIcon />}>Add Item</Button>

// Loading state
<Button type="primary" loading>Saving...</Button>

// Size variants
<Button size="small">Small</Button>
<Button size="middle">Middle (default)</Button>
<Button size="large">Large</Button>

// Color variants
<Button type="primary" color="primary">Green (default)</Button>
<Button type="primary" color="secondary">Grey</Button>
```

**Button Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `type` | `'default' \| 'primary' \| 'ghost' \| 'link' \| 'danger' \| 'text' \| 'dashed'` | `'default'` | Button variant |
| `color` | `'primary' \| 'secondary'` | `'primary'` | Color scheme (green or grey) |
| `size` | `'small' \| 'middle' \| 'large'` | `'middle'` | Button size |
| `disabled` | `boolean` | `false` | Disabled state |
| `loading` | `boolean` | `false` | Show loading spinner |
| `danger` | `boolean` | `false` | Danger/destructive styling |
| `ghost` | `boolean` | `false` | Ghost mode (transparent bg) |
| `icon` | `ReactNode` | - | Icon before text |
| `suffix` | `ReactNode` | - | Element after text |

### Input

```tsx
import { Input, TextArea, Password, Search } from '@fohlio/ui-kit';
import SearchIcon from '@mui/icons-material/Search';

// Basic input
<Input placeholder="Enter text..." />

// With prefix/suffix
<Input prefix={<SearchIcon />} placeholder="Search..." />

// With clear button
<Input allowClear value={value} onChange={handleChange} />

// Status variants
<Input status="error" />
<Input status="warning" />

// Size variants
<Input size="small" />
<Input size="middle" />
<Input size="large" />

// TextArea
<TextArea rows={4} showCount maxLength={500} />
<TextArea autoSize={{ minRows: 2, maxRows: 6 }} />

// Password
<Password placeholder="Enter password" />

// Search
<Search onSearch={handleSearch} enterButton />
<Search onSearch={handleSearch} allowClear loading />
```

**Input Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `size` | `'small' \| 'middle' \| 'large'` | `'middle'` | Input size |
| `status` | `'error' \| 'warning'` | - | Validation status |
| `prefix` | `ReactNode` | - | Prefix element |
| `suffix` | `ReactNode` | - | Suffix element |
| `allowClear` | `boolean` | `false` | Show clear button |
| `disabled` | `boolean` | `false` | Disabled state |

### Modal

```tsx
import { Modal } from '@fohlio/ui-kit';

<Modal
  open={isOpen}
  onClose={() => setIsOpen(false)}
  title="Confirm Action"
  onOk={handleConfirm}
  onCancel={() => setIsOpen(false)}
  okText="Confirm"
  cancelText="Cancel"
  confirmLoading={isLoading}
|>
  Are you sure you want to proceed?
</Modal>

// Custom footer
<Modal
  open={isOpen}
  title="Custom Footer"
  footer={<div>Custom footer content</div>}
|>
  Content
</Modal>

// No footer
<Modal open={isOpen} title="Info" footer={null}>
  Read-only content
</Modal>
```

**Modal Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `open` | `boolean` | `false` | Controlled open state |
| `title` | `ReactNode` | - | Modal title |
| `size` | `'small' \| 'medium' \| 'large'` | `'medium'` | Modal width (400/520/720px) |
| `width` | `string \| number` | - | Custom width |
| `closable` | `boolean` | `true` | Show close button |
| `maskClosable` | `boolean` | `true` | Close on backdrop click |
| `onClose` | `() => void` | - | Close callback |
| `onOk` | `(e) => void` | - | OK button callback |
| `onCancel` | `(e) => void` | - | Cancel button callback |
| `footer` | `ReactNode \| null` | default buttons | Custom footer |
| `confirmLoading` | `boolean` | `false` | OK button loading state |

### Alert

```tsx
import { Alert } from '@fohlio/ui-kit';
import { Button } from '@fohlio/ui-kit';

// Basic alerts
<Alert state="success" message="Operation successful!" />
<Alert state="info" message="Here's some information." />
<Alert state="warning" message="Please review before proceeding." />
<Alert state="error" message="An error occurred." />

// With description
<Alert
  state="success"
  message="File uploaded"
  description="Your file has been uploaded successfully and is now being processed."
/>

// With action
<Alert
  state="warning"
  message="Session expiring"
  action={<Button size="small">Extend</Button>}
/>

// Message variant (compact, no close button)
<Alert variant="message" state="success" message="Saved!" />

// Full width
<Alert fullWidth state="info" message="System notification" />
```

**Alert Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `variant` | `'alert' \| 'message'` | `'alert'` | Visual variant |
| `state` | `'success' \| 'info' \| 'warning' \| 'error'` | `'success'` | Alert severity |
| `message` | `ReactNode` | required | Main message |
| `description` | `ReactNode` | - | Additional description |
| `action` | `ReactNode` | - | Action element |
| `closable` | `boolean` | `true` (alert), `false` (message) | Show close button |
| `showIcon` | `boolean` | `true` | Show status icon |
| `fullWidth` | `boolean` | `false` | Take full width |

### Tag

```tsx
import { Tag } from '@fohlio/ui-kit';
import StarIcon from '@mui/icons-material/Star';

// Color variants
<Tag color="green">Active</Tag>
<Tag color="blue">In Progress</Tag>
<Tag color="red">Error</Tag>
<Tag color="yellow">Warning</Tag>
<Tag color="purple">Premium</Tag>
<Tag color="pink">Special</Tag>
<Tag color="cyan">Info</Tag>
<Tag color="grey">Default</Tag>

// Closable
<Tag color="blue" closable onClose={handleClose}>
  Removable
</Tag>

// With icon
<Tag color="yellow" icon={<StarIcon />}>Featured</Tag>
```

**Tag Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `color` | `'green' \| 'blue' \| 'red' \| 'yellow' \| 'purple' \| 'pink' \| 'cyan' \| 'grey'` | `'grey'` | Tag color |
| `closable` | `boolean` | `false` | Show close button |
| `onClose` | `(e) => void` | - | Close callback |
| `icon` | `ReactNode` | - | Icon before text |

### Dropdown

```tsx
import { Dropdown } from '@fohlio/ui-kit';
import { Button } from '@fohlio/ui-kit';

const menu = [
  { key: 'edit', label: 'Edit', icon: <EditIcon /> },
  { key: 'duplicate', label: 'Duplicate' },
  { type: 'divider' },
  { key: 'delete', label: 'Delete', danger: true },
];

<Dropdown menu={menu} onSelect={(key) => console.log(key)}>
  <Button>Actions</Button>
</Dropdown>

// With groups
const groupedMenu = [
  {
    type: 'group',
    label: 'Actions',
    children: [
      { key: 'edit', label: 'Edit' },
      { key: 'copy', label: 'Copy' },
    ],
  },
  { type: 'divider' },
  { key: 'delete', label: 'Delete', danger: true },
];

// Nested submenus
const nestedMenu = [
  {
    key: 'more',
    label: 'More Options',
    children: [
      { key: 'sub1', label: 'Submenu Item 1' },
      { key: 'sub2', label: 'Submenu Item 2' },
    ],
  },
];

// With selection
<Dropdown
  menu={menu}
  selectedKeys={['edit']}
  onSelect={handleSelect}
|>
  <Button>Select Option</Button>
</Dropdown>
```

**Dropdown Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `menu` | `DropdownMenuItemType[]` | required | Menu items |
| `placement` | `DropdownPlacement` | `'bottomLeft'` | Menu position |
| `trigger` | `'click' \| 'hover' \| 'contextMenu'` | `'click'` | Trigger type |
| `open` | `boolean` | - | Controlled open state |
| `onOpenChange` | `(open: boolean) => void` | - | Open state callback |
| `onSelect` | `(key: string, info) => void` | - | Selection callback |
| `selectedKeys` | `string[]` | `[]` | Selected item keys |
| `size` | `'small' \| 'middle' \| 'large'` | `'middle'` | Item size |

### Tooltip

```tsx
import { Tooltip } from '@fohlio/ui-kit';

<Tooltip title="Helpful information">
  <Button>Hover me</Button>
</Tooltip>

// Placement
<Tooltip title="Top" placement="top">...</Tooltip>
<Tooltip title="Bottom" placement="bottom">...</Tooltip>
<Tooltip title="Left" placement="left">...</Tooltip>
<Tooltip title="Right" placement="right">...</Tooltip>

// Light variant
<Tooltip title="Light tooltip" variant="light">
  <span>Light variant</span>
</Tooltip>

// Trigger modes
<Tooltip title="Click tooltip" trigger="click">...</Tooltip>
<Tooltip title="Focus tooltip" trigger="focus">...</Tooltip>
```

**Tooltip Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `title` | `ReactNode` | required | Tooltip content |
| `placement` | `TooltipPlacement` | `'top'` | Tooltip position |
| `variant` | `'dark' \| 'light'` | `'dark'` | Visual variant |
| `arrow` | `boolean` | `true` | Show arrow |
| `trigger` | `'hover' \| 'focus' \| 'click' \| 'contextMenu'` | `'hover'` | Trigger mode |
| `mouseEnterDelay` | `number` | `0.1` | Show delay (seconds) |
| `mouseLeaveDelay` | `number` | `0.1` | Hide delay (seconds) |

### Other Components

The library also includes:

- **Avatar** - User avatars with badge support
- **Checkbox** - Checkboxes with indeterminate state
- **Radio** - Radio buttons and groups
- **Switch** - Toggle switches
- **DatePicker** / **RangePicker** - Date selection
- **Tabs** - Tab navigation
- **Steps** - Step indicators
- **Progress** - Progress bars and circles
- **Skeleton** - Loading placeholders
- **Drawer** - Slide-out panels
- **Popover** - Rich content popovers
- **PageHeader** - Page headers with breadcrumbs
- **Pagination** - Page navigation
- **Image** - Images with preview
- **Upload** - File upload
- **Divider** - Content dividers
- **EmptyState** - Empty state illustrations
- **Tour** - Feature tours
- **Logo** - Fohlio branding

## Common Patterns

### Form Layout

```tsx
<div className="fui:flex fui:flex-col fui:gap-4">
  <div className="fui:flex fui:flex-col fui:gap-1">
    <label className="fui:text-sm fui:text-primary-black">Email</label>
    <Input placeholder="Enter email" />
  </div>
  <div className="fui:flex fui:flex-col fui:gap-1">
    <label className="fui:text-sm fui:text-primary-black">Password</label>
    <Password placeholder="Enter password" />
  </div>
  <Button type="primary">Submit</Button>
</div>
```

### Confirmation Modal

```tsx
<Modal
  open={showConfirm}
  title="Delete Item"
  onClose={() => setShowConfirm(false)}
  onOk={handleDelete}
  okText="Delete"
  okButtonProps={{ danger: true }}
|>
  <Alert
    state="warning"
    message="This action cannot be undone."
    showIcon
  />
</Modal>
```

### Action Bar

```tsx
<div className="fui:flex fui:items-center fui:gap-2">
  <Button type="ghost" icon={<EditIcon />} />
  <Button type="ghost" icon={<CopyIcon />} />
  <Dropdown menu={moreActions}>
    <Button type="ghost" icon={<MoreVertIcon />} />
  </Dropdown>
</div>
```

### Status Indicator

```tsx
<div className="fui:flex fui:items-center fui:gap-2">
  <span className="fui:w-2 fui:h-2 fui:rounded-full fui:bg-primary-green" />
  <span className="fui:text-sm fui:text-primary-black">Active</span>
</div>
```

## Typography

The design system uses Roboto as the primary font:

```tsx
// Explicitly set font
<div className="fui:font-roboto">...</div>

// Text sizes
<p className="fui:text-xs">12px text</p>
<p className="fui:text-sm">14px text</p>
<p className="fui:text-base">16px text</p>
<p className="fui:text-lg">18px text</p>

// Line heights (matching design specs)
<p className="fui:text-xs fui:leading-4">12px/16px</p>
<p className="fui:text-sm fui:leading-[18px]">14px/18px</p>
<p className="fui:text-sm fui:leading-[22px]">14px/22px</p>
<p className="fui:text-base fui:leading-6">16px/24px</p>
```

## Shadows

```tsx
// Component shadows from design tokens
<div className="fui:shadow-sm">Small shadow</div>
<div className="fui:shadow-md">Medium shadow</div>
<div className="fui:shadow-lg">Large shadow</div>

// Focus rings
<button className="fui:focus-visible:shadow-[0_0_0_2px_var(--color-green-dim-100)]">
  Green focus ring
</button>
```

## Border Radius

```tsx
// Standard radiuses
<div className="fui:rounded-[2px]">2px radius</div>
<div className="fui:rounded-[4px]">4px radius (default for inputs/buttons)</div>
<div className="fui:rounded-lg">8px radius (modals, cards)</div>
<div className="fui:rounded-full">Pill/circular</div>
```

## Verification

After code changes, always run:

```bash
npm run lint    # ESLint (catches hooks rules, unused vars, logic errors)
```

Do not consider changes verified unless lint passes.
