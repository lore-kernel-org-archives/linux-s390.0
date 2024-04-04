Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928221CD3F
	for <linux-s390@vger.kernel.org>; Thu,  4 Apr 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218418; cv=none; b=AnysTTTO/KWRdMha7cZyetmIKZT1Q13Lnb56AfVsxixsTud6vkQVQ6AGKD9xKXW1y1fXfVXJaOBFugIGS/6qrG4WO5cPtnS07umzJOK3g246tChm+AStzhu+yEYi/+Kw/IDXWeFD4Y2CjJXiXMxHWPiQRxaDkJFd3iYq6FQhTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218418; c=relaxed/simple;
	bh=Fa5lb5m3x+LvOulZ0Jep2SxTuCcI02AXO6bmmqcnoJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSYy7IGOtJBiQQGA5URg/IeFz7wQaqy5Gc1SxvbI+lrQ2KrVlWDX20xf7BR+rSaPmDqXXb6JpPh1tou+dDsMuSHvr+02oQDq+Px8bHH8dXv7wmp0jA4JtpNeNniW1VGgTnT1ulajl8o6B8EGxWdospd7/I05qDpgznJQlKGsVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXF7ZkFp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXF7ZkFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712218415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e7G/e5ggzgAw463tJQhN9Xk/7c9PFByf9fd/Bd8Wrkw=;
	b=MXF7ZkFpnUfScoIOYiPCPSCgKGlEc/hp9XOPS0eeir0rcNs67psMsKgp8XN6UxPXAFJjGR
	7YBj+bdCdPjnkJ05alZJDBRb03/kfIZ4zy3IqWpkgMPgS/A7cb8loiOpi6GjC0H3LXJ0wI
	bk5SqTbrFkvqokeIS8KJgdYeUP/Oaes=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-bvPub8hjOPKr9buhl6S5QQ-1; Thu, 04 Apr 2024 04:13:34 -0400
X-MC-Unique: bvPub8hjOPKr9buhl6S5QQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3438a74f0a9so253968f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Apr 2024 01:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218413; x=1712823213;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7G/e5ggzgAw463tJQhN9Xk/7c9PFByf9fd/Bd8Wrkw=;
        b=f/kDPjposSjLSQMl5ot04jAta4PnqK7B6TyucMU/EZmWU3R1S+LDX7pDuAoA5ZmSCh
         j584wDNYtQsiNFNIUbhUqUaMHNXOM3nwUvKWgD9cdkfEIY8xgSZdOuffEImFqKhNXXPq
         FZQBYqgaH6/GZDZZsrQm8KFPUllVBeWEUCj/zt236QJtcoopfPQpoch6RZHOSuS1HXNM
         mzDlM92cVXM87kkxE5gfa5KHEAO9IASM/aocJpwxp3SASli5ZOVWX1y+WpYOxyt15Tk6
         hOtOZCNzYwe6a+0quzoWbYIqeN2069GuuqODKPgC2O+iUtplxywhy9aTsnFdtoEill9H
         /eMg==
X-Gm-Message-State: AOJu0Yxo+4xWvgMGz5WZaGl0J29fwXBp1FG7rJbrWSvjK/Q+4yo79wel
	zGbhGIKX44oSOk50Mnk5L3SLrXvjqFsnJWCUXgi0fQqYdXX+7OuRKqXghi4idpuQsVV2O+SMNN+
	Y3Qu48u7KnL/Lv/BlFAwhcmvugtVI/4dDOxaTMxubnjbd4PG3HvG4tyBFWcA=
X-Received: by 2002:a05:600c:3b9f:b0:414:8f6c:be3 with SMTP id n31-20020a05600c3b9f00b004148f6c0be3mr1354726wms.4.1712218412913;
        Thu, 04 Apr 2024 01:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpi7hb0bEUFOPBpBTmW40T+Gd6IpulyKromWzm8iDOyeYLGeT0ozUNNArWzS3dHrNk3jTlRw==
