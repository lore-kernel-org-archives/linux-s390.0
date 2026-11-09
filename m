Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263310;
	b=WL1+Ms8HI+7jFqNRZp0mtFBGs5ODRgDtZn5V302OsvJQl/JkTRa2lFR8RSaiTLEBh3AS
	 ouQoLv+Dpc1/w6qyeBEYYYjuZOhTyg2KNUGR0Stu7oH4YajUi4dzG2CfWJUBlZu9tVDIi
	 YQZUgpvwWPljpjvTfT8f8JsnYCqyscYl0AFeEAqWxBUZeZoHvw6wsQaZcZBhZzSU+0Ntq
	 XOEYUuTeAtdJlqj2imrUFw8WQJ9ylhSts+WW38/iAIVteA0+e/etX1yvEu13FwBrkuspc
	 lRj1Ft3lyo1Lrh2XFEiIt7M7S0I72HRXJB1LlbTBzRMw/l0Q2D77LrL3YSHoP6ZiZOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pxoH6UjLaaaWaTL/eaygp+/kk97XzslCjCIgMA5Icwg=;
	b=MQuW2/FmVI3lgZS7LpNiWzqksF6E+Ym/1NxV/ayxLDYYgxzesckQ1jdsI48FlbANuTE6
	 BkE7QCkeMhlOMtSSPIBDfZiJzr80avrtBe/dTez/K4cxWgVBCO/GHRDqlFdo31yuVNZG/
	 XFKVifibQIliiO+hs3pEkY1Xitj2f46L5uUJufQQd0hKu0x15YvTVu01/aeh9E9BW4MvT
	 uGz7TY8Hl/tVWopm8xkbY5Ax/rXH72Uu8N/F1YrYizkry9HPHxAG9rx7GcMgM82ynSU0l
	 o8r7uhR+r9Dn1hc4Fmn2FYTG57Zc251RbHUTo7OcgkNlvBLwDjHK9eDthKx6I6PJlDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNOeVnvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEE606A31C;
	Mon,  9 Nov 2026 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNOeVnvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DF91F008A1;
	Mon,  9 Nov 2026 22:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263309;
	bh=pxoH6UjLaaaWaTL/eaygp+/kk97XzslCjCIgMA5Icwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNOeVnvZTF6uY22FKJKjbXfeTCvmLrtIJjRHmnfvXe/Mll0dMd9lcZTG1Nohrm5lv
	 A10328b1w5bTwInnBw04f1S3dh2trZa1hONYgUBbCzEz+rl7s+PqGIsiBqFto2borY
	 pYoT6ZGaU9zctNrXhhXK3r9H2aAKXwjLCOj/o05EFgR1TiWZXZQ0/tvUQRvR1hVizJ
	 QboPLz6NaODn3UbFFK6QpBebujzCL8H+Y1iqe18zcjuVaovLcb4Nn7wmOaLI3FzKpZ
	 ZDkCKzCsYNOs1yjZiTO0w7ZyMLhfLzSBsS8m9Ngl6TyPeRDhJi+ZXB1D+UcCsCE2fo
	 X8clFzLSWfoNQ==
Message-ID: <sashiko-outbox-205732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] KEYS: trusted: TEE: Synchronize session
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Anna Schumaker" <anna@kernel.org>, "Bharath
 SM" <bharathsm@microsoft.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Biggers" <ebiggers@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "James Bottomley" <James.Bottomley@HansenPartnership.com>, "James
 Morris" <jmorris@namei.org>, "Marc Dionne" <marc.dionne@auristor.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Namjae Jeon" <linkinjeon@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "Paulo
 Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg" <ronniesahlberg@gmail.com>, "Serge
 E. Hallyn" <serge@hallyn.com>, "Shyam Prasad N" <sprasad@microsoft.com>, "Simon
 Horman" <horms@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Tom Talpey" <tom@talpey.com>, "Trond
 Myklebust" <trondmy@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>
In-Reply-To: <20261108222719.304712-7-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] KEYS: trusted: missing Fixes trailers for TEE lifetime and
  init_trusted() fixes
--

commit 081b81fce481c8193427ac02abce847085159640
Author: Jarkko Sakkinen <jarkko@kernel.org>

> KEYS: trusted: TEE: Synchronize session lifetime
>
> The parent TEE device can remove the client device while live instances
> keep trusted.ko loaded.
>
> Update the static calls before invoking backend init() and reset them in
> the case of a failure.
>
> In the TEE backend, guard session context state with a mutex, publish
> pvt_data.dev before registering key_type_trusted and sanitize pvt_data on
> probe failure and removal.
>
> When an active TEE has not been bound, reject seal, unseal and get_random
> with -ENODEV.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

[Severity: Low]
Should this include Fixes: tags for the TEE session lifetime handling and
the static call ordering in init_trusted()?

  Fixes: 0a95ebc91305 ("KEYS: trusted: Introduce TEE based Trusted Keys")
  Fixes: 31de287345f4 ("KEYS: trusted: Rollback init_trusted() consistently=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D6
