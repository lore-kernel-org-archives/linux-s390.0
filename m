Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB530216D
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299374; cv=none; b=Lc+udxjqL302x+ABRPOyoy+CidL/TUdan1K1dKf2fkBq2tdV53hzCyWuVwIsXFwtsJ8csmMj9OiwJdlggaO1lDCcLyl+QJsdiYNkFYvTUcLOpicBU39dranfwmHh1Pz8yIfafBrry0iRAODRpur8YnTrPYT6ddD0tektgDr+7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299374; c=relaxed/simple;
	bh=HNCBXR+LnEB9IeLiWBQsqxOQvL3W/ePDbrrt89TCllo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFhnSOPkWd6gQQkPIpCSklZq7LHL6NEdmaMJRwEm1JDFmNLtiyAfehzvUeoGE9EPeGhbQlX1LxhfNBOfksBTedfp5a/2JtU24Z/E8naFd1LOjJIcyAt1nH4mipuCRoBypsZxTmBnwbNdsp97AbiBcEleRhSe5bJdkZRo2Jz7X4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDqzeflw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDqzeflw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD671F0089B;
	Tue,  6 Oct 2026 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299372;
	bh=XTJMTXD0zSBe3cUN5KIA+tdU4PeE94H0sQGOCyVs0Wg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDqzeflwavrDZfEb9GNb5COv+dlS2JGbXkHuX4sE+LmzrbejX/Cj3TWwNHQPSJljZ
	 x4FuJ1Qvwz2YlBBlMWPureUHkX2naGs9csnLToxlD5hvCcj0DfgZVY/052pYpo3Qmz
	 UfgalZqmVRZhYpFUl3Je4wOlURDDc5LPN5tqC2W8Kd1RHjS3lzjYE4iEW2/9lVo/qK
	 j+yzoSL07LJ0JIwqKPL60UmMYZy1miJdPIjZLMSTXcnrOMFuOF99BZRFho/6Yz8EDM
	 +jlpGUXKeXjws1FDenpfv624PjPM+I0x0xKtfPRgCfmf5fMwl12lhC0hsHOGIfJKay
	 V/B87LYGEWvKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261006145823.8421-1-freude@linux.ibm.com>
References: <20261006145823.8421-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:09:31 +0000
Message-Id: <20261006150932.5AD671F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/ap: order-8 kmalloc allocation causes DoS for crypto requests
--

commit c12ee44fe3064032047e06539777b0c95c7b1201
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/ap: Support new APMLM field with PQAP/TAPQ instruction

This commit adds support for the new AP message limit multiplier field in t=
he
GR2 register for the PQAP instruction. It updates the HWINFO mask and
modifies the formula used to calculate the AP maximum message limit.

> diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
> --- a/drivers/s390/crypto/ap_card.c
> +++ b/drivers/s390/crypto/ap_card.c
> @@ -242,7 +242,8 @@ struct ap_card *ap_card_create(int id, struct ap_tapq=
_hwinfo hwinfo,
>  	ac->hwinfo =3D hwinfo;
>  	ac->id =3D id;
>  	ac->maxmsgsize =3D hwinfo.ml > 3 ?
> -		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
> +		hwinfo.ml * (hwinfo.mlm + 1) * AP_TAPQ_ML_FIELD_CHUNK_SIZE :
> +		AP_DEFAULT_MAX_MSG_SIZE;

[Severity: High]
Will this scaling of the maximum message size cause order-8 physically
contiguous memory allocation failures?

By introducing the hwinfo.mlm multiplier, the maximum message size can now
scale up to around 960KB. This value is used to set the global maximum mess=
age
size.

However, looking at how messages are allocated in
drivers/s390/crypto/ap_bus.c in ap_init_apmsg():

void ap_init_apmsg(...)
{
        ...
        maxmsgsize =3D atomic_read(&ap_max_msg_size);
        ap_msg->msg =3D kmalloc(maxmsgsize, GFP_KERNEL);
        ...
}

And similarly in drivers/s390/crypto/zcrypt_queue.c in zcrypt_queue_alloc():

        zq->reply.msg =3D kmalloc(reply_buf_size, GFP_KERNEL);

Since these functions unconditionally use kmalloc() for the maximum size,
user-space crypto requests will trigger massive order-8 allocations. On a
system with fragmented memory, these physically contiguous allocations are
highly likely to fail. This could lead to a reliable denial of service for
hardware cryptographic services since the underlying AP instruction operates
on absolute memory addresses requiring physically contiguous memory.

Is there a plan to adjust the allocation strategy alongside this limit
increase, or otherwise cap the unconditional allocation sizes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145823.8421=
-1-freude@linux.ibm.com?part=3D1
