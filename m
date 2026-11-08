Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143779;
	b=3o5PfmitmN0XJR1Zp7eQwzqQRO/EV05irlkYtcLnYuLVKwD5wQyIrQyJ/v7aD6o7RuWC
	 ZwQ/B173rmKaiCw5oZrXVl8JtrVBgkOanuKJmRL1n/7G13ClFtaN+thxeJCVoqSWYAiu8
	 2gFU7sycqZuojxgEUrB611+YwJP5NdZXa/f2HA+nBG77m67ObXkqgIETq2CyZWghLRQyZ
	 isXPJ/feiJ8n49Eo/i7mDxe4mvn6AXlOGR8rtvTv+t9bNMilMFSWcTZzYQ7mf9SMcXfC6
	 UEb3xK4Q8sOjgjy49TII1szC8jqB8HFs4v052W2ZdKlxbhCS7b4+WpcWmLZaarf+jPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5oBjsqRcHKXwn9v27T9TAbsEp9oQiLXIPosNJi/cyPw=;
	b=UgwTUu7+PSnOJivOIsj683DAsIqZjFicjzYXgLb1ndrlNp/MoYpanb9ohSl1vyE19x6E
	 jLbjq2ISV+Tt/1CgImJ12B+XhY0+ea8paEsqj/kE0XzAumXehH6gDOaq3K6Ib6f1N3AiU
	 CGRxDFIUJ5HMgL5wOV1Ofh3eRMWCkJixkDAd7QA9lKs7W/KdmYZkhUi2QviaxO9TxgdDd
	 1h4Xpu3j9w0H6L58+LHeIKTFn54NEMK86ZHvSlkgAEtu3Gp0L7m0IRFFKDG3Arr/3I63i
	 f+L+kaXC2gAvsnzMEDY/6hGKUciHiTztn9SmikjdSOAJmva+55OMNaLFMzMBZ/Ru0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUyJeWBK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F91606A335;
	Sun,  8 Nov 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gUyJeWBK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7341F0089F;
	Sun,  8 Nov 2026 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143778;
	bh=5oBjsqRcHKXwn9v27T9TAbsEp9oQiLXIPosNJi/cyPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gUyJeWBKw5njYrdlkBHMflYHMA9nWIXBr3Mn63hahII4SQK3QTJZBrhZBkYi4nIpN
	 VtpRoai5RYEzsJitfjhDgTfNFRlxh1Os6Xhmj+GXkuu3FHrlXFK0rZmuH4d3LecvAe
	 DkHz6knlBft+QZK4pG6Va0i8Bxfw8dkOj5PsIZYd8LZHXsoyqT0CFn8NsRgphboM14
	 2LCvF1RY3Usw+Uqie4qKSi2in56L/NKUkN/CMBvY3fUeX0rtX/9AnMDmDlDlHuk14e
	 gco9UeM8veeAOms5cDFwOJxTY5V+ggRzrjyoZO8szJ9Jbh8FfmGvIE+bEb3oNUnM28
	 3wc0ayg78jnLQ==
Message-ID: <sashiko-outbox-203764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] s390/cert_store: Start tracking subsystem keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-6-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cert_store refreshes its keyring by unregistering and then registering
> again key_type_cert_store_key. Once keys pin to the kernel module of their
> key type, this is no longer necessary.
>=20
> Register key_type_cert_store_key once during init before creating sysfs
> attributes, and track subsystem-created keys explicitly so that the refre=
sh
> operationunlinks and invalidates previous entries directly.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D5

