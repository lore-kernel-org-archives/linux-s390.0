Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305001;
	b=xLSsPL/uRKstjiw974byK48a6KkpEYb9YhYjAesGYOARfsNvVf0HrxboFxXrPkmclUya
	 IqU8KEgBS9x5059JZJDavGKkV8nNFeyOYsYdzHMNR8Nlg8RJdEYHS+lHgdWq4LaBbeMPk
	 j7nUeFrPslnp9K8jAd+TQhR3YogGDBx4YuN3u/xlfpdwctoj537C8E33XZ8a6dKJ4kcC7
	 Wj0GbbkR2u/sr6dW5pXVBuwj+TXvGUyJwHjrwB5azrB+bgM3d8qEAOXZLXl0GG4F3ElCA
	 UxQTvzdrZ1alwFiv7KDXlASlE3TJzqGtTU5LFfBJBSRtBbQXhNY4t7uVweufu1ok7bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CLl1E7GgCQeN9Eb94Wl3WRP1HKmEbKBjCFmcVd2CpUQ=;
	b=10HDy56ma7zDinn5LJtsFMag20cVIDtARh2mVEOHDC7a1n3pRtx+BZz6/4xgOhGFhMFr
	 BgriNd+Yz2ukJdgRRb0vhxyd5FC8mchea2dO2r7MNhNXFpRv8km7d7lvd35xGZnVSNZng
	 fP7rfKK1gKOXyni4hnRxxyPGskrH5+oSGUyLVp8tOi9p+mw0vlSzk/h136L0CfWbTTnyf
	 Fqky35JFyLoeS+/AF6+vnxRMf3Ct02akiyX6uEAAbrOOSSd5Auvkta5QANQp/tQTp/SbL
	 Scfy+MYVebuq+ocIsT0aL1trtLV3Qd+pYfXDf0u1Gkwt3txA8MNSAmvPZSN5EOra96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqkM4Itt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5038606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqkM4Itt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C931F01816;
	Thu, 29 Oct 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304999;
	bh=CLl1E7GgCQeN9Eb94Wl3WRP1HKmEbKBjCFmcVd2CpUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqkM4IttRuVF3JpnYm7U6xsPZQadFnR3RZ4kQLbMlksyK18DeuBA32exG7TMsFGqk
	 hFFLY8aEec3Phst/oVoVhCWra1dD6caBrcuSxn0p9OgubsL1+/Y/UK6oEiT9wgr9l1
	 TLvcE2jK71SFTx8pQcwOGyX0hufNutLHA1MmM+VD8A4+tyShx3/FTQOrpznYXUy3Bc
	 +VYw9WC/tfh1+1ZK+wvw5/jHKPGI9zaurzujiXeloklTA6W0ppOSARZ54Z/vBTINji
	 peI9gly76V2R/8WVov03O2bpezYcT2DebmAqRsSOtbNhwT78kJlRI02jQtqEyseIFT
	 yLnPTt0lKmRaw==
Message-ID: <sashiko-outbox-189915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] RFC: mm/hugetlb: delay anon folio rmap removal
 until after the TLB flush
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-15-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-15-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> After fork(), parent and child map anonymous folios read-only shared
> by CoW. On a write fault, hugetlb_wp() reuses an anonymous page instead of
> copying it if its mapcount is 1. As documented, switching to the safer
> refcount would cause more harm than help with these scarce resources.
>=20
> munmap() and MADV_DONTNEED unmap such folios and decrement the mapcount
> before the TLB is flushed. Until then, another thread of the process can
> still read the page through a stale TLB entry:
>=20
>     child: reader        child: munmap()       parent: writer
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     reads the page
>                          clears the entry
>                          mapcount drops to 1
>                                                store to the page
> [ ... ]
> for applications with different parent vs. child trust boundaries.
>=20
> Fixes: 24669e58477e ("hugetlb: use mmu_gather instead of a temporary link=
ed list for accumulating pages")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D15

