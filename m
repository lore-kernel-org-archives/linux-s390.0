Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907837;
	b=mjBUM4slEeVUxe7cbnBqulsfvcv2lbZ+W39MYiWFqDuZsKM3i6Z7YNz1NJEcjxgvFyyb
	 UAnLMTvJ+9YFZKaJ8MElWD0mUeOK6y11tit7ePbx7Tcba/RQ4MZVaDJEqUQqXNApY8h9u
	 wTepGVuBn/pwMP05Xxs/Fjm0Oq1aMjyb3Gt4+PXYpcx+Bzv9lH/QBZOQB8kqXdDQA8nhA
	 +1soH53VJ2XuecJ9OREsUVhobi2X47tV31pwobh/i2QwEwmW6ZHN0hgJV8Z9fTfSiwBF3
	 vcSCyn391lZD4HDek+EBybyliUNUXhMCyoI7/aln4bCubVgrDan9qmY9zi7ptaOeiJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907837;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
	b=G2qNWkn+LxQBWBgkFUwMyvYY0FN76qbdaP8sKxLrhz4OMIFHDHBQCwvmO8HHNzO/i2FJ
	 fwIsuSorAat5I6Vv+cRgwiUNyBbkJn+ePfqkwjQNY/CtVO0pVMHpZINr6xozhOma0xTLm
	 U476UAp/KOZpyj0Vty3noRVt+MfpTCuL2EbRUDq2Qh8F0pA31JZXbPq2erhQmTN81HqyJ
	 GcIbv7i/cW9yAnj8Yt/WMdo+Dyv6GBc6ZQwXxkyQW7QiBVz/NvBMBKEa6cQ/83XMBc+47
	 DC+Kk0fclrVih/hbbAyqdW+ngC+wrciorB3dhJmeOohRQfSNbrShEN3fTvzV/+OK1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="G1LPv/D/";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ttPBOFVs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A8606EA61
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 19:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7A8606EA61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G1LPv/D/;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ttPBOFVs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793907835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
	b=G1LPv/D/v4f+DYPaBTJBhf9+VMRBn2NBUi8VxcZYrSuaO6R6s948HgFVdb1ZeAt9y2jDRB
	vTjhw7B8i6qTrrElHem6SJxaAdCcTE5T4VndMF/TbTn3mb2M0+FNGvyQmDmgplapvIoAbk
	wPj5md9m2fW6XvO+Ostk56BqPCj9380=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-EF5NvCjaPzevKVYFt8QDGA-1; Thu, 05 Nov 2026 14:43:52 -0500
X-MC-Unique: EF5NvCjaPzevKVYFt8QDGA-1
X-Mimecast-MFC-AGG-ID: EF5NvCjaPzevKVYFt8QDGA_1793907831
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a210f93860so19072205e9.0
        for <linux-s390@vger.kernel.org>; Thu, 05 Nov 2026 11:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793907831; x=1794512631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
        b=ttPBOFVs6NhaJnp2fTh3+qTNFTElSrrKwWT8A54LFwBlwetj/JtCEJgyG5e2kjD4T1
         nnO+gOcDMw7odnrw0SNH4visIFGQYXaZxKUjFvlpTkk0zFEUeenUdhhXEHxxufXR3iGT
         DoJDC8nG+GJYzukl1QbjEIDIl9XfpXGBjMixef113++E1RZGxf7hLIZ17RLRGsq/8tPf
         Q5lGJ7d/DHBDZ13RWxf2hbIUo7ntNa45jgm0M27Nbro8gxxIIhjLW3HALgVMP0CPF7ny
         roputxNYHJnFtamQ5uSxqnPiGrCFN20kdw9Lu67uL3XwbdZxmI7/yfV0TrA+jD5G98Df
         I61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907831; x=1794512631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFGBHAMRbC8gjr7H7RJhMUHxgVniv6NNOgtYNglESN4=;
        b=kf1yDaRysIm7Vmvgp40++/nV5oVeYewxssyIEb0teoVjHGUsz3SzzvYGPegKlWrPoN
         2zymOfJwELYj4XmYr8rcnl7no+BS0nu9imfAVe0ny5k5gRNrMlyVtSE8j42hHe4pshyP
         SZKez3G4n9wrFD/XFH2hm/oLF4muNITqvcCgSMQZxjL9/K1l2wNysy3AfYxO9b7Af4TT
         aC/ZCkcUawcJ1mt0alJqBmC1w1slsZ8m+e70PoYx+OBpHgViHAUfeASJurVQd8z4ZiJO
         vzg2zf1Nd2EK4NwZhJgijH+o7WOPXo+zXfbP88xlG81jE3sG2kOANOdB+/xHxsvgMdsf
         T6gA==
