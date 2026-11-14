Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681614;
	b=NvfJ/2D117Cdmc9kuN1K088e7WCRoS4+2+BxVwnFoyZO8hP9FIOuqcZv7MlPx7uxiT+R
	 wJ8eem90yiRjdG4FcfI55TJ3TrPGKGF+CaCEZa9be+QCN2o1Qzr+myLD7z2oHs0uLZ0wI
	 4iUdyekXNj31hZCiru8F79Cv9U5AyagZzE/rD59Kr9bn6zjaIRgzCMvuPvvlvzA29mMx0
	 b02X0yepNEapM+Yiuft7kHnZ7C6PH2NHoT81Jj4vjTPpfJ62wzntGHYxStQFLsBE0mPnD
	 TC/Jc/s4v1a8DqqpAYpNCfFk8QHQGVV3amEjftuUMOe1M6KMlj4iZAtX8M2Fwb87fCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nS/Bhj5CF0M/YfPHHW6+oeqYgCWsF5uKY3dG/JNzYLc=;
	b=rf9P3kqu1oUbhWZpHPHHWzpUpvmHE8Hk26wytqfUL6laWH905mqlR6oGORtJqDaFpJYg
	 vszwG5s+sgt5co+sz7ikMqj/rAE8F6AAMvGOgHKdEI4ax11PccdHLRk3Pa8/WWS/aZWlO
	 2AZ7tRywRxlqWO3a06evvs4J1U2uDPsPm9thtPpzddE3w/+kt956mGBWFwcgbuZxajKdF
	 jKvApO1Td9HZdsSgQBu6oGIaAJm+IkZFAwOaPFzjIAwXhX+R2sXJ2BgDM0q+DzPm7RA94
	 Kl4MMPPZqtbhT1b8LQV3HgfirywvXC/d3AoMxreBWDNRgfM4qjHQ21gKCB9PRXtceGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5OP2a0X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD69606A329
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5OP2a0X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482A1F000C4;
	Sat, 14 Nov 2026 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681614;
	bh=nS/Bhj5CF0M/YfPHHW6+oeqYgCWsF5uKY3dG/JNzYLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5OP2a0X9NAgetvv7ikYbMxKbqzVsi+ATYMuE0GBFeVa+V92zUbG/s7OIgEgaA38v
	 vjF4NTSiXwnNpJfc5Ef0SXHXFlj7mHHmxuz81EVreATTKa4rppubzztJpsuTm9igSK
	 1F/71uxAY8YPD4tPy1mMMHRVLZS5ZpuuIiDerN9QBvCmxKJ9oT5nbZ1DkOc8fq5KcG
	 vt6xfhdlmNUl07fcrGlaaY9S1fPbPDoLQVanFhLb2ttOwdYJ02/E0NR787kwNqkMrd
	 0fBGDCZt64bNyz5JDI0TkvjCdBsQFYSv0yU64pfHKvVvsLt4WGiBuMuVw4X/ycxyG3
	 eUTOMwekKMbxQ==
Message-ID: <sashiko-outbox-214905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114181923.370930-2-renzo@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-2-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:40:13 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114181923.3709=
30-1-renzo@cs.unibo.it?part=3D1

