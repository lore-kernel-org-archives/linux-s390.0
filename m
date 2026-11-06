Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997223;
	b=UNgfwQRMdkUlV1hGyPg8/f1GIX5wcShb/XuE4d6iCCfDd4FHkBLuvAt2is0Vej7zR+C/
	 CGaRUxRhVs3gsvHWDQMS5t+2X5D9zmWLsl2oCoH0fCpSXVMzjLFELVfhtJoFUpH1PcvYh
	 uPYC/JjeJzaavg9u+6/z0SyzacztDZnD6k57dGp3Q9QvhyrzHp9Z8vMIYYhjq0jM7MVUW
	 lpzFJTgHUHkGe6hMNLmI20kNv2MGoCewoLcXqb+Y6axnp7YchbgDsx4cSy9ywfR58ENOo
	 qQ2bU/66afMqFhFw8ghw5MBgxAVYIF9gsYHE0nK0pg62IJ4j0Rh2brRt05SS4EBmrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1vvdav+KnGCJjcGAARu72JqNoZIztS0qW45P1csdPXk=;
	b=ETJz9cImdNuwZDPJGG66frUW1B2Yom2kOcKQE7Ch5mTZ0qpj/ws+Uq6cNAkOvMh05FcH
	 UD2navhdjW41h7plNAC3JBZlqx7GQuxj8WjsA0kxU9kHllG+dyGpaLN6292WmXp6fNw35
	 rAoVT+13oqEO38qI8+1PFpfgsNlTQLZtMNfGRtHAzLHXkzahCdfOGfnpzVULVxzeoub6E
	 ZgRv1CYZdAv7com/WD12nSjbWphXGKeBoHnrLnoQOYyo4GNYWX4r0EXooxJvISZFziwQu
	 Ae/YxSj3Z2FQkPZP6lbn5h+vPYsVcaxPlqYWY8GcZ36+1ghiH9ndVL8sSK42RBxbO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MU/MoLmT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E1606A326;
	Fri,  6 Nov 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MU/MoLmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BCA1F0089F;
	Fri,  6 Nov 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997223;
	bh=1vvdav+KnGCJjcGAARu72JqNoZIztS0qW45P1csdPXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MU/MoLmT3xabLMMTol5t/Ki7oaxt0yGJDqM9/1jhns73cXO9nkdynikWZ2foJVs2g
	 fr+y8DeIU8L5RIDBwEuZtsE4wH1OiAZZblss5EpSvi0W9WzqL6ycMq7vtKL7u4xJyB
	 InCfYJwyonAnXsw6c/7QURCTKTsLwhUePuLD+AUFB3KnmT2ev7BowwveJ5U6ZnFg7Y
	 8Ol1T1mpQPhiwdvA27KQCtgSi++zAI+R8MODtkmCZ/2is/utbCAF+zepC85houar+Q
	 eULOz4vpAlYIFbCAV8/MWFvTNncT+8KNO9tminYXQYV7RAcTOMAIK2Tx5WVz7h20/l
	 /J5C5zmKT0W/A==
Message-ID: <sashiko-outbox-202224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/15] alpha: Remove alpha_ prefix from custom
 syscall entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Arnd Bergmanon" <arnd@arndb.de>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] alpha: typo __sys__clone3 in syscall.tbl causes undefined symbol
  link failure
--

commit fa967afa6e0adcd94fdda9ada7c1dc69e95fd2a8
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

alpha: Remove alpha_ prefix from custom syscall entries

This commit renames the custom fork, vfork, clone, and clone3 syscall
entry points on Alpha from an alpha_ prefix to a __sys_ prefix in order
to prepare for sharing the common syscall table.

> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 790389a15c3ce..25d05f45512d2 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -729,9 +729,9 @@ ret_from_kernel_thread:
> =20
>  .macro	fork_like name
>  	.align	4
> -	.globl	alpha_\name
> -	.ent	alpha_\name
> -alpha_\name:
> +	.globl	__sys_\name
> +	.ent	__sys_\name
> +__sys_\name:
>  	.prologue 0
>  	bsr	$1, do_switch_stack
>  	// NB: if anyone adds preemption, this block will need to be protected
> @@ -746,7 +746,7 @@ alpha_\name:
>  	ldq	$26, 56($sp)
>  	lda	$sp, SWITCH_STACK_SIZE($sp)
>  	ret
> -.end	alpha_\name
> +.end	__sys_\name
>  .endm
> =20
>  fork_like fork
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 8fc4701a63282..59eb066a40bfc 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl

[ ... ]

> @@ -474,7 +474,7 @@
>  542	common	fsmount				sys_fsmount
>  543	common	fspick				sys_fspick
>  544	common	pidfd_open			sys_pidfd_open
> -545	common	clone3				alpha_clone3
> +545	common	clone3				__sys__clone3

[Severity: Low]
As reported by Magnus Lindholm on v7 [1], should this entry in
arch/alpha/kernel/syscalls/syscall.tbl be __sys_clone3 with a single
underscore instead of __sys__clone3?

In arch/alpha/kernel/entry.S, the fork_like macro defines global symbols
with a single underscore after __sys:

    fork_like clone3

which expands to __sys_clone3.

When building an Alpha kernel at this commit, scripts/syscalltbl.sh emits
__SYSCALL(545, __sys__clone3) into asm/syscall_table.h, which
arch/alpha/kernel/systbls.S expands into sys_call_table:

    #define __SYSCALL(nr, entry) .quad entry
            .data
            .align 3
            .globl sys_call_table
    sys_call_table:
    #include <asm/syscall_table.h>

Because __sys__clone3 is not defined anywhere, linking fails with an
undefined reference error. Although the subsequent commit a88b82345eb1
("alpha: Use the common syscall table") replaces this part of
arch/alpha/kernel/syscalls/syscall.tbl with scripts/syscall_common.tbl
and resolves the build error, does this typo break bisectability at this
commit?

[1] https://lore.kernel.org/r/CA+=3DFv5Q+sOLmT0Wf3OGdKw=3DmBt_EoS8ZQDF3wwGr=
m2-2vnOYgg@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D11
