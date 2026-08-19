Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541837E5D0;
	Wed, 19 Aug 2026 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164524; cv=none; b=eVMzMgL0vs9HNU0hx1Ji0dlZGqZcqrKTkMKmRSW+S12aYwuaXbYQ+AHgK/VCf6hC7TAvDt6tzcCWPFA27EkRm4JzE0AA2WNrPSYrlMygK0xs+N79dHhV8njmphRtHgprXkvbTzZawyBA0KDQDsPRK5Z9WSYQALk5mvj3OL7guDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164524; c=relaxed/simple;
	bh=8MhMl8X4jc9W9ZxtdAKGtyoagG1gu9HzjG3UU342WPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nSms9xjywU6dNP2tCbd5kmlH6raGCY48KPm9053Ah+k4nmRh2dPQ45daahcnZ/jZF+0rw6q2P9onWTbEehvPqlkDUmCpR/L3PetWGEvHI0nnoDBu6pi+65Mixm9RfRHO3f3Rg7O9Sh+Dt+JxBFgtQ1nB01MUoJImoVlQY5kEGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBuprqwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBuprqwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC311F000E9;
	Wed, 19 Aug 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164523;
	bh=esSxMZohsTgFLd7iRjr7PDgvBZTG6p3cNP7Cbpt903U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBuprqwWUPpXbbNR6fbjq43/qZPp07JDBPIb7jZdFFn2TP61MVZw0wS/2IIl1n/iB
	 elZuEt6qf2p+EnhQ+6H4N7zS7Gnsj6/LRZsIShPX3cVMnZSkNHdqbCZFvAaxFo7VvS
	 Ld+ui/5ObwFlAi+QUFhucFjOEmo+xzIfZfeye6dP1rGjMY7vRGFpF6JMPnpGtbAn39
	 BZEXCwy2MlAyXOIfJn5GbAw5KBShPwhjUjl3QAS279zM1lCklV5JnGJnYOpYE9vyW1
	 mtxYI7unVCsfVzTDAh7niMLwkEoaA6ZctwAPMEnKaJt7YZxmbfd2L5/yOqo95BaftD
	 f8BVDcJH5aDlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 13/13] modpost: handle MODULE_SYSCTL_TABLE
 symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-sysctl-module-aliases-v3-13-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-13-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:35:22 +0000
Message-Id: <20260819183522.DDC311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Double addition of `st_value` when calculating relocation offsets =
for `SHT_REL` sections.
- [High] `get_reloc_secindex()` overly restricts relocation sections by man=
dating the `SHF_INFO_LINK` flag, risking build failures on older toolchains.
- [High] Unvalidated symbol indices when resolving `.path` and `.procname` =
pointers can lead to out-of-bounds reads and garbage alias generation.
- [Medium] `do_sysctl_entries` assumes ELF relocation entries are sorted by=
 `r_offset`, which can prematurely abort the loop and miss sysctl aliases.
--

--- Patch [13]: [PATCH RFC v3 13/13] modpost: handle MODULE_SYSCTL_TABLE sy=
mbols ---
commit c9abe55361fd772a202db345bc7ccf9707457699
Author: Mauricio Faria de Oliveira <mfo@igalia.com>

modpost: handle MODULE_SYSCTL_TABLE symbols

This commit updates file2alias.c to handle mod_devicetable symbols with
type sysctl. It introduces helpers to iterate over relocation entries,
extracting the path and procname fields to generate sysctl module aliases.

> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 8d36c74dec2d5..abf6ce69831e2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
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
Does this code assume relocation entries are strictly sorted by r_offset?
The ELF specification does not guarantee that relocation entries are sorted.
If a compiler emits a relocation for a different variable earlier in the
section, could this prematurely abort the loop and miss valid sysctl aliase=
s?

