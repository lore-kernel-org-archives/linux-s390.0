Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08F3A48CE;
	Wed, 19 Aug 2026 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107257; cv=none; b=Ct7a3KrnYJ6ITpitXvtU4z07Y5VfJ/M7jJxhc809WKN+vzobuE7e04HNEQDcCoNvZDQvadfqGsjSvS4NJBA9qmDEcc/2lfT/UoFWMEcxe70OI0Cr8Tm92MfhOiALbJABG2MOFTqqhSHRSiTyX8pyFOaJVOs1oWaxPkcRwCC2i+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107257; c=relaxed/simple;
	bh=RFOUEBd0qDik04axY75PASPXmY3gU+r77iPbIXissfc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5JHqWzeT9XThR+22wHofb1U5ooCqpAAZrx51YS6WVHom+EW3KCb6soUuXRzUp0n+4ZSenCO9mmTPdEJIIz5ZxM7QtUHsSX9zA8BA4JXgjSiLajUcSiBvPl2Pg8GJRj5NqLyWfrBDEUxSm5/13gSRgSIsaMI+6Z2KCPdkGOtsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyanajEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyanajEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F891F00A3A;
	Wed, 19 Aug 2026 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107255;
	bh=qR85q3l3hpjNS7LNGhZjC5VXmOaHNYrfgj6MBTN30mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyanajEkQXi4+JLU2cmW8Xyls7HE5+5WEjZoP6neBKhb7shQYqgdFr2jb1I/+BtXN
	 NQgg3jAaR0XMDuO1+drjs+f4mmYxEy2OW8ulZ0ZnIhDBAH11GoIC3b7Gam5ue5gwoP
	 vvS0mSpXvEF7zZJdNOSJAkjg6erYTw2mU+0GeuGHgB7QYlMcuUk6HdRv/vHmixfLd/
	 eyc4qoLaeVsysa5yEcA0shUsUXvbg5luv7oZnVf2t5wNrPa2THqfJ9d37AApPE8RVd
	 S3fneeyKdQXZUvRQy87L5IWclMHFLEPXfW01naElA9FVE5bbW8jGB9AJeXU6onV9AQ
	 ytDMmqgZl9bHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, mptcp@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260818-sysctl-module-aliases-v2-3-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-3-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:40:55 +0000
Message-Id: <20260819024055.91F891F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The file2alias.c handler for sysctl device tables is entirely miss=
ing from the patch, resulting in no module aliases being generated.
- [High] `__UNIQUE_ID` is used without arguments, preventing its expansion =
and causing redefinition compiler errors.
- [High] Pointers in device table structs cannot be dereferenced by modpost=
 without relocation resolution.
- [High] modpost cannot parse `struct ctl_table` due to randomized layout a=
nd nested pointers.
- [High] Macro generates a single struct, but modpost expects a NULL-termin=
ated array.
- [Medium] The MODULE_SYSCTL_TABLE macro silently accepts pointers instead =
of arrays, resulting in an invalid table_size.
--

--- Patch [3]: [PATCH RFC v2 03/13] sysctl, mod_devicetable: add macro MODU=
LE_SYSCTL_TABLE ---
commit 4b00a2bf658ca058127bbaaa61c3c168a3a4574c
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl, mod_devicetable: add macro MODULE_SYSCTL_TABLE

This commit adds the MODULE_SYSCTL_TABLE macro to emit a struct
module_sysctl_table variable containing pointers to a sysctl table's path
and entries. It also adds the necessary struct definitions and field
offsets for modpost integration.

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index a397213bedace..818a4a53448db 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h

[ ... ]

