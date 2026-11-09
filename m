Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215122;
	b=NotqMuQQOnSdDLz0GR3O9xWtcH+klMhC+QY/MNr8uYYGFBOXGgqAErqyOL+q4ZZiXrIC
	 DZ5jmEeEEqCEZLt5zlBUMFMrM2G4mVqBU0bk7JLeDkPEPRnBobO+0wtL/QkpbBbQjJzpC
	 VFiToYW+r1gocb+zratfmKxsoUesf7kqo7tvLAnSxVbyv7w2v/U/3CJEoUb+t2k2+pgd1
	 NAuhbTbSq7FXqTKbyCuzyQIpqGsbFBouSi1AlO+0bTJgKkvEGzIh60bRqthnM6Q5U7ob/
	 DS+SpMthnOC6Ort3BCP0pP19B/WFTMTTI19th88vrnJZzefF//bDEjxQJKln3vXw6dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215122;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xfg0hQBSKPf+yDttDwcQ5+coUidjxVw56kXX9Knkw8w=;
	b=DSt4GoHj9F8tSil8pj6zr7VqPs7fDGfy9AIMyqEeh49/WMBK7F6Uy95EUoySVSWvMKok
	 AOqcq2HJ5Rea42ppg7sOaCqAWMzpsO3DWMblzeqj5hVvXoElpQIAlVKNJHIihIxOroCu8
	 1HZtr3soTAWAQifeashr7H+8bv7QGVOfwDHKLp6xchcjttPBMZRuL/ThYlld8MM+qIcTM
	 VXVWjms8BPKazaqALrTO8ztMM8RuZzD7PTGTDrKzPrkXgZBim3+uhhnBtGd1loXN8vxJv
	 bp+f3Q3QV4UpwZswnekYKpnBpBeOT+PnaTyfh4fgn1ymPxf1nZarggDPHWwb95MifGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlM3GadM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E0C606A323
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlM3GadM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5610F1F0089F;
	Mon,  9 Nov 2026 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215121;
	bh=xfg0hQBSKPf+yDttDwcQ5+coUidjxVw56kXX9Knkw8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlM3GadMLuiTOfLSS2ijoWhIOi8sG36AcyRbLElSbhP6lHQgBFfVntnHhyljG3WEs
	 KvGXJo2XsKbySadX7PNIyj/eCPcWj3rsVzxLPfNOYa9nwd+y2apyN++TMD4At3dBCV
	 GPL68lwaxpME/x8XbxH3V9mnN1ef7g1yahilvKDydjcXzUFbaeX5V1lXV15YWlEBQP
	 Qvw9SRcDARJnO1LQ9RppX9v56nTTrbDGRdcAI6OSQBnR/N6RIGy7AvWYJsCvHy+Afu
	 JbQivywOPmmCR+5Quyc/rwgxtbZZ2MJqoINFNRA/Q5A0MFW578uQwSHsB0XsV6amRE
	 oRMyzf5C42LlA==
Message-ID: <sashiko-outbox-204656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/14] s390/sclp_ctl: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-4-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-4-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_ctl_ioctl_sccb() allocates the SCCB that carries a user supplied
> SCLP command.
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
ready-v1-0-3e7c90eb6676@kernel.org?part=3D4

