Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3638DC56
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850645; cv=none; b=q170NSpX59hh6OjdbjBfhYaxf7/+rqEOcP68zXwwgy/TNjvmPfAWFl5SpQigHjptXzmrBrR04gpy1PJp6LPrwTtkCaJkQ25i6RJO9hI9pog/IPLx1iM32XHhAGgef0KH+zx/whs3CP7bMuiGM9C5bb69cgDQax5BsskNKa4zeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850645; c=relaxed/simple;
	bh=aMPlI6f165qaXjI2ewVV9ZI7hdhGXHNav2hm8zlodTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qi09apqhJhijjZa4Das2k0DLuTbNMZswPnOeqYizi/VZ6aoH7peVgx3ZOSPhmxC3ews2EcFKCkRhgKUS0udWDzcrnJa92mhf5DlZMAf00zy9EnHdkyh00znUBOXlWMZ6XykE2D9alqWFyNyfB8XHnP2bQwkSwB25dMX3FhIDMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6oHBbXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6oHBbXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3E61F00A3A;
	Tue,  8 Sep 2026 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850640;
	bh=SbhWHozeHreKEaSmIh2jN0I/8wLLM0p12Wqi/z9wnF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6oHBbXBRZhW4FdXgU8UiRPr2WYAv/5vbpCYhY2LdqBbrHDix6pwy/lThw6U+/Ap2
	 +8aNtyCoYWPTPCI7qozM+2nQyw1zpeQgpRTxwxujo4l6iBpbRZW7NCEzLd+eLkhAN0
	 pwtWhcK+N6jj5FU9Us0qUBfKhKtvxeqrJbETg1ZbppekPvLK3UODrDRhf4TQjjEDPv
	 gDWrS0RdUzScb2HAlhU1BUl5icWHteYgNKoB3xmokgwSOY7wNVC4eWZBOEMcNqwe4/
	 gJjyiDlhAuntyiPzYRFnX862dGSZN9p0QWxAeKzrHh9snz3hZFFm6eXWH6tbyQPpmG
	 Hl+kzAiBpRUlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, ojeda@kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:57:19 +0000
Message-Id: <20260908065719.DF3E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Parsing failure for valid ELF files containing `SHT_NOBITS` sect=
ions.
- [Medium] `validate_linked_dso` blindly rejects DSOs with `SHT_REL` / `SHT=
_RELA` sections, dropping the workaround for `R_*_NONE` relocations.
- [Low] Unchecked slice indexing in `get_data_subslice` causes unhandled pa=
nics on malformed or adversarial ELF files.
- [Low] vdsocheck.rs fails to compile due to multiple lifetime violations a=
nd a move-while-borrowed error.
--

commit 043a7ddfce689ccb30ea6aee60c35639fb8be5b1
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

vdso: Add the vdsocheck tool

This commit introduces a Rust-based vdsocheck tool to validate that the vDSO
library does not contain absolute dynamic relocations, moving this logic ou=
t of
inline shell commands.

> diff --git a/lib/vdso/check/elf.rs b/lib/vdso/check/elf.rs
> new file mode 100644
> index 0000000000000..520285d6fd10a
> --- /dev/null
> +++ b/lib/vdso/check/elf.rs
[ ... ]
> +fn get_data_subslice(data: &[u8], offset: u64, size: u64) -> ParseResult=
<&[u8]> {
> +    let start: usize =3D offset.try_into().map_err(|_| ParseError::Index=
OutOfRange)?;
> +    let size: usize =3D size.try_into().map_err(|_| ParseError::IndexOut=
OfRange)?;
> +    let end =3D start.checked_add(size).ok_or(ParseError::IndexOutOfRang=
e)?;
> +
> +    Ok(&data[start..end])
> +}

[Severity: Low]
Does this slice indexing panic if the ELF file specifies an out-of-bounds s=
ize
where end exceeds data.len()?

Could this use data.get(start..end).ok_or(...) instead to return a graceful
parsing error rather than failing on malformed ELF files?

[ ... ]
> +impl<'f: 'a, 'a> Iterator for SectionHeaderIterator<'f, 'a> {
> +    type Item =3D ParseResult<SectionHeader<'f>>;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
[ ... ]
> +        match &mut self.0 {
> +            ClassAlternative::Elf32(iter) =3D> iter.next().map(|n| {
> +                Ok(SectionHeader {
> +                    name: n.sh_name.to_cpu(iter.byteorder).into(),
> +                    type_: n.sh_type.to_cpu(iter.byteorder).into(),
> +                    entsize: n.sh_entsize.to_cpu(iter.byteorder).into(),
> +                    data: get_data_subslice(
> +                        file_data,
> +                        n.sh_offset.to_cpu(iter.byteorder).into(),
> +                        n.sh_size.to_cpu(iter.byteorder).into(),
> +                    )?,
> +                })
> +            }),
[ ... ]

[Severity: Medium]
Will this fail to parse valid ELF files containing sections with no file da=
ta
like .bss?

Since sh_size for these sections represents memory allocation size rather t=
han
file size, calling get_data_subslice() here attempts to read non-existent
bytes from the file, which could cause a parsing failure.

[ ... ]
> +impl<'a> RelSection<'a> {
> +    pub fn entries(&'a self) -> ParseResult<RelSectionIterator<'a>> {
> +        RelSectionIterator::new(&self.0)
> +    }
> +}

[Severity: Low]
Does this method signature enforce a lifetime bound (&'a self) that cannot =
be
satisfied when iterating over locally constructed sections? This appears to
cause a compile failure in validate_object_file().

[ ... ]
> diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> new file mode 100644
> index 0000000000000..f4c0730bc976d
> --- /dev/null
> +++ b/lib/vdso/check/vdsocheck.rs
[ ... ]
> +fn validate_linked_dso<'a>(file: &'a elf::File<'a>) -> ValidationResult<=
'a> {
> +    for section in file.sections()? {
> +        let section =3D section?;
> +
> +        /* No relocations are allowed */
> +        match section {
> +            elf::Section::Rel(_) | elf::Section::Rela(_) =3D> {
> +                return Err(ValidationError::UnexpectedSection(section))
> +            }
> +            _ =3D> {}
> +        }
> +    }
> +
> +    Ok(())
> +}

[Severity: Medium]
Does this blindly reject DSOs containing relocation sections, even if they
solely contain ignored relocations?

The inline shell script this replaces in lib/vdso/Makefile.include explicit=
ly
ignored _NONE relocations:

  cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_\w*=
_"; \

Does unconditionally rejecting all relocation sections drop this workaround=
 for
toolchains that emit empty or _NONE relocations?

[ ... ]
> +fn validate_object_file<'a>(file: &'a elf::File<'a>) -> ValidationResult=
<'a> {
[ ... ]
> +        match section {
> +            elf::Section::Rel(ref rel) =3D> {
> +                for entry in rel.entries()? {
> +                    if !allowed_relocs.in_object_file.contains(&entry.ty=
pe_) {
> +                        return Err(ValidationError::InvalidRelocation(se=
ction, entry.type_));
> +                    }
> +                }
> +            }

[Severity: Low]
Will this fail to compile due to a move-while-borrowed error?

The variable section is moved into ValidationError::InvalidRelocation while=
 it
is still borrowed by ref rel.

Combined with the lifetime requirements of rel.entries(), this breaks the
build when the vdso check config is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D12
