Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68AF2BDC26
	for <linux-s390@vger.kernel.org>; Mon, 20 Oct 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944084; cv=none; b=ihq/IA7VF0nbFf415aGdlnS+6AtWlyk16fKCTapS5ZAWHHZGlzvqDKwrGhPk76Uq/kewxIctdG2J/yFyfVclx4k2qndraYDw0LkPdl3yOveQuVlLp9hCXvFK1QJdpfD5obG6Rai+EkounB5M/AwAT5QwuA/PYB2wl3xSE/Qh/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944084; c=relaxed/simple;
	bh=XZ0XrFe8i9BOKiZV0xnN18sfKKByLNmWtR6xj1Y69WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcRB1RNXaDmvIWuZi8zWTL+y8lCgHEXentyP7JWi/Ab5/r8+mJcdAXWAOdyVJ0Y/xj3MJWWxUSCyfZHfQFDb2RBqnLhokhdMaf8/2jfsa626bfmX3m0Aq0IpWkYeU98LzK5phIc9/G+6cUYBkK9Ec/mpfIgsT9hrM/SXWLdNp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw8gCN7o; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw8gCN7o"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so3559008a91.0
        for <linux-s390@vger.kernel.org>; Mon, 20 Oct 2025 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944082; x=1761548882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HOxQeFzZprgS340iSyl+E8y8vVH7kK0gqo8lCK0SDQ=;
        b=Hw8gCN7oSJIanJ7seDeSs7cT6qmeINdD81LFwTET0BnrhqCnTwdyuTHwkSupgmlXzF
         czR+WcTrS2bCbbQey5V+60iOmwQogFHRTaQxrnKnZ9CM0OxZEv7KIo7yEkGFYAN2+A+L
         kjVjGVlj9uaUXZTnZTgdCyERCDYGGXKco6j9aCDAN36GASCpUFrTDapd7b3WBwlr+nsf
         NgzGai106R88mmVazssKKDhkYXPRijbcjfYAEZj+2ZUFFooUuN2tgSPGUKg3ccl3zAWa
         vXCrnY/T1vxXn0k2Bm20BwzwgKIgT3t7snhv3wwtUsePSE/CoQfOG28+tvYHXKKDd7xD
         Sulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944082; x=1761548882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HOxQeFzZprgS340iSyl+E8y8vVH7kK0gqo8lCK0SDQ=;
        b=ASQV2GAt00tH6i+2N3WIHwoRYWiEPFYegyioWayMuidpzlqnB8KHHynVciX4+Gidwb
         HDaUYZFp5xo8hdvApvYnV20fzwyp7Db8eAmqUz/EmiYV7FJZQUbgU5q532ZuZRAtu+3p
         HViNLjt+W7xxlN+FaNITtjvdYA6USvp/cL5bfRlyZc9tPaosyrdfojgJGepkAyhHbp+A
         utYCjICyWFRCFUrygC2Zsa2KQ4AfmrjqiAR4DcdEMiFTXcgOvTKFX738cDoyUWZfs76f
         rqeWNhvctifF/nBRuJZKJU2Be9vHuzEEL9SAj9Y/oLbjFjAeoFsUUd8NN3TMcIv8JlDF
         7tdw==
X-Forwarded-Encrypted: i=1; AJvYcCVjQ1HYo3d/mzlcbUzmOfM8+LK8GPk4nLODI+d0goXhBvS2FuJfuC/0IF3LJcU9BmQTs1nHc/88oXnu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FNPrE31rX9FVxnXHNN0J32IERZtTFecTMEmkOwvHSOeUuNW5
	GSKgBa2LgDaY1rwRv6dg7BP0ZiAefve00j1Hfp73h4gUvK7wmcuEQnKnxrnVnFre
