Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC13B6C09
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293611; cv=none; b=uvk3xDvbJBi7uH20B5L0erZz2O9CwgRQe0fY/ZGQkFoCtYsk48cCgcrCwhyf4guAjhC5rnCprWVKjjstkPDZkHjDov4KeMjnBU0SVxcgNTiN7d4LdpB6zYmTQ9dgg1em3PwXsyxu/O2sc1ckjZWh3AqD4tbwEQMMZswdqV1d/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293611; c=relaxed/simple;
	bh=iKCq06Cw9ItxeC403Qfq4ByMBR+HpC98nuiVNdwrdlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mqD0hmlrGDgkUNuiMDK5SXPEaZmQ/NYRX1MvcU3XZMom5XRamaUmVHVTuBGjMCjp1UPqYQfyWqmdYA04kABu2Ptx8LSz1S4wpx3SJAeC4C2CATVaMzK0I/yQoOp8HEPcK5ddDn6tIy9gulUN9GiTZ1edopqPATa7/GcQn9DSEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNN1jHzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNN1jHzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA81F000FF;
	Tue,  6 Oct 2026 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791293610;
	bh=pycCpPvl3BGtJxTwnwiaCSkLp7HNB0XDOQcpBBhRW38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JNN1jHzR/Z9Wo/DgQ56ktbSazCSLZidCdtXynWKzwNssmPYyOVi0bRtcNr1yliyPk
	 MJAvjlpR0Rh/1I6GIZkzuAu4JVX1sdpSonGTDF+g68YSWmVR4+hHd5d7pm+SJFN9kF
	 DekrU8gxLUEemGsKsBQywSzeZkp2MpNwbwwLaHBDbpEAiOZIbAIMj3PqZ/dJgYNQWm
	 kQRczETuQdbLGi/nkv62AnTb/R9kLhuIC1xOUwrFAMvrdxnTfyGcaZhl40rr69V/qu
	 lzGA6scZzMojA9aYLEvDz7CZqkXXVn7aJNJCQPi60Xrz81nAGUmpNNJcVC/sx78B+v
	 6Oac6W3DO7Y9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261006132127.6251-1-freude@linux.ibm.com>
References: <20261006132127.6251-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 13:33:29 +0000
Message-Id: <20261006133329.EDBA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/ap: APMLM field is zeroed out by TAPQ_CARD_HWINFO_MASK
--

commit a92b6e193aedcdab18cc73823dae8ff72c9b6ca0
Author: Harald Freudenberger <freude@linux.ibm.com>

s390/ap: Support new APMLM field with PQAP/TAPQ instruction

This commit introduces support for the new AP message limit multiplier (APM=
LM)
field defined within the GR2 register on successful invocation of the TAPQ
subfunction. The formula to calculate the AP max message limit is updated
to incorporate this new multiplier.

> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c91b6ace199d7..01d575c358875 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -123,8 +123,8 @@ struct ap_tapq_hwinfo {
>  			unsigned int	   : 14;
>  			unsigned int at	   :  8; /* ap type */
>  			unsigned int nd	   :  8; /* nr of domains */
> -			unsigned int	   :  4;
> -			unsigned int ml	   :  4; /* apxl ml */
> +			unsigned int mlm   :  4; /* AP msg limit multiplier */
> +			unsigned int ml	   :  4; /* AP msg limit */
>  			unsigned int	   :  3;
>  			unsigned int qd	   :  5; /* queue depth */
>  		};

[ ... ]

> diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
> index c86397f4ddcd9..e9a8180f08c24 100644
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

[Severity: Medium]
Will the new hwinfo.mlm value read here always evaluate to 0?

Looking at ap_scan_adapter() in drivers/s390/crypto/ap_bus.c, hwinfo.value
is masked with TAPQ_CARD_HWINFO_MASK (0xFFFF0000FFFF0F1FUL) before being
passed to ap_card_create():

drivers/s390/crypto/ap_bus.c:ap_scan_adapter() {
	...
	hwinfo.value &=3D TAPQ_CARD_HWINFO_MASK; /* filter card specific hwinfo */
	...
}

The 0x0F1F portion of the mask applies to bits 48-63. The leading 0 nibble
clears bits 48-51, effectively forcing hwinfo.mlm to always be 0. As a
result, the new max message size calculation hwinfo.ml * (hwinfo.mlm + 1)
seems to always evaluate to hwinfo.ml * 1, nullifying the intended
functionality.

Does TAPQ_CARD_HWINFO_MASK also need to be updated to preserve the newly
defined 4-bit mlm field?

Note: This masking behavior might actually be preventing a severe memory
exhaustion vulnerability. If the multiplier were not forced to 0,
unconditionally allocating up to ~960KB via kmalloc for hundreds of queues
in zcrypt_queue_alloc could cause frequent order-8 allocation failures.

> =20
>  	return ac;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006132127.6251=
-1-freude@linux.ibm.com?part=3D1
