Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593F4570C5
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323781; cv=none; b=onWNeXhacF/0Dogev3p2+iLUchfgQBD0/rLkHMa1G2JMdAkRsCfZ3mWlrQAA12UUwAuOMoj0xEkkKIK0HXiEm95ryEyzJrjXhsbwEBjM7XYsJgu3umRisdbTL7Wj7ZK18hQCZMULKvFaKJ0iLEqR18WjO7aQEryhL14hT7lMD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323781; c=relaxed/simple;
	bh=IoXWFTRKmM2CrNQ8Vg3JhQIBVF290JCobg5x5QXPiWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GMJoHZ/kwUu+We9J9mpC4gzIBQ0rgvDy+rjjaXhdT9m1L5Sc2zrKLyDzz4mJdeUkGIPwRYw/1kJuc3aohgJrbAf/HsHy2aP/snE/Tc9HRhHIVDWjNzUkTncmLDFO3/OVXmcQ6Nbr5ecU6vKtgwjZUHnqXElLc09acSPKtfbMrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWWQGAj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWWQGAj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF31B1F000E9;
	Wed, 29 Jul 2026 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785323779;
	bh=bZLE/e6q1bWej0lcs21dk2BjyQ+O9n6nlE+M4rqQuns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oWWQGAj1OjG+aRvt551IDjkv5oAaghlCMhkxTc/DKZQMrAvQ2Ev7uoIw6AA7e8Hnz
	 1pOjWyQJpAXulbdl+gH9gUT8wJm9882e3YFrieCYxYWsRF88UKnneP9NWFgYDsGvmX
	 O+0d3yPMwC4TuC3aUI8ta48pGjxUgSnXAq8dtC23nec7MlqkiGioX9XsRnMKcgj/0x
	 hClVa/JgjQ8u7K6zrj0kLtc76g7PKY+fKlDEH2xTJ2D4Bh8FApatf/cG2NsqmynYLg
	 kkWegm2HB0T3Rw2vYpAle3fO5mMbvF/nEFTSkKy93RRHfOFsjpfdA37YDXQ8Td07jS
	 b0gMYURGzB99g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] s390/zcrypt: Pad trailing CCA or EP11 message
 with zeros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729095318.184141-6-freude@linux.ibm.com>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:16:18 +0000
Message-Id: <20260729111618.DF31B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `offset1` and `count1` in `zcrypt_msgtype6=
_receive` when `count2` is present, leading to an arbitrary kernel memory d=
isclosure to userspace.
--

--- Patch [5]: [PATCH v7 5/5] s390/zcrypt: Pad trailing CCA or EP11 message=
 with zeros ---
commit d39d55b2525dc84382b638f22d1bbcec3350871f
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Pad trailing CCA or EP11 message with zeros

This commit pads the gap between the user space copied message and the
message buffer length with zeros. This prevents up to 3 bytes of
uninitialized kernel memory from being exposed to the crypto card firmware.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> index 59e182d1bddf9..0269c92a84bd4 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while looking at this file, does this code
in zcrypt_msgtype6_receive() lack a bounds check for offset1 and count1 when
count2 is present?

drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_receive() {
    ...
			if (t86r->fmt2.count2)
				len =3D t86r->fmt2.offset2 + t86r->fmt2.count2;
			else
				len =3D t86r->fmt2.offset1 + t86r->fmt2.count1;
			if (len > reply->bufsize || len > msg->bufsize ||
			    len !=3D reply->len) {
    ...
}

If a faulty or compromised crypto card firmware returns a response where
count2 !=3D 0 but offset1 + count1 is maliciously large, len is calculated
entirely from offset2 + count2. This skips bounds checking for offset1 +
count1 against the buffer bounds.

Later, in convert_type86_xcrb(), the unvalidated offset1 and count1 are used
to copy kernel memory to userspace:

drivers/s390/crypto/zcrypt_msgtype6.c:convert_type86_xcrb() {
    ...
	if (z_copy_to_user(userspace, xcrb->reply_control_blk_addr,
			   data + msg->fmt2.offset1, msg->fmt2.count1))
		return -EFAULT;
    ...
}

Could this lead to an out-of-bounds read that leaks uninitialized slab
memory or unrelated kernel memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729095318.1841=
41-1-freude@linux.ibm.com?part=3D5
