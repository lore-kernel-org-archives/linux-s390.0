Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013478;
	b=W+0zkt6uOpL/VVj3VaYbH2zmjIxxqzdl3A0EOmahg/cfowdXy9Bb+H9uKpc0JsGo3Uo3
	 +pBXCJCbwfdXkrv4MAYNmkBtvkwfpTty82mrrMRaGyfLyraHeqOcDkjoT7tKrJRNHk+qf
	 FSy/6JtPqTeOT0/ec8dYhRAHwgLSz+aJVFRgYP5X0KA+AXCpxJVR6oPmCCMEA54upo8iU
	 fgi0Inhb9v7GHe/2aS8HwHQobTW0H+wbnHUv8sz2+sd97769kxi7ioOntJzCJrPq7yo8D
	 IFcJaR7trUmIAfH3WrwfQ/KkC8B+Q0j0H2kMlbmBa/CgGoWj/HNPRufk/6i02oG4ocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u3aMGA/gtNSDiX5Zo6eohc8BiyfE4/qh1nML2rXeoSM=;
	b=SOmtFoqOYKiLv3oDxc78TgVlNwoW77OXePsxXg/5NU6XSZWC8dh8seoPRtxsEs65xxGN
	 F3beVvWrjazc6UyI7IGqvmRvprN+BJLMLD02o4H9BIKsa/fB62dAMkWMocsXXemTlEHHm
	 wPUij/MHpBaX14fMrSKhgu78fKAmQ7ywIx8788MkNV+gHGavhrmF/MDqP3kMT/quCqtYV
	 9BR/SWYzTetzV2cBAj/ZFQ8hcVXZk7w/nddnr99sipVliHexOqyEyO2RupH2PvKgkLjpZ
	 XoE9HpWgNbH6WgNLZDC4AqmrQiB5LNt17ALrhwpRNAl/hbdgcSZEiyu/ckcWHO3+2MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2hDXOZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB816606A336
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2hDXOZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BD31F000C7;
	Wed, 18 Nov 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013478;
	bh=u3aMGA/gtNSDiX5Zo6eohc8BiyfE4/qh1nML2rXeoSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2hDXOZb9almFICruSxfojmCuE/+9G9zZwMhLa95KkJfMilOAQHNjqadb7VNyodiW
	 wA207Qh/k9lMdi2C8gGWJWczmaQs+a3oMp/d3jEy26T9iiKvWbxPbMv1E2h4TA0bpE
	 W6SWhCqQJ9KCc0QtTWK00Vm/TEtNDDCFmFlg7xX/+WMJiUUyOsAGvdY5axClFCMf46
	 4ozS7CuFdiJ1FfVFu94MEAxuNfqlahhrDS23yQznOQqhbMO8WeP97I9uawAn5qP24L
	 CvYIFcgKd3wFb/G9sjKTl+eGKuRzj5kQS7C20VCuqOHQJVOTyhbswIRwWsKcDu7qSD
	 I+fSZlWu6AMRA==
Message-ID: <sashiko-outbox-221258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] s390/mm: Add error handling to
 arch_setup_zero_pages()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-6-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:51:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> If set_memory_ro() fails early in arch_setup_zero_pages() just
> panic. This should never happen.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D5

