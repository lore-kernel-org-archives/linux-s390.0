Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485651;
	b=N8LJidH4efVsyG5RvS/wKD9RBjpkH0yJakc3cQAhYU9hTZT4D+3KuheYYtl0ExMiPkGf
	 qMYrakuk/93VqUt7duafmGIQbQbJYJPRrLria+Tikwk0VlEFguAJwnP7fqeJuq6a7/J+7
	 +1/zPUf8FzzG+xdqykImPtfTr00JWlsOPVSJoH4hc8r69nKJkUgF59liu3Nb3b2Hz6nE2
	 oWdVC2dyc+/0WfBLgXIlAwGtb9koSdWH8eDoUOdAWTqoISjrsloE7uJ7N+XcSt1w3wGHl
	 hUwympgnoUJLpTKvzQx5LdbYOeNzqDCuClhGknD4vWBhMqpMOkIknuMmEjVZDy/viGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hjtHQhjFgWctM/zdIYBSkJG4IFNif25XvAOoyCXZ/RY=;
	b=nKNOmklX8asBNWaC3KALQVvFlm5Mu7ritB28J84QvwMrh74zL1WywXhn9/85lbrtX52G
	 FzVcoM+mjEw27hCDDsvvnfRuk5ETl9Roa7tDe1JSbH5DrqZHeVRjFjXY8pY+Nd/aRJ7BF
	 Z0+3nhOuEvzlvDqCsR6dzeh0N4dPUQVQbyJtWizl5N3XoSd6rka25wZy6en1II74tlwFY
	 F7/QXL1rgNxlHXolWmvDMqVqxq6Sg7DSzeAjqhI1e5iHj6xZ10vKHpfhwiOxmS2NVh5o0
	 zGFnpD5aK4vTQsM6CFTTQ1rlbz9FWnbWdApsgzbgVd7Ud+9kbeaC8p4BTZG8q3EoL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8dW3SBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0B606A323
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8dW3SBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A21F000C4;
	Tue, 20 Oct 2026 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485651;
	bh=hjtHQhjFgWctM/zdIYBSkJG4IFNif25XvAOoyCXZ/RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8dW3SBmsjfX4dsXJ0656cfZ71CagUPh+aWZ+pOXHKrkBS9Rb0e8Tn2vx1fqQ5rYF
	 UKZXY0TVXCG5ceFGG8OcfEJ3gMUd6Rk+yACQf/beAXSHkbV3ClDw6HC6MPtltpUch0
	 wtJ+u2nOQHYAZOXLYYr9fNuUVDV423tfqnWXeqXsU5EtKmB7ueScEbW2OPp6Iodhex
	 nEFUSiFO5+iCqKUqwRGEeNAp6AonJh/fj4TKvhc1cK0UVH6eoGN5tBVmr5o6c6H53p
	 yL6ekfyM27o46dAqrPig+s3nhxG87xKSIp19pGlYxZ1LJP6HFrYnoSFYowTVoWJbv2
	 4/AYPkGuaL+Gw==
Message-ID: <sashiko-outbox-178599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020065635.490528-2-renzo@cs.unibo.it>
References: <20261020065635.490528-1-renzo@cs.unibo.it>
 <20261020065635.490528-2-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:40:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Davide Berardi <berardi.dav@gmail.com>
>=20
> At a PTRACE_EVENT_SECCOMP stop the tracer can only skip the system call
> by setting its number to -1, which seccomp reads back with
> syscall_get_nr().  This depends on how each architecture lays out the
> syscall number and the return value in the registers:
>=20
>  - on some architectures the syscall number shares a register with the
>    return value (e.g. v0 on MIPS), so setting the return value after the
>    number would overwrite the skip request, and each of them needs its
>    own way to keep it (MIPS keeps a copy of the number in thread_info);
>=20
>  - on s390 syscall_get_nr() returns the low 16 bits of int_code, so -1
>    is read back as 65535: seccomp does not skip the call but runs the
>    filters again on syscall 65535, which kills the task if the filter
> [ ... ]
> The next patch uses this in PTRACE_SET_SYSCALL_INFO.
>=20
> Suggested-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Assisted-by: claude-opus-5-5
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020065635.4905=
28-1-renzo@cs.unibo.it?part=3D1

