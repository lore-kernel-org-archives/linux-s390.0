Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AEF37C929;
	Wed, 19 Aug 2026 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107737; cv=none; b=iIO277b0IbKIbM7TJwH78IHHsxt+onuHBcvm43iTOrwOHLwwcWtIwMLBv80YDNJF5Ki1utt8tgIdRovH0uNTpqO79QlbL9aoxQuJD9GnmhId7l1N5xyR1bXjD3IZnrIXy0m1biY3sMQbXi3CZZlae97IK2egn/r0cd+5Q6Wjq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107737; c=relaxed/simple;
	bh=m7XWBt4YIing3nJlkWfZI8EovhyTNZ4WiUShxjzch/U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qwBs+dj/qYQ2iF6D2U+L+6GT3v7wF0NCsVn3IG2dJe9ta51B0uDdbuxoziIHGJc84g8O+Ux5CorohuL4DCDUz+s66DujP9qKX9275JuF2apLQH/ut4aCC3Y47ZX4P2I4wrUIf0FXUl4+Foq5++0qF1fgdEe2F7g1+ED1dC7FkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTjsEzyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTjsEzyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F71F000E9;
	Wed, 19 Aug 2026 02:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787107734;
	bh=XCh9WDau8NQtT9O6ffQoN79XvrVW4jx7LKjvFD6VYwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTjsEzyNbGdS/7eaVW49eZIoKcMoMtovTLpY0ktQCDI5dv1kxWC3hb+aZochkvkVU
	 t0rOMIkpRsNQKq1QabHFl21XI/HreG3AAEk+NjHzws6Zg/HgRBcDIm1HI0Mwp9NnDI
	 d8DpmPqhu+Dfwsa29gG2iuPIIJv3I3+j23hxQW+fPsVFfZjgJWtGolMNrCkbv3mvmC
	 gAFwur8jA6UhqbJeNBZcthqY5LXeuN0HLKR1tlMMuzx00TtgRiqnqs+enttL1/3I/K
	 U28wELZ2vs5wp+OLm/9q6gkTd60CW7VYzf25CO4YTa/AE603RPs6Oh8AUmEqnl9LaD
	 sstlWYby4aVkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 13/13] modpost: handle MODULE_SYSCTL_TABLE
 symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: bpf@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, mptcp@lists.linux.dev
In-Reply-To: <20260818-sysctl-module-aliases-v2-13-d5a69dae5798@igalia.com>
References: <20260818-sysctl-module-aliases-v2-0-d5a69dae5798@igalia.com>
 <20260818-sysctl-module-aliases-v2-13-d5a69dae5798@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 02:48:53 +0000
Message-Id: <20260819024854.392F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double addition of `sym->st_value` causes `modpost` to read sysctl=
 table pointers from incorrect offsets on ARM and other architectures utili=
zing `SHT_REL`.
- [Medium] The sysctl table entries processing aborts iteration upon encoun=
tering a relocation offset beyond the table's bounds, invalidly assuming EL=
F relocations are strictly sorted.
- [Low] The string replacement loop in `do_sysctl_entry()` skips the charac=
ter immediately following a '%' without bounds checking, leading to an out-=
of-bounds read.
- [Low] The `entry_size` field parsed from the ELF file is used as a diviso=
r without zero verification, allowing a malformed module to trigger a divis=
ion-by-zero crash in `modpost`.
--

--- Patch [13]: [PATCH RFC v2 13/13] modpost: handle MODULE_SYSCTL_TABLE sy=
mbols ---
commit 75e261ee7e3ce69bb021a98d7b4574fdc959ec34
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

modpost: handle MODULE_SYSCTL_TABLE symbols

Update file2alias.c to handle 'mod_devicetable' symbols with type 'sysctl'.
The key operation is to iterate over relocation entries and add module alia=
ses
for each entry.

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 8d36c74dec2d5..797cfc2f478e2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1531,6 +1531,231 @@ static const struct devtable devtable[] =3D {

[ ... ]

> +// Looks like: sysctl:*/path/procname
> +static void do_sysctl_entry(const char *procname, const char *path,
> +			    struct module *mod)
> +{
> +	const char *src;
> +	char *dst, buf[256], *end =3D buf + sizeof(buf) - 1; /* -1 for NUL byte=
 */
> +
> +	/* Replace '%s' from path template with '*' for wildcard in modprobe. */
> +	for (src =3D path, dst =3D buf; *src && dst < end; src++, dst++)
> +		*dst =3D (*src =3D=3D '%') ? (src++, '*') : *src;

[Severity: Low]
Does this loop advance past the end of the string if the path ends exactly
with a '%' character?

If *src is '%', the inline ternary operator does a src++. Then the loop's
update step does another src++, which would skip the NUL terminator and lead
to an out-of-bounds read on the next iteration.

> +	*dst =3D '\0';
> +
> +	module_alias_printf(mod, false, "sysctl:*/%s/%s", buf, procname);
> +}

[ ... ]

> +static bool do_sysctl_entries(struct elf_info *elf, Elf_Shdr *sechdr, El=
f_Sym *sym,
> +			      Elf_Addr r_offset, Elf_Addr r_addend, void *data)
> +{
> +	struct sysctl_entries *sysctl_entries =3D (struct sysctl_entries *) dat=
a;
> +
> +	/* Skip until .table starts */
> +	if (r_offset < sysctl_entries->table_offset)
> +		return false;
> +
> +	/* Stop after .table ends */
> +	if (r_offset >=3D sysctl_entries->table_offset + sysctl_entries->table_=
size)
> +		return true;

[Severity: Medium]
Is it safe to assume that relocation entries in the ELF section are strictly
sorted by r_offset?

By returning true here, the loop over relocation entries is aborted. The ELF
specification does not guarantee strict sorting by offset. If a linker emits
an out-of-order relocation entry earlier in the section but pointing past t=
he
table, could this prematurely abort the traversal and miss valid entries?

> +
> +	/* Check for alignment with an array entry (.procname at offset zero) */
> +	if ((r_offset - sysctl_entries->table_offset) % sysctl_entries->entry_s=
ize =3D=3D 0) {

[Severity: Low]
Can entry_size be zero here?

Since entry_size is parsed directly from the ELF module, a malformed module
with a size of 0 could trigger a division-by-zero crash in modpost.

> +
> +		/* The symbol for .procname points to a string */
> +		const char *procname =3D (const char *)
> +				       sym_get_data_addend(elf, sym, r_addend);

[ ... ]

> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index d18a87b882a67..10eb7273cdd81 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -340,6 +340,13 @@ void *sym_get_data(const struct elf_info *info, cons=
t Elf_Sym *sym)
>  				      sym->st_value);
>  }
> =20
> +void *sym_get_data_addend(const struct elf_info *info, const Elf_Sym *sy=
m,
> +			  Elf_Addr r_addend)
> +{
> +	return sym_get_data_by_offset(info, get_secindex(info, sym),
> +				      sym->st_value + r_addend);
> +}

[Severity: High]
Does this result in adding sym->st_value twice on architectures like ARM
that use SHT_REL?

In for_each_reloc(), r_addend is calculated using addend_rel(). On ARM,
addend_rel() already returns the instruction value plus sym->st_value.

If sym->st_value is added again here (and in the manual table_offset
calculation in do_sysctl_table()), modpost will read from the wrong
offset, silently failing to extract .procname and missing the module
aliases.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-sysctl-mod=
ule-aliases-v2-0-d5a69dae5798@igalia.com?part=3D13
