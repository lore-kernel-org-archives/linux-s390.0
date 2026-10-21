Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573789;
	b=Q0SVm5t+RqzmFEcjKnTdlWc3L+pHo1dP0NSdUBqKcVpWAzfc08N9FPth2Ny9O/bqZYve
	 kNNg7K9klok/CaNczL66mKKy37UarRar1z/RcTqGXoo/raXYR0HGiF8QEs2lS5NLLHm5K
	 AFwMw/4uaP3pw6cJhm3xrOZ+4BsSsgyCPcdrZjgzPZZq7Ry3rVGul3rIDh9K3pK1WoLZ+
	 21fOewDPaqmbv+9NyjrWFPpMrkG9JvAudXZudBBZVdxMsbUPC+4QOPtUptSjEILuyoaWX
	 /EWs1edWdGnn4ERyUBRPEt14C69VlrSDK6vwdZj1ZZX48nbDE/7F09hr+f0erPs3j9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ss8JCmnLTtIgvOQEI0VDlUEtgjU/ERKBUquXx4nsMOY=;
	b=b66aWGtXkiztSpoe3A7OaqmADrRUJ2yQokY6CBcXRp4u11ZVuNZAY0PmsdIKJs34Gatz
	 OX4nYrdAux9uIQxyMOGyPuqh2F08xHAYRsH5uzcsSVrh6dnR5D1SdQYW7C6rk0g1Parl9
	 KAh4LmtiywgQqNrA3/PPls11GlL9KjggM/tHkdleeHBsdffxPWmVmupyqWJQQsR1+gVOe
	 Zq9AHDpG29tbWsH11K4+NtlvCR+HTvfjp/sh8T1fG0G6toCsW3DIvwn+GyULLWkdtCqFo
	 kRrxhxl6LfHYPXEJcRc63xAemPYM+pHt9fFP0Lmyqty1Fav+Ws/pNkqmViBs3U3CK/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrmDPMrv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C80606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrmDPMrv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CB11F000C9;
	Wed, 21 Oct 2026 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792573789;
	bh=ss8JCmnLTtIgvOQEI0VDlUEtgjU/ERKBUquXx4nsMOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrmDPMrvcQsEPXJ5Mc4aAlZ4h1xmFkQYlOIV2cvVB1T1UKfpgbkLOrwH65dI02pIv
	 mRrVT84Zqyn0y5kw7Qi/LjK0SuhRz+wpyD76a+NN6eNyCcT/T6KbbROTSwndHAbGEh
	 weO6o7GbEZdCWHcvQjKO2qTB+jvs23Kp5w0uudkPLJaGst9MLIdn8q6vnc8TpGziH0
	 48NzWvPDK2RopNvwetWlCIFjlc+JuIQ8KyV7T9v9V5hn3Iu9U/PRIwr3D7mylyEaCt
	 ZY5uSfFDeQepk3zGIn/Drpss9Kz5B7rdTctXwlilv1XYfRqxJhLkdfxNqjv6DZ3c2q
	 zg32IjK33CZ0w==
Message-ID: <sashiko-outbox-180011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/syscall: Set -ENOSYS return value before calling
 syscall_enter_from_user_mode_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021085643.2442949-1-hca@linux.ibm.com>
References: <20261021085643.2442949-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:09:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> On s390 gpr2 contains both the system call return value and the system ca=
ll
> number. With [1] it is expected to set gpr2 to -ENOSYS before calling
> syscall_enter_from_user_mode_work(), so that a skipped system call has a
> defined default return value, and not the system call number like today.
>=20
> To make that work and stay compatible with existing ptrace users, replace
> PIF_SYSCALL_RET_SET with PIF_SYSCALL_ENTRY. PIF_SYSCALL_ENTRY is set befo=
re
> syscall_enter_from_user_mode_work() is called and indicates that reads and
> writes to gpr2 via PTRACE_PEEKUSR, PTRACE_POKEUSR, PTRACE_GETREGSET, and
> PTRACE_SETREGSET are redirected to regs->int_code, which contains the
> system call number. gpr2, which contains the system call return value, can
> only be changed via syscall_set_return_value() (e.g. seccomp).
>=20
> After syscall_enter_from_user_mode_work() returns, PIF_SYSCALL_ENTRY is
> cleared and the code behaves as before.
>=20
> PIF_SYSCALL_RET_SET was introduced with [2]. The flag was set by
> syscall_set_return_value() and allowed seccomp to skip syscalls
> and inject a return value despite the gpr2 aliasing.
>=20
> Kernel seccomp and ptrace selftests, as well as strace selftests, show no
> difference with and without this change.
>=20
> [1] 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_wo=
rk]() indicate syscall execution")
> [2] 56e62a737028 ("s390: convert to generic entry")
>=20
> Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[=
_work]() indicate syscall execution")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021085643.2442=
949-1-hca@linux.ibm.com?part=3D1

