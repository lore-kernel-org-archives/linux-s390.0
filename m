Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEE254F8C
	for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878521; cv=none; b=W4uLpjUmUTQ46aZIVs7YwyD+iUOiiaAsfBQS6RDnlxEXvU7n158ZW62OJ+CsVD2IWpRFbnqFbzwT9OSKCzcxIENhoRT4Qy9zBLXvvhFMPNDv9koKzFoHnvrGn3uWGsErO/dRc7KBpIVw1wt+oJkZ+PUQdB2DxoANfZuiKmqWnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878521; c=relaxed/simple;
	bh=KT+gmGxmqPGTmSPB6Wmg2kppdu71XosMa8bHRQqSGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/P869hSfrnlkR4eiSewXQ9UmLeVjJPpslLLkQ2Bg5FXy4uBKJ9ggxP8jO9AOMSJYI5SPvMpL7RAu9jo1pv4gBWQJZumYZl6QDYut7sTHaY84WUO86/jouWOQfo4K4K+0RMR4uQmxBfM19E1b06dA8SmpFQUnGKl6d9w1XBvjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTR9iNQB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTR9iNQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5cLrcBZuYCEeePJIc62tRcAqhOXIeLud2uXAMK36HI=;
	b=YTR9iNQBxz8JHO3BoOsYjwyWFp9sZfmtM0IpYBVI5EZjZTnfGFa2jryYz227wu0hfbw7y/
	lk+uBKyPsLxgrl6lRkCEXL1K1FegAiAoSF91AqYJQ/ZINN6zJKglVHJRW+Or0eJN4r05kv
	H3Bk82A26kfWe1P0xMEFBpLaIK1f36E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-swJbIESdOCmzQpKvdo2YLw-1; Thu, 20 Jun 2024 06:15:17 -0400
X-MC-Unique: swJbIESdOCmzQpKvdo2YLw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6ef7afd90aso34525366b.2
        for <linux-s390@vger.kernel.org>; Thu, 20 Jun 2024 03:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878516; x=1719483316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5cLrcBZuYCEeePJIc62tRcAqhOXIeLud2uXAMK36HI=;
        b=ohTYgNR+06GIqY/juWUo8VnUKFN2a/v0jwWH56P2KEyj/VOY9wMjmOTrDKzmMzXANZ
         5d3158hhx7fYXyPmkWDpjLdpO9KJvrLTNEjCXHXfsTTMYR9PeCLXIciY87SdFnIePaJs
         tXg0xoLIJGpSiLz/TipOwKGYCGn0xRQV4vd4nXi9hPL6QjHILd1IR/q8tiieNJmVPrpY
         573/3XjtFF6P3Xg9cmQMNalAsvL1AS7ALrDLGRZkNt7xAppLKe9ww3qBTxOFm9hkpZC4
         1SCICNZc3w65Ch0AhX4FRibuZwmf92c9jCJzLsMMMY/Aq01T3AdsR4jTg+wEdOjcE8xg
         LXbw==
X-Forwarded-Encrypted: i=1; AJvYcCXNrRRNBbdl0m2KQPw2n3T0A+Xr/aA9ZR8eKU3Ua7ceaep6vxxCAuiqum2/un2fKS8JnBV86dhNqi7w8k/vIo4HNipEfR0VhFOEnQ==
X-Gm-Message-State: AOJu0YwZCRj0/fiqzthnYL5qH6ZAUOQqMODpWUoEkDQEcuiCpRsxvRje
	hckKCaYDmuAOvTejhKQEG8GO3XJFER2lYl7wsbnDhTfYrw/+YiG5yM9XpkMErZiw6ZsoO25eYkJ
	Uud3s5l5NppzLmOH/xILCc69VKNl/G19IjRIiFLT+p8i2immHlYgwmzJSu6U=
X-Received: by 2002:a17:907:2d08:b0:a6f:501d:c229 with SMTP id a640c23a62f3a-a6fab60ba19mr339713366b.9.1718878515674;
        Thu, 20 Jun 2024 03:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLolJ3t9kBt/FV6CSCM4Ryf1U+wjtgY8UpBQflIEZZb/4e3FwGJgSy2Bl6IqLXHgvitjoz1Q==
X-Received: by 2002:a17:907:2d08:b0:a6f:501d:c229 with SMTP id a640c23a62f3a-a6fab60ba19mr339707566b.9.1718878514780;
        Thu, 20 Jun 2024 03:15:14 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41a7asm750071366b.159.2024.06.20.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:15:14 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:15:08 -0400
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
Message-ID: <20240620061202-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
 <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>

On Thu, Jun 20, 2024 at 05:20:49PM +0800, Xuan Zhuo wrote:
> On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > > >
> > > > >  static inline
> > > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > -			const char * const names[],
> > > > > -			struct irq_affinity *desc)
> > > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > +		    const char * const names[],
> > > > > +		    struct irq_affinity *desc)
> > > > >  {
> > > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > > +	struct virtio_vq_config cfg = {};
> > > > > +
> > > > > +	cfg.nvqs = nvqs;
> > > > > +	cfg.vqs = vqs;
> > > > > +	cfg.callbacks = callbacks;
> > > > > +	cfg.names = (const char **)names;
> > > >
> > > >
> > > > Casting const away? Not safe.
> > >
> > >
> > >
> > > Because the vp_modern_create_avq() use the "const char *names[]",
> > > and the virtio_uml.c changes the name in the subsequent commit, so
> > > change the "names" inside the virtio_vq_config from "const char *const
> > > *names" to "const char **names".
> >
> > I'm not sure I understand which commit you mean,
> > and this kind of change needs to be documented, but it does not matter.
> > Don't cast away const.
> 
> 
> Do you mean change the virtio_find_vqs(), from
> const char * const names[] to const char *names[].
> 
> And update the caller?
> 
> If we do not cast the const, we need to update all the caller to remove the
> const.
> 
> Right?
> 
> Thanks.


Just do not split the patchset at a boundary that makes you do that.
If you are passing in an array from a const section then it
has to be const and attempts to change it are a bad idea.


> >
> > --
> > MST
> >

