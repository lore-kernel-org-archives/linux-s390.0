Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE912A17E
	for <linux-s390@vger.kernel.org>; Tue, 26 Mar 2024 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711427332; cv=none; b=lPgdD3Ovdq8y6/hTLyp0Ui+dhNf43/UnPen2FP9fMkfJlqofnlrEHtTAXfGt/K6/7KMKP0HHg9ACQJFlb9Wx8wjKKDVOEFGe6CLz1xaGkOJotW9NzG/l5iIQpMx1wcUnpEuMKfoTaVMBhCepdOszJraM0oCGevaFZHeqQkIukd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711427332; c=relaxed/simple;
	bh=9ltv4DwYwWj7kB/fZ2mzOIYt06/xNjINGiA4oBElaQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBI6ydo/OyP4ObxPxd8zVKmC/K1MP7QNeNCZ6eNNqPHJ0VBbx7E4Il56hgBt+wz5HXAPtq/pqqFV4zJj/HMwtOXUby2KL5Omtn3jqu+7F95R5jOpR77m0a1mg43bnz9AnddcbvCKwBthF86T6yd9l6/2di3PacrH8xX6tLy/EcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlpXmsvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlpXmsvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711427329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJdaPfqxCLnNgCpNcotB2CUqnM+IpEVFvBowNr66ZI=;
	b=MlpXmsvERXGO7ZMnrfi7W295XzaY9z0tp8x+PhRWpcq9lTNEWB1p0Q1qb7xASNmzXaItyr
	IOWOp1+CIAFe9W0Z3pu2tRm2wQW+N8tBRX321F/ZwddofgXeawpfhiKbqdmwGUdKg3vyuL
	LpYQrDAy/TY+repVccmd2A975+vvkWw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-PhAoB2b4OaKBrkpVmychjg-1; Tue, 26 Mar 2024 00:28:46 -0400
X-MC-Unique: PhAoB2b4OaKBrkpVmychjg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5e5022b34faso4635374a12.0
        for <linux-s390@vger.kernel.org>; Mon, 25 Mar 2024 21:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711427325; x=1712032125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYJdaPfqxCLnNgCpNcotB2CUqnM+IpEVFvBowNr66ZI=;
        b=KaBlKt5Fcd6nEkBfHzUVg3SwRknwwuL+iAc9advppkPtoxGMG9bN5eqvoNj2W4/xNM
         PTIbipm4W9laKBBwlF4DN3/P4uXLYqfFt4xOyCwkvdfDbqirfWcDz+hG2qYor9qDDG6I
         lOuWMjUAMkRlkwVqOYyr0DeOmWwGLf5VuFmNfAwXm6CSUi6AERZuNnlpubCK07YAOO0H
         3mtld/Oyo07UZAZsUnBrcY8rzQYnc7Rhm2eWPRSMspBmTMHam4tzVa6BzHWjiCuAO55D
         J0PcxMl/eDXaRhjoPvAxIIFm/I26GGFEvP7Ndxh8Ye63DLDq2xAv4iUb7YZQHa+S7Vfs
         +eGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhA5u5vGaur9eICvqnnFYP7UUVwkj7KVlVP+xdPg63ffxHApc2TKG87sUTptq2/ikplEhD2+KTjczhiL8Z9ZBK1qBqfIlynNs6aw==
X-Gm-Message-State: AOJu0YwtmzqqkN6kJYaG71stId91/N1xfIiSjfirV6sUMBlkpDbkQrcz
	YhKqxYZx7+MHEIrlnU0waI3r++0Jt2oQe8K1VbKhPpLay9lIw3fFQbimymUkdcAAHU+pgj1Jxps
	6H0an27zFLNIFEYFWjpN8fhvEexNctu8TxiwPN/H7VwKa+kppljbr25KMvoOYLVqLi6Xf2KxgYv
	9/nh2M6PcW04bAMag5wBglRI/CMZdusnjldg==
X-Received: by 2002:a17:902:e541:b0:1e0:f550:82e2 with SMTP id n1-20020a170902e54100b001e0f55082e2mr154430plf.22.1711427325201;
        Mon, 25 Mar 2024 21:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwbHtFo5NnweY6aiIQsz8qOqVwbBb5nB1OBSL78XFdIi+hU5TswumUMNoFDqt6TH1kJ3Y6QgJCf7jKybputQ=
X-Received: by 2002:a17:902:e541:b0:1e0:f550:82e2 with SMTP id
 n1-20020a170902e54100b001e0f55082e2mr154413plf.22.1711427324953; Mon, 25 Mar
 2024 21:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com> <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240325090419.33677-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:28:34 +0800
Message-ID: <CACGkMEuuNrDkEUnnES-APDVag2=4wjyZi3aEg0+8vY+Bho=BRg@mail.gmail.com>
Subject: Re: [PATCH vhost v5 2/6] virtio: remove support for names array
 entries being null.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> doesn't apply. And not one uses this.
>
> On the other side, that makes some trouble for us to refactor the
> find_vqs() params.
>
> So I remove this support.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c             | 5 -----
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 4 ----
>  drivers/remoteproc/remoteproc_virtio.c   | 5 -----
>  drivers/s390/virtio/virtio_ccw.c         | 5 -----
>  drivers/virtio/virtio_mmio.c             | 5 -----
>  drivers/virtio/virtio_pci_common.c       | 9 ---------
>  drivers/virtio/virtio_vdpa.c             | 5 -----
>  include/linux/virtio_config.h            | 1 -
>  8 files changed, 39 deletions(-)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 8adca2000e51..1d1e8654b7fc 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1031,11 +1031,6 @@ static int vu_find_vqs(struct virtio_device *vdev,=
 unsigned nvqs,
>                 return rc;
>
>         for (i =3D 0; i < nvqs; ++i) {
> -               if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> -               }

Does this mean names[i] must not be NULL? If yes, should we fail or
not? If not, do we need to change the doc?

[...]

> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -56,7 +56,6 @@ typedef void vq_callback_t(struct virtqueue *);
>   *     callbacks: array of callbacks, for each virtqueue
>   *             include a NULL entry for vqs that do not need a callback
>   *     names: array of virtqueue names (mainly for debugging)
> - *             include a NULL entry for vqs unused by driver
>   *     Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)


Since we had other check for names[i] like:

        if (per_vq_vectors) {
                /* Best option: one for change interrupt, one per vq. */
                nvectors =3D 1;
                for (i =3D 0; i < nvqs; ++i)
                        if (names[i] && callbacks[i])
                                ++nvectors;

in vp_find_vqs_msix() and maybe other places.

> --
> 2.32.0.3.g01195cf9f
>

