Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310823;
	b=cYndccEqN4EZBydEBh4OZgFSM0h7DFsxsz/qE6soN6o9ksPIxbkOeEcKO2iWXF+QLOA7
	 WyABYUeQS6uEyYqLdGIhphKfYg8Qm/HVmOKBB5CcjRGtXuZKEUz8JT2sDFe3nRMQ+9Ga+
	 F4WQLSnsyfupirmM0Z5S+wgpLZ5kgFkEOLrsHIjweuuB7UQEAPh7nTpjAQB0v6hxK+YOI
	 iT64W57ZN4BDzyijCwInJqWisMXP1UbAXRbPnX5iiHJLpy+FYq+0nqRra3x++oX6jg4mt
	 0KxJIJtn5FdmDTcsVmiCEUYR6XLiDc7GVNSNAWGIgw+zYWmgBk118J00uz7NsyBakZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hrPoaAqolLxWxF0xAlYrkeu3bX849s+U3aDmkBonisk=;
	b=BNaLFR6nTD6CX0vPDS1dupdLG7g2l/I0aj2KAxa5rotlY+l0E4+qlfC+CtVxCm1L8LAF
	 1t97xn5kOw0tDc+HqEu3rdzalRz45QiNhimz9HUPnbQ4YplbQA+fK+A3hCjvFCB7TjH3W
	 LCkAsAGnKuM9Ap7ASjlIqLTl2LkluHpzZ1KsqriLTBkBdhMX9+4iprgCu4Zjg4PrEexd5
	 pgMVfTenSRqTOVZoGUyfTVZ9qD6PfU39rHKo747I6j83RuDKFP7pl2D9au++6smPr0V9G
	 QeTCIO4Vc+c5Bxh3lP82VYhxPX7YPKJQd72Tck8ITi5F76hMX3m1XzD2yZvNqR9L2tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMpNOn7q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341D606A321
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMpNOn7q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521761F0089F;
	Tue, 10 Nov 2026 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310822;
	bh=hrPoaAqolLxWxF0xAlYrkeu3bX849s+U3aDmkBonisk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMpNOn7qef5fO0tt8+GsVDaCtlL9g0kidIH7do4lVcqe65fstrSTX+yCbMQTT7VPY
	 BIxjUWq8RyprNCb9cHv6CAD/RGEWDYXZOEOypHTz0MewK3uIZCLfVxb/b11iqke3yC
	 rTg5xQIz8NDnx0952Z6DVR0rZqtaYw3RXbAeYvbyxhHuGiDURsWXUNRhPO8vnlBEZk
	 ojCI9nJIi5hYu3e5X8F9w6eGn/I34xmHwO6QuOtibjGLpMfoCQZSTc8MHDLaZ3AfB9
	 Akdk4P0n8HH3TzOQzZQY5GzksmsCOfvsRvZ/0iMf3rdNTdW3NxHNaB/ohQo4X0WuVd
	 RHSI5WDBSgNLQ==
Message-ID: <sashiko-outbox-206946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/5] s390/sclp: Make parsing of received event
 buffers more robust
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110113047.238367-2-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
 <20261110113047.238367-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:40:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Validate header fields of SCCB and event buffers to protect from potential
> out-of-range memory accesses which might be caused by malformed hardware
> responses.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110113047.2383=
67-1-egorenar@linux.ibm.com?part=3D1

