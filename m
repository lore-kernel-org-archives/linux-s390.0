Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF9381C6
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874876; cv=none; b=sSb+6pzbduPg/fvfJu87Am8G05dxrIZWhInhKmGyjyVEO4v/G+c7GygCMtXfKnuAYMe2fLvfzMnjqEAtqQKao8aVbcvBTl5gv8NNsXgGaSE506mqGaLPUP4cGDwCKfJVoDWKgks3lRilLMp6i3pJDQFHHPThPjxjGlAo9V5AAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874876; c=relaxed/simple;
	bh=AblgfDKsQmxG/rhwuU9LnaVafDArI7B9+bO2yRkgtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuseZwrlqt/yGmup8jerjv7X0GaaspHWt8qg/xoFLF0vXvhMoUQDUXTfI6ow9LLtHko7ipHURI6+qbAPsjd2Fwbtiuqa7Tzw2Q+9Nw1tJaB1bJ2BU2MjvjsiQE1fNEtXWXSH2bhH4zy/NexI9P/aImVcuPl2boPP9Ck04PnC7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=irXsrZLt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irXsrZLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
	b=irXsrZLtsV9w1DOkpSiklsaRGmo7YidbABELFEliHwulXqXFATiX1T3Lrxk1lIBHNlDnX2
	6ErIDnREBz6Ks2o04Lpo9KmjoRDWwfueKO7XcD7JGeYACuJwkMcbsP3N3y7B1m8wwW8zZb
	oAoM399rPmz6Uq5GoXk3M/gQtLSPOQo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-NzPpuz8JOiSTIg56Hnp3VQ-1; Thu, 20 Jun 2024 05:14:32 -0400
X-MC-Unique: NzPpuz8JOiSTIg56Hnp3VQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f4af1c655so22874966b.3
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 02:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874871; x=1719479671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n/q6GHKkD/zFmXGYbmYPlaDuYuUj7aK/70/tkj3IdI=;
        b=ee9eYoPvZSyoYFN/IZQvDosIUUHtd5ULZfiZa/LVYQgwQbfZR8EHoIfIAratCt6/s6
         ZdLT5Bp8yEJ9AmyphPU08EnFK6SRysrS4hCKxzu/5+kM9cpjqkTxs9n/EjxWDfMgBiC3
         nMrCQCpzcJOL9XAL/S2S1kPdAd1O0EYBC108FL2JM28p0L6jhylwigwwm01EzsKq+WQ2
         DjagGdax0H/mccByVwfvqWrOaE65PMZCa17sAwX2e20EovlJ7DQFGeGOemtFR35qYBQ2
         4LwGebYDp1eM5lnBRsEt1ypDzg+ooCRfOEZKSRJGDtFcqJtiu9ozoz0BnV3b2hYatVLd
         NHpw==
X-Forwarded-Encrypted: i=1; AJvYcCV0WecobedoFqb382O2kpVbBqPtH+d8GeeoxQICplHKpnAzE3nYZyz5N379ssHun0CEgLRiWR4w4hc96ZvenGFDb3HUp6XNh4OA7Q==
X-Gm-Message-State: AOJu0YzY4KwcdN31LKrZjjoj8jhY3o0YQg8TmS+jkuBtRVcwTkgdUUyT
	OXzhL1SBy9z5Xpu2EcVWlkOegsdGFEYlIBzEH312ZzdEMygHxlnTpFNQ1i1U8zaWlV9UbZ7ocUB
	D8u1E5CQD46ja4IL6Yz04wmax6FiVk6rqU4fM/c4s2flomOdtWH/GPI+t/OY=
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334400766b.25.1718874871295;
        Thu, 20 Jun 2024 02:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdf7P1AFITZr2DVkTfIKfl2IcVnjVg8p04jUd8bO23ArK3RuJSM+iwOfOkWQb1H37WeNIsA==
X-Received: by 2002:a17:907:a581:b0:a6f:af4f:ff82 with SMTP id a640c23a62f3a-a6faf500049mr334396566b.25.1718874870708;
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3fe5sm759661166b.18.2024.06.20.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:14:30 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:14:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of
 multi parameters
Message-ID: <20240620050545-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718874049.457552-1-xuanzhuo@linux.alibaba.com>

On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > >
> > >  static inline
> > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > -			const char * const names[],
> > > -			struct irq_affinity *desc)
> > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > +		    const char * const names[],
> > > +		    struct irq_affinity *desc)
> > >  {
> > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > +	struct virtio_vq_config cfg = {};
> > > +
> > > +	cfg.nvqs = nvqs;
> > > +	cfg.vqs = vqs;
> > > +	cfg.callbacks = callbacks;
> > > +	cfg.names = (const char **)names;
> >
> >
> > Casting const away? Not safe.
> 
> 
> 
> Because the vp_modern_create_avq() use the "const char *names[]",
> and the virtio_uml.c changes the name in the subsequent commit, so
> change the "names" inside the virtio_vq_config from "const char *const
> *names" to "const char **names".

I'm not sure I understand which commit you mean,
and this kind of change needs to be documented, but it does not matter.
Don't cast away const.

-- 
MST

