Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510972;
	b=FV8P/n5UuKd4mIa6F3DK701zrixXFahF6Q1Tkk8gau6oIN4ojc7ZKXGnALsnD0bfA7wn
	 piG+KrA+GPGl6ehuCfUqEK3ISowTl+tVGu87XTqvx2u8bc4vNgo+W1jayZOhhcDfOdVuz
	 68iZffsRSEjRPcyASpLG6R2d9ELvsd/Z2yJ/UMxHRdrK1YShNw4T2DCFtPrhPhRYyl5/6
	 RCkQBbRkOT+vSoH4hkwXKvad6TwkbcN75EIWCiPO29fqoW9C9O+BrJKvQWM+8jCNmJpay
	 yaW3g/pOMrwrt90ffNDDevH87XHwanTEKWsMP6hqCi2vyq9W8GEoObnaXHHuGsvba3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510972;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BOO6v97kh8NxiYp8gQcpN82VKIkmFwVtJHJY8GbDeg4=;
	b=Rfcyl3zRqRoB+u82iUL0gHx9fJ3pKIj8aQy/7Ayj28ebIPqbzpecYNXqkYK6ScAf+BOj
	 yyVRBdd6uKxWKeoP80RnHi5n4jLRCKlZ3eDBxRvRxR3z4LMHjdaFCegjDB/UfugAo6SRw
	 NbUCbdHe/Tdzbjcw2YKu038TlD0QS5gFV9zXmK2w30d29l8Mbx9Sa2IjFHM3hkT3i/yol
	 Q8mWJ4J363AiDP9DSvpl/uSeXlplCgN3xfoQH+k4/4wYBM9mU2xUiyoFuESUzF5akjKtV
	 jd46IxIeZsO2KwRZ38xQJ8OdDBEesbJe69VjFcxio6r/IEJprtZH8NthNmkrYXgeN+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61601606A31E
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 15:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D21F000C4;
	Tue, 20 Oct 2026 15:42:51 +0000 (UTC)
Message-ID: <sashiko-outbox-179272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] seccomp: let the tracer skip a syscall
 independently of its number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020152945.575664-2-renzo@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
 <20261020152945.575664-2-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:42:21 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020152945.5756=
64-1-renzo@cs.unibo.it?part=3D1

