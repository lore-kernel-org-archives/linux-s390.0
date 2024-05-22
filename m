Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243313D61A
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381839; cv=none; b=iZN8FaCOIHz/jh6nNKQ4HAALjto3nNxrC3QjMznaAFPlJSEzcNMvwYFYQoyGJddbaUlQzKNPBJSGltYl/NsXgiKaJaXhZdvHEud8N2kYc/Cle7cSj3VSXKaIxYnyFRrUvE3oAEz7EP8S/znphQE6J28eurH/lEUqj9/6d6D6C+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381839; c=relaxed/simple;
	bh=579+PwZAall9CCUoOjULlOHgIo8Ra+uTvd5iStPs+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp1mSDqfLJF+DjnGhnW+9z+GmtOvR2LcMcH5GXOINTmlOASBkUqeZ92F3ZFHLaVw7/3EqG1o1Ny5km1cidNK8L4N0IhU7PgmEUHzdMu1EbFS4oo1p+grJT/5Vb2AAayTq12P0F/wJtKLOexfuuOtC/lXZ/XPH9Avi7rocEgqcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hF9WWONK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hF9WWONK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716381836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUgbrkFHxg4F+kRJ096ILydWxQUTBg55cdfx2xz7DQs=;
	b=hF9WWONKq0z/mzTyXjDixPbOqM66qf+JgQ0G17yhNa9CbOYMj51p4AVCpFN591bJxpglsY
	nUHci6gW9DmleLigWEyZbYunBanPUvu0jJhIv1aN/6pu/eG/gD1B7Dv2+keZR4Xuvl7XKX
	q9CJNhtZXKxvPERpe8qli2aWut+/lKo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-v5LVsGwjO7OJMnqXcKGJDw-1; Wed, 22 May 2024 08:43:54 -0400
X-MC-Unique: v5LVsGwjO7OJMnqXcKGJDw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-351d13dd8aeso4005243f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 05:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381833; x=1716986633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUgbrkFHxg4F+kRJ096ILydWxQUTBg55cdfx2xz7DQs=;
        b=lrG75T8lPopFn+YB9V7vAbcQzrjFX0IXp9n01si1ktJXheZIhAuJhSWt1L4pxT3GjJ
         +EeH930m6Dw0ptkgyDYe4ImRL13jGpSpcdOE+Q9+m7OPZv1THLR7nDiYfwMbeubgOcUw
         Po7bHlkQVwlBY0ow+DYcNZBj32n5UxEyWz6d0fqJcwgOgzl94Dy07Gs//cMo9cyrNfzM
         rx9g/tadnEApimJNIB+C4zt0OppRaT/Bqn2Hn4KNuwo2KVPqDhjImi8BjKJoKAcEZi9x
         XK8luG/81VUxrIzt/hK0ZMxx1byIsT61nptQxVuh4EJ5Kc7ukPMIVi+iZgmdYLovkM1X
         hqDw==
X-Forwarded-Encrypted: i=1; AJvYcCWyRmdW46M6OhoeR6MdmigDrhoK0z7v/3wYXfNK6KOYjnVudm/Ri8ReLUgML/HCJpUb9jpLUBmxHS8ZpyWur15eWjVRGVGgnOxbog==
X-Gm-Message-State: AOJu0Yw1xlhNCFGIuMRONO1uqLAYMRT9A6bKDuz+QxDIgjxNyI/FuNF2
	biIs61ruRlFQQAS+x2iW1QuaQMOFFjNVnFQ/yfE26VgcYgDt+CcBhGEpP/amoYObBhUyjkysSzy
	5EOQt5ONoJEG0NzfeWFU6Q8jMATRcRUenqQ+2YNLXp5EXYPNjWMKYo3JxHJQ=
X-Received: by 2002:a05:6000:d1:b0:354:c2c3:a319 with SMTP id ffacd0b85a97d-354d8dad7camr1537125f8f.61.1716381832844;
        Wed, 22 May 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFpLqeLCJUrO7rqx1MM8b891NleWkGLj5GGveBxw1L4XYP6vJDRZB7/pPW2A9B5hgEhmBdw==
