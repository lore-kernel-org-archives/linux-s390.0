Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215130;
	b=1vjhYZOFUf9MHyNJdEPYEiAwsOKO3Fv8Ngu7HGvo1uzX1hNkkRD9smN5Q6row6gBxFWg
	 T15DQTg6/h0wATBCaXwSG/00b6A4edKyhWMec4/7bd/LZl/fhMU01bsPRwHyDc5ZnAii9
	 jsg95nqZGMpcjxnuJNehdhJe1GpcyU37qFT+kTKjG1HwSGEwKlkoJqmSd2xOnJSGrPkrz
	 Sx9kQgwvUiC49i29hDYuna5ebm3BtMXsHFghysPfKsoUBd4pgIrdaTrY5P/fJPJ+93fiB
	 UzQEVSniDUzb12/5M8AIRetnCVLl0bGUy/fsXK7TrwrB2/8CQahCioMCM8XPZYvHQDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AdD/afv1wuT11RGTsHa49S9WhiY8LGOlYuD1/w3T5H0=;
	b=cXBHlnm6spJS3QX0zzZnmlJnwJyct/v4B90Cphs2rZrfOCqc8hjuk+F35f7YSjBHnILD
	 fZWRKDlhXlLK4QjvINjyRuXxh3ee/GjfPTRVrZcAnfAkl7lCZePEWoovMU1WyClX4LvIv
	 LRoikz89rFO0eSv2TUaChzXhJSCLNSEjhX8+il9hTIhIaFNjfwUBcK0FOuy3M0lWOVE2x
	 +ONn4No+8+jkiB6s0hjofiJakTNE7SbqSDajBD0JgjB0hrc8oVWchNq+nS/aLSXh6z7BC
	 UJftiPzG91JA6MonhjD9rWWwHnIMKK3TRcm/T7wF17mWqW+gKFrJP6gVxuaXXOF6S9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+1Ze8sJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B1606A325
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+1Ze8sJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294841F008A1;
	Mon,  9 Nov 2026 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215129;
	bh=AdD/afv1wuT11RGTsHa49S9WhiY8LGOlYuD1/w3T5H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+1Ze8sJ6EGGvF0RQl2Ik1DUe0QLxBFlgtu0uKC2QPYS45YlcIuEOC9JPa+Dv5ISy
	 VLDmzVdOKU0wdLXcAJJ3ztAmf0cYJLK5uw9JH662ueShsJMkcnT4KzYtx3d7lzZMBW
	 BXWaYIV62zYJCxSPMjYZffmCqnjrFOg3hZ0zPd8wzbrKngCfi+Fc1o4TMHdoe2anUg
	 j2y0r3+URdFCFn5KvOYd70RjUopnEzbWxODy31zxDNKMq1bAIU3mO0lNy2xbKlJVu9
	 +d60CDAhz/HBGP+nZZMBTnr4oUu9GPIoa48UsVxXpZ79nVuZK1Oy260TTGKXEXiYtY
	 FkCAwyFwcfdCw==
Message-ID: <sashiko-outbox-204666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/14] s390/sclp_ap: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-14-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-14-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_ap_configure() allocates the SCCB used to configure and deconfigure
> AP adapters.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
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
ready-v1-0-3e7c90eb6676@kernel.org?part=3D14

