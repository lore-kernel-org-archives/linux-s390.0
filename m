Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486415;
	b=UF/jLNwIEiXSjrIz1gsL5i6cksDyJnl+j/BBHdJ5/Gk1TjfVSfDrCDWNQxiL51T8ATM5
	 IVc1txD527sAUDRKYvTD4WyElVpakc992N7ub3h/JGxR+lZWZJbRgmTdCtKuzTcaWegTp
	 ZN5bgE1KuWvianPshZLdcM3wdeJFAXZicx5UQwmujnXTcrRVR8Hp1d/LwGncYzbg3WqOc
	 /0sADKxwcEd6fVPk0w8F6lKPYTpLBD7KpbIgvdsivKpXcsFlv4UML54voUquzFYf+LtlE
	 LGC8a4EeqbZkRS7EJUvCs54j+2aEfgFNEEvGgypD+zcixeKi79aCp/NYOuWa5CBLLZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJzSuqHYXxidhne+FQjLxNXptJfcvLITDluvJ47BQT4=;
	b=A4LXAMsMh+GvsxNWfLDSvEGFmdIplESf9JXxIr7lnVizosQvjoZ7AyHHWGUdboPAIhaC
	 6h6AgigNDZv5XFVrr7zzzWivC8CMQi64T1WoGbScOklhccgeJMvy5ZpyaLOjuTkM0JnJ2
	 dGEUwTWJUWx8Vc162PHNG+fh6+y0Lg5WcF5keZG92rn0sJJ6E9qyxeTNs5S4NBkBAnhYI
	 hKD1lBNIjgcd0A8SMdsM5dR6EO+EcpTpQ+fSaGlp1hIZ2bCrW2SD2fx9wnamLMcyufX7f
	 h8Ij4/rV3mKh7L8Yq5J/Z1dh25+lhXgJne0g3cJesI2BxvbeYWgKviunzwqqTByYVNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2KWC9iB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE248606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2KWC9iB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D5E1F000C5;
	Tue, 20 Oct 2026 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486414;
	bh=tJzSuqHYXxidhne+FQjLxNXptJfcvLITDluvJ47BQT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l2KWC9iB61GMHQTwrpM+gBO1t3bPFQCnIKNPCukYnJv92Z0MovWQQznYc3JorftRi
	 0JZBedGW7H4sV5YQOsFCwT8rzxEVqT5ZeRjL8KHVJdb79Xej7p5l7+/ZDZs5hh01Nk
	 dlPTWWWNlSnHRHBKDVV/KAfH39GE8LhIklWWuV5BIirA7vxRe3NIc3wQzlYWD4QgAY
	 lbwB0tIF3gy5h3eSv+7NwyJI3/FHMCMtaAgFYI37COUJ/NfcS5GQmkrTQ8Er9bsf9p
	 wbvzAq8vUjXXYd1PimXneopzHaMdWKp382oA5pwthdd9R9AeMINxNaBsjPUCpwgty0
	 goqeEqfG6MEhQ==
Message-ID: <sashiko-outbox-178644@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020065635.490528-3-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
 <20261020065635.490528-3-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:53:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020065635.4905=
28-1-renzo@cs.unibo.it?part=3D2

