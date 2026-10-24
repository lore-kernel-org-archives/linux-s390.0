Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792853907;
	b=Qr6oOGxP5fk+4WxgccN5ymLCtZpFn+RsBBgx1SI+AH3gL7oVJ1PQc+AmD4pEaUF0M4nG
	 lvKhr083i6Jl4ePgQiGhDag0LZ6BtYiAwsNmOSc6FvsdW1J26vBslA6LEURi29lwrHbNT
	 rlAvPjxeH3pEX8ioKU3se1OsnnyqTHEUu7Dg5NKWtvHnMR+eqjmOEPOnyaV+4YtKHlrJy
	 7SI3AhdkuAXVrsz0FOTpB8j6rhkQBSxTbyPWwxZqKafnmunPi3axzujBtRaUV3emj7yUG
	 OrMvL0Y1AdqEAyGfWmtsS4K3ylHB01CwDXCpAoIWDCvCMZaVf+shkazV5e1JZsPdTuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792853907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AYcILXQ7RPLQI1qdgQA4MeQelQzROOHiZpi/N/RijCc=;
	b=c3btNvdKnV941JDWI/Iy3J56mZ+fjTXUWx/llCghPCKzu5Clqy79ZxwivGujHgYa/LWQ
	 mCazogrHRY5pwxNC0a1Ex8rIwBE9Uy5fYlT+/bnZc94jcNn1CrVnWlSE7y415GwBUiLvX
	 +OgOW66vfe2FEdVL23PhwBuqqrW1DebFGTWPM2RRAEk1FvIFJMvQcgkhOlB8GqjqfVSmk
	 9B01U3l338w5wnRhOz028rvMIeV0QTvC5BCG/QgmvKfvk2KMaH9CjEML3DfpGP4vXVGB9
	 vvT67boeFroKf+yDIWk5yWj4pa3MoUAtbAiyVmX9y8G1nWobl91R4i4b4hRgl69GGfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD9B2Fy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE6606A31A;
	Sat, 24 Oct 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PD9B2Fy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C812F1F01825;
	Sat, 24 Oct 2026 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792853906;
	bh=AYcILXQ7RPLQI1qdgQA4MeQelQzROOHiZpi/N/RijCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PD9B2Fy+3Vp43f4PV6SmKs5gJHuJpUokYmJQJNl5ntzCxWcgWuKZy22TbjVPkBztP
	 ukRRsj/+Q4KTULnTcMLXll9r6JhZnMu3+OtLn1MmZn43gmvQUoY4CiE0bU/eWiCtHS
	 aA7HwTv1NAFh0888B8jXJTswKcPrgzffaKOMgkjvIiHHoKFUL5oKuMHrfGVa6PpLfd
	 OTKibmBMpjvUwxEWgT2u6HkTAajchxo8PJPMCTO5RMMP1FSpNg1SCNmZIDrw0ZcjXT
	 tggZwm603hQthbX21axmPV+XQ/WbN3N5v8X9qfT494K/rA9fm3UkPtDlrS8uVfUi+S
	 rwC9sVOr2Qaqw==
Message-ID: <sashiko-outbox-183758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/cert_store: Hold the keyring->sem while
 invalidating keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "David Howells" <dhowells@redhat.com>, keyrings@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Kees
 Cook" <kees@kernel.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Anastasia
 Eskova" <anastasia.eskova@ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261024144229.1546151-1-jarkko@kernel.org>
References: <20261024144229.1546151-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 14:58:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] s390/cert_store: scoped_guard() mixed with goto in invalidate_keyri=
ng_keys()
--

commit e2f24110a6a571c7bef25566a83aee22fb61ad5a
Author: Jarkko Sakkinen <jarkko@kernel.org>

s390/cert_store: Hold the keyring->sem while invalidating keys

This commit acquires keyring->sem for reading via scoped_guard() in
invalidate_keyring_keys() while querying the keyring payload length and
reading the key serial numbers.

> diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
> index 998f2da561750..d35b1ea22507d 100644
> --- a/arch/s390/kernel/cert_store.c
> +++ b/arch/s390/kernel/cert_store.c
[ ... ]
> @@ -320,13 +321,17 @@ static int invalidate_keyring_keys(struct key *keyr=
ing)
>  	struct key *current_key;
>  	int rc;
> =20
> -	keyring_payload_len =3D key_type_keyring.read(keyring, NULL, 0);
> -	num_keys =3D keyring_payload_len / sizeof(key_serial_t);
> -	key_array =3D kzalloc_objs(key_serial_t, num_keys);
> -	if (!key_array)
> -		return -ENOMEM;
> +	scoped_guard(rwsem_read, &keyring->sem) {
> +		keyring_payload_len =3D key_type_keyring.read(keyring, NULL, 0);
> +		num_keys =3D keyring_payload_len / sizeof(key_serial_t);
> +
> +		key_array =3D kzalloc_objs(key_serial_t, num_keys);
> +		if (!key_array)
> +			return -ENOMEM;
> +
> +		rc =3D key_type_keyring.read(keyring, (char *)key_array, keyring_paylo=
ad_len);
> +	}
> =20
> -	rc =3D key_type_keyring.read(keyring, (char *)key_array, keyring_payloa=
d_len);
>  	if (rc !=3D keyring_payload_len) {
>  		pr_dbf_msg("Couldn't read keyring payload");
>  		goto out;

[Severity: Low]
In invalidate_keyring_keys() in arch/s390/kernel/cert_store.c, this patch
introduces scoped_guard(rwsem_read, &keyring->sem) while the function still
uses goto out to free key_array when key_type_keyring.read() returns a leng=
th
mismatch:

	if (rc !=3D keyring_payload_len) {
		pr_dbf_msg("Couldn't read keyring payload");
		goto out;
	}
	...
out:
	kfree(key_array);
	return rc;

include/linux/cleanup.h notes that goto-based cleanup and scope-based clean=
up
helpers should not be mixed within the same function. Could key_array also =
be
declared with __free(kfree) =3D NULL so the out label and goto can be dropp=
ed,
or should explicit down_read() and up_read() calls be used instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024144229.1546=
151-1-jarkko@kernel.org?part=3D1
