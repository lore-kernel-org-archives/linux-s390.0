Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4E466B04
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296555; cv=none; b=ETe1T0yMaTGJNVrRPxLTvBKRxdzXJw/gn7kcHd4BJ3eDHa+2TFOarz+PLlMzrJH0XJecK3U4rP1OLJ/FgdrfrhMwnHkSwIl0djdYjaqSxPKLz4Opdtwdw8hoO4o0crBpp5GpjJh8XI38Lqsg845uHkDiUUh+2FcaWBcbAxUUAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296555; c=relaxed/simple;
	bh=wS3svgPEdmwwYYZjWRK1geq2V72wStvZI4c9CUw9280=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYiMe/PW5YCAtOHK+VHV3IQu6E1MlHjYSEcwvIGrxCrZFDTOSHVcKF1OoQa+Yje+mWIqMdbz7SVESLD1nIAjpEbfRY+4tbGk10c57/r5+kB4uTIj9Z7tQ0aWHtRyofIVKu64EvQpwabyRmiv8OzUeS89MRlVRMHS6nvYwU3Dq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnPerWLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnPerWLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538C31F00893;
	Tue,  6 Oct 2026 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296553;
	bh=+4Bl7pL48szw7qRwzS9OMxJdmL86pVdvG9wzx2/XGc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnPerWLLEXDgqgutoNSdf7wyREYfrDc3wgwWE5U3h20O8xTb/5M5oIWRNG5jHDRit
	 MmoZ1z8HnVO0Mkb2bNY0xM7iWAWTuQQeu8pbRHik/4qpMt7ZvY+NIJJF/jRq4nM9S/
	 3bHxNbJs0mMn+W9xa2nQyG7b4Q639Fxzh7mzk28AaRWnaaOG2t7poWaVxvfp8Sn3pg
	 aA5Fe+9wqsksIuEVo2O2VjvTHEy0/ThrLPnPhBsJFUmQGx+weUo7W5CkBjbz9uL+29
	 fiaFj9TMinEA85170RbRiH+di120OycOrWR2Rb2jVm+QXuOzZXiNde0Si4C8EnV8C5
	 E7lR1hJNF/lZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in
 cca_query_crypto_facility()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261006141245.7558-3-freude@linux.ibm.com>
References: <20261006141245.7558-1-freude@linux.ibm.com>
 <20261006141245.7558-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 14:22:32 +0000
Message-Id: <20261006142233.538C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] crypto: zcrypt: OOB read and underflow in cca_query_crypto_facilit=
y()
--

commit 5de45449fe732b12f3310f3ce76a2abecc04ed97
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()

The FQ reply parser code blindly advanced the walk pointer by a length
value read directly from the hardware reply payload without checking
that the advance stayed within the allocated reply buffer.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index 19909bf43dc91..862947431164f 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[ ... ]
> @@ -1673,27 +1674,44 @@ int cca_query_crypto_facility(u16 cardnr, u16 dom=
ain,
>  	prepcblk->rpl_parmb =3D (u8 __user *)ptr;
>  	prepparm =3D (struct fqrepparm *)ptr;
>  	ptr =3D prepparm->lvdata;
> +	datalen =3D parmbsize - 2 * sizeof(u8);
> =20
>  	/* check and possibly copy reply rule array */
>  	len =3D *((u16 *)ptr);
> +	if (len > datalen) {
> +		ZCRYPT_DBF_ERR("%s reply rule array len %u exceeds datalen %zu\n",
> +			       __func__, len, datalen);
> +		rc =3D -EIO;
> +		goto out;
> +	}
> +	datalen -=3D sizeof(u16);
> +	ptr +=3D sizeof(u16);
>  	if (len > sizeof(u16)) {
> -		ptr +=3D sizeof(u16);
>  		len -=3D sizeof(u16);
>  		if (rarray && rarraylen && *rarraylen > 0) {
>  			*rarraylen =3D (len > *rarraylen ? *rarraylen : len);
>  			memcpy(rarray, ptr, *rarraylen);
>  		}
> +		datalen -=3D len;
>  		ptr +=3D len;
>  	}
>  	/* check and possible copy reply var array */
>  	len =3D *((u16 *)ptr);

[Severity: High]
Does this code introduce an out-of-bounds read and subsequent integer
underflow?

If a corrupt or malicious device response sets the first array length (len)=
 to
exactly or almost exactly the remaining reply buffer space (datalen), the
first array parsing will advance ptr to the end of the buffer and reduce
datalen to 0 or 1.

When we reach the second array parsing here, a 16-bit length field is
unconditionally read from ptr before checking if there are at least 2 bytes
remaining in the buffer (datalen >=3D sizeof(u16)). This could read 2 bytes=
 past
the end of the allocated buffer.

> +	if (len > datalen) {
> +		ZCRYPT_DBF_ERR("%s reply var array len %u exceeds datalen %zu\n",
> +			       __func__, len, datalen);
> +		rc =3D -EIO;
> +		goto out;
> +	}
> +	datalen -=3D sizeof(u16);

[Severity: High]
If the out-of-bounds read above results in a value smaller than or equal to
datalen (e.g., 0), the check (len > datalen) is bypassed, and the subtracti=
on
here will blindly consume 2 bytes. This would cause an integer underflow if
datalen was 0 or 1, wrapping the tracking variable to a huge value.

> +	ptr +=3D sizeof(u16);
>  	if (len > sizeof(u16)) {
> -		ptr +=3D sizeof(u16);
>  		len -=3D sizeof(u16);
>  		if (varray && varraylen && *varraylen > 0) {
>  			*varraylen =3D (len > *varraylen ? *varraylen : len);
>  			memcpy(varray, ptr, *varraylen);
>  		}
> +		datalen -=3D len;
>  		ptr +=3D len;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006141245.7558=
-1-freude@linux.ibm.com?part=3D2