> +
> +	/* Check for alignment with an array entry (.procname at offset zero) */
> +	if ((r_offset - sysctl_entries->table_offset) % sysctl_entries->entry_s=
ize =3D=3D 0) {
> +
> +		/* The symbol for .procname points to a string */
> +		const char *procname =3D (const char *)
> +				       sym_get_data_addend(elf, sym, r_addend);

[Severity: High]
Could this read out-of-bounds memory or garbage data if the procname pointer
references an external string?

If the symbol section index is SHN_UNDEF or SHN_ABS, sym_get_data_by_offset=
()
might read from offset 0 (the ELF header) or an index far outside the bounds
of the section headers array. Should the symbol's section index be validated
before fetching the data?

> +
> +		if (!procname) {
> +			warn("%s [%s] found entry with NULL .procname (skip)\n",
> +			     sysctl_entries->modsymname, sysctl_entries->mod->name);
> +			return false;
> +		}
> +
> +		do_sysctl_entry(procname, sysctl_entries->path, sysctl_entries->mod);
> +	}
> +
> +	/* Continue at next entry */
> +	return false;
> +}
[ ... ]
> +static void do_sysctl_table(const char *modsymname, void *modsymval,
> +			    Elf_Sym *modsym, struct module *mod,
> +			    struct elf_info *info)
> +{
[ ... ]
> +	/* The .path symbol can be read directly. */
> +	sysctl_entries.path =3D (const char *)
> +			   sym_get_data_addend(info, sysctl_pointers.path_sym,
> +						sysctl_pointers.path_r_addend);

[Severity: High]
Similarly to the procname symbol above, is it possible for path_sym to be
SHN_UNDEF or SHN_ABS? Reading it without validating the section index could
cause modpost to crash or embed garbage aliases.

> +
> +	/* The .table symbol is the struct ctl_table array. */
> +	sysctl_entries.table_offset =3D sysctl_pointers.table_sym->st_value +
> +				   sysctl_pointers.table_r_addend;
> +
> +	/* The .entry_size value must not be zero. */
> +	if (sysctl_entries.entry_size =3D=3D 0) {
> +		error("%s [%s.ko] invalid entry size (zero)\n",
> +		      modsymname, mod->name);
> +		return;
> +	}
> +
> +	/* Add module aliases for entries in the struct ctl_table array. */
> +	for_each_reloc(info, shndx, do_sysctl_entries, &sysctl_entries);
> +}
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
Will this result in a double-addition of st_value for SHT_REL sections?

In for_each_reloc(), addend_rel() is called for SHT_REL sections, which
already adds sym->st_value to the addend. Adding it again here computes
the offset as 2 * st_value + addend, which could read from the wrong offset
or cause an out-of-bounds access.

> +
>  static const char *sech_name(const struct elf_info *info, Elf_Shdr *sech=
dr)
>  {
>  	return sym_get_data_by_offset(info, info->secindex_strings,
[ ... ]
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index a98811552bd29..409fdfc844c4b 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -186,6 +186,25 @@ static inline unsigned int get_secindex(const struct=
 elf_info *info,
>  	return index;
>  }
> =20
> +/* Find the relocation section for the section of a symbol */
> +static inline unsigned int get_reloc_secindex(const struct elf_info *inf=
o,
> +					      const Elf_Sym *sym)
> +{
> +	unsigned int sym_secindex =3D get_secindex(info, sym);
> +	unsigned int secindex;
> +
> +	for (secindex =3D 0; secindex < info->num_sections; secindex++) {
> +		Elf_Shdr *shdr =3D &info->sechdrs[secindex];
> +
> +		if ((shdr->sh_type =3D=3D SHT_RELA || shdr->sh_type =3D=3D SHT_REL) &&
> +		    (shdr->sh_flags & SHF_INFO_LINK) &&
> +		    shdr->sh_info =3D=3D sym_secindex)
> +			return secindex;
> +	}

[Severity: High]
Is it safe to mandate the SHF_INFO_LINK flag for relocation sections?

Older toolchains or alternative linkers might omit this flag even when
sh_info is correctly populated. If this returns SHN_UNDEF, the build will
fail unconditionally due to the error() call in do_sysctl_table().

> +
> +	return SHN_UNDEF;
> +}
> +
>  /*
>   * If there's no name there, ignore it; likewise, ignore it if it's
>   * one of the magic symbols emitted used by current tools.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D13
