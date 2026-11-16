Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851600;
	b=DPgODgUWZFQpqYx46LEXCdSE9CXiA/ksW3imW8hiiiGbO54h+2GiAxVWvsWy61BU4J8P
	 4Uoj6qTQI2MpCYXRKEpLnTnOqV6fenbfbrwzWJrYACtouyRWUaBwlGyF6YeJlyM5TnMkW
	 H6lS9BnbvQYsFkIBU0oNESKKbwJ3vmc99U33yrvWiX7A27eLVFTEF5wv0L1euerwNUxTA
	 Iqwq/mbLi/iHg9wWeagIF/0JT8L5hSglFe3ifkzvagG1pagOb0DL0EUsdOuShAikgE5E6
	 /3gD7bxxq72LvwdQTe8+Hp+cVVzACZvA00T4XSnEPdNMPMyorC/1BtFsESc4Qz2moqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851600;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vrpw/DwYr9x6YCQgCT8gDYZ5zobFrCiWofs8G/J8CxY=;
	b=M6uNc8KMErkqRp+u2seOdqmcL/zGBvFJzO4Xh+vCiPyfbhFKHJv/YXrsXxIaHcVi83PI
	 Cv5T0dSPoVAWbLwgxPKVc+YRIeoiPkruCvZ3O+egMOvsu+sQFpSiKs+KIBK7V+NiJ4iy2
	 dojs2vaAE3qjlQmS28k7cpL58Y5og9o5kXSl+2nS2C0tLGCws7Gx+ZH1wpwBlvMn0x9KR
	 jHUJYbPO+B3RS1aoFzu++GIZeTnnjN/IU+/U7R3SM/9CddF58GNgEKwX1w0gBZiyPWD9L
	 ftxmjZrT+380/ikYCbLYd0NrjnFb5QZYP48ZcrMlc0Yt984gYE3QdYcQ0xkMJOyzuYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnJJbGhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F062606A891;
	Mon, 16 Nov 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnJJbGhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465421F000C4;
	Mon, 16 Nov 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851599;
	bh=Vrpw/DwYr9x6YCQgCT8gDYZ5zobFrCiWofs8G/J8CxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnJJbGhcF9kDfjOx8V3czcEQn2aPD155SUhlG+Xpsl7jLy8tVpd9pBNqiPLKrqs8W
	 6Nf8ORL9XLRwH5zlb2otKpohbHw50zAQ1dUdzhVzShYfPG/mHIj3LtTF9QIGRd+ThT
	 BG3LeX8iY1Pglf/pmpNY2SsZZuKu4k8cw32vx4MEwjwOqfY2Wrep132MbpEedKGuNB
	 602z5a7eg3lLnMQkzNzH6noGcnu4E12lqPAXnzYbr53ZgJiJqU0LS1zPPvcjnC8ycx
	 +UIcs6tLXYg5/wD+R8MNI0XKIV0sxRPi1LztZFfDBsssMGbzXkdPcCsra+3hcFPH0P
	 AUsgR//juFMaA==
Message-ID: <sashiko-outbox-217454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] s390/cert_store: Unlink before invalidate in
 invalidate_keyring_keys()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Anastasia
 Eskova" <anastasia.eskova@ibm.com>
Cc: "Sven Schnelle" <svens@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, keyrings@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20261116143534.158375-6-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:53:18 +0000
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
- [Critical] s390/cert_store: key reference count underflow and
  use-after-free in fill_cs_keyring() [1]
--

commit fbd12b78eb8c69fc439e6febd3b649bd06084a33
Author: Heiko Carstens <hca@linux.ibm.com>

s390/cert_store: Unlink before invalidate in invalidate_keyring_keys()

This commit reorders key_unlink() before key_invalidate() in
invalidate_keyring_keys() so that the key garbage collector cannot unlink
the key first and cause key_unlink() to fail.

> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 8eb32497ca24d..a69eccf6affd3 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
> @@ -346,10 +346,10 @@ static int invalidate_keyring_keys(struct key *keyr=
ing)
>  			continue;
>  		pr_dbf_msg("Invalidating key %08x", current_key->serial);
> =20
> -		key_invalidate(current_key);
>  		rc =3D key_unlink(keyring, current_key);
>  		if (rc)
>  			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
> +		key_invalidate(current_key);
>  		key_put(current_key);
>  		if (rc)
>  			break;

[Severity: Critical]
This problem wasn't introduced by this patch, but can cleanup_cs_keys()
and fill_cs_keyring() underflow cs_keyring->usage and cause a
use-after-free [1]?

In create_cs_keyring(), keyring_alloc() links cs_keyring into the user
session keyring, starting cs_keyring->usage at 2 (one allocation reference
and one link reference).  However, find_cs_keyring() drops its lookup
reference before returning the raw pointer, and cleanup_cs_keys() drops
another reference before unlinking cs_keyring:

arch/s390/kernel/cert_store.c:find_cs_keyring() {
	...
	if (!IS_ERR(cs_keyring_ref)) {
		cs_keyring =3D key_ref_to_ptr(cs_keyring_ref);
		key_ref_put(cs_keyring_ref);
		goto found;
	}
	...
	key_put(cs_keyring);
found:
	return cs_keyring;
}

arch/s390/kernel/cert_store.c:cleanup_cs_keys() {
	...
	cs_keyring =3D find_cs_keyring();
	if (!cs_keyring)
		return;
	...
	key_put(cs_keyring);
	key_unlink(get_user_session_keyring(), cs_keyring);
}

arch/s390/kernel/cert_store.c:fill_cs_keyring() {
	...
	rc =3D add_certificates_to_keyring(vcssb, cs_keyring);
	if (rc)
		goto cleanup_cs_keyring;

	goto out;

cleanup_cs_keyring:
	key_put(cs_keyring);
cleanup_keys:
	cleanup_cs_keys();
}

When add_certificates_to_keyring() fails in fill_cs_keyring(), the
cleanup_cs_keyring label drops cs_keyring->usage from 2 to 1 and falls
through to cleanup_cs_keys().  There, find_cs_keyring() returns cs_keyring
without holding a lookup reference, key_put(cs_keyring) drops the
remaining reference from 1 to 0 (scheduling the keyring for garbage
collection), and key_unlink() then accesses the zero-refcount key and
drops the link reference an extra time.  The same extra key_put() happens
when create_cs_keyring() calls cleanup_cs_keys() to purge an existing
keyring whose initial allocation reference was already dropped.

[1] https://sashiko.dev/#/bug/linux-6c517b55-b772-4ca6-8a47-30730e6a9177

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D5
