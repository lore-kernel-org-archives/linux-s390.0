Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5977F0B
	for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 23:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652733; cv=none; b=pyGEFws2EamM4iidn/MkwpBCSpYLzZ9UxwmMVT7mivNiAQCIH3d3M2l6/gFP+Q6ZYVV4VffyqJBu+zQfqjMlXVnGOXNTF4POQ2ehXuEsVPCweUGLlc2SfGxOsHY+daq5UTUhfI1o5qQ8d2g5LUfyS4B9Zf4i659JLrOI8Hc8go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652733; c=relaxed/simple;
	bh=dHyQFmMz5lxrpJK4rm2aTZY4iDQooBZuodwjk+/rx7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7pERN4dkmL4AOlzBTlm7MrLtN7A+kGmHrcr78fMQ7Zd0C888NG7JMVCFogsQ77YvxADVSA56TilcNxD3dOUVbywkcsdXYH78GhvX3o8XobLkM2iNnwl+mdCWHY/69xOhmOf9iy5qBrFITkAokKQF7UMLVKq96HNfHFkoefKLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DwVM0d4b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwVM0d4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720652728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pocGWFShxQ+GSWj0tkDTAgxmCbZcO+UfiqU5SyA0Efs=;
	b=DwVM0d4b6Y12iVLuUEVLL0Atdz5CK7jrTtCR8n+aO0+L9PhX9nL6gDJPYIPWLHuzn/YTzg
	wQzospDOwRVaSnfsbaoEQwWwi6xRA9LpMoAcsP8Grtc+6w4l/Qth6fhnPvggOSiUEq1Oe2
	OGGq2XkTc1mIhMdW41lEMroF59V0QB0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-JJll1iHMMLSOI3G67535lw-1; Wed, 10 Jul 2024 19:05:27 -0400
X-MC-Unique: JJll1iHMMLSOI3G67535lw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367960f4673so698698f8f.1
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 16:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652726; x=1721257526;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pocGWFShxQ+GSWj0tkDTAgxmCbZcO+UfiqU5SyA0Efs=;
        b=PZrinAhrTA3ESjOeDd0t1U0ZHTOg0vKnuoqzdIWaFC7PctWzXkBzEdshRosuQ/JOlt
         tvVIjEj1I5LKfBWsnUZwevLDwH5hXHRIVG6sh1eQTgGtl3yLvgFV5Z30Zw+dG34v8hHY
         yfWLHk/cIhNe30qjvf4nUK7RnKwDFmDTEIsiM/Bi2TNEYCgJYm71fzKwm6NhKAXMpmjI
         zt+J4WN6CPNurh7r/StVaKCqLWkLLIVP4aI3VJ4Z5YuGGj/ussfBt8dsRpZXL6745sxt
         Qu+S+ucaOaj0tCRLSHToGDOZR4nceE7v81jjkYWQMzy3YOCeKxNrn/UnjM+zYmNMsDDs
         BX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWlFgXymIRwPYB7PUNomhSElKjNE+lO82y7xv68cDqcWmFEygaZojwn4uPtFLanpnglISFQBcRo2bu4S+WF7yhWk1OJGN6HnPvpdg==
X-Gm-Message-State: AOJu0Yyx66UjIUyZLv2fXHBv5RlRXuivCfEdfNQquRFTI10J8K18JLix
	mZLsqUA+VFHA/jRbs4+HxmBTJBy9dbGul+BwolzthVgATcwdwHeXtmDLFoieRNEyUwyDn335VSU
	VkZEB0WQkd5PJxlxs9i9HZvGh1VfbP8RLySDyLm/PD6GdbYpaDypy0rLoG6s=
X-Received: by 2002:a5d:674d:0:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-367f04c394fmr848912f8f.5.1720652726247;
        Wed, 10 Jul 2024 16:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfrrspXtlMpDRODV1gtZ6UbNGtoYk75D8SS60rLLEn4NhjjhpRqJHKf/56m95g7RzAi+V6jQ==
X-Received: by 2002:a5d:674d:0:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-367f04c394fmr848885f8f.5.1720652725448;
        Wed, 10 Jul 2024 16:05:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde8904csm6208508f8f.49.2024.07.10.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:05:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:05:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
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
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240710190222-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org>
 <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
 <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>

