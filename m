Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662362;
	b=t7cXia1c3qq8zWGHqLtlmC3ebJPt7jm9kWtITYyssarAZclofitdQ1f55bzyORPNcEmW
	 eOvN/dSp+DyfqR8uQ89VqwKJH7Km7pGdymjeAcTl7RjzliI4vESf0F4epko/7gzZ9zc+B
	 fDg84Ea8glblqLgAEpm1kt9Fm3YeIeidnt4elZ+HO9Weu51j7FE2E6EOKJGjn4Fcpxcaa
	 1VI0GBldzKmL6Hj33j37lkJ6FbsWqkN9uJCZqiEd7pBhRxwC2T0B/mMh16Pipz5YZb4Ye
	 Ktjz5fxxn6OrMX7QWKZ1kRbpitGdvOSJdL0iQPJaGDMtg/dzraHxiu2bzLTb7TvxGWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2nbMOlMNb7MWIyi25KZO6seDQe1DJAAAFw6HORijwjU=;
	b=MLc3hMRs6Joh9B40cSSgkMe7F5icRO5pP32phYcF/XcaXcgPU9PvFb9dKTn6IQwjZON+
	 DTHA5Uitfl+0wKjKKC5LGuQyUz806BBopP+55Cl67RdJDKI1XqNYDzAc6kAh0JohXDlyM
	 mV9VqhgcWe3Je7ML2LtWucXYdGI9aqxxhRWR0q3cnfFbbMo7ZGrP+ZKodMGL72mwUylKq
	 Sas3VJyv42Y2ZG8fjkyzvg1F0viPJKuj8V/eMY0MGkguRdRH7vWQV6/cGzwaKVesSMHXl
	 1vzzV1l8ZZhBP97zgnBtUOKpoJ22n+v+fs0NyLUHTXvKSB/tIvIxVl+Nw/PY8+nOKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFfneAwv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C6606A895;
	Sat, 14 Nov 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFfneAwv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E0D1F000C5;
	Sat, 14 Nov 2026 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662361;
	bh=2nbMOlMNb7MWIyi25KZO6seDQe1DJAAAFw6HORijwjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFfneAwvzJIhqHTwJju5SkkcLdNizXsPiHLJpAECae0XCthNVV8f82RicNcQy6vU3
	 B5kiTwgXjegjAT+s5tHuzZ3e3WA9PKYgqMxTaqmhusk/S1EYwvJp8pEA/pskHIh2Zk
	 ezLHOFgUj5dYRwZuacrNMXq8Tqy4HAzNSNgLBSF/tzMmAVqfMa/I9dOCVXmioPDdRe
	 lio50sViYO1lZJrl3B3+dx95vNCLkpLljRZ9Dna1LFFEa6hlcvETtyyJ2eLykHYi5t
	 tj3QBthLYjaefepSgIiOZICIFGyD02mOLx+V1zfrNCrPwEXyUGOkoWGPA5CRhHlpKT
	 4rbAS1Hi2ag+Q==
Message-ID: <sashiko-outbox-214540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 06/42] proc: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-6-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-6-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D6

