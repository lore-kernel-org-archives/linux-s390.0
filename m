Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310997;
	b=ccnX507+lYj0Ho/2FlSd6LyBrlYA1scjeMhcGvCLZ2K5uTuB05/er2v3pU3PfYU+JKpr
	 KrCJomZwbEBXiJVsb9SZI7hfuoH3wld9E8ParwwyyX9bh7SUlK3PBfiHbPs5KNxwm2aKI
	 SQIQGzK7s3VVqtaT+4VDccn5DHwGiFh/jAXDeGqmkd48PFqvwjnuREdQYp3DxGJ5iQMaG
	 VwJ0O1ZIQiK+BPACanC01YG/c0adiZwAiFIzfdxPcekgNdUKr4JS36y75sdgga9ySMIeH
	 tSZany/1zz6RKBYrTpNYHunUIkGE8kOnXG7hgm2EjuAPUWsElYzgGoGWMHhxao1umjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OJquXdABcptctfHTf9lqDPLxOEBy1nEO8RgyraoCeLo=;
	b=LzHAV6K+qWkHn7Ur+Lir6TZZwv5vS0OSrsMln1En7ztY9M2Qa2s0775+iU8YITflRGhQ
	 MLNqdPvON93F3u1BE/AfNW4+G+jpx/0UItZqBsQ12ZpULyZ51QZmJmltDy2H7HAU7lFdf
	 kLlADEYeoH0L+DMfle4peICGpQ+1VGLUzSJ4p/HhkiQbOnr/CbZFXRC00IP7rBOTDk+Ec
	 kH6WJw6a9M1wYcPc7Y75MMG8fxjc5v29eNlYnvqgqMeK6VruQT4yFI84cvhn2i4WTHGE8
	 1DUyIc/s24yA+Ry5LU+qRZEGuK6AiOcOJtVlsjIZjnV93FCOekzh66QjrZ4QuM5s6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSjK6dSg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA64606A33F
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSjK6dSg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3841F008A2;
	Tue, 10 Nov 2026 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310997;
	bh=OJquXdABcptctfHTf9lqDPLxOEBy1nEO8RgyraoCeLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSjK6dSg4gJ5DVyRIqm7w2jYixt15Iu1hCrof8hEnMtm4yhWYfn1tpFDWSGEOHEP4
	 9FGpD6yuD5TJzjoH1IxoCuJ3JBU56t+/852X+dEIyOzeMSS7poBUNV2VRRvCIG70Tg
	 io8LVnixuk0un/QvXyG9A+ea2bznJRLitVPghXRGLg98Y1DJLe/Dun34iKTiBp6MXI
	 nL0dFYcyw242hSPoak4Jp295CE1AccdVl7qWkHSP0dl+gpElm7P/aTHNl/7lRKxQS8
	 H4jmqxitLsrOPaIvWO6uH9yzEAKjP/1WhvmKHbulmMCw3CQAgCZJYb71G7lNzI6RZf
	 TUVdnRW2Cfw5w==
Message-ID: <sashiko-outbox-206949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] s390/sclp: Ensure no callback gets called after
 sclp_unregister() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110113047.238367-6-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
 <20261110113047.238367-6-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:43:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> There is a potential race condition between sclp_unregister()
> and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
> it is not guaranteed that the callbacks registered with sclp_register()
> will not get called one more time (and no more than one) after
> sclp_unregister() returns.
>=20
> The basic idea is to use a single global wait queue which is woken up
> when no SCLP WRITE_EVENT_MASK and no SCLP READ_EVENT_DATA request is
> outstanding. If both are true then it is guaranteed that no sclp_register
> callback could be in-flight. Once the struct sclp_register given to
> sclp_unregister() is removed from the list sclp_reg_list, no further
> callbacks can be scheduled for the given struct sclp_register and it only
> remains to wait until the SCLP driver becomes idle.
>=20
> With this change sclp_unregister() may no longer be invoked from atomic
> context or registered callbacks. But this represents no problem because
> this is no regular use case and no driver using sclp_unregister() requires
> this at the moment and likely should not require it in the future.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110113047.2383=
67-1-egorenar@linux.ibm.com?part=3D5

