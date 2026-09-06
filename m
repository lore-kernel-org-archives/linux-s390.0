Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFC3A9D8B
	for <linux-s390@vger.kernel.org>; Sun,  6 Sep 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721178; cv=none; b=X69KaNzoJ+Cma3eiWiLUPQ+hh4lG5fQPYoB5prmXGD6WRJAiUTr1eLpV0GBq5ngNcTWyvtA3vbrFoiH08cbmmHEoMgreBs+2ka3m78GbWi3z+Ov8y3zOyVYg3ksvfOlQDp5TiqtGmRg6D3WMOJXqmRIF88tRemEuwH8oZ3S0SUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721178; c=relaxed/simple;
	bh=GMPYh/BDHr7AL+7oovYHgh1rFAozNMA+LI+Dt7ATe0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHAdR25Qk8ecP6SY39rTh83XXXV2d49WLcF3zhrNonwHVllGp+gb1pKpHCE/KSjU9rkdApq6xvsZlIjJ4n4r+K7BArf5wgkNKobKWrl61Xf9FrueL74TzfxKsf94TKQxh6QImD5l4Df/4lMetls48c4z8gwfjQk5wfjkTDqzNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXB8GS3c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpJgGtmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXB8GS3c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpJgGtmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788721174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsIbDGQjULL+F6DGJQ2UNVf4v0nalwigJPjkFSk+cAA=;
	b=NXB8GS3cWp7Uq1iS2H/snkDJ1z3j4PEBTHNQvsSmcrt8YZrcxhH9pa2XlDCEdG8LiUnHbl
	foMo09XH0voxuPd0gq0Vv7XOJNYwYvgfTB1ETDak54W/Vs0WKXxKz8Nj/aATF7Q7pQsb3n
	pKo0ApyNOQvvv+HdrBfnHwhJjrKRMC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-2e3rXflDNfyf3bWZlyP0vA-1; Sun, 06 Sep 2026 14:59:33 -0400
X-MC-Unique: 2e3rXflDNfyf3bWZlyP0vA-1
X-Mimecast-MFC-AGG-ID: 2e3rXflDNfyf3bWZlyP0vA_1788721172
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-482e8e1ac69so2166702f8f.0
        for <linux-s390@vger.kernel.org>; Sun, 06 Sep 2026 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788721172; x=1789325972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsIbDGQjULL+F6DGJQ2UNVf4v0nalwigJPjkFSk+cAA=;
        b=UpJgGtmYuRPDd2wwO7pAiNajvauDBmWYrnGuFGKN2NCqFir9j9s/5YZxQUAjMXqCPd
         kjE31en6OlYL/VhvbOg7mMLu95wM/pPMe+U4F/rpHRXCGDFOq2n5Kpfvcvg6zfptvugs
         8O1zAjGos65AYX7Aios3BMOcRuXm/qAOo6Q04gMjcz5OIscXOMdJfNRbD+mgAf9TZjgN
         ng+4BOTbeUc3WsHU+WeFoP16GNXU/OQK245ei7vcXX1lz5Nwfcp8Rv2SldLJydta4p/9
         34CgVx151gnCT7ecPYkFbHOnxEmLzwOmYTf5Fk5sW0xShboH1LUP0KF5NyMrIZF53uqO
         WIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788721172; x=1789325972;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsIbDGQjULL+F6DGJQ2UNVf4v0nalwigJPjkFSk+cAA=;
        b=QE9EIlpgG2IM9QZvgNGZiLt4bKLDK76NzDuk4BuDBDvzBArCfz545oVvGYe6JoFW44
         i4ZOlJ/YL9RxUPQbQL+hLRGhAbBY4xXeCys84UzYv1xuhctZFHhnwjXDg0iC7bi5SFln
         Ex6ZC+Ju11+T5Ty2fYLY7EBq78v4/FfcHsUdAqzlRNjT/9HFr6obhbiZcfnPW63HDB/j
         dh9Sc0yIR/Dzps0EeIILJoDfSkBUYhE3weSUleWKOz4xCc48Z67TAJXV2U2DyCXLSnTL
         FNUPXYKejDdtS7/gYhAeum5atfYkaAAZVD93ywhLjUGlDiluCYvMhVErOtxsGVevHNKK
         2OzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjaIXV/yZPe1l10MUIdzpGNZRlpGYTn/aOhFZpz4RD75qHcovjJrdQ6ZdqMkdx1UhLbV8GJa43cWnw@vger.kernel.org
