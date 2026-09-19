Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C930F927
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778488; cv=none; b=dCGZTrQy+CZuQ5ZEr1kxuDbsJ7FOLn6dJsSYGzxlSDbMN+DM14immmx1Ec0rtju+6FqyaXcNBmBpyYwe9WGk0HEbd97AvSdcy8TqO4FjYIr6zJfu09RcjeBAlHPc9PdAyQevDp47it0fBfPSJH0e0U3ZadNSJfdEd2yQdNZdz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778488; c=relaxed/simple;
	bh=TKeR5WwUWVBF817DT7OLSp4pg/AMvd8cdSPEFitUTqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6BeSEz1TOxLvBwtQ38CQ8LidtAYiNeEVeeoC/Pz5Hw8b5fePQruZjwvqyHXaTyQzIC1Xk8xuqkngTVhWL8Dkr/txYoL0PnR2BcZOPnyB7KV5jNNcW+8Z4D1LYykxI2yI+RpOUjqL0KMI6+XPFdSRHrK7XnlLW6adZdxkYEvmcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYwG+DTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYwG+DTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C761F00898;
	Sat, 19 Sep 2026 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778481;
	bh=zwazDRXUGTlGHUduBFa6+kYvpwoqHBBzSbHnj9iBFGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYwG+DTF7BoZ88Wcd5evB6qhw1AF80TkLtSeZMDe+k8VFzWRQgWFuJ4J1SXbAYNWD
	 BWgdEpq4eg/O14oHBwhpfjv7vy+4gKTD4G3m94IRRwVwfFXln6WQKmvueaFmV9er5R
	 ORIzu7IDhgaQwrbYWsWaihKcjHhT0TtM7Yj+xuoqg3kTr+DIeELz4bY62O605dL3/Y
	 9tIyxb/FiGE/Zw7Gg5i5pSB/9SHYakZFmq+DYVpqYWTsfN2mb5hLhSjkSJ9i0C8sf3
	 05C+o2ExLSrq5F1eMHblrSXjy4drxGZlKhlqpEpGnf/b+Ou6+ASc1vUIKQ1rhMu1Xh
	 cpUMiAI0HFfew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/12] scripts/syscall.tbl: Use the common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-3-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-3-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:41:20 +0000
Message-Id: <20260919004121.37C761F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] arm64: compat: ABI breakage due to omitted clone3 syscall
- [Medium] perf: silent trace breakage on RISC-V/CSKY when syncing syscall.=
tbl
--

commit 6f36ef0832663a9b88501de9d0a2dada0399dd37
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

scripts/syscall.tbl: Use the common table

This patch removes duplicated syscalls from architecture-specific tables by
moving them to a common table. It creates a new scripts/syscall_common.tbl
and adjusts build scripts and Makefiles to use it.

> diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Make=
file.syscalls
> --- a/arch/arm64/kernel/Makefile.syscalls
> +++ b/arch/arm64/kernel/Makefile.syscalls
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  syscall_abis_32 +=3D
> -syscall_abis_64 +=3D renameat rlimit memfd_secret
> +syscall_abis_64 +=3D renameat rlimit memfd_secret clone3

[Severity: Critical]
Does this code omit clone3 for 32-bit AArch32 compat processes?

The new scripts/syscall_common.tbl defines clone3 under the explicit ABI
name clone3 instead of common. Because syscall_abis_32 does not include
clone3 here, the build system will not generate the clone3 entry for the
32-bit compat table.

Consequently, 32-bit AArch32 binaries running on arm64 that invoke clone3
will receive -ENOSYS since the generated system call table will populate
the slot with sys_ni_syscall.

[ ... ]
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -344,72 +344,3 @@
>  293	common	rseq				sys_rseq
>  294	common	kexec_file_load			sys_kexec_file_load
>  # 295 through 402 are unassigned to sync up with generic numbers don't u=
se
> -403	32	clock_gettime64			sys_clock_gettime

[Severity: Medium]
Will moving these syscalls out of scripts/syscall.tbl break perf trace
for generic architectures like RISC-V and CSKY?

The tooling script tools/perf/trace/beauty/syscalltbl.sh hardcodes reading
the main syscall.tbl when building tables for generic architectures:

tools/perf/trace/beauty/syscalltbl.sh:build_tables() {
    ...
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" ...
    ...
}

Because it completely ignores the new scripts/syscall_common.tbl, when a
developer later syncs the modified scripts/syscall.tbl into the tools/
directory to resolve check-headers.sh build warnings, perf trace will silen=
tly
lose the capability to map IDs to names for all of these removed syscalls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D3
