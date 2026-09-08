Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850B37F30A
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852040; cv=none; b=MpTXOYapbmKV+2W2n/oT/2NOqTNjEg1xaEY+52LVrKlvFBPqwMW7DOQv0iZUUf1xotor01lP1vLVXgr+EoyGEpOlwwG/ndTyC9jqyYlmZPOtXCMNFeYEBFXXXdWB5Hp7DacPm91dNESMZLqkzT1QhCfFIil8hzAuKDEkqj5Ge/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852040; c=relaxed/simple;
	bh=apibC93RSahAj08XM2vBA8YTBE40isdtNZF2tRLuuOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJiMrMwcITdAM761MtQfA58Wn+qdsTkv0uhh4aVzY822CYvdjWbW5b9M+juM/Eka8BEdfptZyFc5Ff0NQclAUwF0ooA87jxMIiP//ZbHAUSiJb2ZY2PRadlEjwCdryHWEmW9+SzdyCxyXXewHPHJ7wowmQQuetT1W73D2UQdXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY/0CJgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY/0CJgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7737E1F00A3A;
	Tue,  8 Sep 2026 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788852038;
	bh=1xqDsNXKjNHzz5DrRrrVaGHOTxkRVAT8EXNpL8B83Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UY/0CJgo8FYyveQLLRa5mVr12CLSoRW1CVmfN7i6+VxTKFK/ge9xW98poZ2ymZij+
	 adBKdoUK6dBNeu9COIuHdtEoKtwH1J9rH3+XcUvUFfHwKpoNJffdhkq2xnTssE/Thx
	 hlHkJPDkC4PMif43QecTmfpCeOLNfWtRLSuPzeeWCQ5q9kCS8hOXIps82mDk85ZuuM
	 E5mL/RD/2ajjPfs6Asl7F5t1/e3hynkp5fLtKgkZWZWlxLg3j5W/4bipjHryWjUVfx
	 utbmCFMmh+L5Ad38LrYNdiWjABWcwsoAUdsD5TEmSJTwT28GHtt7hzbiV+9ciZCk1j
	 eJYpqnzG+jsqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/24] MIPS: vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: ojeda@kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-22-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-22-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:20:37 +0000
Message-Id: <20260908072038.7737E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] vdsocheck incorrectly parses MIPS64 little-endian relocation types,=
 breaking the kernel build.
--

commit ea40289bf46aaa734bd008626afd0dcc58b9b860
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

MIPS: vdso: Enable the vdsocheck tool

This commit wires up the vdsocheck tool for the MIPS architecture. The tool
validates VDSO object files and the final .so library to detect incompatible
relocations created by the compiler.

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a06f243173060..6cd04a9d52813 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -107,6 +107,7 @@ config MIPS
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select ARCH_HAS_ELFCORE_COMPAT
>  	select HAVE_ARCH_KCSAN if 64BIT
> +	select VDSO_CHECK

[Severity: Low]
Will enabling VDSO_CHECK on MIPS cause spurious build failures on MIPS64
little-endian?

When vdsocheck parses ELF64 relocations, it extracts the type as follows:

lib/vdso/check/elf.rs:RelSectionIterator::next() {
    ...
    ClassAlternative::Elf64(iter) =3D> iter.next().map(|n| {
        let type_ =3D n.r_info.to_cpu(iter.byteorder) as u32;
    ...
}

For both RelSectionIterator::next and RelaSectionIterator::next, this
extracts the symbol index instead of the relocation type for MIPS64
little-endian ELF64 relocations.

Since CONFIG_MIPS now selects VDSO_CHECK, this can break the kernel build
on MIPS64 little-endian when Rust is available, because the vdsocheck tool
incorrectly parses r_info and exits with an error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D22
