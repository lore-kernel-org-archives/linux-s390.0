Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FD3859C3
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850881; cv=none; b=U5hbiD+E8AQwF3NVyD0DASAyN3IoMZOS4E+62vttBY9ZI4l9t3eyxQCxIEZozlM0GfKzMvkPh5FJWifvnAQQ9KPeNi67GBUR/nWK+h3RzrOD58byMwFOvMPkGt/pF3FUS4YjEy6iUxoAygu3XxWUPRcXCp2lR66AFZQqDPL64Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850881; c=relaxed/simple;
	bh=sKzJJ6+3Lat98uxXCnCiDEbDORpqm20kpG4MlUlJroI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMTMCJXFXWXkUa/tnKCOrHXOJfs+nu0VQK4atmMtjnRcpj2j9PDwdL49rbt1HlJXP5C/2prQDoV31o/zxpJ/ZlpbfHzub9XSE0BifX10Dtvq4Q/2hQcV52SDZtfveiKYbql0wOomG0YdfE0ym6rcOhALkTE820y3NwLq49sB8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj3D4afR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj3D4afR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1641F00A3E;
	Tue,  8 Sep 2026 07:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850880;
	bh=sP4bAVwgq8vm5+KjQfIrI2f/FO56Xx4a9zte1BuXwaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lj3D4afRIf2MnFl+jP0VBqs11wE1lW57iRPKrzlQbTakwBdgiMDAO1hF9NsWVqNRl
	 EDVkfdCt9OZdqZsE5mM0fvFBIJSvVMAvi3mLcTSAb/Vq9PRXKhw8OMgwOd18/5oncq
	 ai8S8TNJmgBVQpzLD6ZmTW+Q8pqgax1gG9eoxlD9w8a3pT1yurJ7v1vmfU47EA6Dnr
	 A3rKXRXcqjo7p36Rwe5E8QUTIBWRN+EL2tHA0kUD7ZnL7eJTN3yprE/eNQLZDXkMzb
	 DbaxYJ+y8LPO/5TczcQ0X60w0KK4YavvZfQlpKhUoVreO/MJ323UjeCEKiTAg/vwO9
	 9GQPIFEFblXKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/24] ARM: vdso: Enable the vdsocheck tool
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, ojeda@kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-14-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-14-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:01:18 +0000
Message-Id: <20260908070118.CE1641F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The Rust vdsocheck tool unconditionally rejects linked DSO (ET_DYN=
) files containing any relocation sections, inadvertently breaking the buil=
d on ARM with GNU ld ports that emit unneeded dynamic .rel sections contain=
ing R_ARM_NONE. This drops an explicitly documented workaround.
--

commit 195e701f0a3b1e98465728bdcdb8ca98175ba1ae
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

ARM: vdso: Enable the vdsocheck tool
   =20
The vdsocheck tool validates the object files and final .so library.
It can detect if the compiler created relocations which are incompatible
with the vDSO which need to be worked around.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index f7bea397a201a..0dcf6a2df0751 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -925,6 +925,7 @@ config VDSO
>  	depends on AEABI && MMU && CPU_V7
>  	default y if ARM_ARCH_TIMER
>  	select GENERIC_GETTIMEOFDAY
> +	select VDSO_CHECK

[Severity: High]
Does enabling VDSO_CHECK here break the build on ARM with GNU ld
ports that emit unneeded dynamic .rel sections containing R_ARM_NONE?

In lib/vdso/check/vdsocheck.rs, validate_linked_dso() unconditionally
rejects linked DSO (ET_DYN) files containing any relocation sections:

lib/vdso/check/vdsocheck.rs:validate_linked_dso() {
    ...
    match section {
        elf::Section::Rel(_) | elf::Section::Rela(_) =3D> {
            return Err(ValidationError::UnexpectedSection(section))
        }
        _ =3D> {}
    }
    ...
}

However, the ARM vDSO linker script explicitly retains .rel.plt:

arch/arm/vdso/vdso.lds.S:SECTIONS {
    ...
    .rel.plt    : { *(.rel.plt) }
    ...
}

If GNU ld populates this section with R_ARM_NONE, the vdsocheck tool fails
immediately during the vDSO linking stage (vdso.so.raw).

This discards the explicitly documented workaround for these dynamic
relocations.

Could vdsocheck be updated to inspect the relocation types before rejecting
the section?

>  	help
>  	  Place in the process address space an ELF shared object
>  	  providing fast implementations of gettimeofday and

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D14