X-Gm-Gg: ASbGncuyNDRamC7LeTNt+/61DN4gukeFwkCV0Gt9yZYsIshc1Ll5awZ5+Qe03NKMUzL
	Bz6Pm9sLG8x99pmgAPz84uhUIIHDQ9RlNMAQTn7zrHXZtK8F0Adh6AY321fP/ySsJBHN9PRgcHA
	O1qsju2bDHoqCz/J/6nQ6m6SssVwmk9KrrzyPNPJ4CVKaRv9iFfzmI+5REwjknDFSbCKNnsuH67
	+KoNSm8YIrPQy+DsklM9IC3gQUNlnlmvIk8wpAkl/G4EgBgNTc37+hZd7WsBIQSGtiya0vZQGAz
	er54OY8A4yEus93BeRiVMBwjQ/Gh3/9jkKlOJouuflCAlWE6ACv3T94XXq+mr/9PH4D2c692PCl
	P3wB+a5Jzbap3pkYB7ZTWlTYUZYSNSjtD1sn74yENTb8m4OQuAOCrJ6VvzhAM5GHtnS7hWlhSb3
	mb45M=
X-Google-Smtp-Source: AGHT+IEQ5375x2wAPSKC6RY36q65Xq6o1ABPfooltKbLM5TnVL2vpALRNQnKbvej+kaD3bTB+gwZ+Q==
X-Received: by 2002:a17:90b:4b0f:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33bcf8faac8mr15518129a91.28.1760944081925;
        Mon, 20 Oct 2025 00:08:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5deae553sm7219872a91.21.2025.10.20.00.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:08:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 123104241816; Mon, 20 Oct 2025 14:07:57 +0700 (WIB)
Date: Mon, 20 Oct 2025 14:07:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH 03/17] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384,
 SHA3-512, SHAKE128, SHAKE256
Message-ID: <aPXfzd0KBNg-MjXi@archie.me>
References: <20251020005038.661542-1-ebiggers@kernel.org>
 <20251020005038.661542-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bwyeZRG0SF5QekIi"
Content-Disposition: inline
In-Reply-To: <20251020005038.661542-4-ebiggers@kernel.org>


--bwyeZRG0SF5QekIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 05:50:24PM -0700, Eric Biggers wrote:
> +The SHA-3 algorithm base, as specified in NIST FIPS-202[1], provides a n=
umber
> +of specific variants all based on the same basic algorithm (the Keccak s=
ponge
> +function and permutation).  The differences between them are: the "rate"=
 (how
> +much of the common state buffer gets updated with new data between invoc=
ations

Use reST footnotes, like:

---- >8 ----
diff --git a/Documentation/crypto/sha3.rst b/Documentation/crypto/sha3.rst
index c27da98c89b7f8..ae1fd3e01e34c2 100644
--- a/Documentation/crypto/sha3.rst
+++ b/Documentation/crypto/sha3.rst
@@ -18,7 +18,7 @@ SHA-3 Algorithm collection
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-The SHA-3 algorithm base, as specified in NIST FIPS-202[1], provides a num=
ber
+The SHA-3 algorithm base, as specified in NIST FIPS-202 [1]_, provides a n=
umber
 of specific variants all based on the same basic algorithm (the Keccak spo=
nge
 function and permutation).  The differences between them are: the "rate" (=
how
 much of the common state buffer gets updated with new data between invocat=
ions
@@ -136,7 +136,7 @@ should use the much more comprehensive KUnit test suite=
 instead.
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-[1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
+.. [1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
=20
=20
=20
> +If selectable algorithms are required then the crypto_hash API may be us=
ed
> +instead as this binds each algorithm to a specific C type.

What is crypto_hash API then? I can't find any of its documentation beside
being mentioned here.

--=20
An old man doll... just what I always wanted! - Clara

--bwyeZRG0SF5QekIi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPXfxAAKCRD2uYlJVVFO
o3A4AP9bdkVnmtIfCagfxHcW5eGHSyGy7zxDqFUTIe8b2dhvVAD+KVzQDxqnujqm
eYhwNKRJG53xvL9m37FLDKGqqZLtLw0=
=VJti
-----END PGP SIGNATURE-----

--bwyeZRG0SF5QekIi--
