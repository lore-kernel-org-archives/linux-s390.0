Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C5248F7C;
	Sun,  6 Sep 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683465; cv=none; b=Ew/bHZjX/T3IscKS6ZeWr+3AHK+f2MQVdRFbDSkHrFST/PXPH+9Wh64LE9BrX2va+pmFzt8N5lAjywwIe5uD13QGGyKlLp3aE5Sahh6nvFeVpPBqsdIjn13Ae4xPziZZ5pBz1+6Uad9E/C/JVSm/fTP9YsH89XJFTZBI6pvvszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683465; c=relaxed/simple;
	bh=e2L7SdCLW+d6wj5VlIsXvgxlSvOgIM5O38tZCd4dEv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtCV/A5z2t278QeVTL12lGlIC2chS6tib60t+lsYrHK2TBJnRhH50qpePb/N4onDML0zFVLV7Ao6Z7aJD9Mt9LrcX03qOv7Tb49yK4j1Qd6EAw9scNR9qhVNR8vXk0/sWLnSGXX6LmUHCHNmLWXkB7yEp4pp3kcPs3JcZAFFK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFB5RNbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFB5RNbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEB51F00A3A;
	Sun,  6 Sep 2026 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683463;
	bh=e2L7SdCLW+d6wj5VlIsXvgxlSvOgIM5O38tZCd4dEv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFB5RNbScoOffKZcMx7eYqzS9yvXNOzbQ1P3Sjz+Kld/hEMaESMPQKmEXV9vQfCVu
	 u1QGIcDy7pzzmtjW44GCkjm/U0zuLebmJ5vTkr9MweW0j5XyfW/3AT46JHeTqZk7ob
	 ONXuiOpikuzrgkqPlbhSXI4oNqOWJ06/lU3k8j5heRszY/Sgku5qBpxECgK+quuapR
	 8+KnG7lWTojv99cgy2wHCwkFcuWMlPvshJjF/W4MecF9MmoOQJtdV0SvLwHVyZmn82
	 TMoymySHlsF6sLOBYBSpppVuwh5QiqW6h254kfUHHSK2AZ8+Qs2FZIlrXRXmaLV409
	 +CQGkK5FgfkAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: s390: Replace get_zeroed_page() with
 kzalloc() for the STHYI buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260906-s390-kvm-v2-1-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
 <20260906-s390-kvm-v2-1-2cf6434e6646@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:31:02 +0000
Message-Id: <20260906083103.4CEB51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> handle_sthyi() allocates the buffer that receives the STHYI response
> block before it is copied to the guest.
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
> The only goto in that function does not unwind anything, it merely skips
> to the exit when the function code is invalid. Turn it into an early
> return so that the buffer can be freed with __free(kfree).
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-s390-kvm-v=
2-0-2cf6434e6646@kernel.org?part=3D1