X-Received: by 2002:a05:6000:d1:b0:354:c2c3:a319 with SMTP id ffacd0b85a97d-354d8dad7camr1537078f8f.61.1716381832095;
        Wed, 22 May 2024 05:43:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c7df311esm7583246f8f.3.2024.05.22.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:43:51 -0700 (PDT)
Date: Wed, 22 May 2024 08:43:44 -0400
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
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Message-ID: <20240522084221-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240522082732-mutt-send-email-mst@kernel.org>
 <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>

On Wed, May 22, 2024 at 08:35:21PM +0800, Xuan Zhuo wrote:
> On Wed, 22 May 2024 08:28:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> > > This pathset is splited from the
> > >
> > >      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> > >
> > > That may needs some cycles to discuss. But that notifies too many people.
> > >
> > > But just the four commits need to notify so many people.
> > > And four commits are independent. So I split that patch set,
> > > let us review these first.
> > >
> > > The patch set try to  refactor the params of find_vqs().
> > > Then we can just change the structure, when introducing new
> > > features.
> > >
> > > Thanks.
> >
> > It's nice but I'd like to see something that uses this before I bother
> > merging. IIUC premapped is dropped - are we going to use this in practice?
> 
> 
> 1. You know this modification makes sense.
> 2. This modification is difficult. Unlike modifying virtio ring or virtio-net,
>    this patch set requires modifying many modules and being reviewed by
>    many people.
> 3. If you do not merge it now, then this patch set will most likely be
>    abandoned. And I worked a lot on that.
> 4. premapped has not been abandoned, I have been advancing this work. What was
>    abandoned was just virtio-net big mode's support for premapped.
> 5. My plan is to complete virtio-net support for af-xdp in 6.10. This must
>    depend on premapped.
> 
> So, I hope you merge this patch set.
> 
> Thanks.

If this makes thing easier for you, I can put it in my tree post
release. This way you do not need to keep reposting it.
I'll then merge it with premapped.


> 
> >
> > > v8:
> > >   1. rebase the vhost branch
> > >
> > > v7:
> > >   1. fix two bugs. @Jason
> > >
> > > v6:
> > >   1. virtio_balloon: a single variable for both purposes.
> > >   2. if names[i] is null, return error
> > >
> > > v5:
> > >   1. virtio_balloon: follow David Hildenbrand's suggest
> > >     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
> > >   2. fix bug of the reference of "cfg_idx"
> > >     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> > >
> > > v4:
> > >   1. remove support for names array entries being null
> > >   2. remove cfg_idx from virtio_vq_config
> > >
> > > v3:
> > >   1. fix the bug: "assignment of read-only location '*cfg.names'"
> > >
> > > v2:
> > >   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> > >
> > > v1:
> > >   1. fix some comments from ilpo.jarvinen@linux.intel.com
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > Xuan Zhuo (6):
> > >   virtio_balloon: remove the dependence where names[] is null
> > >   virtio: remove support for names array entries being null.
> > >   virtio: find_vqs: pass struct instead of multi parameters
> > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > >     parameters
> > >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> > >   virtio_ring: simplify the parameters of the funcs related to
> > >     vring_create/new_virtqueue()
> > >
> > >  arch/um/drivers/virtio_uml.c             |  36 +++--
> > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
> > >  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
> > >  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
> > >  drivers/virtio/virtio_balloon.c          |  48 +++---
> > >  drivers/virtio/virtio_mmio.c             |  36 +++--
> > >  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
> > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > >  drivers/virtio/virtio_pci_modern.c       |  37 +++--
> > >  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
> > >  drivers/virtio/virtio_vdpa.c             |  51 +++----
> > >  include/linux/virtio_config.h            |  76 +++++++---
> > >  include/linux/virtio_ring.h              |  93 +++++++-----
> > >  tools/virtio/virtio_test.c               |   4 +-
> > >  tools/virtio/vringh_test.c               |  28 ++--
> > >  16 files changed, 384 insertions(+), 394 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

