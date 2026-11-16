Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851719;
	b=pQmmvTDhwV751lejChQtRBhE2rq3q64Srv+b3UdxpEp1FuQizcMACMO1F1uYZT8BNiM7
	 08zv5PALycsemYmqVounuH5j277LvGh/U00H1RD4zVSgH7b3VyAOKZA+CXga8i7atuysn
	 JB2ukmRwZsqLw13ZC7cWUp27cVd0VEeZqZn/dsCgVVv9fa+pim22QG/lihCytYzedQeDK
	 RAp+q0XbB0E1foHE42sVQT3PY6rVsaq2h8tplkp6kfwmesMM8rdKfznEBfmfcsyUEYdLU
	 VskWdRpIBSZYIL6/a22ciQvCyHTwMktKC7aTngIUATou5IEQHLlaUktwVuQwGMm/avg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851719;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E9WiqVTsHYyO82owqIeFl1E3Hx54jB7Uqk6hwRVxVYE=;
	b=cRZCYv5+gNvc3TkLdJmSC3lEgjOcfGQwc5jvWG3GQwhw0gEpde79mStkitB2Dr9Ox93o
	 hI3tKm7y5ILyOTGsrn6ANK6r1760S0rX5nOVNsQYoUG61dGp02OPjTATuQFu3nuQgaNHZ
	 MWAX/jYphitbO+K92ii0uvZA1qWErBqUNZAVuawgtpqWJPr5TynZjYFahIGgaXhHk4lLP
	 DHGCdiB/gRwL19SdD0jV3TKVK03nN96j/4URBZpNmZV8fdOKCDxLuKIh3HY7Jx9kUDNzQ
	 ER2Wkqx3nQnhizjsVQ3ct96oSRttRgIUMdTlEUYkh6ml/gzTb51UZ2DskM+8Wag0kcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0wjrA5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E88606A33B;
	Mon, 16 Nov 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0wjrA5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B353C1F000C9;
	Mon, 16 Nov 2026 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851718;
	bh=E9WiqVTsHYyO82owqIeFl1E3Hx54jB7Uqk6hwRVxVYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0wjrA5yq/+4ZUtKvOH91rRmZechP5/SEm1J4yeVIrd3bX5E0lHEKdhMfj/d0f5D8
	 wLomE07mgBMb7e2cuu2+d7ychzgX5grKnrKS7EyPYS63lDEFP3IGu4xRc7F/FQXGK/
	 RKdgLENWsjJvCCaexIgPjvfFksio1au7ckvteYVeztoJ8qoWo8YrOD0gd16XZPpdrw
	 9bnKTQc6sNAaquUHBiXvTChfYe2l9QXJWb06U+Ri9JM4oAOO77Gab4NeSOvYGtlArh
	 PRRxs93F3e65ZxzMVO84F9tU5+nMv+FTYcz1Sc2vZV9LCzzV29K8jguSp9OQqabdyj
	 sDoLhs6B4isEA==
Message-ID: <sashiko-outbox-217458@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] s390/cert_store: Fix return code handling in
 invalidate_keyring_keys()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Anastasia
 Eskova" <anastasia.eskova@ibm.com>
Cc: "Sven Schnelle" <svens@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, keyrings@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20261116143534.158375-3-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:55:17 +0000
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
- [Critical] s390/cert_store: unchecked key_lookup() and UAF in
  invalidate_keyring_keys() [1]
--

commit ad52ff18526194809b9921405599d976809c02b9
Author: Heiko Carstens <hca@linux.ibm.com>

s390/cert_store: Fix return code handling in invalidate_keyring_keys()

This commit adds error handling to invalidate_keyring_keys() when
key_type_keyring.read() returns an error or a short read.

> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index d35b1ea22507d..89cc3a1683a32 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
[ ... ]
> @@ -345,7 +347,7 @@ static int invalidate_keyring_keys(struct key *keyrin=
g)
>  		key_put(current_key);
>  		rc =3D key_unlink(keyring, current_key);
>  		if (rc) {
> -			pr_dbf_msg("Couldn't unlink key %08x: %d", current_key->serial, rc);
> +			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
>  			break;
>  		}
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can current_key in this l=
oop
[1] be an error pointer or be used after free?

keyring->sem is released after reading key_array, without holding references
to the keys.  If a concurrent keyctl operation unlinks a key and garbage
collection frees it before key_lookup(key_array[key_index]) runs, key_looku=
p()
returns ERR_PTR(-ENOKEY), and dereferencing current_key->serial or passing
current_key to key_invalidate() crashes.

In addition, when key_lookup() succeeds, calling key_put(current_key) before
key_unlink(keyring, current_key) and the current_key->serial debug print dr=
ops
the caller's reference early, which allows a concurrent unlink and garbage
collection to free current_key and cause a use-after-free.

[1] https://sashiko.dev/#/bug/linux-3ea8bbf3-6016-4165-bad4-2a5916ce887e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D2