X-Gm-Message-State: AFuF++mQYf/iSrPPoOEI74ap2CJq6WQoy706B7iPrDSY70rebC7w7P2b
	g8CYG8HlHE+ghZQV24I27W94+2E5nvEjAe05oae4ZDblDvdIPvCzGJbpidSSbwV3v/FVld7nOMO
	IljRVPJTq0ezMiS0bvCZmIMvaA5/+CL7G2SGQQPZzyWtysYArmBSv9rJHzR29v5I=
X-Gm-Gg: AYBFou2MhvIgHzJlSXPKo24ycvVaCD+0k+oAdh1I6EEysrDvAH76fc5hRGaQ4lux01W
	SDfeQpbEXvz4pmaOFUnvqMPkriQkwwagXUjnRaBEiNEF/tIOzLBzOFEiJXI8CYeAMtTMvYrCIpB
	Vn8sE8nyPnmIbq6Lwxe3UEQigw7Jse0IaykEXqdPiYbQmIF2O9AP37vHFQNsdnGfzCT2a383esS
	5Nv3NW+/uXQ4sLBONlUkrnbIGl+8OE1lBORkUZMNFbvkHLyj3ejs6VXrL7Dut2JKo24iU5OoNB4
	KVSguMf2X74aZLw+DNhscSJHBm2RmBdajgVor/YWTHA0rvldt4MuRjDC/6Rh/FPPYaluROsPKat
	dCsLboXps9PZIfr7GfFjjFKU=
X-Received: by 2002:a05:600c:3544:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49cf82bea0amr164278375e9.3.1788721172204;
        Sun, 06 Sep 2026 11:59:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49cf82bea0amr164277895e9.3.1788721171624;
        Sun, 06 Sep 2026 11:59:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5941cb4sm170369945e9.4.2026.09.06.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:59:30 -0700 (PDT)
Date: Sun, 6 Sep 2026 14:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] virtio: implement synchronize_cbs for remaining
 transports
Message-ID: <20260906145728-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-4-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-4-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:59PM +0200, Karl Mehltretter wrote:
> virtio_reset_device() now calls synchronize_cbs to wait for running
> callbacks. Its synchronize_rcu() fallback does not cover workqueue or
> sleepable callbacks.
> 
> Add the missing hooks. UML waits for its shared IRQ; TmFIFO takes the
> existing per-direction locks held around vring_interrupt(). Virtio-vdpa
> uses a per-device rwlock around its callbacks, which must already be
> hard-IRQ safe.
> 
> Remoteproc callbacks can run in hard-IRQ or process context, and rpmsg
> callbacks can sleep, so use one SRCU domain per rproc. Enter it before
> looking up the queue. Initialize it in rproc_alloc(), returning NULL if
> that fails, and clean it up at final release. cleanup_srcu_struct() can
> sleep, so document that rproc_put() and rproc_free() may sleep when
> dropping the last reference.
> 
> These hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>


sounds like sashiko sees some issues here.
they seem legit.
I would also maybe split, 1 patch per transport.


