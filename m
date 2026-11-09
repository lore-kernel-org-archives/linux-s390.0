Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215123;
	b=comwHAaWeDs1WJ8THinclSoHaaUviAP10867EWEsnKgbxuLmujtuD4wp1lXpRHCvNa39
	 kJGeNqA1u3NMo68Fmsp6leuOG+ti+MTkPACEhqV6vM2SgbNVd9zQlAZ5cNDf5fMPrVTDR
	 DLNLQ612wypR5gLrr1BH0Dsv+7bdPvyQir+lNNYiQGxsraJP1U+r9KCfHt2oueEHuvzBz
	 IPC1YuCLslah4eJ2EMcRPhbGnSuxcumRTh4FB5ja+HZSsqbllEd5DN68FYrmQKvqdekCg
	 gaJB6jX0iL2qLX5KipmE/mACPEkbFN6dNHfoL5iEab5OfzpQ6nKhZPOB/5cTT+qaIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i0d4HzX99hDhJY6pM39vet5235zVAD2S6DVcckHDdZM=;
	b=pwLMSzmIZf8G2qmvf05qRM5fbnSXU1N5IQsttRwabagxjsO04Gkm+OShdQgTgK7JWyQr
	 zHy6IkKDwmcXpgjftMnQBgOILFREMCmwueuczta2509550TGQpAJ6XsbCTKoupAZJQ9DZ
	 wwChQjpl9cPwRhxtow7BZTYRLL5GUlmwjG824nhh3d+fAq7m26Q5lgl3yt8E+STVXEHGT
	 pPDUYAn+5azpqQ8WO7sT1CUR09ZMHwaGGJAUUG9C4H/2AUTsYq+C/CJsbtYjzGH66Ub/y
	 iu3kZDGliMqVih/dKTZqDIIpC3A7yRfNFuDoZc8h3OIzzZllIKP4dvbXclJ+xQWSkog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG7pLwPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAE606A323
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG7pLwPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F8D1F008A2;
	Mon,  9 Nov 2026 09:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215122;
	bh=i0d4HzX99hDhJY6pM39vet5235zVAD2S6DVcckHDdZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NG7pLwPnRfVlHTzcYjXpD9y0o/8uEc1vKwHJdDmKni/Ivu9WV9BXGMn/J8SdXvgD7
	 rTRNMRhYl2si8jeLJHTlex6tBXQiaw2CsqT8KB5qxK+GVtbFGskCG/DpUcAZ0970wy
	 BtOdUd409aXqueNAcxw0HAAx9/kQvkQv8KZZnlKNVVM3MmtG2R54rowWQRUyYcgGXi
	 /5FXPv7KtVg7IzK1AZ/xaeBLOmxSO7jtkATgd6ZLFB87S6s9p3O6nFmSY3q4dB+pCR
	 pHuccOuTF/dqLxFVMQl/ZaGt/RQDGoUMLdC0Zmhgyq9aI83GxcyIib3rN27FHORkpJ
	 DyEydTAPi4CYA==
Message-ID: <sashiko-outbox-204657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/14] s390/sclp_con: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-5-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-5-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:21 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_console_init() allocates the SCCBs that are used as the output
> buffers of the SCLP line mode console.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D5

