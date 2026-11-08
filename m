Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143782;
	b=fpykZt6Ifzbsd4thQADy6aGsE+TmGidAFdwl8gyQYI9YSIziVf+6ed30q3HTcJTbN5tk
	 tEgj80LCU8yR1Mej3XYQxnVwGczBMCAAb2Pzk/UnZCFBpn6D/IlDLCdA9OfeSF8Ym2dSD
	 o941lSHLCqmIXpuqNLFb9VV+7gdRVEEFOreoyMQPyDI/frMlx4frNL/33Nh/b8egtDJwA
	 V1OuxtYx1UVVfj6ojY0nQkXto/vInDS3EQVPUYv8zkdpOafkVcFrxvHbhTbM6cGxnYNiK
	 n/hBtFFQu2KPPRDvNs+mNvlPyrP1Yoedy2k+ryH/VA/vd6H9GgQ8/zdJXE8sUJlKK5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YTRq5fqYeacVIBi0kToxui7tcm91SiUZ6dPnT9SacLQ=;
	b=Kpz6kmDW2XAu2uMJyXazxkRcYPv08hJr3qV6twcsU2KQ8t3zC5GT6y9Y4d6OqcuNzJZA
	 C9G4UHSKdEa0gHcrnGpTOcwpkD4Fcp89V320pFYvBLKRt0DC4gMNtODZ3hCAuZ5yDQdAP
	 pc3paNlWelV+W6KkQHbp6+B9FLgSr96lwqGFMqZtbDa4LF6boAssgjA6NM93tQcsjMCtQ
	 QdEifQiMIEgBI8RmxDBfJUR8iaHfIBqBqSWRWGW9tSwIwKt6RyFjdPRKTnDHvx5Iy9PwE
	 dj1PhdiV6Lh6PnNt+bP2+D+Rc8Jywz/GImUooMmrC3aknQELZNznlb9UPxxSCIsdaDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pam355H1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E9606A31C;
	Sun,  8 Nov 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pam355H1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6258A1F0089F;
	Sun,  8 Nov 2026 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143781;
	bh=YTRq5fqYeacVIBi0kToxui7tcm91SiUZ6dPnT9SacLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pam355H1NU8ZihN3YmWMW7RkXUgvUsVpz8gNzCIpqCbKyr8vMOXXgq16paO2PGpbl
	 xi5E58IoLv6ExymcvKp1ywsS6hMmFNH21ClcOUQYtNyXhgsH4lQE19l7Fq3Q47fgYx
	 x4f6EKU4NmshTvp6fiulIpH13GbSOY1CEwj5kL8KToycPRARaM5MNyg5poQJzF856Y
	 9HI4XJcULNmePmXdDKgolipku93guPEbQ/nCkPbULFcfAibhvncegpx42f39un4D85
	 nkHxAU9vHSEUr8yPV1+ITibYpxSGRjxTxRS1yYNQ1eWNicXuT1/e/bfenYQhTwTol9
	 BTEDvArGadlbA==
Message-ID: <sashiko-outbox-203765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] KEYS: trusted: TEE: Disable sysfs bind
 attributes
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
In-Reply-To: <20261107131512.3603168-7-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] KEYS: trusted: premature register_key_type() before
  init_trusted() setup [1]
--

commit 3bd98fb38b1322342ed23c63a9f83d8e5a79dd02
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: trusted: TEE: Disable sysfs bind attributes

This commit sets suppress_bind_attrs on trusted_key_driver to prevent
userspace from unbinding the driver via sysfs and unregistering
key_type_trusted while the module is loaded.

> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/tru=
sted-keys/trusted_tee.c
> index 6e465c8bef5e5..227efb668aa95 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -263,7 +263,8 @@ static struct tee_client_driver trusted_key_driver =
=3D {
>  	.remove		=3D trusted_key_remove,
>  	.id_table	=3D trusted_key_id_table,
>  	.driver		=3D {
> -		.name		=3D DRIVER_NAME,
> +		.name			=3D DRIVER_NAME,
> +		.suppress_bind_attrs	=3D true,
>  	},
>  };

[Severity: High]
This problem wasn't introduced by this patch, but can a concurrent
add_key() syscall invoke trusted_instantiate() before the backend is fully
initialized [1]?

Each backend's ->init() callback (including trusted_key_probe() for
trusted_key_driver) calls register_key_type(&key_type_trusted) before
returning to init_trusted(), which only then populates the static calls
and backend state:

CPU0                              CPU1
init_trusted()                    sys_add_key()
  ops->init()
    register_key_type(&key_type_trusted)
                                    key_type_lookup("trusted")
                                    ...
                                      trusted_instantiate()
                                        static_call(trusted_key_unseal)()
  static_call_update(trusted_key_seal, ...)
  static_call_update(trusted_key_unseal, ...)
  static_call_update(trusted_key_get_random, ...)
  migratable =3D ...

Calling an uninitialized DEFINE_STATIC_CALL_NULL target dereferences a
NULL function pointer when CONFIG_HAVE_STATIC_CALL is disabled, or runs
__static_call_nop() and leaves the return value uninitialized when it is
enabled.  In addition, trusted_key_probe() calls register_key_type()
before setting pvt_data.dev, and if TEE probing is deferred until after
init_trusted() returns, the static_call_update() calls in init_trusted()
never run at all.

[1] https://sashiko.dev/#/bug/linux-384065c3-cac2-4397-8b30-74edea3d1ff3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D6
