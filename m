Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbgBQRIy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 12:08:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HH8rgA138040
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gmqc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 12:08:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 17 Feb 2020 17:08:33 -0000
Date: Mon, 17 Feb 2020 18:08:28 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH trivial] s390/pkey/zcrypt: spelling s/crytp/crypt/
References: <20200212084622.9219-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212084622.9219-1-geert+renesas@glider.be>
Message-Id: <your-ad-here.call-01581959308-ext-9465@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jiri Kosina <trivial@kernel.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:46:22AM +0100, Geert Uytterhoeven wrote:
> Fix typos in a comments.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index d4caf46ff9df1559..2afe2153b34e32e9 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -887,7 +887,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
>  	/* empty pin tag */
>  	*p++ = 0x04;
>  	*p++ = 0;
> -	/* encrytped key value tag and bytes */
> +	/* encrypted key value tag and bytes */
>  	p += asn1tag_write(p, 0x04, enckey, enckeysize);
>  
>  	/* reply cprb and payload */
> @@ -1095,7 +1095,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
>  
>  	/* Step 1: generate AES 256 bit random kek key */
>  	rc = ep11_genaeskey(card, domain, 256,
> -			    0x00006c00, /* EN/DECRYTP, WRAP/UNWRAP */
> +			    0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
>  			    kek, &keklen);
>  	if (rc) {
>  		DEBUG_ERR(
> -- 
> 2.17.1
> 
Applied, thanks
