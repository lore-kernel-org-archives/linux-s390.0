Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AF42C4E6
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343609; cv=none; b=Q7sig3MJ3+yD8MTkXkRmnlcw3JpsINqliZ4SULMxaj1EGnI7BwfRJ7oU5uFFlxV4yrrRhmThCq3bdiwWs235aRyeH0hp34eL9gNfMpvstFMaNDX8ZAbcp4MQW3BJsCjkpBlLkaRdY/xn/txVSTQ4p2TRQAT9AhC7HZ8g6tQ4N5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343609; c=relaxed/simple;
	bh=N9SfRBBlL1sG2f/uSv1WUQ1rJy0C+6ISltYLiIqxmgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYaSK2hLyY18yTV1zy8WaQLWqBMN2jl2qGy8+IzXaKHvrwTwjhiecfIzY09IpJAaOOf+TSV4YspawkVkGVyufzwh5KgxHQ9v6M1Ig4x2DaSqrXIYIWUSWLeGAZ6BU4sL6FkgBej+K3inhmel6onvUxn/b6aw8+UIaPYdkng0WsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMbkvImQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMbkvImQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED81F000E9;
	Wed, 29 Jul 2026 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343607;
	bh=dThgnyp9CajNrKxOfPl0J/lTaqWsGZ6/7JZD0DERCSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMbkvImQMtO9CnbDXNDwzFhyrdsyTFrFDd4jYEjlHojwT7gV0a+/pOp+R9QnkDSr1
	 W9tSbwvNdiP8UB/20DOx+MQH+SZJig4vCsfI4+3EOKeo0ZSwrHXCQA3d4amcMT3z9i
	 M8kw9qFAVOGsoPg6J6X6bCQE9x+byAs8i0a8ZRVfGHnmHyFWHQyIzsk1qykjuErp2j
	 ssdrv7h6UVfI+7HGbkWiBXCL297cQ1/d+0I39yDxIk3CFIGdX52jdqA9mOEvQkJWM5
	 nHSC93/Ums3TA1OQmYd4bZEzYGnTWCO9KqBdXbNQ92lDKBQBF0zqlweGRJnSIZz4sg
	 Y3f+yAL3R+9QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260729154458.195135-5-freude@linux.ibm.com>
References: <20260729154458.195135-1-freude@linux.ibm.com>
 <20260729154458.195135-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:46:46 +0000
Message-Id: <20260729164647.60ED81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing bounds checking before reading `pld[offs++]` causes an=
 integer underflow in `pld_len - offs`, bypassing bounds checks and enablin=
g an Out-Of-Bounds (OOB) read and write.
--

--- Patch [4]: [PATCH v9 4/5] s390/zcrypt: Improve EP11 CPRB domain handlin=
g with ASN.1 parsing ---
commit 750aceaeb85ad5fa9ff8e2614110f89a4c147522
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/zcrypt: Improve EP11 CPRB domain handling with ASN.1 parsing

This commit replaces struct overlays with explicit ASN.1 parsing for EP11
CPRB domain handling. It introduces bounds checking at each parsing step
and adds a helper function to safely write integer values.

> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/=
zcrypt_msgtype6.c
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c

[ ... ]

> @@ -1235,51 +1258,90 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool u=
serspace, struct zcrypt_queue *
>  					   struct ap_message *ap_msg)
>  {

[ ... ]

> +		/* payload length field */
> +		i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
> +		if (i < 0)
> +			return -EINVAL;
> +		offs +=3D i;
> +		if (u > pld_len - offs)
> +			return -EINVAL;
> +		/* function tag */
> +		if (pld[offs++] !=3D 0x04)

[Severity: Critical]
If the ASN.1 payload tag and length encoding completely consume the payload
buffer, couldn't offs become equal to pld_len here?

If offs equals pld_len, does this array access read out of bounds and
increment offs past pld_len?

If offs exceeds pld_len, it appears the subsequent pld_len - offs
calculations will underflow to SIZE_MAX. Would this bypass the remaining
bounds checks, such as pld_len - offs >=3D 3, and potentially allow
asn1_int_encode() to write out of bounds?

Additionally, it looks like a similar pattern exists in
xcrb_msg_to_type6_ep11cprb_msgx() where pld[offs++] is checked for the
function tag without a prior bounds check.

> +			return -EINVAL;
> +		/* function length */
> +		i =3D asn1_length_decode(pld + offs, pld_len - offs, &u);
> +		if (i < 0)
> +			return -EINVAL;
> +		offs +=3D i;
> +		if (u > pld_len - offs)
> +			return -EINVAL;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729154458.1951=
35-1-freude@linux.ibm.com?part=3D4
