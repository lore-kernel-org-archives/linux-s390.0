Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF73845D5;
	Wed, 19 Aug 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164336; cv=none; b=PtcsK+qbqILA1QN6S4zaT2fd456lkP3EMjYlzg2za0UzfM2tOL5exxAWh8HehZ3vVwlQHRbqsXNyUnp8Sb0R8ZArXYLNFFf+9MkNg8UyWYudJAviBI+gKs8dK/NxKTLRQjeRjhQZKj24i33r0O97A2zEy15RYdmdZzFQnuNh1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164336; c=relaxed/simple;
	bh=gDGh2HKcSpCzk2K5ZSS9qcJ/Tn7IFDii1N4giq6u5P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QrqYQ8v7oknzCzSZEFMfu0iQA+5t+kg79tXMhLk58sYv5AJmgBvEUIRdckPZFAqXg6eDWwZW/5wjnULuWZN8n6gZaZoo0liEmjCqPC1jjKa8ih5oW7KOkAoTHEaYZqxjgob70Nac5qR8yMjmtI40SoivItSPD2i5ZyVf6wrQ48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJGdFSvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJGdFSvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BD91F000E9;
	Wed, 19 Aug 2026 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164334;
	bh=tdkdL9zNHUUcVRngtuzksElZuYPDmdAFUm/voGbyz3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJGdFSvqe+bUNidA8dkPI/ANMYD1IwJl3TDuSzz/sOmYlYLL3HArMCkFm4rQvI7+8
	 JjTzMz/ek0tE1xNNUZW3spFtbLeG6OYP/4J3N8GfaOYFIzpjl8EfiS++4/pyhb74/Z
	 20pSWRK7rk9SjVGAUFg9CFPPmNUTuNU7voKN53o2L60xi+CN5agGIph5MTdQQ7M6y4
	 AVt2qNpGH5R64E7+P85TViEwFfXn8cJYekGBh3ykzC5ASX9SiMpjTYOTpuuMMJlsLp
	 xvivGNL3PXpfeNupMK7h0vMjJGbj++yU6IddRJvPnUU4y60AprnQrn6kvonlv6KTX6
	 0+ActXuPUr8jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819-sysctl-module-aliases-v3-3-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-3-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:32:13 +0000
Message-Id: <20260819183214.05BD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] MODULE_SYSCTL_TABLE exports pointers to modpost, violating the dev=
icetable design pattern and breaking module alias extraction.
- [Medium] Silent truncation of sysctl table size for large arrays.
- [Low] Brittle symbol name generation requires manual user workaround for =
struct field arguments.
- [Low] The commit message incorrectly documents the names of the control m=
acros.
--

--- Patch [3]: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro MODU=
LE_SYSCTL_TABLE ---
commit 65937d6d2c35e0f567f1295d6273adbf6b625450
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

sysctl, mod_devicetable: add macro MODULE_SYSCTL_TABLE

The MODULE_SYSCTL_TABLE macro emits a struct module_sysctl_table variable
with pointers to a sysctl table's path and entries, and table/entry sizes.

> The option macros MODULE_SYSCTL_TABLE_{DISABLE,UNIQUE_ID} can be used on
> a per-file basis to disable the macro and change the symbol name pattern.

[Severity: Low]
This isn't a bug, but the commit message documents these macros as
MODULE_SYSCTL_TABLE_DISABLE and MODULE_SYSCTL_TABLE_UNIQUE_ID, while the
code actually implements SYSCTL_MODULE_ALIASES_DISABLE and
SYSCTL_MODULE_ALIASES_UNIQUE_ID. Could the commit message be updated to
match the code?

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index a397213bedace..818a4a53448db 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -78,4 +78,11 @@ struct cpu_feature {
>  	__u16	feature;
>  };
> =20
> +struct module_sysctl_table {
> +	kernel_ulong_t path;
> +	kernel_ulong_t table;

[Severity: High]
Will modpost be able to resolve these pointers? file2alias.c parses raw
section data from unlinked ELF objects to extract module aliases. Because
path and table are pointers rather than inline string arrays or structures,
modpost will read raw unresolved offsets instead of actual data.

This would break alias extraction on most architectures since file2alias.c
lacks a generalized relocation engine to resolve pointers across ELF sectio=
ns.

> +	__u16 table_size;
> +	__u16 entry_size;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */

[ ... ]

> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index e5d7226ab6f5a..0adc056ff54d8 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h

[ ... ]

> +#if defined(SYSCTL_MODULE_ALIASES_UNIQUE_ID)
> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
> +	__mod_device_table(sysctl, __UNIQUE_ID(sysctl))
> +#else
> +#define __MODULE_SYSCTL_TABLE_NAME(table)					\
> +	__mod_device_table(sysctl, table)
> +#endif

[Severity: Low]
Does this symbol name generation unnecessarily force manual workarounds? By
default, if table is passed as a struct member (like my_module.table), this
creates an invalid C identifier containing a dot. Would it be simpler to ju=
st
use __UNIQUE_ID unconditionally to avoid syntax errors?

> +
> +#define MODULE_SYSCTL_TABLE(path, table)					\
> +	static struct module_sysctl_table __used				\
> +		__MODULE_SYSCTL_TABLE_NAME(table) =3D {				\
> +			(kernel_ulong_t) path,					\
> +			(kernel_ulong_t) table,					\
> +			(u16) sizeof(table) + __must_be_array(table),		\

[Severity: Medium]
Could casting sizeof(table) to a u16 cause a silent truncation for very lar=
ge
sysctl tables?=20

While no current single static sysctl table in the kernel exceeds 65,535
bytes, casting size_t to a 16-bit integer creates a structural limit that
will silently report the wrong size if a table ever exceeds roughly 1,024
elements.

> +			(u16) sizeof(const struct ctl_table)			\
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D3