On Wed, Jul 10, 2024 at 03:54:22PM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 1:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > > On Wed, Jul 10, 2024 at 11:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > > On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > virtio balloon communicates to the core that in some
> > > > > > configurations vq #s are non-contiguous by setting name
> > > > > > pointer to NULL.
> > > > > >
> > > > > > Unfortunately, core then turned around and just made them
> > > > > > contiguous again. Result is that driver is out of spec.
> > > > >
> > > > > Thanks for fixing this - I think the overall approach of the patch looks good.
> > > > >
> > > > > > Implement what the API was supposed to do
> > > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > > is handled inside virtio-balloon, which is the only driver
> > > > > > making use of this facility, so far.
> > > > >
> > > > > In addition to virtio-balloon, I believe the same problem also affects
> > > > > the virtio-fs device, since queue 1 is only supposed to be present if
> > > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> > > > > and assumes that request queues start at index 1 rather than 2, which
> > > > > looks out of spec to me, but the current device implementations (that
> > > > > I am aware of, anyway) are also broken in the same way, so it ends up
> > > > > working today. Queue numbering in a spec-compliant device and the
> > > > > current Linux driver would mismatch; what the driver considers to be
> > > > > the first request queue (index 1) would be ignored by the device since
> > > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > > >
> > > >
> > > > Oh, thanks a lot for pointing this out!
> > > >
> > > > I see so this patch is no good as is, we need to add a workaround for
> > > > virtio-fs first.
> > > >
> > > > QEMU workaround is simple - just add an extra queue. But I did not
> > > > reasearch how this would interact with vhost-user.
> > > >
> > > > From driver POV, I guess we could just ignore queue # 1 - would that be
> > > > ok or does it have performance implications?
> > >
> > > As a driver workaround for non-compliant devices, I think ignoring the
> > > first request queue would be a reasonable approach if the device's
> > > config advertises num_request_queues > 1. Unfortunately, both
> > > virtiofsd and crosvm's virtio-fs device have hard-coded
> > > num_request_queues =1, so this won't help with those existing devices.
> >
> > Do they care what the vq # is though?
> > We could do some magic to translate VQ #s in qemu.
> >
> >
> > > Maybe there are other devices that we would need to consider as well;
> > > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > > benchmarks that seem to be from a different virtio-fs implementation
> > > that does support multiple request queues, so the workaround could
> > > possibly be used there.
> > >
> > > > Or do what I did for balloon here: try with spec compliant #s first,
> > > > if that fails then assume it's the spec issue and shift by 1.
> > >
> > > If there is a way to "guess and check" without breaking spec-compliant
> > > devices, that sounds reasonable too; however, I'm not sure how this
> > > would work out in practice: an existing non-compliant device may fail
> > > to start if the driver tries to enable queue index 2 when it only
> > > supports one request queue,
> >
> > You don't try to enable queue - driver starts by checking queue size.
> > The way my patch works is that it assumes a non existing queue has
> > size 0 if not available.
> >
> > This was actually a documented way to check for PCI and MMIO:
> >         Read the virtqueue size from queue_size. This controls how big the virtqueue is (see 2.6 Virtqueues).
> >         If this field is 0, the virtqueue does not exist.
> > MMIO:
> >         If the returned value is zero (0x0) the queue is not available.
> >
> > unfortunately not for CCW, but I guess CCW implementations outside
> > of QEMU are uncommon enough that we can assume it's the same?
> >
> >
> > To me the above is also a big hint that drivers are allowed to
> > query size for queues that do not exist.
> 
> Ah, that makes total sense - detecting queue presence by non-zero
> queue size sounds good to me, and it should work in the normal virtio
> device case.
> 
> I am not sure about vhost-user, since there is no way for the
> front-end to ask the back-end for a queue's size; the confusingly
> named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
> size of a queue, but there's no corresponding GET message.

So for vhost user I would assume it is non spec compliant
and qemu remaps queue numbers?
And can add a backend feature for supporting
VHOST_USER_GET_VRING_NUM and with that, also
require that backends are spec compliant?
And again, qemu can remap queue numbers.



> > > and a spec-compliant device would probably
> > > balk if the driver tries to enable queue 1 but does not negotiate
> > > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > > whole virtio device initialization process if a device fails like
> > > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > > not clear to me if this is allowed by the spec, or what device
> > > implementations actually do in practice in this scenario.)
> > >
> > > Thanks,
> > > -- Daniel
> >
> > My patch starts with a spec compliant behaviour. If that fails,
> > try non-compliant one as a fallback.
> 
> Got it, that sounds reasonable to me given the explanation above.
> 
> Thanks,
> -- Daniel