X-Forwarded-Encrypted: i=1; AKwUvBxHUgLZUdq0WmSrFvpULG0/D75pNS6g69MS6WlTRJ9LFyB84v5kXpI4Z92QyRiIG39oTH49zQt0vazv@vger.kernel.org
X-Gm-Message-State: APuU4Z8SipVfZQihbPWxs2kifGYMZsOm1Dlt3FdZUT7Ba06zmYd/ZiYh
	+bG7PF85NrdLQiRMSrLx+FySuNfizvjMZ9s82a9DUtVNyTBUNdGb+XMCXzm4y9Umt5k8hHLcqUA
	QBvRnNvayq0jNu9sNjJ1s8F0/1WPv/mpH7ZA04y/dQkcGT0w4Wzc+jI+77KgFbWI=
X-Gm-Gg: AYBFou3d8rqj7XtAvl/fqMWqBygbTsxHpPgP8JtypUYWSiXjWO3Vb54KbIvixAC8yED
	FTau0xxYOMctuiaI0WoUbKHMCc61WjuugpLJzvSdp6MJnaoSkt3Vx8bDBmum/PFc7HmpWCSboyo
	ezgsgYKAOGwbpi/24Mzmef/dO+LHB3hLYOizaKLvf4XOFri5dEzvl2xGywmms8XeSCm+ikYSxXI
	eyRcss5YjiMEXj5srwmizLUBCqjeDYKhGYfE1uA4KPH98q+GN51NyU3yo4SGpFPF+8de6OMzN2Y
	6rSSYWYagVXDTWVG/Ei4cOpwAPJMJFv5J9SHBGVWm34x7+6sth+Q1bGFi5fq6Fgpn6ttDrXQtm3
	kUk5P/FEtZduVjL+VStdXudYAHvSkY/U+kPsaqrZfaQ==
X-Received: by 2002:a05:600c:19cf:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4b6dff85599mr2217365e9.33.1793907830809;
        Thu, 05 Nov 2026 11:43:50 -0800 (PST)
X-Received: by 2002:a05:600c:19cf:b0:4a1:fbf8:55c9 with SMTP id 5b1f17b1804b1-4b6dff85599mr2216835e9.33.1793907830232;
        Thu, 05 Nov 2026 11:43:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4527fed5bsm206845465e9.3.2026.11.05.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:43:49 -0800 (PST)
Date: Thu, 5 Nov 2026 14:43:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>, virtualization@lists.linux.dev,
	linux-um@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: return an error pointer from
 vring_create_virtqueue()
Message-ID: <20261105144316-mutt-send-email-mst@kernel.org>
References: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105193426.2999631-1-stjepan.poljak@gmail.com>

