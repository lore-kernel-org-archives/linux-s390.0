Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794680852;
	b=W0sHRyAzNSOkftGyVu7kYUWipMi1PQyOFGOCr+giSwCo0DBPPEsCBHpgBlA8Zxj0sZNg
	 zv375YgtpfGOo9zTZNos3B2iucgrmJy8eDpTGdDI5ZgbYLT1sxn8k0ovcWom5qio6WKmj
	 BJba1rdE6p9zoWcTHmMJNXbWW1pJgxBLZlOOPdTr/+SnSQXmPFZkwx8BKMxwHTrf/yh9s
	 OfEoAGWbZj7ne0iJvxE/CLwH0CuFePEV99+0XxVWxCOEQXZIx6Zz9WYdivdmOXFXUlzh0
	 pxMg8NV+8Kz444teAXvGONJw8g6/khJXz9JwMQ0vp0OAVc0ZninlchgH3PTepy/4O1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794680852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AAOvQvkUBdH8mXCoOr/ClDcfXczvlCIE0rY/0QVezyc=;
	b=v4ppt9NniI3aoTnqJw7fQRnt4CuFn3He7MPv7Qi2PsXBVBVVjVWVNt+VSrOhwrO+ISC7
	 vTLW23jutbfun7Y02OhqCqn8jqxa2vYCo3WUaojXBYM7GhdtO1It/OUXfmjCXVOeEGF/K
	 LCTnWg9o0aGfs7HFhjse8tLs3oMwaa+vwMugfrcHK1e36RhuHlqaQOv2Gp0183WJK/HJB
	 487WLTodYzZNHazGVrZ1iTGE5cr0zmLktY7Kc3aapcxpI5Lh7pIxf0sXJQG+VBS2sK6vy
	 3MlR56a6pgTSgZ0PYHSZLBFQiRr/8U/Nl+Raw6L+qNkwVa/tpzKOhcpQBiZ7SCKkYLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI+E+q2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B4606A331
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GI+E+q2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0EB1F000C4;
	Sat, 14 Nov 2026 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794680851;
	bh=AAOvQvkUBdH8mXCoOr/ClDcfXczvlCIE0rY/0QVezyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GI+E+q2BHS1HtqbkSpeJzYEckQWps9f/VLVKyiS1LOseKuuRIMAfqbT8V5i1Ffd1w
	 txTP/xTbQG6B6KLnV6aABTlTq+6qWlUEBxnZdOjJJ3vTgaq2bCswArmK1ISA6HgBTM
	 TcCtb6YUv9Ag213/2Q7EzxyjZpqo/cTfFggiYmyGoBmxBmh5oXZMYK39XZl8E0MRUM
	 2OJOCaVCwNQXKixyFQ4M1j5tJ1jGl6HL9dnCi/qUXNPmRoJY2DT231vxz2lznpuhrS
	 BfwHv0l1CHxBJVyX5w8uYHZKaGqRAyi3UNe8Aofe9umBJIaE21rCWdioGUeN9/Hmkg
	 TsJaLcFQN330w==
Message-ID: <sashiko-outbox-214901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/3] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO syscall skipping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114181923.370930-4-renzo@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-4-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:27:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Check whether PTRACE_SET_SYSCALL_INFO syscall skipping semantics
> implemented in the kernel matches userspace expectations.
>=20
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114181923.3709=
30-1-renzo@cs.unibo.it?part=3D3

