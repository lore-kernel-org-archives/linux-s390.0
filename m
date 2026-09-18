Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820813264C8
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689680; cv=none; b=dguN6QeJacyombiiW7GlGQDmr18H3qgMXxS7tAWSHyH1hOHeN0xdLtPoMIsAPmtkArHIWYjpl1y/oilnjvZX6E979nCcUC2KNZK3t4V4b+vkU5xVf16O6fl1dNkFXp9lg19A8DghZmarq7po1VTFk75A6XYVLHHU3lt/PyZIGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689680; c=relaxed/simple;
	bh=wQ/qKptBllJl9VP1R7eERJoiXtDh+4yS/VdTDYd5s4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3Qt2oWXWwkuV3YEVqn/c5kZMbwRJUK9JjTkHBvTv3HnXZZQMVuX7Agyw9TCXZP83YiYfVnukm/BaB1Di5BqMcs0nW/TyCjtkt0el+46miY/0sSXJ2qDNEhhDoJ+ZilY9z/w7YGYpQ82GzM+8Te+L6v9Qe/7EceyovIewP+q2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgBC/+tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgBC/+tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7701F00893;
	Fri, 18 Sep 2026 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689679;
	bh=q4lvBqZU98DoGkOTwkydZsd799yUsVsPHOWUF5QXxn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgBC/+tpEOpbutPLY29hexZJKEFf6jM7BsTyNQvzLTsTBFwYPNitZtfCq5J6pOLRN
	 ptWT34VlHSq3YcL8BD27wnJVWzXVWj4HcQlA8d40gLdQSpp099x9hgWjXHLiteEI4A
	 ITYci0HN/CsEpJ71vx5IoP8ql5rKhq/QCQGGbmBX2HioVk0geUWnsD7AykzoI/1F1i
	 ksjgWv+mom59EfHfTqjn+AaUmeAhyU7Xwr5AmqKoWc732hrzWur/6+ZBxp+rJgm8e1
	 XCCf4x9I4zEcOjABzs558UN5hjKjzFkaspCaxh+944c3XoX+/v/UD1p7XlM2Hg4gaA
	 0XyQtrU6UGXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/13] arm: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-4-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-4-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 00:01:18 +0000
Message-Id: <20260918000119.0D7701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm: OABI ABI breakage for epoll_pwait2 due to missing local sysca=
ll.tbl entry
--

commit 538cbce7faef9329b4e409f09b73e772fc2b26c9
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

arm: Use the common syscall table

Remove some of the duplicated code by using the common syscall number
table.

> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 55717ed32c27e..bccded328911a 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -438,52 +438,3 @@
>  421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
>  422	common	futex_time64			sys_futex
>  423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
[ ... ]
> -440	common	process_madvise			sys_process_madvise
> -441	common	epoll_pwait2			sys_epoll_pwait2
> -442	common	mount_setattr			sys_mount_setattr

[Severity: High]
Does removing this local entry for epoll_pwait2 break OABI binaries?

By removing this entry, the build falls back to the common table definition
in scripts/syscall_common.tbl, which defines a compat handler:

441	common	epoll_pwait2		sys_epoll_pwait2	compat_sys_epoll_pwait2

OABI prefers the compat entry point when available, as mapped in
arch/arm/kernel/entry-common.S:

#undef __SYSCALL_WITH_COMPAT
#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)

This causes OABI to attempt to link compat_sys_epoll_pwait2 instead of the
native sys_epoll_pwait2 handler.

Because ARM32 lacks CONFIG_COMPAT, the weak stub in kernel/sys_ni.c resolves
the missing syscall to sys_ni_syscall:

COND_SYSCALL_COMPAT(epoll_pwait2);

Could this mask the build error while causing the syscall to silently fail =
at
runtime with -ENOSYS for any unprivileged OABI process calling epoll_pwait2?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D4
