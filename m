Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143787;
	b=TmOFrWWs+1rUGVWNVsvBpU9NCXhLKvWYLxJxB1WQAISfNwcsScdxxDLnNCHFm5V4Epq6
	 U9JkI8DuW77o1axdim9LMObdv5Ql/SRfTci7FNitHB1CicFUZUiuKq5Ii9fdLXJ43DKiV
	 XXBJwhqep1LMznzHzM8V1VIAvu1rhWCS65X9mOWy+q7CMrxMV1Vs/rAfZoaf6lG00vuTP
	 5UblCZrbJwalDPGRBDyH7v3HCQCZtEJsAnY0I6ZAm+nDHrs/cGI14aNuuEXK2LFH4/Lae
	 LBUEDzoqnBUBqVw79wuRINC70Y7M7HsMeaPwIz8wb5+NDwdFFCIurapea32bd9sWzaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v1GzT4Jwv27YBmtTQ/6R06I4yHOVV17RiLfotxX0g3Q=;
	b=uGpNl0oCk3UnVYrdn7RJ/f3RZTuGS1b8FOKLMuGrzEKsx4G650T97tI1qib61VsjUkpM
	 K7sOaDoMGFrgM4wFEC0ESVBqSQWcYzacgIhh4XxDRK4BAJR3+S1R+vJXz4C9DJds5P0Xn
	 THaTuk91gT88ryBn9EL90bN/E2jSXpk5pJCQLTyVRv7ZIg+ogyqpNgRnsoC1h4Tqbeahm
	 nCnhx31sUoAgMdfgX4ZGsxSEJzd8u6XxViJGMw4mBbw7GUcCglQld2XpBB2J2Au38mHhY
	 pkEi6ZNNkbgKWUi3MAOsByjuCGt+hOrCbH9kgbPEv2IckS/szeqlQ7jb4l19BgXu3Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyQXwssZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C55606A322;
	Sun,  8 Nov 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AyQXwssZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9635C1F008A4;
	Sun,  8 Nov 2026 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143786;
	bh=v1GzT4Jwv27YBmtTQ/6R06I4yHOVV17RiLfotxX0g3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyQXwssZhAzvryQ9jTUVd+TlrywvhNcT5oSRt29xJTbssQtMtHwywYHq4mpNezELA
	 oZDFYunezpPQeYlVn6yBKBU8wG5gbQ/R0Qma2pglquRERzAe/bz3gRIJWxGYG21io5
	 QvC9DaU8QUGboWTgzVJbu8rbmrCF4lrq5iErfyZA+rJA/2lp4Fnh4m0aETOQyrrlgd
	 9wLa8kt992gNUZkQJm7QpOgZBCWUVMLVPSXhtcmRtfV5Ee9AXlSn8HkDJpeXhIUdF0
	 zkbGkDNk1fgfU/t9mJ3ooLr4YHRQE3y3DOHzNGT0tAV03YMjyXP06Td271UIycMjJH
	 IhmQAg+7h3BuQ==
Message-ID: <sashiko-outbox-203769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/11] KEYS: Remove key_type_dead
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
In-Reply-To: <20261107131512.3603168-11-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:25 +0000
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
- [Medium] keys: broken garbage collection timer calculation in
  key_garbage_collector() [1]
--

commit 685cce051d4099c4b86015bc6b82bcd593f0652f
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Remove key_type_dead

This commit removes key_type_dead and its three-phase keytype reaping logic
from the key garbage collector and unregister_key_type().

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 7b2f32998f58b..859f331549cef 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c

[ ... ]

> @@ -246,18 +192,6 @@ static void key_garbage_collector(struct work_struct=
 *work)
>  			goto found_unreferenced_key;
>  		}
> =20
> -		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
> -			if (key->type =3D=3D key_gc_dead_keytype) {
> -				gc_state |=3D KEY_GC_FOUND_DEAD_KEY;
> -				set_bit(KEY_FLAG_DEAD, &key->flags);
> -				key->perm =3D 0;
> -				goto skip_dead_key;
> -			} else if (key->type =3D=3D &key_type_keyring &&
> -				   key->restrict_link) {
> -				goto found_restricted_keyring;
> -			}
> -		}
> -
>  		expiry =3D key->expiry;
>  		if (expiry !=3D TIME64_MAX) {
>  			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))

[Severity: Medium]
This problem wasn't introduced by this patch, but does the timer calculation
in key_garbage_collector() mix delay-adjusted and unadjusted expiration
timestamps [1]?

security/keys/gc.c:key_garbage_collector() {
	...
		expiry =3D key->expiry;
		if (expiry !=3D TIME64_MAX) {
			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
				expiry +=3D key_gc_delay;
			if (expiry > limit && expiry < new_timer) {
				kdebug("will expire %x in %lld",
				       key_serial(key), key->expiry - limit);
				new_timer =3D key->expiry;
			}
		}
	...
	if (new_timer !=3D TIME64_MAX) {
		new_timer +=3D key_gc_delay;
		key_schedule_gc(new_timer);
	}
}

When KEY_TYPE_INSTANT_REAP is not set, expiry has key_gc_delay added before
it is compared against new_timer, but new_timer is then assigned the
unadjusted key->expiry.  Subsequent keys whose adjusted expiry falls at or
after a previously recorded unadjusted key->expiry fail the
expiry < new_timer check even when their actual reap time is earlier.  After
the tree scan finishes, key_gc_delay is also added unconditionally to
new_timer even if new_timer came from a key with KEY_TYPE_INSTANT_REAP set,
delaying background reaping of expired keys and dead keyring links by up to
key_gc_delay.

[1] https://sashiko.dev/#/bug/linux-327c9a06-109f-4001-9a3e-a6092c989462

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D10
