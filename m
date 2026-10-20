Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511721;
	b=ciNr1fsD9D4AQ9FaB/N+KfshUVWdWy/0BsBnuD7LiKrKVujxYC+/eOuKnp12FAkLjbPZ
	 QXvu/bIqIpdvpRPBa7vGdBKSRNiU+ufzzowdPP5jhYKUBDYCdoE1A5mr+3ykiGLoOHDOP
	 o0hVXD2jHXGjMhzsgfdnWN6KoXkQNdCHO3rB4wLyZfCZ/lJLj8PYM6IPjAnM0hfIIgiVB
	 oThej7d6gyb0edtWWsQQy1QUFe0IhMylbttMy7d2DU4qGI1vjDnue+owYPQJFcGb71o+i
	 7NOwoqej23Uv0aIowbQ5tktkIF9Bv5k4uQR6A9NTqN5U66ht1D1iGKU5v+p1n+ImsDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511721;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jbLZEwKXh6ELSvvCLuiSjGQBDuIUlGszm8daAwZ7c38=;
	b=OLmIziHhJlXHFtpWZxiKK00FaYQDoSOSEITEptPZiPOsGEzBRZhd8KHPW596Es1NdaD7
	 Vhk/lLgxYA7gHjvQW6hoPSTu66LN62PDxOPCnGNb3JRd36RYdoh2N/LKV2ogeTfc3JQ57
	 Q709CkdwuKUMRCD9ajLGyj71oABk96ORxDpYhRHerlpPiY5BWJwogk315e2dZqQcVPzuB
	 pah4vWcbZzQHmFLtvzKCVuT73KhRRrDVxajIERNob6mc/Eywdn30mRp6Wmdi3AU6rYePm
	 gGmyLnf7CYbLsdgcR/mdCWuCkNObaf9Z2e7gDqzHIHO2JD22ZXV53LldgS64Qw5JIsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB61606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 15:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4581F000C4;
	Tue, 20 Oct 2026 15:55:20 +0000 (UTC)
Message-ID: <sashiko-outbox-179318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020152945.575664-3-renzo@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
 <20261020152945.575664-3-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:54:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Extend PTRACE_SET_SYSCALL_INFO to support skipping a system call
> triggered via seccomp.
>=20
> When a tracer retrieves a ptrace_syscall_info structure with 'op' set to
> PTRACE_SYSCALL_INFO_SECCOMP, it can now choose to skip the system call.
> To do this, the tracer changes 'op' to PTRACE_SYSCALL_INFO_EXIT and
> populates the exit union fields (rval and is_error) to define the return
> value and error status for the tracee.
>=20
> The skip request is passed to seccomp with seccomp_ptrace_skip_syscall()
> rather than by setting the system call number to -1, so that it does not
> depend on how the architecture lays out the syscall number and the
> return value in the registers.  The tracee then skips the system call
> the same way as for SECCOMP_RET_ERRNO.
>=20
> Once the system call has been skipped, a further PTRACE_SET_SYSCALL_INFO
> with op =3D=3D PTRACE_SYSCALL_INFO_SECCOMP during the same stop fails with
> -EINVAL, as the return value may already have overwritten registers
> holding the syscall number or arguments; op =3D=3D
> PTRACE_SYSCALL_INFO_EXIT can still be used to change the return value.
>=20
> System call suppression via PTRACE_SYSCALL_INFO_ENTRY is currently not
> implemented.  On some architectures (e.g. MIPS), when a system call is
> skipped by setting the syscall number to -1 at the entry stop, the
> architecture entry path unconditionally overwrites the return value
> register with -ENOSYS, clobbering any custom return value set by the
> tracer at the entry stop.
>=20
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020152945.5756=
64-1-renzo@cs.unibo.it?part=3D2

