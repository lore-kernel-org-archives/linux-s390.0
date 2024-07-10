Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE419581F
	for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635208; cv=none; b=RJS8TjeAtuwNfYS4kMlSBQ78hOLzkr7nZJ4oIYZ8ce2u+4ONLCGJWjz59rB4mp4v+NKvcuGjYmKHAd0rmtMq2it5SEKJfe2b1dNz8jYzc2n58+tZDms5LruAhqYNaP3IoTweUplIjVWxRtHIc3qL0/9wXpHszLaq+ajWr7dGDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635208; c=relaxed/simple;
	bh=MowyvhNf6vGY6QkQdJz3UoNEMj0pRe3OT+CjdYCaGBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyJ6TKGjO+cCFptl+ytx4qmTeGq4XOEtFjpbxCz4aIVocQ4h6hUWZjuwH0UDGP/Olq4YR+An2crUT5WMwZrtR0UrTPNvQSIA6c6xfnP0KPAav/hXXRWylwqXOi/yTN+SaI6f/LD/gFwM8c2LKCgQeQME3qny3zLf85DByA4+414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FNWDD4pB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNWDD4pB"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so14786a12.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720635204; x=1721240004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=FNWDD4pB720QgbJL79wvXbdghkF7X0rdEXc2sZqKbYc/rLz6OTzgliepOiwJC2NJ49
         jqoinvyuHoAtqENamYjsBmxu+N3KioPQMXIMuxMXlmfeM731tS+vCkLASyehDxtTTnIl
         ncAIZwRwqcFAVsqyv9OjjAH85vtZSNAUTjBvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635204; x=1721240004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+jxUeQSFPMoGDRB/Tj2AzJBbVNk2aXSQNlmGiXjDjE=;
        b=OYbth4pcQYLQjyjHoImNjROTru83RIaJVrnLnv5aWfzR8aLByAp9VrLoISN8yXGUU8
         yPSag/jJpXzAG//57VLAcbDijx2TrWiFazNXbOuBA9h/RYQz+3oqGrtf2njZlAbFf+ew
         hOEKZft76BP6ty/9TTQz3+NZMx8H9CxEUd8WbB76whvje5T9O0hxoGYHPq0N05BrFw2S
         9Do7bXpXFwPra7aR4mtoyNwHRr6XR+te0s7pn9kuSmaqBpgymAPdH1pgTIng8fWQ61Do
         KHQLlySjXwAXHO/gY5+SY6UWWDvveb/JhmJ84HGN0BDneDWEbDrn+XzcOUBhwgh2H9F9
         16yA==
X-Forwarded-Encrypted: i=1; AJvYcCW5+dxWFCS0QPGZDOetsDQMl8H2shsG3pIRxDPrW9hNTWdNfGgC6AqHvROUTM02TPOfn3TjeTGYwR5jJg6/hIcAWUt6De/IuRYtoA==
X-Gm-Message-State: AOJu0YwGKreDprGEZNuAhY6mXTHRalghmnA+pQup67KGNyP3WQqor8O/
	KAl1UXqGWs7GxM7KnExsJ/HdFqzBRXQ7q1y4VqfrkBG9EkvwbvIyKRfi2fLe2QIzKbXS/LYzqOK
	5JvyUuxM=
X-Google-Smtp-Source: AGHT+IHYnR5ACPg2a04F1bvHqKtipAyoUtuQQnbKByjmjG3zdrsxaQ2B8y+0XLZPOHm7ojOH2zMjTg==
X-Received: by 2002:aa7:d0d5:0:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-594bc7cab19mr4700066a12.26.1720635204596;
        Wed, 10 Jul 2024 11:13:24 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594b8d6cdffsm2494166a12.0.2024.07.10.11.13.22
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:13:23 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36798779d75so5764996f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 11:13:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgvvr4Q+X19Kc/5Q1cjuqRZILuwkFfdFrgnQAhVnTM9b90aOyjxrc/ntQgj/OK2IExEmJDuTtYo/J1pTDWptNXNnqFfXwpvfxRhA==
X-Received: by 2002:a05:6512:281d:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-52eb9991dcfmr5848110e87.14.1720635181335; Wed, 10 Jul 2024
 11:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
In-Reply-To: <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 11:12:34 -0700
X-Gmail-Original-Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Message-ID: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.

Thanks for fixing this - I think the overall approach of the patch looks go=
od.

> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.

In addition to virtio-balloon, I believe the same problem also affects
the virtio-fs device, since queue 1 is only supposed to be present if
VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
meant to be queue indexes 2 and up. From a look at the Linux driver
(virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
and assumes that request queues start at index 1 rather than 2, which
looks out of spec to me, but the current device implementations (that
I am aware of, anyway) are also broken in the same way, so it ends up
working today. Queue numbering in a spec-compliant device and the
current Linux driver would mismatch; what the driver considers to be
the first request queue (index 1) would be ignored by the device since
queue index 1 has no function if F_NOTIFICATION isn't negotiated.

[...]
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index 7d82facafd75..fa606e7321ad 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>         struct virtqueue_info *vqi;
>         u16 msix_vec;
> -       int i, err, nvectors, allocated_vectors, queue_idx =3D 0;
> +       int i, err, nvectors, allocated_vectors;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>                         msix_vec =3D allocated_vectors++;
>                 else
>                         msix_vec =3D VP_MSIX_VQ_VECTOR;
> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
> +               vqs[i] =3D vp_setup_vq(vdev, i, vqi->callback,
>                                      vqi->name, vqi->ctx, msix_vec);
>                 if (IS_ERR(vqs[i])) {
>                         err =3D PTR_ERR(vqs[i]);
> @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vde=
v, unsigned int nvqs,
>                             struct virtqueue_info vqs_info[])
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vd=
ev, unsigned int nvqs,
>                         vqs[i] =3D NULL;
>                         continue;
>                 }
> +<<<<<<< HEAD
>                 vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callback,
>                                      vqi->name, vqi->ctx,
> +=3D=3D=3D=3D=3D=3D=3D
> +               vqs[i] =3D vp_setup_vq(vdev, i, callbacks[i], names[i],
> +                                    ctx ? ctx[i] : false,
> +>>>>>>> f814759f80b7... virtio: fix vq # for balloon

This still has merge markers in it.

Thanks,
-- Daniel
