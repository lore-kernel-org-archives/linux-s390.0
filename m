Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9239AD49
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320173; cv=none; b=ux+X2tUO4TsMQUr5pRsz1QMXPGUyQd08D2b+R/NpiN1GSIoVq6fluuNTZhKZ8SNdVR9Efd2IOBW4Rsf6YDbg2ypvN+yJ4mFBB/odIkbY1Y/ZsQJglrE0cuz+bk/4szFeS1HxDBAF+GG/Mx4zbraiWmNCQ90Q+E0sTULmFyFMLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320173; c=relaxed/simple;
	bh=ltqURssCEywIUL52oVipV6UX05OZdh7SOv63FVhBk4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N2wWpzpSXa3ac//vCzB8ySgdo9o1m57ae58RWi8kOvpgyxfiZDi4BiMqXK/4RdiRjB3eI/qocwjaVZhngH/v+Msyupr4Dm0tnws2+2DXz33zqVviV+YC10UWKNuCGjACEk65ZM+82okkVvcpEGLR9QmUI/JAyfQT82C3BWRILA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaduD5UG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaduD5UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4A11F00A3E;
	Wed, 29 Jul 2026 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785320172;
	bh=TeualuRpb4/pg5htohTVFHwz+MssBaIhQxXF52BwbPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaduD5UGcdbFdTCxJilQ4CUfnVjLxyojmfdU6qBNt0uOFBYFHUuDmItpC87Xorfhl
	 6U98xrm7HUTKdD1zbQS7FrnNwl/PUSuVvCUxpDAPIcWAiwNQcLHRE/k6+0STGLCO3j
	 kHXSPuFXX6E+8H4swGKJWYO9FiW85RKiVSzGSI4hyXPSUURrfmolGahXHJllXAAScn
	 SufiRrKIbXyD+PQI2RwnP0Xn01BIRguT//J5c1hPBfTDGTqWi+bPNwNlgVfHPKihKR
	 r5XzOlHKVfMSkqkH+DhywpkYE+1Zrl+ejGQBOICeCqY1qU9UPxFbBPc81pFi+R+w+C
	 AstZd4CewO98A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC private
 key requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Holger Dengler" <dengler@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729093616.4184642-3-dengler@linux.ibm.com>
References: <20260729093616.4184642-1-dengler@linux.ibm.com>
 <20260729093616.4184642-3-dengler@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 10:16:11 +0000
Message-Id: <20260729101612.0D4A11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds validation on user-provided keys leads to Slab Out-=
of-Bounds Reads.
- [High] Unvalidated token length from hardware reply causes Heap Buffer Ov=
erflow and Out-of-Bounds Read.
--

--- Patch [2]: [PATCH v1 2/2] s390/zcrypt: Validate length for CCA ECC priv=
ate key requests ---
commit dd9e9a635152d7bae8edba05dc9b9aad02d9a1e9
Author: Holger Dengler <dengler@linux.ibm.com>

s390/zcrypt: Validate length for CCA ECC private key requests

This patch adds a length validation check for CCA ECC private key requests =
in
cca_ecc2protkey(). It ensures the key token length does not exceed the
available space in the parameter block before proceeding with CPRB memory
allocation.

> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/z=
crypt_ccamisc.c
> index db6a4211a97e0..322677a8d3200 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -1428,6 +1428,9 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u=
8 *key,
>  	} __packed * prepparm;
>  	int keylen =3D ((struct eccprivkeytoken *)key)->len;
> =20
> +	if (keylen > PARMBSIZE - sizeof(struct aureqparm))
> +		return -EINVAL;
> +
>  	/* get already prepared memory for 2 cprbs with param block each */
>  	rc =3D alloc_and_prep_cprbmem(PARMBSIZE, &mem,
>  				    &preqcblk, &prepcblk, xflags);

[Severity: High]
This is a pre-existing issue, but since we are adding length validations in=
=20
this subsystem, is it possible for unprivileged users to trigger slab=20
out-of-bounds reads in other functions like cca_apqns4key(),=20
cca_verifykey(), and cca_key2protkey() in drivers/s390/crypto/pkey_cca.c?

If a user triggers an ioctl like PKEY_APQNS4K with an 8-byte buffer and set=
s=20
keylen=3D8, _copy_key_from_user() will allocate exactly 8 bytes. The code o=
nly=20
verifies that keylen is at least 8 bytes, but then casts the buffer to=20
larger structures.

In drivers/s390/crypto/pkey_cca.c:cca_apqns4key():

    if (flags & PKEY_FLAGS_MATCH_CUR_MKVP)
        ptr_cur_mkvp =3D t->mkvp;

Could this access t->mkvp well beyond the 8-byte allocation?

Similarly, in drivers/s390/crypto/pkey_cca.c:cca_key2protkey():

    if (cca_check_secaescipherkey(pkey_dbf_info,
                  3, key, 0, 1))

Does this pass the key buffer to a function that reads up to 60 bytes,=20
without verifying the key is actually large enough (since checking against=
=20
hdr->len could be bypassed if the user sets hdr->len =3D 8)?

And in drivers/s390/crypto/pkey_cca.c:cca_verifykey():

    *keybitsize =3D t->bitsize;

Does this access t->bitsize at offset 56 directly after only verifying the=
=20
8-byte header?

[Severity: High]
This is also a pre-existing issue, but I noticed there might be another spo=
t=20
in zcrypt_ccamisc.c where we trust token lengths without sufficient bounds=
=20
checking.=20

If a malfunctioning or compromised APQN crypto device returns a CPRB hardwa=
re=20
reply with a large t->len value, could this lead to an out-of-bounds read o=
r=20
heap buffer overflow?

In drivers/s390/crypto/zcrypt_ccamisc.c:_ip_cprb_helper():

    memcpy(key_token, t, t->len);

Does this trust the t->len value from the hardware response blindly,=20
potentially causing an unbounded write to the destination buffer?

Also, in drivers/s390/crypto/zcrypt_ccamisc.c:cca_gencipherkey():

    if (*keybufsize >=3D t->len)
        memcpy(keybuf, t, t->len);

Since *keybufsize is user-controlled (up to 8192) but the CPRB parameter=20
block backing t is strictly allocated to PARMBSIZE (512 bytes), could an=20
oversized t->len bypass this check? Would this cause memcpy() to read=20
beyond the 512-byte allocation and leak kernel memory back to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729093616.4184=
642-1-dengler@linux.ibm.com?part=3D2
