Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3531181334
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959962; cv=none; b=ERqzOFhz/weMUFQ7KSwJ6QTsCAq+kHoW2YSw/NnuPCaydAA1beIovvUZjBm6EjBujLzf2yI+87g5rJImW725ZeaV4lcb8ulIqS7lXupFVV6TvlpoAuIXtXkiRCCc2JqeEFdce5u4jhmzINVjJ4hEe6jIsJgpGFGKr+gJKp5+BOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959962; c=relaxed/simple;
	bh=iiyySwJHCzOxfnhxgPpfCNuYqVigd7v4mwqhtJXshSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTv2o1+8lBrBhQSYngFEf5LsSImtiUwVD6N8E0flWJlYHblBLLVbtQ1Oat7rM83tUCR1zL9MBLsnjbPrmQDpaED9Nfy72cZvDGTIyc1TDJS1pkXf4l2tsNv04AEComLK5oLWgiEpx7TnZny4CGaI/9aDJlwk3X/lLdDE2FthdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTyMqr+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTyMqr+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA31F000E9;
	Fri, 28 Aug 2026 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959961;
	bh=5eqHgHYe9xVKWL7IX8wPBGDDswBT/wWfb0s8TjUZpO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTyMqr+JfbxMCW4ficVFFSfcp9uwjMkdn8q9AUv4dPCk61H2ehKKfYFxkIFFfQ9aV
	 wMTV9DSJmQYX1x44/NXQurx55yvQMeif5CEHDPJRcMdKCU7TKkMBUn/PgVL3WjGhnL
	 LeIRtUUxTF7+2g+QBNqaHV8iHZwkSaq9qh9CAlW+fDWKPuXtZQves6wRCNSQW0lVH0
	 6MVBTxlYJFraCMFIHyFK6UUHLn2mHc+mRPccVkfwdqo6ELDG8m2xtKuPLI7I0nOWxI
	 bqNnsEzgeWWk8BbPKCCNtCTSIewwqm8Or3D4zr+2ncco03hs6wWM/YjNlK5j/nvvAh
	 u7qIqg7S9gbjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/13] scripts/syscall.tbl: Use the common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260828-tonyk-syscall_table-v6-3-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-3-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:32:40 +0000
Message-Id: <20260828233241.1DAA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The perf tool's copy of `scripts/syscall.tbl` is left out of syn=
c, and its syscall generator is unaware of the new common table.
- [Low] The use of `mktemp -p .` in build scripts is a GNU extension causin=
g build failures on BSD-based hosts, and temporary files are leaked on erro=
r paths.
--

commit 81fbe53cf08247610dc3aa87d8f9c9e8106a9994
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

scripts/syscall.tbl: Use the common table

Remove some of the duplicated code by using the common syscall number
table.

> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
> index b38931314ad7c..e81d3ef8938ca 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
[ ... ]
> @@ -57,14 +58,14 @@ quiet_cmd_remove =3D REMOVE  $(unwanted)
>        cmd_remove =3D rm -f $(unwanted); find $(obj) -type d -empty -dele=
te
> =20
>  quiet_cmd_syshdr =3D SYSHDR  $@
> -      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) \
> +      cmd_syshdr =3D $(CONFIG_SHELL) $(syshdr) --common-tbl $(syscalltbl=
_common) \

[Severity: Low]
Does this build script rely on a GNU-specific extension?

While not modified directly in this diff, scripts/syscallhdr.sh uses
mktemp -p ., which is a GNU extension:

scripts/syscallhdr.sh:gen_hdr() {
    ...
    tmpfile=3D$(mktemp -p .)
    ...
}

This will cause build failures on non-GNU hosts (such as macOS or FreeBSD)
where their mktemp implementations do not support the -p flag.

Additionally, if the script exits early via exit 1 in scripts/syscalltbl.sh
within gen_tbl(), the temporary file is permanently leaked in the build tree
because cleanup relies on a direct rm at the end instead of a shell trap:

scripts/syscalltbl.sh:gen_tbl() {
    ...
    tmpfile=3D$(mktemp -p .)
    ...
    exit 1
    ...
}

>  		   $(if $(syshdr-args-$*),$(syshdr-args-$*),$(syshdr-args)) \
>  		   $(if $(syscall_compat),--prefix "compat$*_") \
>  		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
>  		   $< $@
[ ... ]
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 0ab5316051202..ee828d03094ed 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -344,72 +344,3 @@
>  293	common	rseq				sys_rseq
>  294	common	kexec_file_load			sys_kexec_file_load
>  # 295 through 402 are unassigned to sync up with generic numbers don't u=
se
> -403	32	clock_gettime64			sys_clock_gettime

[Severity: Medium]
Will this removal break perf's syscall resolution for architectures relying
on the generic syscall table?

By removing syscalls 403-472 from scripts/syscall.tbl, perf trace may fail
to resolve these syscalls by name (mapping them to unknown) because perf's
generator script is unaware of the new common table.

Looking at tools/perf/trace/beauty/syscalltbl.sh, the build_tables function
relies solely on scripts/syscall.tbl and has not been updated to include
scripts/syscall_common.tbl:

tools/perf/trace/beauty/syscalltbl.sh:build_tables() {
    ...
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,risc=
v,memfd_secret EM_RISCV
    ...
}

This will also cause the perf build to emit warnings due to
tools/scripts/syscall.tbl being out of sync with scripts/syscall.tbl.

> -404	32	clock_settime64			sys_clock_settime
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D3
