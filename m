Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5483ACA4B
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816007; cv=none; b=HufP57yvCGTS5JP7xGDy6CzBNEqOkZw6IU3n1DJSyErtJMCOcB1DG7r49+cbtq3XbUEzLbaAqH/eSMd22kA+kQm4yW7Qv1eWcmnwcDGJiEOoLbMdcECia+tHpYD6ITIItWUif57yVrS320D5DkhUL7enL+kt55fL4ad2J6YY/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816007; c=relaxed/simple;
	bh=k/QImo2NCCg/3TCmY5Vmxee1X5XnCsMH8Zic6TCGMok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGPKdOwHwGdAjum4IjrCL+sGyiCIgFtSYZUfnaO2EXILwRn9HClXWT0OUY1SlwC460ahwAla9hq5J1DglO8txrLCX113iIjoMkatCoR0FfVgikXLGVp6oKp1lS0915NwX738yF1VXLwj3eC0Htif4wqX+YZjsJaN9gmkEr963VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPfpvjV4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=heMfVXUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPfpvjV4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="heMfVXUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788816005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNqMvmk3XjOuru6dfpLyr8VojH7qEb8Z1Jw+8letoJM=;
	b=GPfpvjV4KK3GVMD9YFmKKVm9YX8RrQNW/1u7yco+0lcm/O9Iiq1zPPMtmyWEhCF5uU+L3g
	JyQ1qXRuJTfBhjAAgNp4W+9VBol07MqfwwCFbaQA4Ro2j+xzxoMvK/ELTvVLFJglWIK4qx
	c7iZSXf4vnWCLDAwkDiqmSTmQ+mRQi4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-667q0wWPPOKON6piel8Cmw-1; Mon, 07 Sep 2026 17:20:04 -0400
X-MC-Unique: 667q0wWPPOKON6piel8Cmw-1
X-Mimecast-MFC-AGG-ID: 667q0wWPPOKON6piel8Cmw_1788816003
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482db84a6eeso3597149f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788816003; x=1789420803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNqMvmk3XjOuru6dfpLyr8VojH7qEb8Z1Jw+8letoJM=;
        b=heMfVXUnYTwR6xc7/U0xMCI+YcZkGMs6MdIGGA2wbN0FXU81vlTc05NbefxBxN7M3S
         FgMj5p+YV/95MbLAtwI3MKUF3PWL4ls7kFyizcQ5+JJiSL0WnAkzdCY7uwMI9DLOwBCp
         Z+bdjTYnn1yMutTH/5WymTo8evVdflZIUymfw8TV0mxOqKqdJzhanLZ5xsOVTlEtFl6M
         08wDpAJZAtUD3k4fZUslpqph4G/Pe+flPXAFzdJPK4A2Vv6sZl7G43knGc+7n5OyXDjY
         WX8TS267PQTPlVoNsjzYBNw3DHMJSfOEW0DKGHBqSUO3x8zDhcYd8GFnXvjpW3MFbBQK
         yBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816003; x=1789420803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dNqMvmk3XjOuru6dfpLyr8VojH7qEb8Z1Jw+8letoJM=;
        b=Zv2WGpTz3ppCZpk/AYbbvQfkR3q5CpNdY8H9SWwltmrnZUQe24mMsWFFTUrnWa2LQy
         hilIj4FTXu2ZBvDUsNyh/9bHit5CbfYbHUF1epxL2Lt3oiF3+CRUUmN710v0iVPpALKF
         OFWmaAkPXDMY6jJiyHtP8zUr33vz1i0FLGr/HlEnEAZS0G6HDnTsx//VLXqo4A4jnEAf
         BBE/0ryGU92bm2XpfB62OuwpJUDsbstDDxcwiU/u3eiEcjxuFkE1aMUCcS57DS/RtYTZ
         3zJ7vhLjAh2UkOPTPgQBwxmXDns+NV7KsHws0YgCurHRHwBSYf4ECVShRT7DhSXwhkCH
         a6XQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/yP0Cgfb+okXlCkWHF4BaUkEm2f76XyF9UNx4jqQgZZOLfxGPdu71HkfFQKc6av+hwATNXdbP/qub@vger.kernel.org
X-Gm-Message-State: AFuF++nv13Vwbh9vXvcsWeUXXrwNdyCqAJofms5yCPsCyYIbyYkNKSWn
	vk6tfb3BClGynCyqnj9aEkcEn4iR+IqqAUN50be0+f+zMNpMVOLUvz8d1ylaYgHLZuzcHmM85Kd
	D+0XN9DAXfPxBfWdPGi8lw2F94frfjSkXUscAR2hIRim24znOtToWpT/KzY099Nw=
