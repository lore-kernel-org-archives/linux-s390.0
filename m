Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772330;
	b=YaKibwjZPH326yFczOwLtrckUQgxjDPGj0qS+VsES70mu99ZtJuD4venUhqTQy0P/h+E
	 1jG2N2BenJMB5Le7F6fPYyW+VSzKQ+sf9FXbzthufsZH5plnptyOgsvrnH2tLZ6iX1GCr
	 ZUG4DhB7gdT4GZ6vj+daa1I91cufxUav5SqslgLrtfJrdO7GCJStkBjerbUe+OlpjDrEt
	 BsJ2aTbVbMtGYwCsXomfD6EM3FnfDY68YPDRj4rm/6lk5LpIpELIayhn38xmx7+0g6+HG
	 Uc6fUU9SOdmzqJHCTjqVzKDuYqq96y8r0fNOF+AjzFrVgFgRMlXwJWGd7Z5lstgda0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gIRgUTC42EdpWN60yLD7pqAHo3/rRBxJbnsNnUZ0yqc=;
	b=fgjbTT2v6Fzbu41pe1scgBWY3mCAPFtjKy+Znx5A7fwtoJzzupF83bhA82mXyOuRVHbo
	 wMSdNiMvtRUyz3BHEQ9hfAIM9tPSGigibBQKb82AWeb2UfSgF3nacohnC3r7NhVk3Z77e
	 sehTXqu1kzX75ftYp9oZB/lRY/+0BjUtd2dRhTlRBsjDC1ZN/NXElTqXrMqkkw8gnUm0k
	 v2Wq1Y8mnsZekWqGPVo5TLlges+vhLNmhEC8N+JVW664TWnk/hiI1L7BxTleezXknuV6w
	 ScL7FIoKs3VVrMFUvLHfKghJKi4XyQoRLOCr88VCbyoFLZnZfQuHFuATg/VRddiGXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMAwA1rB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F5606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMAwA1rB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE851F01825;
	Fri, 23 Oct 2026 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772329;
	bh=gIRgUTC42EdpWN60yLD7pqAHo3/rRBxJbnsNnUZ0yqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMAwA1rBGEUlJNG0JfGVYqdDjzG8nomLow3+Q2rsBzNw1vybaPm8PM/s/y74JjSbN
	 JY0EudZC6aNvgvv9vo4yCJhlF1ANCf/Rso1LbOyM4r/E6xkZExUgRxEuIJKPMArkBW
	 KBhO1jP4/W1V50rpYPaXGiOzIHxB6gx6lbjX/nkkVBHlM7SgGQ6zPFao+nBvwcnC9e
	 EbXg8CMmI3Nu2oEXbFp6Odyt9GYxnekUl006buppFRmO4lnqIXMpX2M/o1USEfOJMx
	 2qvNCih6ptoxfL8xY9N2EFF1pob7Q1oVrnoQg8gtlsRq4krYJ7srieVNlA717h+06u
	 YyTpozDYPa/+Q==
Message-ID: <sashiko-outbox-182943@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-2-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:18:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D1

