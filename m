Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7E2E7375;
	Sun,  6 Sep 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788683692; cv=none; b=Fx9CaMyKAb+KXzfF6e0PTRJpe29MpjzmXM2mLsQCNUkXplL7NAKCK1dg1kOv0qnHlUHykGxWuwmDKXJem7CvnPGO27wjiA+stLG8WPguXKKLKfVaOdo6qvaoDjTjdGhXTSYeDd/9AXW7ajPixjFy9SYmXlXizL+YdGvAro2aBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788683692; c=relaxed/simple;
	bh=OlLGLU7iwRHIlkc70s7WUNJcNPLDKmRgZZw6/EkT1EQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKuVxj83oM+X436EwrCOoVdQKpPvFlV3XA32O9k70CHb8OywZr7Vgyur6ZPAkOlc7O1QSQEBl4fYlMDsVJvz+QxRgyX+7xYqC/CtTbVsBrcUab64TJzDR0aKIp9EyU+elrDe7xzanzlqFpjBNrhuHcjv0Blc9WnjTI0hP/fYQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R15oq4Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R15oq4Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9CA1F00A3A;
	Sun,  6 Sep 2026 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788683691;
	bh=OlLGLU7iwRHIlkc70s7WUNJcNPLDKmRgZZw6/EkT1EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R15oq4EsAAOXnpUUNukt97IDpldp9LCioBTwzJkynGxvQJzxYvG7nNw9ss6hk/mKL
	 Gyhezzw9x2iyBwCjJSCI5vOi5/t62bgJ8bM/YoSIuNmgQ2m/KGzsfi7qq6YzOtqJ94
	 q6jTgy4fim6U8YuClio9L+AA6qCrBDvcU1qBaw6pYyby+tYIitMS9mTx+EL9jHUPg8
	 629UZYbZW71GtgbllNM2NNgnw3h2RbkdAMu4GZ7CrzdyjrAJh7gsM0z07FJS6TSdRm
	 VkjIQEA41t8k+BKpN8eZahOsRZi+VRfhyk5s8Qht8x4ELf0bCMmkC7iyu270oVvVub
	 CjRwRBG+Ru2Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: s390: Replace get_zeroed_page() with
 kzalloc() for sie_page2 and CMMA
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260906-s390-kvm-v2-4-2cf6434e6646@kernel.org>
References: <20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org>
 <20260906-s390-kvm-v2-4-2cf6434e6646@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:34:50 +0000
Message-Id: <20260906083450.AC9CA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> kvm_arch_init_vm() allocates struct sie_page2 that holds the facility
> list and the crypto control block of a VM and kvm_s390_vcpu_setup_cmma()
> allocates the CMMA collaborative memory management block referenced by
> the SIE control block. Both are passed to the hardware as physical
> addresses and must be page aligned.
>=20
> kmalloc() guarantees that a power of two sized allocation is aligned to
> its size, so a PAGE_SIZE allocation is page aligned as well.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> [ ... ]
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-s390-kvm-v=
2-0-2cf6434e6646@kernel.org?part=3D4