X-Received: by 2002:a05:600c:3b9f:b0:414:8f6c:be3 with SMTP id n31-20020a05600c3b9f00b004148f6c0be3mr1354703wms.4.1712218412495;
        Thu, 04 Apr 2024 01:13:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b004156c501e24sm1755494wms.12.2024.04.04.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:13:32 -0700 (PDT)
Message-ID: <68ce59955f13751b3ced82cd557b069ed397085a.camel@redhat.com>
Subject: Re: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Wen Gu <guwen@linux.alibaba.com>, Heiko Carstens <hca@linux.ibm.com>,
 pasic@linux.ibm.com,  schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Date: Thu, 04 Apr 2024 10:13:30 +0200
In-Reply-To: <20240328154144.272275-2-gbayer@linux.ibm.com>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
	 <20240328154144.272275-2-gbayer@linux.ibm.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 16:41 +0100, Gerd Bayer wrote:
> Since [1], dma_alloc_coherent() does not accept requests for GFP_COMP
> anymore, even on archs that may be able to fulfill this. Functionality th=
at
> relied on the receive buffer being a compound page broke at that point:
> The SMC-D protocol, that utilizes the ism device driver, passes receive
> buffers to the splice processor in a struct splice_pipe_desc with a
> single entry list of struct pages. As the buffer is no longer a compound
> page, the splice processor now rejects requests to handle more than a
> page worth of data.
>=20
> Replace dma_alloc_coherent() and allocate a buffer with kmalloc() then
> create a DMA map for it with dma_map_page(). Since only receive buffers
> on ISM devices use DMA, qualify the mapping as FROM_DEVICE.
> Since ISM devices are available on arch s390, only and on that arch all
> DMA is coherent, there is no need to introduce and export some kind of
> dma_sync_to_cpu() method to be called by the SMC-D protocol layer.
>=20
> Analogously, replace dma_free_coherent by a two step dma_unmap_page,
> then kfree to free the receive buffer.
>=20
> [1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/
>=20
> Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to dma_alloc_=
coherent")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/s390/net/ism_drv.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 2c8e964425dc..25911b887e5e 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -14,6 +14,8 @@
>  #include <linux/err.h>
>  #include <linux/ctype.h>
>  #include <linux/processor.h>
> +#include <linux/dma-direction.h>
> +#include <linux/gfp_types.h>
> =20
>  #include "ism.h"
> =20
> @@ -292,13 +294,15 @@ static int ism_read_local_gid(struct ism_dev *ism)
>  static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>  {
>  	clear_bit(dmb->sba_idx, ism->sba_bitmap);
> -	dma_free_coherent(&ism->pdev->dev, dmb->dmb_len,
> -			  dmb->cpu_addr, dmb->dma_addr);
> +	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
> +		       DMA_FROM_DEVICE);
> +	kfree(dmb->cpu_addr);
>  }
> =20
>  static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
>  {
>  	unsigned long bit;
> +	int rc;
> =20
>  	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
>  		return -EINVAL;
> @@ -315,14 +319,27 @@ static int ism_alloc_dmb(struct ism_dev *ism, struc=
t ism_dmb *dmb)
>  	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
>  		return -EINVAL;
> =20
> -	dmb->cpu_addr =3D dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
> -					   &dmb->dma_addr,
> -					   GFP_KERNEL | __GFP_NOWARN |
> -					   __GFP_NOMEMALLOC | __GFP_NORETRY);
> -	if (!dmb->cpu_addr)
> -		clear_bit(dmb->sba_idx, ism->sba_bitmap);
> +	dmb->cpu_addr =3D kmalloc(dmb->dmb_len, GFP_KERNEL | __GFP_NOWARN |
> +				__GFP_COMP | __GFP_NOMEMALLOC | __GFP_NORETRY);

Out of sheer ignorance on my side, the __GFP_COMP flag looks suspicious
here. I *think* that is relevant only for the page allocator.=20

Why can't you use get_free_pages() (or similar) here? (possibly
rounding up to the relevant page_aligned size).=20

Thanks!

Paolo

