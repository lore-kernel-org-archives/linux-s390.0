Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897266;
	b=C9LTdGymYILIBtiIi+FcB/8xFH6YODp1khLMrAbuozGMx+3P26jpXhoYPKGoYYscH4Lg
	 kqfkaxRwt4qUkFFvsl9PbdUAM4FeKUbk2V8JRDHkC6ynp9FPD087D4AxopYbyvVVgJN18
	 vrCXqXJsqXj4dm3LmJxMxHsNiy59+yKBpm2f7nFlI+fN+jWl+wJyJUYAOxOZFjN+67ZIw
	 KnE4+85sMcM4/ZKKR+l1MkjwkxGF1aGu6rRY59hEgmYncyMZUNptx6M0aZ21+HcrUUZ3n
	 b4TtMzIP27ATdOMSrvGwFBIjSFbULL/8g2c2vcN6xFE1JgkI88Wz1TluN5H3GHwCFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fpfp8pNAaz9MMwfs2nyd3GklfUpXcwyxhPUq2vhylg8=;
	b=bbQLcNe8xydGqsc+YNJ3UIYFypxSCTYoS6a57wzN9tnR++IVnu9uQtywMoluabrrwaiE
	 Dh0AgCp/XH/kzxiL6ESW6aXtK5sQTs6UM6bNYJ9dIsEgCoukUNgbOa37fvSs3B6R9vaND
	 7yOU0L/j5zzeGJQfWj4JnI+CSbMvpjLZdgHbsPn5LqpA1yDTVjl8kITcC6X6sJiZ0QBQG
	 zjnBbztqoar6ik+dPkRORh+HsMqSHeQ7hVlEAD09QGTlb7vaz4kdQM9xVLOAyi4g/TJul
	 gEXXNXoj/vKaU/tbmKNfMwenTLU7rkjAGXmviw4xDcvtNW1c5w6fYiwQDp2GWaWgQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuW0A54f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BD606D801
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuW0A54f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864821F00919;
	Thu,  5 Nov 2026 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897265;
	bh=fpfp8pNAaz9MMwfs2nyd3GklfUpXcwyxhPUq2vhylg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuW0A54fUSPPh7lREV4ls4GCG/3XrZMJGd41nR6N69zYTY6UGP219wzLEVa0752KZ
	 apJmzzg7iB8ViXlAXNxwJTjd5m5TVUWF0SrGRbx4y1xGj8GCwhwIWrp8QcgO45rBw5
	 4o+4FA3Bj0LeuV5R1vFTVni3gRc7G18aNwX5AAFK9rpFUpNkg55XtPTLPUjSUStWCK
	 aiO1R/QDdxvP/dszLUHjXOQUthN2boG4KuhSWfxEC2T5pcA1vrtPcm1HfLnM0bjxUd
	 BiXtzbK06jess7zqYZQgCRC0afqvHdBoidtlGFTAEt87ILxGaBwJPAP311ScjQXGOu
	 u1eax+YFlioTw==
Message-ID: <sashiko-outbox-199532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] KVM: s390: vsie: Fix pinning using the wrong
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105153705.208516-6-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:47:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
>=20
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
>=20
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
>=20
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153705.2085=
16-1-imbrenda@linux.ibm.com?part=3D5

