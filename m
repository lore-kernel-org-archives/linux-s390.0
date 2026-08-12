Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427454746A3
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557428; cv=none; b=KPblSLnCFD9KUpxUvYg7bhvdQs1boIwqLTTR4BWfQeRyxHF3d13JrQDTeS73LOfc2xg2ualdc1O8Qlzs36CAS06CTikBppl+NZ0peMnmPl4+rT92m2eifrii6NvuM4uAaP2TKm2Q1z8RLWL1cXrzJo9qTu0lOuRUweiuiOyRfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557428; c=relaxed/simple;
	bh=h2d5bF+63eyRd4fIlpVgGgd6/07NOnzp15SU4tD+g/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=haKGmo1/gnmIFR/dy9nnwZSbQb9sys7I+Zznmjs5ujpf8aeUgcEmFYG7SxLApUyXi8n7rYASYxA6YeYrwd/CtwVwoX/QuOxWZ6QayvN6FaLx30nTnckUlsdJcJkpfCH/Iy7l547mGDrHHGCtqysByIA+YoMVRh905VKmL37PC4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvkqtlqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvkqtlqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF00E1F000E9;
	Wed, 12 Aug 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557427;
	bh=WQwxc193ssFeipaec0ddgoBCnQ74giMoYeIzWiUD38M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvkqtlqZUaEiUq2AKUdAzFeLZLYYXLCYR1I/72Nt7RPrKFJKnFBueQB8jbRBCE2yW
	 abx16WLIbBUKyVKdYlvPD9hzVNHuF/T7GIfb41x3jq2oCoEeX1bTtFDEqRuYubqHQg
	 BD3kHz/+oTFWJjDuTtHOzSX4Bbno+ex5cSedir0DUDkQoUeEVWZDJvC1JBRUv8HdVG
	 PKq7qCvkbE4X6eRBi1524BSPwChp2a7KPM3ScVfDShXfuai0X7UuoGxx46nps8l3NQ
	 WsqUFDOylUfY7nCbQ2hTut/bsg3+hrVTS5xk2RQ9i/qSBNBDwhCsKUbHHn9tJWa6sG
	 MpqvIaolfbFeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-11-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
 <20260812-tonyk-syscall_table-v5-11-3d383927c609@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:57:06 +0000
Message-Id: <20260812175706.DF00E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Interface Omission / Synchronization: The tools/perf copy of the al=
pha syscall table was not synchronized with the kernel table.
--

--- Patch [11]: [PATCH v5 11/13] alpha: Define entry point for set_mempolic=
y_home_node syscall ---
commit 65b94b8b8c8352e18befb0f4f62dfbedfd1fca90
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

alpha: Define entry point for set_mempolicy_home_node syscall
   =20
Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
the syscall table, define it as the real syscall entry point,
sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
mempolicy sycalls will ever be compiled for alpha, resulting in the
COND_SYSCALL() fallback being used to result in the sys_ni_syscall.

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index f31b7afffc345..25180953c3c1a 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -489,7 +489,7 @@
>  # 557 reserved for memfd_secret
>  558	common	process_mrelease		sys_process_mrelease
>  559	common  futex_waitv                     sys_futex_waitv
> -560	common	set_mempolicy_home_node		sys_ni_syscall
> +560	common	set_mempolicy_home_node		sys_set_mempolicy_home_node

[Severity: Low]
Does this also need to be updated in the perf tooling copy of the syscall
table at tools/perf/arch/alpha/entry/syscalls/syscall.tbl?

It looks like tools/perf/arch/alpha/entry/syscalls/syscall.tbl was left out
of sync and still contains the old sys_ni_syscall entry point for syscall 5=
60.
While perf primarily parses the syscall number and name and might still work
correctly, keeping the tooling copies synchronized with the kernel table is
usually expected.

This isn't a bug introduced by this patch, but there is a pre-existing typo
in tools/perf/check-headers.sh. It checks for the non-existent path
arch/alpha/entry/ instead of arch/alpha/kernel/, which silently masks this
divergence during CI testing.

>  561	common	cachestat			sys_cachestat
>  562	common	fchmodat2			sys_fchmodat2
>  563	common	map_shadow_stack		sys_map_shadow_stack

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-tonyk-sysc=
all_table-v5-0-3d383927c609@igalia.com?part=3D11
