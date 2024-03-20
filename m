Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AA3A1BE
	for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927095; cv=none; b=K2IwEFF/VMom+wYU1aEIfJ0hb2W9WdnLwBqW4OKNbcUpl0SAPONsbXZPdNz6XCAao5XbCeAgMU2BvQk+/CC6a8VZM1EE+RohuiMIxjnmk2uJIW5pHNXOM+ztN/alWtxkqHl+Th0K5sUXsnlPx8TXBdbhnbRBUpVWJeJ3yWBUPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927095; c=relaxed/simple;
	bh=m3OuEhR/6MblZ2PmSzWxlYaPTpvH2hKzIR9TJDfxRHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMHqjd1/aVADFNDbl7j2jGpHCEZUdn1LDo1IJP3XovrOBBfXAMhVTOQEM0O6fTeErIHGDoDKOM7PQ0f3z1lc6sCDLINfnuzQTRjgB0IZ7DCysYn94+mW0aarmGQys8MEn1Je7YYXGLp0ANqV7VHo+spsuVZBtPrXKRoLZRIqArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYRGyXGX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYRGyXGX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710927092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
	b=QYRGyXGXp9M6MgxZ8UkRuABuhH+UBnm9dIafJ5HoGUFLeteHeISATx1hkGKtf0MR8Z1ZQF
	ezGY94/7TKWgvfSc+syDsKQOZrYpu8eDFrySGSQN2gUD2oxJo3s57/48Cuqy7vjRB3NYXG
	sdYLQA5JkF6bRtuyeOMWvt3oA+T7DIo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-cIY-YhKkNkihEJL5AW7KKg-1; Wed, 20 Mar 2024 05:31:31 -0400
X-MC-Unique: cIY-YhKkNkihEJL5AW7KKg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6e6a1625e4bso6608292b3a.1
        for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927090; x=1711531890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcpPpj8COzr4sFGDjPc9DI4s95FhBo7rGSMdOcO4pRA=;
        b=fLgDIEyxS91Op1Rq37lNSimGGkEKsL5bZ51WeeVcJfsg7OK0FsbsqSzUujdNEStPfO
         EE5W46P32ii6x2ZsaET3mlt4lNEhvKWYYy8R2OSC9kPlm654YRpKNSQY4Fn0A1TzJAWW
         1fjiHAPPJ2DQa6jaId5MY0jkULpdXVtTZleIGR2m+iIuBoF4DouqQP9uNpkPLboFaO3t
         PF8E4omvL9dM4PMSuK2GqskbUSyxCH9PyAtFsfgyrFzFazenvm0ZnvJ7/2HPGqLleeI4
         dOHLDe56i4Da8sh14eHs4yZuZdfkH9IK413vQCz95KbtPhxjZf7Pag8oyvkNsy0P9aA7
         sZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtpRs5vYzK6/b5NnXlvza/nvNa0CpoHwymG7CiIV55BTylZSG57845XJhdCdywRZXwXq+XoLju4ur+s5VWDNvyQ/xqUUH+J+Ux3g==
X-Gm-Message-State: AOJu0YwB3t7H1FjT0dJILkJ3OjcGV+Faoh3ccChhbz4WHD7DeJs4wHnT
	PmrtVo0hmKJxgjckg5MCm2dMgdtMvdXrjy2npATexTm78zzw8uR0NPaM+FNsHwVdUlWfaRIOt6c
	XiSAZR7dvb/mf9qKy8hlDzNb+FdF5r28akybXc+oUVuJcFGMSnHh8TGXRxiA4ctri3xvbqzd2VB
	sxzfPN1BEVTe/msOV3ir1KF9bb0EUcRRgw3A==
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id ej1-20020a056a200e0100b001a36f61200dmr4956849pzb.9.1710927090293;
        Wed, 20 Mar 2024 02:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8qe09t4g3HfkRiIbfxrA8Ju1f60Up1DuN2Huw8OLenlVMbWpJINYFcOydIKj7JhZrxkyZn+X3zIVTMeJ8+is=
