Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA417279E
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870910; cv=none; b=lKrbEcrS1RUDWr1r5f95FAh19FlQiMZQipPhlHDrSSspe79RTlgMHKimjJrkefn8ctx5sZCTSw1ROi3lOT0+KkrgvFCs15UVlkjnU37Xomi3lQlztn/AEW561lYWmby7NCimbptKfqatRRzbMHJrTLF2KN+oGsLmPOX91WMbri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870910; c=relaxed/simple;
	bh=iZmgo2+TOhUg1x9YUztlK/dbvEtJpfYQSCVEMXHMeyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQjVHSSni5yT9fQihSXkkUT9nkDbQRZOMsu0i7PlOgCpo5a+PB7G1t+CuuYI9jS5oSGf3mSK4mDsK1iZyNKrIuBufnpUSrwjhnQa9aVywC5n7JdlZu69Q8klynXcV9kCuUb7k6VQOIZ4tOefVLBWiD2gWyLtBQQeubFqkBYRnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF2P88s4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF2P88s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718870907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
	b=bF2P88s4SX3EaUwaeIwnArorSHARc3SzTla3IYss7j/qpYCU6LkXZBlS0zfg3IEcFxyo/2
	gtEsz+XWgkR2Ype+hZrBExturpTSxIKm6JHPGWpRP6V3YGCG058JwbtFWkkJELZyChz0Of
	4ckXhx6+JQ30wt2EWW6f1jtH9j785Sc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-2GiVT0IKMMq3nSo8weDcYA-1; Thu, 20 Jun 2024 04:08:25 -0400
X-MC-Unique: 2GiVT0IKMMq3nSo8weDcYA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so292520a12.3
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870904; x=1719475704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYkcvH1qikOhnYAi1RzJNYy38ecUZaxzjAiohS4BdJU=;
        b=wNsck4q+A8i9iAR0zgevA58y6E+GhQ5zeUGu1vUrWHg8/bHQceaFG4Qi/MX47vvUuj
         DsSH2Eay/6ZjehVkXvhnqcDjsMupHsT476QlaVW8HS/3E2JwT8fdi43KlInDIdxPLkbt
         2H0Nu7C84kBF2qlMEzuIK+gviXYcpykah7qyYodJjG9unpLjedctiXmknexDoGWvQ/DN
         GDc6nQDyKlCJgaOIg4VhA0hAQHvfe3esbXc4uOYd3R7aOWGdC6X4iBMuDDrFagwSNfDx
         61ahxHFVk6T8UH9/eVh/u1yjXmOGelUOLixZ3cyIPqFDByfFivv0fJXSGq8GBB46ctNi
         Nahw==
X-Forwarded-Encrypted: i=1; AJvYcCU9LktLSBy3gfZbGYPtEdMMHzoo1SS6oc5E3jEaL5xZEb4UEFpY60FR7H6f2n6f2oe4QVnERKiXHTeL+umj7mWSEITo3ff1c/eDew==
X-Gm-Message-State: AOJu0YwxbDPTE4/ENut4HvM2kC5OZEyqy48pR2N9OdYU4RjjRK+06Pb2
	YYjs6Nh9NE5UvK1gpkhWnLNIMtN4xn2+YqRxNg7Fuu6ZRAL5lzO8Zgr87mLOS18nfMeesHiFX60
	QPyKew7TApNqEsBIg8A+IyEDJCZ87OKoetQQ7YWg1/uwzDGaod7rwr5p5YY8=
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054068a12.18.1718870903882;
        Thu, 20 Jun 2024 01:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElyy2gCyt3ovTk4v5Gf3L+EBBsQDxCvTGnZmU0yxgu5HjKvNiZ0eDBqsa0yCdr2XWpOKzZ1g==
X-Received: by 2002:a50:ab18:0:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-57d12c3ed79mr2054031a12.18.1718870902978;
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cd24df611sm5962871a12.16.2024.06.20.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:08:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 04:08:15 -0400
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
Subject: Re: [PATCH vhost v9 1/6] virtio_balloon: remove the dependence where
 names[] is null
Message-ID: <20240620040415-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424091533.86949-2-xuanzhuo@linux.alibaba.com>

On Wed, Apr 24, 2024 at 05:15:28PM +0800, Xuan Zhuo wrote:
> Currently, the init_vqs function within the virtio_balloon driver relies
> on the condition that certain names array entries are null in order to
> skip the initialization of some virtual queues (vqs). This behavior is
> unique to this part of the codebase. In an upcoming commit, we plan to
> eliminate this dependency by removing the function entirely. Therefore,
> with this change, we are ensuring that the virtio_balloon no longer
> depends on the aforementioned function.
> 
> As specification 1.0-1.2, vq indexes should not be contiguous if some
> vq does not exist. But currently the virtqueue index is contiguous for
> all existing devices. The Linux kernel does not implement functionality
> to allow vq indexes to be discontinuous. So the current behavior of the
> virtio-balloon device is different for the spec. But this commit has no
> functional changes.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I can't make heads of tails of this.

David you acked so maybe you can help rewrite the commit log here?

I don't understand what this says.
What in the balloon driver is out of spec?
NULL in names *exactly* allows skipping init for some vqs.
How is that "does not implement"?

And so on.


> ---
>  drivers/virtio/virtio_balloon.c | 48 ++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index c0a63638f95e..ccda6d08493f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -548,49 +548,41 @@ static int init_vqs(struct virtio_balloon *vb)
>  	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>  	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>  	const char *names[VIRTIO_BALLOON_VQ_MAX];
> -	int err;
> +	int err, idx = 0;
>  
> -	/*
> -	 * Inflateq and deflateq are used unconditionally. The names[]
> -	 * will be NULL if the related feature is not enabled, which will
> -	 * cause no allocation for the corresponding virtqueue in find_vqs.
> -	 */
> -	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
> -	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
> -	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
> -	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
> -	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> -	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "inflate";
> +	callbacks[idx] = balloon_ack;
> +	names[idx++] = "deflate";
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> -		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> -		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
> +		names[idx] = "stats";
> +		callbacks[idx++] = stats_request;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +		names[idx] = "free_page_vq";
> +		callbacks[idx++] = NULL;
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> -		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
> -		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
> +		names[idx] = "reporting_vq";
> +		callbacks[idx++] = balloon_ack;
>  	}
>  
> -	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> -			      callbacks, names, NULL);
> +	err = virtio_find_vqs(vb->vdev, idx, vqs, callbacks, names, NULL);
>  	if (err)
>  		return err;
>  
> -	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
> -	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> +	idx = 0;
> +
> +	vb->inflate_vq = vqs[idx++];
> +	vb->deflate_vq = vqs[idx++];
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		struct scatterlist sg;
>  		unsigned int num_stats;
> -		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> +		vb->stats_vq = vqs[idx++];
>  
>  		/*
>  		 * Prime this virtqueue with one buffer so the hypervisor can
> @@ -610,10 +602,10 @@ static int init_vqs(struct virtio_balloon *vb)
>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> -		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
> +		vb->free_page_vq = vqs[idx++];
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> -		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
> +		vb->reporting_vq = vqs[idx++];
>  
>  	return 0;
>  }
> -- 
> 2.32.0.3.g01195cf9f