> @@ -78,4 +78,11 @@ struct cpu_feature {
>  	__u16	feature;
>  };
> =20
> +struct module_sysctl_table {
> +	kernel_ulong_t path;
> +	kernel_ulong_t table;

[Severity: High]
Does modpost know how to read these external pointers?=20

Modpost's file2alias.c extracts raw bytes from the struct and typically
does not resolve relocations to dereference .rodata or .data pointers. Will
this prevent modpost from actually reading the path or table strings/data
from unlinked ELF object files (.o)?

> +	__u16 table_size;
> +	__u16 entry_size;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index e5d7226ab6f5a..6960fe22c50bf 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h

[ ... ]

> @@ -293,6 +293,48 @@ struct ctl_table_root {
>  	int (*permissions)(struct ctl_table_header *head, const struct ctl_tabl=
e *table);
>  };
> =20
> +/*
> + * Creates a symbol so file2alias.c can find the sysctl table.
> + *
> + * MODULE_SYSCTL_TABLE() is the sysctl equivalent of MODULE_DEVICE_TABLE=
(),
> + * with pointers to a sysctl table's path and entries, and table/entry s=
izes.
> + *
> + * The parameters 'path' and 'table' must be static (e.g., string litera=
l or
> + * static char[]; static struct ctl_table[]) as both are used as initial=
izer
> + * elements for a static struct variable.
> + *
> + * The generated symbol name contains 'table' by default. However, if 't=
able'
> + * is a struct field (contains '.' or '->'), in order to avoid syntax er=
rors,
> + * define the macro SYSCTL_MODULE_ALIASES_UNIQUE_ID.
> + *
> + * Define the macro SYSCTL_MODULE_ALIASES_DISABLE to disable this.
> + */
> +#if defined(CONFIG_SYSCTL_MODULE_ALIASES) && defined(MODULE) &&			\
> +    !defined(SYSCTL_MODULE_ALIASES_DISABLE)
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +
> +#if defined(SYSCTL_MODULE_ALIASES_UNIQUE_ID)
> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
> +	__mod_device_table(sysctl, __UNIQUE_ID)

[Severity: High]
Does this use of __UNIQUE_ID work correctly without an argument?=20

Since __UNIQUE_ID is a function-like macro, using it without parentheses
prevents its expansion. This could result in the preprocessor treating it
as a literal token, generating a variable name like ...__sysctl____UNIQUE_ID
and causing redefinition errors if invoked multiple times in the same file.

> +#else
> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
> +	__mod_device_table(sysctl, table)
> +#endif
> +
> +#define MODULE_SYSCTL_TABLE(path, table)					\
> +	static struct module_sysctl_table __used				\
> +		__MODULE_SYSCTL_TABLE_NAME(table) =3D {				\

[Severity: High]
Will this work with modpost's do_table() logic?=20

This macro generates a single struct instance, but modpost expects all
__mod_device_table symbols to point to an array terminated by an all-zero
element. Scanning this single struct could cause a build-time
"not terminated with a NULL entry" error when it sees non-zero bytes.

> +			(kernel_ulong_t) path,					\
> +			(kernel_ulong_t) table,					\

[Severity: High]
If modpost attempts to parse struct ctl_table through this pointer, how does
it handle a randomized struct layout?=20

Since struct ctl_table can be marked with __randomize_layout when
CONFIG_RANDSTRUCT is enabled, a host tool like modpost cannot reliably extr=
act
information from these entries without having the field offsets explicitly
exported in devicetable-offsets.c.

> +			(u16) sizeof(table),					\

[Severity: Medium]
Can this silently evaluate to a pointer size instead of the array size?=20

If a pointer to a ctl_table is passed instead of a static array, sizeof(tab=
le)
evaluates to the pointer size, leading to an incorrect table size being
emitted. Could this be protected using __must_be_array(table)?

> +			(u16) sizeof(const struct ctl_table)			\
> +		}
> +#else
> +#define MODULE_SYSCTL_TABLE(path, table)
> +#endif
> +
>  #define register_sysctl(path, table)	\
>  	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> =20
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-=
offsets.c
> index b4178c42d08f5..e3b8855e6ebcf 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c

[ ... ]

> @@ -284,5 +284,11 @@ int main(void)
>  	DEVID(coreboot_device_id);
>  	DEVID_FIELD(coreboot_device_id, tag);
> =20
> +	DEVID(module_sysctl_table);

[Severity: High]
Where is the file2alias.c handler for sysctl device tables?=20

The commit message mentions this symbol will be handled by file2alias.c,
but the patch does not appear to add the corresponding entry in the
devtable[] array to actually parse the new struct. Will this result in
no module aliases being generated at all?

> +	DEVID_FIELD(module_sysctl_table, path);
> +	DEVID_FIELD(module_sysctl_table, table);
> +	DEVID_FIELD(module_sysctl_table, table_size);
> +	DEVID_FIELD(module_sysctl_table, entry_size);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D3
