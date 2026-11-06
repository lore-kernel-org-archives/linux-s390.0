Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997226;
	b=B4s2VJUsqSlN988lxBuBQpI6FEmW3lB8czFSj1fX+9TwdpLVvXwlacvbAZJckXmeq7Yw
	 E5ApnnVaCDcOw0CogQ4MeeBNtE9KZOiKMuN/f2QMATfi2dgvvmrDC+/hFAlMjnXrbms5+
	 7b8VFVcYNfuSBhUbEGn4PK9E+Wm1G0j69GvFNCyh8CdylqPzaaIyEvgVZffaf8mg0imZX
	 lyma1fyfZfl1vkvpvCMwT/vcU8nzuhYpqcEHQyyeRqqAzhzTM4Hz8tpplU1uROzWN/wc6
	 AiKqRFIfPwzhXTtQXcPwW1eB9U/7Yb4TaQLDjEiPKqQ7kY+R+WWqDJkn7QHnoyhEtKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gV84wLazvpcj2gZmVw7KlvY9+u5EzKgdR2qt+5Zrau0=;
	b=o57kLHKfjBYhviBimBa8//U2miqSBKN9NTnVI27pvv/bYGrizdfY1wHqcuzWDvqifCRS
	 O5PI7dKhXBN4C1AmyQRWKMXXSnJhC7iSOR8knpFBxW5ocPJPgT72dFuaf9WMCddU7CAr4
	 ok9WQ+qYbqz07UgKxerRWUagAlncYZi0A9n38LEkJ5TvY//5BJ7Hal5mvIuqmv3okgM1T
	 15mhoMy0tpAsynyEQ0HOS26PnFAXHDfLrIk3HWMDTF96R4ekOj4HZq9wjS4OvzwDWvHUU
	 plZBRnU3lCZdig0Z6JkHHBPFtKiAbXWOQwGJ/wiyBfmlhLxDUo2Lz+DnqL+W+e7voYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyRzvC45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F4606A329;
	Fri,  6 Nov 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyRzvC45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9941F008A1;
	Fri,  6 Nov 2026 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997226;
	bh=gV84wLazvpcj2gZmVw7KlvY9+u5EzKgdR2qt+5Zrau0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyRzvC45xZHxbNxqLj0hqd+ooWxM7bimdrDxoOF6O2JN/IlwsarThMsoL+r9DhbH+
	 T5/QBUUj7k1p4LvEfWzCA1ER2hPL70zivzr3LUHEDhimG5QJ/+91MCmw01CL/tT3PG
	 wNnGCg2J7DxDuhCu0hh5HtksT7nGj4O6Nbeuwq+pnvrX+t3wGvE/cb+CBMydZ2EdK8
	 mid7NWMcG3u/nPPkawPR7OpppzEY+dmhmlqI9HwWsWuOF7h1aoqndvCM3UuvwmLesd
	 HqoNDJc7cTioRY0na3+73hQH6X9uzF797MeKlatKx7wI7xumgNwsp/NTOa9WrJMcZr
	 P7+rV55JqdhAg==
Message-ID: <sashiko-outbox-202227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/15] arm: Reorganize syscall table and separated
 the ABIs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-14-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-14-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arm: missing oabic entry for sys_syscall() breaks OABI compat
  syscall(2)
- [Low] arm: Makefile overwrites gen-y with :=3D and drops calls-oabi.S
  generation
--

commit f142c55483ada4ca8dfa9f75478b67abaeef8965
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

arm: Reorganize syscall table and separated the ABIs

This commit separates the EABI, OABI, and OABI compat (oabic) ABIs in
arch/arm/tools/syscall.tbl, drops the compat column entries, and generates
calls-oabic.S for sys_oabi_call_table.

> diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
> index 28b6da8ac5f64..cde235b382bdc 100644
> --- a/arch/arm/tools/Makefile
> +++ b/arch/arm/tools/Makefile
> @@ -14,6 +14,7 @@ systbl :=3D $(srctree)/scripts/syscalltbl.sh
>  syscall :=3D $(src)/syscall.tbl
> =20
>  gen-y :=3D $(gen)/calls-oabi.S
> +gen-y :=3D $(gen)/calls-oabic.S
>  gen-y +=3D $(gen)/calls-eabi.S
>  kapi-hdrs-y :=3D $(kapi)/unistd-nr.h
>  kapi-hdrs-y +=3D $(kapi)/mach-types.h

[Severity: Low]
Should this assignment use +=3D instead of :=3D when adding calls-oabic.S to
gen-y?

Using :=3D overwrites gen-y and drops $(gen)/calls-oabi.S from the kapi
prerequisites in arch/arm/tools/Makefile. When building with CONFIG_AEABI
disabled, sys_call_table in arch/arm/kernel/entry-common.S still includes
calls-oabi.S:

arch/arm/kernel/entry-common.S:
	syscall_table_start sys_call_table
#ifdef CONFIG_AEABI
#include <calls-eabi.S>
#else
#include <calls-oabi.S>
#endif
	syscall_table_end sys_call_table

which causes the build to fail because arch/arm/include/generated/calls-oab=
i.S
is no longer generated.

> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 55717ed32c27e..944f11030ab4a 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl

[ ... ]

> @@ -131,7 +141,8 @@
>  114	common	wait4			sys_wait4
>  115	common	swapoff			sys_swapoff
>  116	common	sysinfo			sys_sysinfo
> -117	oabi	ipc			sys_ipc			sys_oabi_ipc
> +117	oabi	ipc			sys_ipc
> +117	oabic	ipc			sys_oabi_ipc

[Severity: High]
Just above syscall 114 in arch/arm/tools/syscall.tbl, syscall 113 is defined
only for oabi:

# syscall to call a syscall!
113	oabi	syscall			sys_syscall

Since sys_oabi_call_table in arch/arm/kernel/entry-common.S (compiled under
CONFIG_OABI_COMPAT) now includes calls-oabic.S instead of calls-oabi.S:

arch/arm/kernel/entry-common.S:
	syscall_table_start sys_oabi_call_table
#undef __SYSCALL_WITH_COMPAT
#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
#include <calls-oabic.S>
	syscall_table_end sys_oabi_call_table

won't omitting an oabic entry for syscall 113 cause scripts/syscalltbl.sh to
emit sys_ni_syscall for slot 113 in calls-oabic.S, breaking indirect syscal=
ls
via syscall(2) for OABI binaries running under CONFIG_OABI_COMPAT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D14