X-Received: by 2002:a05:6a20:e01:b0:1a3:6f61:200d with SMTP id
 ej1-20020a056a200e0100b001a36f61200dmr4956832pzb.9.1710927089974; Wed, 20 Mar
 2024 02:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com> <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com> <20240319025726-mutt-send-email-mst@kernel.org>
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
In-Reply-To: <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:31:18 +0800
Message-ID: <CACGkMEtfZx3+PcR7pCKQ9feLSERX6W-UKR0iJWEXVt7Q7ssZNA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:22=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Now, we pass multi parameters to find_vqs. These paramete=
rs
> > > > > > > > > may work for transport or work for vring.
> > > > > > > > >
> > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > >
> > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > >
> > > > > > > > > Every time, we try to add a new parameter, that is diffic=
ult.
> > > > > > > > > We must change every find_vqs implement.
> > > > > > > > >
> > > > > > > > > One the other side, if we want to pass a parameter to vri=
ng,
> > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > Too many functions need to be changed.
> > > > > > > > >
> > > > > > > > > So it is time to refactor the find_vqs. We pass a structu=
re
> > > > > > > > > cfg to find_vqs(), that will be passed to vring by transp=
ort.
> > > > > > > > >
> > > > > > > > > Because the vp_modern_create_avq() use the "const char *n=
ames[]",
> > > > > > > > > and the virtio_uml.c changes the name in the subsequent c=
ommit, so
> > > > > > > > > change the "names" inside the virtio_vq_config from "cons=
t char *const
> > > > > > > > > *names" to "const char **names".
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.intel=
.com>
> > > > > > > >
> > > > > > > > The name seems broken here.
> > > > > > >
> > > > > > > Email APP bug.
> > > > > > >
> > > > > > > I will fix.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > >
> > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > >
> > > > > > > > > +/**
> > > > > > > > > + * struct virtio_vq_config - configure for find_vqs()
> > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should set=
 this to 0.
> > > > > > > > > + *     During the initialization of each vq(vring setup)=
, we need to know which
> > > > > > > > > + *     item in the array should be used at that time. Bu=
t since the item in
> > > > > > > > > + *     names can be null, which causes some item of arra=
y to be skipped, we
> > > > > > > > > + *     cannot use vq.index as the current id. So add a c=
fg_idx to let vring
> > > > > > > > > + *     know how to get the current configuration from th=
e array when
> > > > > > > > > + *     initializing vq.
> > > > > > > >
> > > > > > > > So this design is not good. If it is not something that the=
 driver
> > > > > > > > needs to care about, the core needs to hide it from the API=
.
> > > > > > >
> > > > > > > The driver just ignore it. That will be beneficial to the vir=
tio core.
> > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > >
> > > > > > I don't get here, it's an internal logic and we've already done=
 that.
> > > > >
> > > > >
> > > > > ## Then these must add one param "cfg_idx";
> > > > >
> > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_device *v=
dev,
> > > > >                                          unsigned int index,
> > > > >                                          struct vq_transport_conf=
ig *tp_cfg,
> > > > >                                          struct virtio_vq_config =
*cfg,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *vdev=
,
> > > > >                                       unsigned int index,
> > > > >                                       void *pages,
> > > > >                                       struct vq_transport_config =
*tp_cfg,
> > > > >                                       struct virtio_vq_config *cf=
g,
> > > > > -->                                      uint cfg_idx);
> > > > >
> > > > >
> > > > > ## The functions inside virtio_ring also need to add a new param,=
 such as:
> > > > >
> > > > >  static struct virtqueue *vring_create_virtqueue_split(struct vir=
tio_device *vdev,
> > > > >                                                       unsigned in=
t index,
> > > > >                                                       struct vq_t=
ransport_config *tp_cfg,
> > > > >                                                       struct virt=
io_vq_config,
> > > > > -->                                                   uint cfg_id=
x);
> > > > >
> > > > >
> > > > >
> > > >
> > > > I guess what I'm missing is when could the index differ from cfg_id=
x?
> > >
> > >
> > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > >      During the initialization of each vq(vring setup), we need to kn=
ow which
> > >      item in the array should be used at that time. But since the ite=
m in
> > >      names can be null, which causes some item of array to be skipped=
, we
> > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >      cannot use vq.index as the current id. So add a cfg_idx to let v=
ring
> > >      know how to get the current configuration from the array when
> > >      initializing vq.
> > >
> > >
> > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int =
nvqs,
> > >
> > >       ................
> > >
> > >       for (i =3D 0; i < nvqs; ++i) {
> > >               if (!names[i]) {
> > >                       vqs[i] =3D NULL;
> > >                       continue;
> > >               }
> > >
> > >               if (!callbacks[i])
> > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > >               else if (vp_dev->per_vq_vectors)
> > >                       msix_vec =3D allocated_vectors++;
> > >               else
> > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i],=
 names[i],
> > >                                    ctx ? ctx[i] : false,
> > >                                    msix_vec);
> > >
> > >
> > > Thanks.
> >
> >
> > Jason what do you think is the way to resolve this?
>
> I wonder which driver doesn't use a specific virtqueue in this case.
>
> And it looks to me, introducing a per-vq-config struct might be better
> then we have
>
> virtio_vqs_config {
>       unsigned int nvqs;
>       struct virtio_vq_config *configs;
> }
>
> So we don't need the cfg_idx stuff.

And actually, I'm also ok to have cfg_idx internally, it's better than
having an API which has a field that the user doesn't need to care
about.

Thanks

>
> Thanks
>
> >
> > > >
> > > > Thanks
> > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >

