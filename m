Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924778;
	b=dh14pXG/L1+IokZ7D4UFl3MT2vlwYvEPFzvaubqXGuVRqNLRAj8Fq0kPsuEZMmj4Wf/c
	 znrBDmdU3wqpneDRg/P0kSgTlGJIJSoroKDmV5ihl+ZmhBcC+rHnwnPAwiCNI36G/L3Ge
	 aNOu92lIhUodkW+GcaVks8SNR4yWUIAdqjMlbc4g4JtIsLbUIqmq7+IS/BLmLxo3+NOX8
	 sK6NtI4NTSzACuHhjUWMdOCHjr9FMKm5zOBMZVs5InQc3Asr1AfXYIJAs5HpSV/2GVYzi
	 lsYRoacGOk0OHY7IFw/wCQ7t8RM0Qo/HM68ZVAvUA++Y8g3TpFigcfRO9qcfUmB9Suw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1l1ztD8sbDEMK/op0OwtcL6+M4Qve0On9aM7RBPINq4=;
	b=eXDp+XcdXqRzYSjmmqTlJqDaN7QsnBl636GPcPx4i+Nrf81y30C0EHqIhujn2oQtEmqo
	 riDGdSs3EsDVktjoIYvK+XsXyIQjb2TzGuSTmsQEdE01pNDvdkbW7Y5WUygO27OlcGs9M
	 9XtRhSH+IzNJ3T+UkaJlTTRmvQqKUhnahBQzN9YDbSMPkq4k4UBiQen7zaQxPdztEbAQz
	 dYTN6B8VbGgilzpbZVYYEqUw7k3M3QwQMwU7mJq3Z5rNzvuvefpW12UWrPHyW7hlVlQAA
	 cs6l1fanMD9LoSl+krD4/29Jkohm/CbZpOZksbdKQTlHYsw+iWq+jhYeKSx3iYzg7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbYzQpyb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFD606B088
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbYzQpyb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F561F000C4;
	Tue, 17 Nov 2026 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924777;
	bh=1l1ztD8sbDEMK/op0OwtcL6+M4Qve0On9aM7RBPINq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbYzQpybp6WNZpVBAR3JUh7TfSyeC3H3HWLvBEO3AdfNlEjZze4M6Hz/i0eyeFx+S
	 6k5aaDbi5C27+QH5iV36KqAqzyBS/AJE/SDQoHjuKix1sz4Tx2e6NQ1cD/IH5jFdBv
	 889MW+lEMIICsCsoYRrtAjMRiwulEbEGgf559GWM9/TS56SPnuJK1jU6fl/Snjw87J
	 UdmNU6Dl+tPl+BOGxx6WQj0Ia2FiLCCM3KB2e+BklFUR5MwhxZdl6tnzm7KR4BdIfu
	 C3GgiPvaXFUBxqKwHkZUYRpyaleET1Qcv5L6TKIGOMUkchCUP0SsfYOsCnLFovnX11
	 KKvEuwaGDrFpA==
Message-ID: <sashiko-outbox-218940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/14] s390/sclp_tty: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-6-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-6-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_tty_init() allocates the SCCBs that are used as the output buffers
> of the SCLP line mode terminal.
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
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D6

