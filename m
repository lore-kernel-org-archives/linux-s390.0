Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2283A1B9
	for <linux-s390@vger.kernel.org>; Mon, 26 Feb 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947430; cv=none; b=MbOkI5m45s+ss2Zfi647bWKn7+iNSL7vLNWj7yjQ2qJ1nA4XcV43/hDqCrP7bOAQ2lpMf/7QdKVXZohcrcG7ZOB+uAxIMI+KZTsIVRtc3e0FupKPkI4+o8oXicGNqGfvf99Gkxl7EOiPpMENhjeGvSJuYtMTKeB8kjmK6wTOYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947430; c=relaxed/simple;
	bh=cdvsXEAAdJFQk8TvtsGZXJF3H+eh0FsJmmxlLLI+i6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ma+n7bUVHLc7rEsO97hJz54IV2ufxxxaKP4T5KDRp3XH9ERQpmjaGUJHYzpttKh7wL5j19XpOhCCIlt1ApyE5/8T8LLqSxcrbKo4aAD7jJ39EvZ8mDMgmYEV0vsf3oAUQHpqy6mn+ZXZTsrBkksB1gcC1WhbbjMYtGmBs0p04H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA8qNQmn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA8qNQmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708947428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
	b=eA8qNQmnN3o5rUFOlhHDwxWIJsNDGLS75i+O/9Yni71O7ofikJcfLj5UXF5TuVADEMhKsg
	ivw54QK7EzcpymwPBAfwUo9BoSdevAO/C5qQy1+cV5tjmS+cyQbL0qwqG7GdpVvU2Uwspo
	efiXAyxkpJqHhRO3bvjLKP76R4MMuo8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Wn-nQIRINXGSBnYaeq18Sg-1; Mon, 26 Feb 2024 06:37:04 -0500
X-MC-Unique: Wn-nQIRINXGSBnYaeq18Sg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4128defb707so14825925e9.0
        for <linux-s390@vger.kernel.org>; Mon, 26 Feb 2024 03:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947423; x=1709552223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
        b=DFce99wxFQMmNqVX86h+Zhcob5ZOvDAk84y1cDjX3GaG/+aPFSNshQfONDHmwmYt1M
         dmI8hXQ7DlWu5fNstHNFvs3+CanDbuU+5XLpLk2YlTZX4+XgTNJUAEhT0SA46dWQu4kU
         RVxJ38Ko5WpCDcftdGvqTHr/tdzfgUC7YrudUd8bch+gy+JdQCrv4giMNqhUcDOvzk+/
         hA2coR67zc94/LjCCnLgCRNhUFTcGDBGe4/llqIU3AMz9ZFgUavDR1Nk+uaep9VRJitF
         gvzH9IifNZSL1PoKDaUUWKv/AaH3TJSgwhMKmkRC5G5S3304+zj0Vn2taOXeEfUS/8fQ
         Ne2A==
X-Forwarded-Encrypted: i=1; AJvYcCXItDdLX86cvEdLWUjOQVOVxzATW3cs/t4VqaValos3Ui97fpYB/05Zo+zu/M3bc2iduZBt+/114rmQ9Y/z2Orw8TfKn2cl3ABWFg==
X-Gm-Message-State: AOJu0YxMl9VJV7T+RTk4qwXLVe9zX2eD6Y4zbylh7eJbF07AXbNjUEHI
	eVP5mOoawM+FMoGn1fRvz7ZVbHwkpQhxuyGyEBNev0pIXDfnswvEvITEMhiwLR9ifkJX91L2RPm
	6O1YE5avaNOmQQBuPX34olnECTJIR+rsbJoeXnl+e+Qo7PhBHMWDXax/oxPQ=
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379090wms.8.1708947423788;
        Mon, 26 Feb 2024 03:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvXe87LdVjv57x0ixL/iOJ9+IQcZQwZBW2BhhDacRcGH/iDCk0HMP0COfYaRJOaDiHQGYMqw==
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379072wms.8.1708947423449;
        Mon, 26 Feb 2024 03:37:03 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b0033de1e1bddcsm1319266wra.26.2024.02.26.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:02 -0800 (PST)
Date: Mon, 26 Feb 2024 06:36:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226063532-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > what is dma_map_direct? can't find it in the tree.
> 
> YES.
> 
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58db8fd70471..5a8f7a927aa1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
>         return dma_go_direct(dev, *dev->dma_mask, ops);
>  }
> 
> +bool dma_is_direct(struct device *dev)
> +{
> +       if (!dma_map_direct(dev, ops))
> +               return false;
> +
> +       if (is_swiotlb_force_bounce(dev))
> +               return false;
> +
> +       return true;
> +}
> +EXPORT_SYMBOL(dma_unmap_page_attrs);
> +
> 
> Thanks.


where is it? linux-next?

-- 
MST