On Thu, Nov 05, 2026 at 08:34:25PM +0100, Stjepan Poljak wrote:
> vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
> on any failure, so the error returned from vring_alloc_queue_split()
> is lost and turned into -ENOMEM. This is especially misleading if
> vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
> queue size is not a power of two):
> 
>   virtio_blk virtio0: Bad virtqueue length 100
>   virtio_blk virtio0: probe with driver virtio_blk failed with error -12
> 
> So the error points whoever debugs it at an allocation failure that
> never happened.
> 
> Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
> or vring_alloc_queue_packed(), or -ENOMEM when allocating the
> virtqueue itself fails. Make the callers, virtio_pci (modern and
> legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
> with IS_ERR() and pass the error on. The error path in virtio_ccw
> deletes a non-NULL vq, so clear vq there before taking it.
> 
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

not how you ae supposed to attribute LLM use.

> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>


> ---
> Tested on x86_64 with a virtio-mmio virtio-blk device offering a
> 100-entry queue: the probe now fails with -22 instead of -12, and a
> 128-entry queue probes as before. The other transports are only
> compile-tested (x86_64, ARCH=um, s390 with clang, W=1).
> 
> No Fixes: tag, since the error has been -ENOMEM since 2010 and nothing
> regressed.
> 
> This conflicts trivially with patch 07/12 of Alexander Graf's "virtio:
> support devices that own their virtqueue memory" v2:
> https://lore.kernel.org/virtualization/20260818211425.91009-1-graf@amazon.com/
> ---
>  arch/um/drivers/virtio_uml.c       |  4 ++--
>  drivers/s390/virtio/virtio_ccw.c   |  5 +++--
>  drivers/virtio/virtio_mmio.c       |  4 ++--
>  drivers/virtio/virtio_pci_legacy.c |  4 ++--
>  drivers/virtio/virtio_pci_modern.c |  4 ++--
>  drivers/virtio/virtio_ring.c       | 12 +++++++-----
>  drivers/virtio/virtio_vdpa.c       |  4 ++--
>  include/linux/virtio_ring.h        |  6 +++++-
>  8 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 881c34098a74..8b645523277f 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -984,8 +984,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>  
>  	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
>  				    ctx, vu_notify, callback, info->name);
> -	if (!vq) {
> -		rc = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		rc = PTR_ERR(vq);
>  		goto error_create;
>  	}
>  	vq->priv = info;
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 552d77998012..c5a30f0a2bc2 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -590,10 +590,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>  				    vdev, true, may_reduce, ctx,
>  				    notify, callback, name);
>  
> -	if (!vq) {
> +	if (IS_ERR(vq)) {
>  		/* For now, we fail if we can't get the requested size. */
>  		dev_warn(&vcdev->cdev->dev, "no vq\n");
> -		err = -ENOMEM;
> +		err = PTR_ERR(vq);
> +		vq = NULL;
>  		goto out_err;
>  	}
>  
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e2ec0ec01d67..c403a025006e 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -396,8 +396,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>  	/* Create the vring */
>  	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
>  				 true, true, ctx, notify, callback, name);
> -	if (!vq) {
> -		err = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		err = PTR_ERR(vq);
>  		goto error_new_virtqueue;
>  	}
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 8115aa39e01e..9d94fffff344 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -130,8 +130,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
>  				    true, false, ctx,
>  				    vp_notify, callback, name);
> -	if (!vq)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(vq))
> +		return vq;
>  
>  	vq->num_max = num;
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 922e2df027de..28ccb2130e27 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -720,8 +720,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  				    SMP_CACHE_BYTES, &vp_dev->vdev,
>  				    true, true, ctx,
>  				    notify, callback, name);
> -	if (!vq)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(vq))
> +		return vq;
>  
>  	vq->num_max = num;
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..6dd4a7651bde 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1421,13 +1421,13 @@ static struct virtqueue *vring_create_virtqueue_split(
>  	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
>  				      may_reduce_num, map);
>  	if (err)
> -		return NULL;
> +		return ERR_PTR(err);
>  
>  	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				   context, notify, callback, name, map);
>  	if (!vq) {
>  		vring_free_split(&vring_split, vdev, map);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	to_vvq(vq)->we_own_ring = true;
> @@ -2671,15 +2671,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  {
>  	struct vring_virtqueue_packed vring_packed = {};
>  	struct virtqueue *vq;
> +	int err;
>  
> -	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
> -		return NULL;
> +	err = vring_alloc_queue_packed(&vring_packed, vdev, num, map);
> +	if (err)
> +		return ERR_PTR(err);
>  
>  	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
>  					context, notify, callback, name, map);
>  	if (!vq) {
>  		vring_free_packed(&vring_packed, vdev, map);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	to_vvq(vq)->we_own_ring = true;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f9559b6b2e0b..c1b6134b2267 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -208,8 +208,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
>  					true, may_reduce_num, ctx,
>  					notify, callback, name, map);
> -	if (!vq) {
> -		err = -ENOMEM;
> +	if (IS_ERR(vq)) {
> +		err = PTR_ERR(vq);
>  		goto error_new_virtqueue;
>  	}
>  
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index c97a12c1cda3..c808ca7e8d58 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -66,6 +66,9 @@ struct device;
>   * may_reduce_num is set, then this may allocate a smaller ring than
>   * expected.  The caller should query virtqueue_get_vring_size to learn
>   * the actual size of the ring.
> + *
> + * Returns the virtqueue or an ERR_PTR() on failure: -EINVAL if num is
> + * not a valid ring size, -ENOMEM if the ring could not be allocated.
>   */
>  struct virtqueue *vring_create_virtqueue(unsigned int index,
>  					 unsigned int num,
> @@ -80,7 +83,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
>  
>  /*
>   * Creates a virtqueue and allocates the descriptor ring with per
> - * virtqueue mapping operations.
> + * virtqueue mapping operations.  Returns the virtqueue or an ERR_PTR()
> + * on failure, like vring_create_virtqueue().
>   */
>  struct virtqueue *vring_create_virtqueue_map(unsigned int index,
>  					     unsigned int num,
> 
> base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
> -- 
> 2.53.0

