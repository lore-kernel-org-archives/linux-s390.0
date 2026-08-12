Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0823EA84
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557710; cv=none; b=ebR8iAQenNUoJ8kANGE2h37VpiRQmVttnVB/Kg5aycxPORiJfW0lVxwdvcPpAdDICYMNcwUrxefLmGsH9JM2y2aC4ZZn6SvLnaUteBBQ165KC44Y09Laj80M2heumKLNE1hCw+0SPDIpnuGRTMMDuEo3JrfVKFY+6LX8HRgD6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557710; c=relaxed/simple;
	bh=FvX1/O8XJ3cQFiyl+6N7+vQVONUduVhMB6barThFoFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SsUoW78VM1ltscM5oW1ebmd7D4+2spms1BbMA46NGgyF0cSHkZNM0RwG8Li5caaRdTvZNmHhJINQyJwFSc4q57QBtQJInt7redKdSj9UaoHnL3J49HjKQA1BxahYPagbaKNdyQT57I7+SncL9TyYCR3obHIXeS1tqIWpYftX8FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOw0zLZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOw0zLZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E4F1F000E9;
	Wed, 12 Aug 2026 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557709;
	bh=3DMZgLePlRSH0TB4gJdyGrqg9l6Ams3UjJBk04NfE/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOw0zLZLVtr2Q5NzkQcqW5J+bZT9BeHOeoCc29WSwD2pWlwnKVnkv2SlrcLVvRwvV
	 MGoELJ5pQufoHiGBGPg9zc9dJL36SgIEvdNbWNCBNvQy8uX4jyEFodVcomkoXMN4UN
	 Qv2++Tnc5KYlbosghxia5U4buknaOChuj490tkMasybLmzjcS8OmxB4Uvn+5h/QPXA
	 Ld/VDwXyulAOvYVQ0jGOX+ATYcTQ0BSn3slPee1pkNKo+NsPUHWMmyqHHMfU9N9CGY
	 GJouFeRx4d0quuwVaE2wYJDgZxbzKELhkd2t9B//onJ6Ee2GHVVkWwcaXoO8o7H9g2
	 PNIEn4Qqwy73g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] alpha: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-13-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-13-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 18:01:48 +0000
Message-Id: <20260812180148.B7E4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Incorrect `__NR_syscalls` calculation in `syscallhdr.sh` trunc=
ates the syscall table bounds check on Alpha, breaking all syscalls >=3D 47=
2.
- [Low] The modified syscall build scripts use Bash-specific process substi=
tution, which causes syntax errors and build failures on systems where /bin=
/sh is dash.
--

--- Patch [13]: [PATCH v5 13/13] alpha: Use the common syscall table ---
commit 8a4799a8727ec390bf08ab1390ac21a27d092616
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

    alpha: Use the common syscall table
   =20
    Remove some of the duplicated code by using the common syscall number
    table.

> diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/sysc=
alls/Makefile
> index b265e4bc16c2e..18682418327bc 100644
> --- a/arch/alpha/kernel/syscalls/Makefile
> +++ b/arch/alpha/kernel/syscalls/Makefile
> @@ -7,12 +7,18 @@ $(shell mkdir -p $(uapi) $(kapi))
>  syscall :=3D $(src)/syscall.tbl
>  syshdr :=3D $(srctree)/scripts/syscallhdr.sh
>  systbl :=3D $(srctree)/scripts/syscalltbl.sh
> +systbl_common :=3D $(srctree)/scripts/syscall_common.tbl
> +abis :=3D common,__clone3
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr $< $@
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --emit-nr \
> +		   --common-tbl $(systbl_common) --common-offset 110 \
> +		   --abis $(abis) $< $@

[Severity: Critical]
Does this offset argument truncate the syscall table bounds check on Alpha?

When the common table is processed via scripts/syscallhdr.sh, the maximum
syscall number is stored before applying the offset:

scripts/syscallhdr.sh:gen_hdr() {
    ...
    while read nr abi name native compat; do
        max=3D$nr

        if [ -n "$offset_nr" ]; then
            nr=3D$((nr + offset_nr))
        fi
    ...
}

Because max is assigned the un-offset number, it resets to 471 when parsing
the common table, instead of reflecting Alpha's actual maximum (581). This
causes __NR_syscalls to be emitted as 472.

Consequently, does this cause the bounds check in arch/alpha/kernel/entry.S
(entSys) to reject all valid syscalls >=3D 472 with -ENOSYS? This would bre=
ak
several valid syscalls when using the offset.

> =20
>  quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) $< $@
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) \
> +		   --common-tbl $(systbl_common) --common-offset 110 \
> +		   --abis $(abis) $< $@

[Severity: Low]
Do these modified build commands fail on systems where /bin/sh is dash?

Both scripts/syscallhdr.sh and scripts/syscalltbl.sh use a bash-specific
process substitution pattern:

scripts/syscallhdr.sh:gen_hdr() {
    ...
    done < <(grep -E "^[0-9A-Fa-fXx]+[[:space:]]+$abis" "$input")
}

scripts/syscalltbl.sh:gen_tbl() {
    ...
    done < <(grep -E "^[0-9]+[[:space:]]+$abis" "$input")
}

This syntax is a bash extension and results in syntax errors on strictly
POSIX-compliant shells like dash, causing the build to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D13
