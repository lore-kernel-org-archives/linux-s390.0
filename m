Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724033;
	b=djjWfUPTq2wJlWxW5xExFRDLHBw58eyZ7ljzi7ttvKak5sEc6eq1V1Xk0K+fnPEfFANF
	 brmilfubzuOhHaEgkxd7i/Cwt2OXtjzWgMYiWslzN33ye51OCcxrJBtB20lBdnXbJm5Gk
	 x7BVa83iQQDii49X0iUNEOPf4S2qWEOyAJ7oz8p7OVDOXPlkTvUeXBhHSkYsJrFmVzF39
	 nB8jqG3GPqoZ0Q5ywlzpz3xl3hNclQXLafZvoZRBg3mhBb6oVBzPhC3nOlwWnuX7kHaXX
	 +6DKyjtfa7pvCFqE08nYdBk6XH5n03ewha82tiVn1o1nxqaoD1hiUSfZ825mHJ134Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r6dcB0Wh6asCXEUVdfHLaWvjCCke0p2QjDzY4yMe3G8=;
	b=UMQSDsMTb1dqXMS7DGK4+QUCGAARqCmhaTgX6naf2I26E+m1/2amn7W3CmjdXMIIormV
	 xJNjPRlLL2s97g2a0ewy161sIed2VlvNTca49xO9PbEg/LpQOuThw4GGnVbmvkfZVteA7
	 yC9dFK5UChmgnnYsosEVaLL+xdb1L2XGuYSJJFQ2JEibdJ9JmuM7nw5f3mwWcD0nQAwPS
	 8LcCuqiHBrukV90akbuO0frn08RXXFNsGQeo6+tIMAwzH6Kqzc+AVjE2TQFl/9k9UF+JM
	 udjmZwrkBpJb3rABfNL4MA8pg5YayR6ljj+S4FkjCG4uhU9ACeX10XGTwVsL6sFJ1+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hnhs77Ma;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF900606A319
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hnhs77Ma
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF5C1F01825;
	Fri, 23 Oct 2026 02:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724032;
	bh=r6dcB0Wh6asCXEUVdfHLaWvjCCke0p2QjDzY4yMe3G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hnhs77MahTcQLYlnq+lDvdNyEOvni9R9aAF0UvZPKbInEPzDn9u1kyPHMohqAbFxH
	 a9TyyV7W3CEul0T18SHMLMfovNIWMdb3g4qKikRb4RcWxY4Jdbxsc08odhW2GDBQ6q
	 aDhfXDQc5Ca2lRZ2evXtClArsuSvkFi7gFyj4YNlnMAULB9m3O7N9OuoKsNzY79i4m
	 OJ/QQQb3Jb3BUuecoqFT5UoEvrICRjKGwBJbUiyxOfORMToF231NXCqKPoXpzqARuH
	 ifrFPiSFoWMh8i6kAOnDC0Mh3a2G06ng+RCZnc+HKxCGZzHA/MXJMZsVqGJItgTDyk
	 /zptyFY371rZA==
Message-ID: <sashiko-outbox-182250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: clear hs_dev before dropping its
 reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me>
References: <20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me>
 <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:53:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> iucv_sock_close() drops the socket's reference on its HiperSockets
> device and only then clears iucv->hs_dev, while afiucv_hs_rcv() compares
> that field against the ingress device for every socket in the list,
> under iucv_sk_list.lock and not the socket lock. Between the two it
> compares a pointer the socket no longer holds; KCSAN reports the plain
> read against the plain write. The order dates from 800c5eb7b5eb, the
> compare from 80230a18c164. Nothing user-visible is known from it: the
> receive path holds the ingress device, so the stale pointer is compared,
> never dereferenced.
>=20
> Clear the pointer first, through a local, then drop the reference, and
> mark the lookup's read and the two stores that race with it: the clear
> in close and the listener's child's, which is in iucv_sk_list from
> [ ... ]
> Fixes: 80230a18c164 ("net/iucv: filter frames in afiucv_hs_rcv() by ingre=
ss device")
> Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb666=
7e@linux.ibm.com/
> Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-disp-b3=
5a9153-v1-0-d74645876195@proton.me?part=3D1

