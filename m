Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852064;
	b=WWzpQSAFgxEx+1faZhEU5l0KTNuaZXvTrT28dilS138B1slcDbVfgmon8eLB5DdxXjMG
	 2R9XHEKC7mybd6SNDaqsZ4rZJY0ldGfMrm85q6czJSvnoBDcZ0gFQEUgMKFGHoQNncJbm
	 wAhRCWq1dW/EPBV4m4hgmvlKHce0NMMFlpdmQfirej1M9rPzK7UAKAC+kAL3kfmS3zxgK
	 mMM7OCr1iiLEex98daM1ixqRUKuXDp2LyCdD5l9Wzf90c6zDDsLNK/oqxI9JRbrNDt4yz
	 lfqqSgv4hQEWb+Wc4ffHzpN0a55yJCUZenx2RsXLWRSKscCRpeVxQHPZ7bSTtiartEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0EZJ8qCW0n13Yb3DU9KhVra3JPQolNjbfNF2UDAJIBA=;
	b=WspUSORzMR8tBID9JgQnDh69s3iQ6E4afVDnRchFEofhW/yDd1BBadF6Xzi4fgOmxm9+
	 HmMJ2yiARboHs5uOmtQX3w2+MgORNwSZWwe2sELbhoHzySES3vvNIr0ywqzZb/TJ9YsK6
	 n8mLvyWDAwwZvBR1gPaiyESP+AosCPhY2oSXjpTmWiM55H03e2KVHIoMc/NLdzclwPO+M
	 o4dHVWDmY7BuCT0QvLn13zNb4cZqOCelea+FRlBsyQoVgmBbqSwURATi14VnVKM0zBMrd
	 qIGRwz/zmWsC+tK2LfVw6U3gfJcorOHfl1QiHdWPb97Qr5rfwlS2dPFBjtOTnzKXW4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI4BvSTy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D0606A880
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI4BvSTy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844FC1F000CA;
	Mon, 16 Nov 2026 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794852063;
	bh=0EZJ8qCW0n13Yb3DU9KhVra3JPQolNjbfNF2UDAJIBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RI4BvSTytePEYbZeLh9D+sUO1HU+/qiNphS+IHxtUpOPdbSfhk26Aw1OLxc3UlVLF
	 q0y9wgSg5dCYe9SfiWqGbEjyM/Aj4LsdRV1mrMG1mx0107vspXirC/npX7XdsB0UoE
	 c3JUCoITcwuj2r8d5KY6bCWYJp9vCNK6YMgFw3pleI3N/xl5aS0ruzesJCrok4ESSJ
	 n0T701b9w5XVTSulQXki1pA1PM0xo4BzZETeJ4eXbFtoETe91iVURE3b6h1FsL/El7
	 Nrn9sU8b0AyMGlOmPzniRFkaYcudtpLjiRIIufnkl6D8gCk3HnoWSg1tGwRJV70a+d
	 EVS1i0QzzzNgQ==
Message-ID: <sashiko-outbox-217477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] s390/cert_store: Fix potential use-after-free in
 invalidate_keyring_keys()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-4-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:01:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Drop the refcount of current_key behind all users of current_key which
> dereference it, like e.g. error logging.
>=20
> Fixes a potential use-after-free bug.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D3