> ---
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  6 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 7425a8548141..baca6b09e9ac 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -20,6 +20,7 @@
>   *
>   * Based on Virtio MMIO driver by Pawel Moll, copyright 2011-2014, ARM Ltd.
>   */
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -869,6 +870,14 @@ static void vu_reset(struct virtio_device *vdev)
>  	vu_dev->status = 0;
>  }
>  
> +static void vu_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
> +
> +	if (vu_dev->irq >= 0)
> +		synchronize_irq(vu_dev->irq);
> +}
> +
>  static void vu_del_vq(struct virtqueue *vq)
>  {
>  	struct virtio_uml_vq_info *info = vq->priv;
> @@ -1121,6 +1130,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
>  	.reset = vu_reset,
>  	.find_vqs = vu_find_vqs,
>  	.del_vqs = vu_del_vqs,
> +	.synchronize_cbs = vu_synchronize_cbs,
>  	.get_features = vu_get_features,
>  	.finalize_features = vu_finalize_features,
>  	.bus_name = vu_bus_name,
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 3c6408581373..c260e3a1544e 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -1135,6 +1135,19 @@ static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
>  	tm_vdev->status = 0;
>  }
>  
> +static void mlxbf_tmfifo_virtio_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
> +	struct mlxbf_tmfifo *fifo = tm_vdev->vrings[0].fifo;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fifo->spin_lock); i++) {
> +		spin_lock_irqsave(&fifo->spin_lock[i], flags);
> +		spin_unlock_irqrestore(&fifo->spin_lock[i], flags);
> +	}
> +}
> +
>  /* Read the value of a configuration field. */
>  static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
>  				    unsigned int offset,
> @@ -1179,6 +1192,7 @@ static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
>  	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
>  	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
>  	.reset = mlxbf_tmfifo_virtio_reset,
> +	.synchronize_cbs = mlxbf_tmfifo_virtio_synchronize_cbs,
>  	.set_status = mlxbf_tmfifo_virtio_set_status,
>  	.get_status = mlxbf_tmfifo_virtio_get_status,
>  	.get = mlxbf_tmfifo_virtio_get,
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 1ed406714849..1b139d25ab2b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2410,6 +2410,7 @@ static void rproc_type_release(struct device *dev)
>  
>  	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
>  
> +	cleanup_srcu_struct(&rproc->vq_srcu);
>  	idr_destroy(&rproc->notifyids);
>  
>  	if (rproc->index >= 0)
> @@ -2507,6 +2508,11 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (!rproc)
>  		return NULL;
>  
> +	if (init_srcu_struct(&rproc->vq_srcu)) {
> +		kfree(rproc);
> +		return NULL;
> +	}
> +
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
>  	rproc->elf_class = ELFCLASSNONE;
> @@ -2571,6 +2577,8 @@ EXPORT_SYMBOL(rproc_alloc);
>   *
>   * If no one holds any reference to rproc anymore, then its refcount would
>   * now drop to zero, and it would be freed.
> + *
> + * Context: May sleep if this drops the last reference.
>   */
>  void rproc_free(struct rproc *rproc)
>  {
> @@ -2586,6 +2594,8 @@ EXPORT_SYMBOL(rproc_free);
>   *
>   * If no one holds any reference to rproc anymore, then its refcount would
>   * now drop to zero, and it would be freed.
> + *
> + * Context: May sleep if this drops the last reference.
>   */
>  void rproc_put(struct rproc *rproc)
>  {
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d5e9ff045a28..ecc022e354db 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -23,6 +23,7 @@
>  #include <linux/err.h>
>  #include <linux/kref.h>
>  #include <linux/slab.h>
> +#include <linux/srcu.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -89,14 +90,19 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
>  {
>  	struct rproc_vring *rvring;
> +	int srcu_idx;
> +	irqreturn_t ret;
> +
> +	srcu_idx = srcu_read_lock(&rproc->vq_srcu);
>  
>  	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
>  
>  	rvring = idr_find(&rproc->notifyids, notifyid);
> -	if (!rvring || !rvring->vq)
> -		return IRQ_NONE;
> +	ret = rvring && rvring->vq ? vring_interrupt(0, rvring->vq) : IRQ_NONE;
> +
> +	srcu_read_unlock(&rproc->vq_srcu, srcu_idx);
>  
> -	return vring_interrupt(0, rvring->vq);
> +	return ret;
>  }
>  EXPORT_SYMBOL(rproc_vq_interrupt);
>  
> @@ -242,6 +248,13 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
>  	dev_dbg(&vdev->dev, "reset !\n");
>  }
>  
> +static void rproc_virtio_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct rproc *rproc = vdev_to_rproc(vdev);
> +
> +	synchronize_srcu(&rproc->vq_srcu);
> +}
> +
>  /* provide the vdev features as retrieved from the firmware */
>  static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  {
> @@ -330,6 +343,7 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
>  	.find_vqs	= rproc_virtio_find_vqs,
>  	.del_vqs	= rproc_virtio_del_vqs,
>  	.reset		= rproc_virtio_reset,
> +	.synchronize_cbs = rproc_virtio_synchronize_cbs,
>  	.set_status	= rproc_virtio_set_status,
>  	.get_status	= rproc_virtio_get_status,
>  	.get		= rproc_virtio_get,
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index de2af696de6c..4f9e70c1332e 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -27,6 +27,7 @@
>  struct virtio_vdpa_device {
>  	struct virtio_device vdev;
>  	struct vdpa_device *vdpa;
> +	rwlock_t callback_lock;
>  	u64 features;
>  };
>  
> @@ -123,8 +124,24 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
>  static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
>  {
>  	struct virtqueue *vq = private;
> +	struct virtio_vdpa_device *vd_dev;
> +	unsigned long flags;
> +	irqreturn_t ret;
>  
> -	return vring_interrupt(0, vq);
> +	vd_dev = to_virtio_vdpa_device(vq->vdev);
> +	read_lock_irqsave(&vd_dev->callback_lock, flags);
> +	ret = vring_interrupt(0, vq);
> +	read_unlock_irqrestore(&vd_dev->callback_lock, flags);
> +
> +	return ret;
> +}
> +
> +static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> +
> +	write_lock_irq(&vd_dev->callback_lock);
> +	write_unlock_irq(&vd_dev->callback_lock);
>  }
>  
>  static struct virtqueue *
> @@ -439,6 +456,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
>  	.reset		= virtio_vdpa_reset,
>  	.find_vqs	= virtio_vdpa_find_vqs,
>  	.del_vqs	= virtio_vdpa_del_vqs,
> +	.synchronize_cbs = virtio_vdpa_synchronize_cbs,
>  	.get_features	= virtio_vdpa_get_features,
>  	.finalize_features = virtio_vdpa_finalize_features,
>  	.bus_name	= virtio_vdpa_bus_name,
> @@ -472,6 +490,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
>  	vd_dev->vdev.config = &virtio_vdpa_config_ops;
>  	vd_dev->vdev.map = vdpa->map;
>  	vd_dev->vdpa = vdpa;
> +	rwlock_init(&vd_dev->callback_lock);
>  
>  	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
>  	if (vd_dev->vdev.id.device == 0)
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index a44368737b39..ad6bccbdfabc 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/srcu.h>
>  #include <linux/virtio.h>
>  #include <linux/cdev.h>
>  #include <linux/completion.h>
> @@ -230,6 +231,7 @@ enum rproc_features {
>   * @rvdevs: list of remote virtio devices
>   * @subdevs: list of subdevices, to following the running state
>   * @notifyids: idr for dynamically assigning rproc-wide unique notify ids
> + * @vq_srcu: SRCU domain for virtqueue callbacks
>   * @index: index of this rproc device
>   * @attach_work: workqueue for attaching rproc
>   * @crash_handler: workqueue for handling a crash
> @@ -276,6 +278,7 @@ struct rproc {
>  	struct list_head rvdevs;
>  	struct list_head subdevs;
>  	struct idr notifyids;
> +	struct srcu_struct vq_srcu;
>  	int index;
>  	struct work_struct attach_work;
>  	struct work_struct crash_handler;
> -- 
> 2.39.5 (Apple Git-154)

