Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896974;
	b=B0WCZSQ86QrZIk4t3cA3dDhSr1w61PmSprOVASOZVhiLIkH4dRUDAOqwFJbBgRuyREkY
	 dUdAcHTah0o/jfiwZkaYLZcfgnOGQjYh04F3DLSsJ3Z2ciKzwXHxiCujx80f20+QS8kfU
	 occ2hXkaCuAL2NvPmhPaW1GiiAKHHexfJ900T5DZv9THmb7ZMeDTPgqPyZwWFX5WxGeDP
	 Li+/Ytzo8z04pHQkQZhZZRfbxlXW4IZmGauzlaljrZJ9TNqvCWShzRoBWD92zZsub2gTT
	 agoqSmOXo4d87ggu/1aZb5GvGP2t4miXKtMRx9kTHnGjYPr3x9Z2VrN+cdNZoMK3v2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896974;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A30uXE/Hevt3QFSIErjkzz9XBDLddngEbtWMtG8mN64=;
	b=BvZmr1gXIxYFFDj1bnKCuwhuRhxZTfi7N49vCY1NeyEozH3Ec6exh7H03P8NdyFqFmeA
	 ffs84gWjA2GDWqkudaD0b5h+2QHcRTOcxlf3tAGBIB0AmYM9QA69EwdRxrH+jLcv0zsN8
	 dyT+zW4J7H1yHPH82OQ7X58VWaCbBTk9bA5ukKegx2CecKFp2OHjn0f94fWPZdLbUyRCh
	 Ykw6sicDrTBhEPMhxwY1okjRUzpWFWm94usoOPu7iSI9IAvI0/lODx1otLp8YmPSa/g0k
	 xZTcFR+JDayVNwUo7dC3gMiiVGW1N9/plJ9+Mt2mzJkPqLhBGNTVFNbjiHqllV7grgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmNy0ugU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22700606A92B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmNy0ugU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FA41F000C1;
	Thu,  5 Nov 2026 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896973;
	bh=A30uXE/Hevt3QFSIErjkzz9XBDLddngEbtWMtG8mN64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmNy0ugUv6p9qUwApnFxRWIrVZhmhOcVDtjmbsbz/ZtM/QlQqtdFgRvZkRWjIt5Sr
	 Ji8/VpzWOOHvaeEL1YM/QUewRzMRmuTmuEq1d1dM5CBv864OOa8fk2RbRCJIGUksPp
	 HUeDWkeqT4nnQA7/JJa7khO+2pkNgDnlqbdtUnQ9rdaj/Snqe9OUZYRQo28HObdgwC
	 oAj3m6KLgAh4r2pRAGr4Wb3wA9XO10gAgF+sBk1rQ3jnbPXQRfcEEGCNZQUMYZDHiJ
	 RNIPmNyaPuYIAZ3KiDTs+uRJuyMbPLzh2gsOiMDbbPG7fCHaN9hgazYDzb7Nv6bDml
	 qI1Bxt+ddW/bg==
Message-ID: <sashiko-outbox-199517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105153705.208516-5-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:42:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When unmapping guest ranges, each individual leaf DAT entry is
> invalidated. When unmapping large ranges, this results in a very large
> amount of invalidations, which is time consuming. Moreover, since the
> unmap callback is called by KVM while holding a spinlock, this also
> leads to stall warnings.
>=20
> Improve the situation by invalidating DAT entries higher in the tree,
> instead of each leaf individually.
>=20
> For small invalidations (up to 1 segment =3D 1M of guest memory), and
> special cases (like protected VMs) regardless of the size, the old and
> slow invalidation is performed; all leaf entries are invalidated one by
> one.
>=20
> For large invalidations (larger than 1M of guest memory), the new
> strategy is used:
>  - Invalidate prefixes on the whole range, extending start and end to
>    1M granularity
>  - Iterate through the page table pointed to by each pmd and unshadow
>    entries as needed
>  - Detach (invalidate) the pmd
>  - Save storage keys as needed
>  - Invalidate each (now detached) pte by simply overwriting it
>  - Reattach the old pmd to point to the updated page table
>=20
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153705.2085=
16-1-imbrenda@linux.ibm.com?part=3D4