X-Gm-Gg: AYBFou3BQkeeRxBr5rFuIftziFBEb0QuDc2f0eNuCqCRg0CMMm4mNOtV2CCBj7jyXdQ
	T9SDwErK5cboKs3E7Jtti3zU8tiytPyjGWJWDLzMCfg8LuHCf9/74VTniM6mW7DAtHTFZ/yp1OY
	Wy6zf4LLes0jOrjc+fYfDN1NVw4lLu9oyGTQJvJUqkvXFdm/Aj76Ab9H4IC4JTwZax+z8+l6ci1
	coWVGTNJrNzQxQEzF7cLlTUH1HwE0ESDFY+vPJveOoi6+5Uwd5BgE3LdkvRi6/jcK21cDQRzw0T
	eMWHy2lVSH9unPYrQr7v1A9NwWd2je3/Jyc/nEJLBaJqA9689PHPQ5Q+qRplNgjWqD7F5pSiCT5
	EWSgEG09i7DexbgzrFDCDAYg=
X-Received: by 2002:a05:6000:491a:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-4858704a9d7mr51670316f8f.8.1788816002924;
        Mon, 07 Sep 2026 14:20:02 -0700 (PDT)
X-Received: by 2002:a05:6000:491a:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-4858704a9d7mr51670251f8f.8.1788816002441;
        Mon, 07 Sep 2026 14:20:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bbb51sm32653149f8f.30.2026.09.07.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:20:01 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:19:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, kvm@vger.kernel.org,
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907171921-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260905153357.7FE5E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905153357.7FE5E1F00A3A@smtp.kernel.org>

On Sat, Sep 05, 2026 at 03:33:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `virtio_reset_device()` in the error path of `virtinput_probe()` before deleting virtqueues, potentially leading to use-after-free or memory corruption by the active hardware/hypervisor.

This one is fixed in my tree.

> - [High] The driver leaks DMA mappings for unconsumed buffers in the event virtqueue (`vi->evt`) upon device removal or suspend/freeze.
> --
> 
> commit 71bbbcca0b03e3c67fa905a8357e9d3ad23e7fe4
> Author: Karl Mehltretter <kmehltretter@gmail.com>
> 
> virtio_input: stop callbacks before unregistering input device
> 
> virtinput_remove() unregisters the input device before resetting the
> virtio device. virtinput_recv_events() drops vi->lock around input_event(),
> so clearing vi->ready does not stop a callback that passed the entry check.
> It can still use vi->idev, requeue buffers and kick the queue.
> 
> > diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> > index deec24e8e6828..7b654af0a42cb 100644
> > --- a/drivers/virtio/virtio_input.c
> > +++ b/drivers/virtio/virtio_input.c
> [ ... ]
> > @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
> >  	vi->ready = false;
> >  	spin_unlock_irqrestore(&vi->lock, flags);
> >  
> > -	input_unregister_device(vi->idev);
> > +	/* Callbacks use vi->idev. */
> >  	virtio_reset_device(vdev);
> > +	input_unregister_device(vi->idev);
> >  	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
> >  		kfree(buf);
> >  	vdev->config->del_vqs(vdev);
> 
> [Severity: High]
> This is a pre-existing issue, but does this cleanup leak DMA mappings for
> the event virtqueue (vi->evt)?
> 
> The cleanup loop correctly detaches and unmaps vi->sts using
> virtqueue_detach_unused_buf(), but it ignores vi->evt. Since
> virtinput_fill_evt() populates vi->evt with buffers using
> virtqueue_add_inbuf_cache_clean(), which establishes DMA mappings under
> the hood, omitting the detachment step leaves these mappings active.
> 
> Does this result in a persistent DMA mapping leak every time the device is
> unbound? Furthermore, since the memory for these buffers (vi->evts) is freed,
> does this leave active DMA mappings pointing to freed memory, posing a memory
> corruption risk if delayed DMA occurs?
> 
> Does this exact same DMA mapping leak also occur during the power management
> suspend cycle in virtinput_freeze() which performs the same cleanup?
> 
> [Severity: High]
> This is also a pre-existing issue, but is there a missing
> virtio_reset_device() in the error path of virtinput_probe()?
> 
> Looking at virtinput_probe(), the device is marked as ready:
> 
> drivers/virtio/virtio_input.c:virtinput_probe() {
>     ...
> 	virtio_device_ready(vdev);
> 	vi->ready = true;
> 	err = input_register_device(vi->idev);
> 	if (err)
> 		goto err_input_register;
>     ...
> }
> 
> If input_register_device() fails, the error path deletes the virtqueues:
> 
> drivers/virtio/virtio_input.c:virtinput_probe() {
>     ...
> err_input_alloc:
> 	vdev->config->del_vqs(vdev);
>     ...
> }
> 
> Since virtio_device_ready() sets the device status to DRIVER_OK and enables
> the host/hardware to start processing virtqueues, does deleting the active
> virtqueue structures without first calling virtio_reset_device() to halt
> the device risk a use-after-free or memory corruption by the host backend
> if it continues to access the freed vring memory?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260905152059.89560-1-kmehltretter@gmail.com?part=2

