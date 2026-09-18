Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91B75809
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689727; cv=none; b=L4t0HT3AfXMHUqL8ZQjG1qzPfjR1cFXtmWt0S1K1StuhjREltEd6go+wHPnZ9alczNo/3DY9GvM+NhPT7hUUpHT3dnuqzUad25lg+F5tvQCvV4vtgSntxPW5qUGIQNmvOrS+Bj8uBRdOI1B1YxZfVEV3ypMGAoh7zORhz9eaAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689727; c=relaxed/simple;
	bh=5IiTaZqKbN+lkS4IIAhCMMy7Zsj3Lq5Qi3/hukFRf1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ob/MYbtqdingNFCeqamH50QZOkfM+xaeSa/NcAsAvS75A0rpt61oZ2h4qnS+0o73jlmyPGEN5fzkQ6+GLkTv2Fg8LwJyUQvG0l3RLoRzi2yyo40XpQtg6nMokA6J20xhgL7ZDB+BOHhrrMPfMsitKexp81HhME0W46ZFFtnYqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNMUUzQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNMUUzQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8781F000FF;
	Fri, 18 Sep 2026 00:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689725;
	bh=tf2/jFeHn6rKbMRgW5gtjuYRMGqeX48ZseB4nZRRN+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNMUUzQ0uVwBRSzT0ogNHJje0B1nL890u7hErNOFtBuFPEiB0VUSJi8S4QqvUPfGY
	 zo05kD0l71gGvxOs6a2QLDYMd4Bg+1Z1fIZZqKmyX3kBYrWcGqGYI56hYbW2L/P8Jh
	 v/fPBUZT1/9JoJWDT5SZwubbrHG1y/HdG++c4Ag840ZPV1ezuYRqaL9D1ds6ZEK41a
	 5xn9IvnrPkMMvcxB+4+7dTYl4M2y9KhZh9Im9Fh3OGf5szyPNHmGKZLgBkV0qM+2+R
	 hX/vm2RwosZtKUhQ1acFX04DxmrFhmYiNMAPph717JdY/WuQu6AlafN5HhYWc2oUXU
	 p2t5H8+xW1S+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/13] scripts/syscall.tbl: Use the common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-3-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-3-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 00:02:04 +0000
Message-Id: <20260918000205.2B8781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: perf trace silently drops generic syscalls >=3D 403
- [Low] docs: adding-syscalls.rst directs developers to break the build
--

commit b66e7fc900570caaf1efbae8e5955a536079dad9
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

scripts/syscall.tbl: Use the common table

Remove some of the duplicated code by using the common syscall number
table.

> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
> index f1c3d287c14b0..b09dbc8992c32 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
[ ... ]
> @@ -15,9 +15,10 @@ all:
> =20
>  src :=3D $(srctree)/$(subst /generated,,$(obj))
> =20
> -syscall_abis_32  +=3D common,32
> -syscall_abis_64  +=3D common,64
> +syscall_abis_32  +=3D clone3,common,32
> +syscall_abis_64  +=3D clone3,common,64
>  syscalltbl :=3D $(srctree)/scripts/syscall.tbl
> +syscalltbl_common :=3D $(srctree)/scripts/syscall_common.tbl

[Severity: Medium]
Does this change cause perf trace to silently drop generic syscalls >=3D 40=
3?

The tools/perf/trace/beauty/syscalltbl.sh script is hardcoded to only
parse scripts/syscall.tbl for generic architectures like CSKY and RISC-V:

tools/perf/trace/beauty/syscalltbl.sh:build_tables() {
    build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" \
        common,32,csky,time32,stat64,rlimit EM_CSKY
}

Because the newly introduced syscall_common.tbl is not parsed by perf trace,
local execution of perf trace on affected architectures will fail to resolve
the names of generic syscalls >=3D 403 (e.g., clone3, openat2, io_uring_set=
up),
displaying raw numbers instead.

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
> -404	32	clock_settime64			sys_clock_settime
[ ... ]
> -471	common	rseq_slice_yield		sys_rseq_slice_yield
> -472	common	fchroot				sys_fchroot

[Severity: Low]
With these entries moved, does Documentation/process/adding-syscalls.rst now
direct developers to break the build?

The documentation actively instructs developers to place new entries in the
now-deprecated primary table:

Documentation/process/adding-syscalls.rst:
    As scripts/syscall.tbl serves as a common syscall table across multiple
    architectures, a new entry is required in this table::

        468   common   xyzzy     sys_xyzzy

Because syscallhdr.sh and syscalltbl.sh append syscall_common.tbl (which
starts at 403) after processing syscall.tbl, a developer following these
instructions and adding a new generic syscall (e.g., 468) to syscall.tbl wi=
ll
cause the internal nxt counter to exceed the first entry of the common table
(469 > 403). This triggers the strict ascending-order check and results in a
fatal "syscall table is not sorted" build error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D3
