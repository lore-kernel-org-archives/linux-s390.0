Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ACF41DDF0
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830119; cv=none; b=HBI99qF6LTsUp9ps5G8XAKfKzqLBJZSI/y6p0ZYpMOEfrnnEg5ukiIUczmvK5gnc1A07ziVFsh2pRTfVQg4VdkQO2ELGwvqWEIqMkV/NugUnEjoA5AABn0Nwk26x+E2dj2bKIT4G/W8LRCAUqp0KNglmwmAFRtBas7Gu379k7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830119; c=relaxed/simple;
	bh=d+Knu9YHhbgoA7Dwog6LHFWcOtee3L0hMMbxcfRoTbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQtTJFa0PMIqITjCaofeb5SOiXPU0U6j6xO0R+WMcp7+IGusKx7WVCjVixDBA/tdrpfUdqWDve1dcohZBxyrTNrToMPI+N6RmiVGvxttv/bNpjtTS/M3hgcG791ygoqNjT6qVfN91oRnMxt4LEF+Ic97jKy7mDFFU9BATGrxiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzPqxEcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzPqxEcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3261F000E9;
	Tue,  4 Aug 2026 07:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785830117;
	bh=51uTXQDMgszzZSxI3Hix4hlSYQ3Le4YG+pVwbRwLz+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzPqxEcClFMVLC9AjT6gGLPjxjera/qq+Up0GWw9QQ1Ys5G+3IEq7mf56cNNlPjye
	 F6QwN+lTK8efz8C67PmbZkMVp4cFvY9pQZGvS4SiaEMqX5pxUkbNVmjVYY2iphEruI
	 EbD90/ByfpP2hpg2JtoylxJgRzSiXpovWJz11TJiPHwS/reNV5y+tckDlOKJ8mVB9Z
	 KaM6R5G2di6i+VkJg0V/s1SNibhM4YWqHgIwC57HSrNP3JZ0E2e0vTpuMhWXVbCXma
	 nX17hxGCHXapz7t/c9Ap9kUWN/aFMrgdIRGrnXSj0FxO6G3NJvG3mJRjK1qwpDN6OF
	 +v2wdlZp04Xxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] s390/sclp_ocf: Fix computation of length of GDS
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260804074511.236153-2-egorenar@linux.ibm.com>
References: <20260804074511.236153-1-egorenar@linux.ibm.com>
 <20260804074511.236153-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:55:17 +0000
Message-Id: <20260804075517.9F3261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Integer underflow when computing GDS subvector payload length lead=
s to an 8-byte out-of-bounds read.

Pre-existing issues:
- [High] Parsing GDS vectors and subvectors without checking for zero lengt=
h leads to an infinite loop.
- [High] Missing struct size and buffer bounds checking in GDS parsing loop=
s allows out-of-bounds memory reads.
--

--- Patch [1]: [PATCH v2 1/2] s390/sclp_ocf: Fix computation of length of G=
DS values ---
commit 89f746e9734f7be9cdc7f0e26a7a861dc8653aae
Author: Alexander Egorenkov <egorenar@linux.ibm.com>

s390/sclp_ocf: Fix computation of length of GDS values
   =20
This commit attempts to fix a potential invalid read memory access while
extracting the HMC network and the CPC name from event buffers sent by OCF.
It subtracts the GDS header size from the total length to calculate the exa=
ct
size of the GDS value.

> diff --git a/drivers/s390/char/sclp_ocf.c b/drivers/s390/char/sclp_ocf.c
> index 35f3a4a08b123..cee4bfa4a48aa 100644
> --- a/drivers/s390/char/sclp_ocf.c
> +++ b/drivers/s390/char/sclp_ocf.c
> @@ -66,13 +66,13 @@ static void sclp_ocf_handler(struct evbuf_header *evb=
uf)
>  	/* Copy network name and cpc name. */
>  	spin_lock(&sclp_ocf_lock);
>  	if (netid) {
> -		size =3D min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length);
> +		size =3D min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length - sizeof(*=
netid));

[Severity: High]
Does this subtraction safely handle small length values?

If the hardware provides a malformed SCLP event buffer where netid->length =
is
0 or 1, subtracting sizeof(*netid) (which is 2) will underflow. Since the c=
ast
to size_t makes the result unsigned, this underflows to a large positive va=
lue
like SIZE_MAX.

The min() function will then evaluate to OCF_LENGTH_HMC_NETWORK (8), leading
memcpy() to read out-of-bounds bytes from the event buffer.

>  		memcpy(hmc_network, netid + 1, size);
>  		EBCASC(hmc_network, size);
>  		hmc_network[size] =3D 0;
>  	}
>  	if (cpc) {
> -		size =3D min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length);
> +		size =3D min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length - sizeof(*cpc));

[Severity: High]
Could this code also underflow cpc->length?

Similar to the netid block above, if cpc->length is 0 or 1, subtracting
sizeof(*cpc) will underflow to a large unsigned value, bypassing the min()
clamp and causing memcpy() to read 8 bytes out-of-bounds.

>  		memset(cpc_name, 0, OCF_LENGTH_CPC_NAME);
>  		memcpy(cpc_name, cpc + 1, size);
>  	}

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the GDS parsing hel=
pers
used earlier in this path:

drivers/s390/char/sclp.h:sclp_find_gds_subvector() {
    ...
	for (sv =3D start; (void *) sv < end; sv =3D (void *) sv + sv->length)
		if (sv->key =3D=3D key)
			return sv;
    ...
}

Does this parsing loop prevent infinite loops on malformed buffers?

If the buffer contains a subvector where sv->length is 0, the pointer sv wi=
ll
not advance, resulting in an infinite loop if the key doesn't match.

Additionally, does this condition ensure the full struct and its payload re=
side
within the buffer? The loop condition ((void *) sv < end) allows entry even=
 if
there is only 1 byte left in the buffer. This means reading sv->length and
sv->key could result in an out-of-bounds memory read. It also doesn't verify
if sv + sv->length exceeds the end boundary.

The same concerns apply to sclp_find_gds_vector().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804074511.2361=
53-1-egorenar@linux.ibm.com?part=3D1
