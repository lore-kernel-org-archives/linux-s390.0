Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1B37756A
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556885; cv=none; b=Hw4agH3PXGyYXScbh2S5/KYwkEqJ9kAFL/1X1d//EERk2Fi6LImz/01wDDIjHvagKrXqdLVBdOSnDqOUWo7WvVDLNDUnA8lTpq6invERN4CzWHgH3v2WagwyXFSSd/8ZXP9Pm+7ZUsgXY+A0MafwyGvRiRpbyPd08u6KKg2eE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556885; c=relaxed/simple;
	bh=k39/qIa3Or5HNYG3+b8779QEIVUjc9SYnfD34QTT9HY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXAq9hHGZcSAnXAqgpQOuYzKrfjlR7O38FGxotMOZIG9NayZOgNPPgUJreVVZ/7CAgCXmwDxgxTCCFsS4EMQF4NHQ5BdIn8phfEz2x9i0X3hRHXBYxfp5sygCwxdUIiR8VhglFZ3C1OwCpjkcZguYDj/C2gEmttu2EBlIrvbJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQE+Npra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQE+Npra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A331F000E9;
	Wed, 12 Aug 2026 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556883;
	bh=CVgk3T75EKfVXkEVPza/liSbx+wuynqZMYypHDWv2Kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQE+Npra7tM0m6GsEbOY+5BDtyayOSgSTpb3LyqEPIKaNbMpZWuOz1sU+77ElY+dh
	 WdmMHfU+5Cj+8LvEakRRgxUGihPZ+xlQnf0/ZTavRjs05IdftB25cIENJrAxiZWAEr
	 /8S3WuFjiUFqjBKnExUqn4BuL3rsBOWaMezisL3gMZM5rQP7+N6FVN8PtfvXBBAf6q
	 UV4ZUKyNXmVR2H9lcY6vWi4o/fy+f0sHapwlaeKiwvNXOpwdp0MU9KiXBIaHu/bdc2
	 Z6pvBIrCCVH56KYY8Jf9Ul/UTQ14GrKCNDFu/TSdKsNBUzUOCXlJhg97MqzF1bJV3o
	 xo8hNBdDO/9qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/13] mips: Remove duplicated syscallnr.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-7-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-7-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:48:02 +0000
Message-Id: <20260812174803.75A331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The MIPS kernel build fails because an empty, unquoted Make variabl=
e causes `scripts/syscallnr.sh` to misparse its arguments.
--

--- Patch [7]: [PATCH v5 07/13] mips: Remove duplicated syscallnr.sh ---
commit 877d5f006e4ab42c99a338fbffa9cb65343bea2e
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

mips: Remove duplicated syscallnr.sh

This commit removes the MIPS-specific syscallnr.sh script and switches to
using the common script in scripts/syscallnr.sh for generating syscall numb=
ers.

> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscal=
ls/Makefile
> index 56f6f093bb88e..69adc21483edf 100644
> --- a/arch/mips/kernel/syscalls/Makefile
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -5,16 +5,17 @@ uapi :=3D arch/$(SRCARCH)/include/generated/uapi/asm
>  $(shell mkdir -p $(uapi) $(kapi))
> =20
>  syshdr :=3D $(srctree)/scripts/syscallhdr.sh
> -sysnr :=3D $(src)/syscallnr.sh
> +sysnr :=3D $(srctree)/scripts/syscallnr.sh
>  systbl :=3D $(srctree)/scripts/syscalltbl.sh
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
>        cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@
> =20
>  quiet_cmd_sysnr =3D SYSNR   $@
> -      cmd_sysnr =3D $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
> -		  '$(sysnr_abis_$(basetarget))'			\
> -		  '$(sysnr_pfx_$(basetarget))'
> +      cmd_sysnr =3D $(CONFIG_SHELL) $(sysnr) \
> +		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ \
> +		  --abis $(sysnr_abis_$(basetarget)) \

[Severity: Low]
Does this break the build when $(sysnr_abis_$(basetarget)) evaluates to an
empty string?

Because $(sysnr_abis_$(basetarget)) is unquoted, if it is empty, the shell
command becomes:

  --abis $< $@

This causes scripts/syscallnr.sh to consume the input file $< as the argume=
nt
to --abis, leaving only the output file $@ as a positional argument. Since =
the
script expects exactly two positional arguments, the script's parameter cou=
nt
check would fail and terminate with a usage error.

> +		  $< $@
> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
>        cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D7
