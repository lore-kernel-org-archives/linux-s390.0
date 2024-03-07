Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB51B966
	for <linux-s390@vger.kernel.org>; Thu,  7 Mar 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789324; cv=none; b=eJqsrr0eU9WxY+a8nKqsQrf1I+srgpKK26FToh8o4O0fKYCjX0YyoRQBgqKM+lIGTcMvpqFLIYPW+t5VM6jBaPnDq4oxh6vnFaSSnu1fSHIypxAR/hsjMvywfqnkPpqa2KGSktHL+S+v5cBpst6OCjbx2ez9LXqju3NE7bhX5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789324; c=relaxed/simple;
	bh=PkWKesdKCZHdpKYD3mbBzEfF2DT8ijrZ24k+m6SrSIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCn8OMBd3tjUmuam6miJjL0meHJCA8I1e+Uk+mLlv5azeldEf+DMt53LVfLy05jvwgey3AVmYdcbNqCmCs21OTUpF4GNO+5zxXZBQyU1ISF6ZX53/jyOE8tGpx+HNQixvpx2Fm0iJZBQ+6aGpQMxsF+a5/XUrdtiwIM/PmlQe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAxy1GMN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAxy1GMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709789321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFF3SdzrPB5k9mPw8VciaVK/KbIaE86hBRyAcg4GkOg=;
	b=fAxy1GMNpU2fojGsCss8+l3473s3Hxv4Qqz4OkaIPsDn7WGzwoCw4V98ZsOtLeiCnyfyTV
	OmqB1rnItwY41FnqCWVH7TFmnSVjD3dFiaGhyaiwP5Cton8EeNpcBmMhJiMKpSFvs71Brs
	RhamWHOU/GJWoVewelawSe2NtTHSQVc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-laKe-v3ROR2Dy9s9BNgejg-1; Thu, 07 Mar 2024 00:28:39 -0500
X-MC-Unique: laKe-v3ROR2Dy9s9BNgejg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29b55cca63aso324882a91.2
        for <linux-s390@vger.kernel.org>; Wed, 06 Mar 2024 21:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709789318; x=1710394118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFF3SdzrPB5k9mPw8VciaVK/KbIaE86hBRyAcg4GkOg=;
        b=fDUhScZCbICcrvdtXRwMc7tDlYJXgxIu7a7iiWKj9jhHBMKOlTmnEfR1P94yVRHHdA
         O/xAW+fKs6A7xIdwaqTw22FtHWKI1DrC0TuZyiSDDxU6JzDEMxnBoZ0ed7qplxkDUP0Y
         VxdEFw9q0glPVJzkGShwyn5Ioe4Gv8VNcc2qEJKC33mP6auWibqS5Odn/T5PEeaWwjdW
         LP1KtQx86CKK7aCBwGVRJVFBw3eREzQsg6AGHSbBqapt0MSsIgDqmyyI1cUJRdj6f66F
         lFGNCW/OTcSFSqeAIaOayLmYurxy3q5rGG9hixUyDHsDQkmZE3Hhsfdp/PWlqUqSFEy+
         otng==
X-Forwarded-Encrypted: i=1; AJvYcCVv1X30yHcY33V91l13hfLsTFvjf6z4jMipSruRUZu4z9KJaSx3uCz1U1jozQT1exlMfyjN/zH5NubyrT6h1MLAb0GpQ03OOEY3zQ==
X-Gm-Message-State: AOJu0Yxa9ENnVhvNvurJVV2nMszJhaIRTrfh116VHJAZaiNClDcEVyhp
	gLRR6v/Ind5lX3BaRWM4ak4T1jKSJs1YwHtiCBFs5YnE31wF8vlHc81d2dwa5MusCdgX4QWAVdp
	RNYoCY74M0sa6dr7C77517BNbiQwrIDVE7V8SWSUQGJl+FYfRryXe//Sb9J1NMnJf4vm1uGhMRL
	JfcBbDRmsYkZIHJTrf/imzHG9zMQc30c5JYg==
X-Received: by 2002:a17:90a:d315:b0:299:8ff:40c0 with SMTP id p21-20020a17090ad31500b0029908ff40c0mr13843139pju.28.1709789318502;
        Wed, 06 Mar 2024 21:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjlNjcTJfkYmthsYkTIYD+6dKrjtynluBSb9Ic08P4WJbd2Iq9ksuZjvEPBh8JZf8Bm+xUFE5g9BmBqFTSRbY=
X-Received: by 2002:a17:90a:d315:b0:299:8ff:40c0 with SMTP id
 p21-20020a17090ad31500b0029908ff40c0mr13843101pju.28.1709789318165; Wed, 06
 Mar 2024 21:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org> <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
 <20240229043238-mutt-send-email-mst@kernel.org> <1709718889.4420547-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1709718889.4420547-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Mar 2024 13:28:27 +0800
Message-ID: <CACGkMEu5=DKJfXsvOoXDDH7KJ-DWt83jj=vf8GoRnq-9zUeOOg@mail.gmail.com>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 29 Feb 2024 04:34:20 -0500, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Thu, Feb 29, 2024 at 05:02:37PM +0800, Xuan Zhuo wrote:
> > > On Thu, 29 Feb 2024 03:21:14 -0500, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Thu, Feb 29, 2024 at 03:20:25PM +0800, Xuan Zhuo wrote:
> > > > > As discussed:
> > > > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPa=
VmJ3rHYqRZxYg@mail.gmail.com
> > > > >
> > > > > If the virtio is premapped mode, the driver should manage the dma=
 info by self.
