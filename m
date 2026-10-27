Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111678;
	b=3Al0yc5+3+R1dDrLNIY5pHasebUel9fgQMtb/SZrqWKpc2KyPLZJqgt7ezgFwOSpHuO0
	 cvW3mdbQE5vCz1L7DP9HdYcnwE8akRE0a6E0TktYVN2J4pCQiCNRW9CSr9fkhrV2X08Ey
	 fF1IVihU+i2DUNK9D+MdEww75UYRuhVx8tj3Wj/dLDS0n6D77Ez/1m+dOo1WPq/fv+gjU
	 nkiaZTyU7mg7I5HPdtbbPSiGjBuZ38J8vlsg1Xr89v3Ik5UPeY5pjJQuTYbh4uzfXtUb0
	 bN4KhTc3o8cbFEuFUHwNC6qzK7QtlJokQCp3uBInySsJTJOOJauOdvyrAuXsFHjAi1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=turUQbQMqWyNxA0OEoJuC/Fg8Z84WIsQarx3lCTsVLk=;
	b=qM5o8L6IL3C4NcxXl+dCJ/WlZ/DZaxRNZdBTtqtI5NO9LloiNRHSrUQpgwHYrkhCUWbB
	 AxBDjS17DUjJLFAOfvOhz0vR6nJKTny2iYGvntrE5S1EVo/FjwdR5G2glaoXeW6SeLVTW
	 ClydkhCYEAHb8haJa7VKf1utK0zjx8vYNjmrj61IXfQEIrj2aQbPelBVD/kHSnEL5AyUt
	 oG+qYEMyacRcOHNiow6gxIN+AkmJjeqz4prxjPRBBK2nLacUUWWf8QsZB3T2aeAVCfkHq
	 e9TLpih3L0PHOFNajCsbuOfv0tfJKOswICIldTcK9P1eDxdfgwvxdXYF0i4j9251sJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E1/is0pu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422F606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1/is0pu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14051F01828;
	Tue, 27 Oct 2026 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111678;
	bh=turUQbQMqWyNxA0OEoJuC/Fg8Z84WIsQarx3lCTsVLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1/is0puQHP2vNa7qQjXDaMCeAso6YtxpZZxxll4rowf4jMOYmeUERHwkbPyyPSW0
	 qmxJs6c7fLTwvVohXtMxh/O0LpazsQ2ZGPn5mczQY0RKuTE1CEmCynj6ytvRpLEMTW
	 DgbdFkN9CaTD26vWma5tB7lmdikqdCPqA3EqvG7B+c1l/3oUqmo0zk/XLxL8idsa85
	 QtQBWumuYZ/J+lpQujMOiIDo7CK3z7FBCSDSZejYZCcj0NqqGYYqqVYTH9e+5DtUSO
	 v+SnZWlUdYCZCcHyHm+V78leiwvJBkslsnFrd3srRgOZkw/Yi56PNGpjogr4G765OV
	 158DyU9NCyJMQ==
Message-ID: <sashiko-outbox-186728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] s390/runtime-const: Serialize text patching
 with text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-5-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:34:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex inside runtime_const_fixup() around the patching
> loop.
>=20
> Serialization is not required for runtime_const_fixup(), however this is
> part of larger series where at the end s390_kernel_write() requires that
> callers hold text_mutex.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D4