> > > > > So the virtio core should not store the dma info.
> > > > > So we can release the memory used to store the dma info.
> > > > >
> > > > > But if the desc_extra has not dma info, we face a new question,
> > > > > it is hard to get the dma info of the desc with indirect flag.
> > > > > For split mode, that is easy from desc, but for the packed mode,
> > > > > it is hard to get the dma info from the desc. And for hardening
> > > > > the dma unmap is saft, we should store the dma info of indirect
> > > > > descs.
> > > > >
> > > > > So I introduce the "structure the indirect desc table" to
> > > > > allocate space to store dma info with the desc table.
> > > > >
> > > > > On the other side, we mix the descs with indirect flag
> > > > > with other descs together to share the unmap api. That
> > > > > is complex. I found if we we distinguish the descs with
> > > > > VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > > > >
> > > > > Because of the dma array is allocated in the find_vqs(),
> > > > > so I introduce a new parameter to find_vqs().
> > > > >
> > > > > Note:
> > > > >     this is on the top of
> > > > >         [PATCH vhost v1] virtio: packed: fix unmap leak for indir=
ect desc table
> > > > >         http://lore.kernel.org/all/20240223071833.26095-1-xuanzhu=
o@linux.alibaba.com
> > > > >
> > > > > Please review.
> > > > >
> > > > > Thanks
> > > > >
> > > > > v3:
> > > > >     1. fix the conflict with the vp_modern_create_avq().
> > > >
> > > > Okay but are you going to address huge memory waste all this is cau=
sing for
> > > > - people who never do zero copy
> > > > - systems where dma unmap is a nop
> > > >
> > > > ?
> > > >
> > > > You should address all comments when you post a new version, not ju=
st
> > > > what was expedient, or alternatively tag patch as RFC and explain
> > > > in commit log that you plan to do it later.
> > >
> > >
> > > Do you miss this one?
> > > http://lore.kernel.org/all/1708997579.5613105-1-xuanzhuo@linux.alibab=
a.com
> >
> >
> > I did. The answer is that no, you don't get to regress memory usage
> > for lots of people then fix it up.
> > So the patchset is big, I guess it will take a couple of cycles to
> > merge gradually.
>
> Hi @Michael
>
> So, how about this patch set?
>
> I do not think they (dma maintainers) will agree the API dma_can_skip_unm=
ap().
>
> If you think sq wastes too much memory using pre-mapped dma mode, how abo=
ut
> we only enable it when xsk is bond?
>
> Could you give me some advice?

I think we have some discussion, one possible solution is:

when pre mapping is enabled, virtio core won't store dma metadatas.

Then it makes virtio-net align with other NIC.

Thanks

>
> Thanks.
>
>
> >
> > > I asked you. But I didnot recv your answer.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > > v2:
> > > > >     1. change the dma item of virtio-net, every item have MAX_SKB=
_FRAGS + 2
> > > > >         addr + len pairs.
> > > > >     2. introduce virtnet_sq_free_stats for __free_old_xmit
> > > > >
> > > > > v1:
> > > > >     1. rename transport_vq_config to vq_transport_config
> > > > >     2. virtio-net set dma meta number to (ring-size + 1)(MAX_SKB_=
FRGAS +2)
> > > > >     3. introduce virtqueue_dma_map_sg_attrs
> > > > >     4. separate vring_create_virtqueue to an independent commit
> > > > >
> > > > >
> > > > >
> > > > > Xuan Zhuo (19):
> > > > >   virtio_ring: introduce vring_need_unmap_buffer
> > > > >   virtio_ring: packed: remove double check of the unmap ops
> > > > >   virtio_ring: packed: structure the indirect desc table
> > > > >   virtio_ring: split: remove double check of the unmap ops
> > > > >   virtio_ring: split: structure the indirect desc table
> > > > >   virtio_ring: no store dma info when unmap is not needed
> > > > >   virtio: find_vqs: pass struct instead of multi parameters
> > > > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > > > >     parameters
> > > > >   virtio: vring_new_virtqueue(): pass struct instead of multi par=
ameters
> > > > >   virtio_ring: simplify the parameters of the funcs related to
> > > > >     vring_create/new_virtqueue()
> > > > >   virtio: find_vqs: add new parameter premapped
> > > > >   virtio_ring: export premapped to driver by struct virtqueue
> > > > >   virtio_net: set premapped mode by find_vqs()
> > > > >   virtio_ring: remove api of setting vq premapped
> > > > >   virtio_ring: introduce dma map api for page
> > > > >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> > > > >   virtio_net: unify the code for recycling the xmit ptr
> > > > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > > > >   virtio_net: sq support premapped mode
> > > > >
> > > > >  arch/um/drivers/virtio_uml.c             |  31 +-
> > > > >  drivers/net/virtio_net.c                 | 283 ++++++---
> > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 +-
> > > > >  drivers/remoteproc/remoteproc_virtio.c   |  31 +-
> > > > >  drivers/s390/virtio/virtio_ccw.c         |  33 +-
> > > > >  drivers/virtio/virtio_mmio.c             |  30 +-
> > > > >  drivers/virtio/virtio_pci_common.c       |  59 +-
> > > > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > > > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > > > >  drivers/virtio/virtio_pci_modern.c       |  38 +-
> > > > >  drivers/virtio/virtio_ring.c             | 698 ++++++++++++-----=
------
> > > > >  drivers/virtio/virtio_vdpa.c             |  45 +-
> > > > >  include/linux/virtio.h                   |  13 +-
> > > > >  include/linux/virtio_config.h            |  48 +-
> > > > >  include/linux/virtio_ring.h              |  82 +--
> > > > >  tools/virtio/virtio_test.c               |   4 +-
> > > > >  tools/virtio/vringh_test.c               |  28 +-
> > > > >  17 files changed, 847 insertions(+), 625 deletions(-)
> > > > >
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >
>

