Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D214B948
	for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652119; cv=none; b=GrotT6blAZxsr702eFyha79XPXkaAoG/I8hpzEQEiDWaa9SOK5eSIaNIp22B1dV/fz/JZktDQXLHRgElkL2EVYE/lxYaMO1mU4xLeuhqYhKVvISmSS04C1vAGnNKGrAF4DKqDWgcK8uwU/NgqBH7BPcFU77aN9srEIIPqU1tK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652119; c=relaxed/simple;
	bh=cDOzi+ZXwS5C7Idx4dnKQ0UYYVdAQXQ23kbJX7qsTSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdwyMZjy20Uck9jzrO4jueVHz1AlKh36XtNJ9rI5z7MhlFVabTXeGA1fJvOKYAkpUrYdSjqRCDbIf81ncN4TtCUJaxsrNer8kHZiNQ5+vGR8ehjOlp+Ch1cvRr6Oiy6XDPjV9P4WIHICaobzU3mq++1n568F5AETqAkZzOknpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WAseCsnx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WAseCsnx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso392398a12.0
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720652115; x=1721256915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=WAseCsnxOK6GEqwNkdRbyfoABhjq1uPUZlBAgVohnoaj41Hk1Cs/5eCn89tm1iSQp3
         2dXDun/tYl0yVnFQngT1SiJZ/ToD7KPpT7lYqKhSwI/9xWDNNefBC+u9TIWIobX05KvK
         YGu55StuR+VWP+nSYP1nzMHIdi6P4qpkddLdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652115; x=1721256915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XJJfsxcbaqihoVxsU56HYN19zV6cTHgOtHzTxAFpq0=;
        b=o0w9HnMJE+8xf2Vr0OYDUVrmUrnlonUY5MjcstccUPg+SmRtXq5ZndH/v/n7M/vBVS
         ElbY4S72jNwyxHsJRZdKQ+1p+s6bP4DkEehnxdKmQ0krV6kZAl+6EgZx4V7loOCASwkZ
         FPE8NQGCVx81AWZG1pZHyjlMcAjHMRKQjDF0ck5HADf6YYU3EiNdxk9GOpVgGLyvyGzQ
         1glYzDAFYVL1LTKASWrYFvX0k4PrfXgUKmIB5+jeWNNYa5x5YAZEiW0X5nWk95m7DF1W
         WUVUDNHBxPvROnOlij5tp7wGFqL9SpiVJpAkRQfGANBE1wQG48UcwxL4ZVasRJ0MkPg9
         0vIg==
X-Forwarded-Encrypted: i=1; AJvYcCXgCJ4ZiGMnU82dVX4Sk3rLVjLjVBa2yVkSv555pFz1wFHwBS7eIcgurBQCzN2Afyj9PpgsYOprBOOtmqyy+9+7zgoSUtWuyMKQqQ==
X-Gm-Message-State: AOJu0YzvaOX5VYcnLWYKmVQAHh7MS0JGJN1RNKENNM6okj7aFJ3w2mWr
	ZrkEfWYAft/sNm8GrrWl9LxyA7AGEnP+vdOxBQa7Ekobsk1rqmfjyZqMlerzuwlidcKiyQm3yze
	mz3kjBco=
X-Google-Smtp-Source: AGHT+IHvw8798tbjiIiJIWQRL6fMOpzx47+SoLDtm9hQ0z7Z6l8HaytxA+QnIQ+dMRa2KCo4H3xIWg==
X-Received: by 2002:aa7:c258:0:b0:57c:abf9:e6ab with SMTP id 4fb4d7f45d1cf-594bc7c7df9mr4484806a12.31.1720652115505;
        Wed, 10 Jul 2024 15:55:15 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459de5sm2716750a12.70.2024.07.10.15.55.09
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:55:10 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77c4309fc8so50733166b.3
        for <linux-s390@vger.kernel.org>; Wed, 10 Jul 2024 15:55:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhU/ELM8RFUp9mRvSwqhEPnqTt14GZajAUKpkdDcoB6fkNLxkYsMKyAlZhY8MUXnR//a3XU97ZJqe0cAANhh4yf2L+8h2bMm4wRQ==
X-Received: by 2002:a17:907:7f12:b0:a77:db34:42ca with SMTP id
 a640c23a62f3a-a780b88347amr588125666b.49.1720652088624; Wed, 10 Jul 2024
 15:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720611677.git.mst@redhat.com> <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
 <20240710142239-mutt-send-email-mst@kernel.org> <CABVzXAmp_exefHygEGvznGS4gcPg47awyOpOchLPBsZgkAUznw@mail.gmail.com>
 <20240710162640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710162640-mutt-send-email-mst@kernel.org>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 10 Jul 2024 15:54:22 -0700
X-Gmail-Original-Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
Message-ID: <CABVzXA=W0C6NNNSYnjop67B=B3nA2MwAetkxM1vY3VggbBVsMg@mail.gmail.com>
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

On Wed, Jul 10, 2024 at 1:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 12:58:11PM -0700, Daniel Verkamp wrote:
> > On Wed, Jul 10, 2024 at 11:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> > > > On Wed, Jul 10, 2024 at 4:43=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > virtio balloon communicates to the core that in some
> > > > > configurations vq #s are non-contiguous by setting name
> > > > > pointer to NULL.
> > > > >
> > > > > Unfortunately, core then turned around and just made them
> > > > > contiguous again. Result is that driver is out of spec.
> > > >
> > > > Thanks for fixing this - I think the overall approach of the patch =
looks good.
> > > >
> > > > > Implement what the API was supposed to do
> > > > > in the 1st place. Compatibility with buggy hypervisors
> > > > > is handled inside virtio-balloon, which is the only driver
> > > > > making use of this facility, so far.
> > > >
> > > > In addition to virtio-balloon, I believe the same problem also affe=
cts
> > > > the virtio-fs device, since queue 1 is only supposed to be present =
if
> > > > VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> > > > meant to be queue indexes 2 and up. From a look at the Linux driver
> > > > (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATI=
ON
> > > > and assumes that request queues start at index 1 rather than 2, whi=
ch
> > > > looks out of spec to me, but the current device implementations (th=
at
> > > > I am aware of, anyway) are also broken in the same way, so it ends =
up
> > > > working today. Queue numbering in a spec-compliant device and the
> > > > current Linux driver would mismatch; what the driver considers to b=
e
> > > > the first request queue (index 1) would be ignored by the device si=
nce
> > > > queue index 1 has no function if F_NOTIFICATION isn't negotiated.
> > >
> > >
> > > Oh, thanks a lot for pointing this out!
> > >
> > > I see so this patch is no good as is, we need to add a workaround for
> > > virtio-fs first.
> > >
> > > QEMU workaround is simple - just add an extra queue. But I did not
> > > reasearch how this would interact with vhost-user.
> > >
> > > From driver POV, I guess we could just ignore queue # 1 - would that =
be
> > > ok or does it have performance implications?
> >
> > As a driver workaround for non-compliant devices, I think ignoring the
> > first request queue would be a reasonable approach if the device's
> > config advertises num_request_queues > 1. Unfortunately, both
> > virtiofsd and crosvm's virtio-fs device have hard-coded
> > num_request_queues =3D1, so this won't help with those existing devices=
.
>
> Do they care what the vq # is though?
> We could do some magic to translate VQ #s in qemu.
>
>
> > Maybe there are other devices that we would need to consider as well;
> > commit 529395d2ae64 ("virtio-fs: add multi-queue support") quotes
> > benchmarks that seem to be from a different virtio-fs implementation
> > that does support multiple request queues, so the workaround could
> > possibly be used there.
> >
> > > Or do what I did for balloon here: try with spec compliant #s first,
> > > if that fails then assume it's the spec issue and shift by 1.
> >
> > If there is a way to "guess and check" without breaking spec-compliant
> > devices, that sounds reasonable too; however, I'm not sure how this
> > would work out in practice: an existing non-compliant device may fail
> > to start if the driver tries to enable queue index 2 when it only
> > supports one request queue,
>
> You don't try to enable queue - driver starts by checking queue size.
> The way my patch works is that it assumes a non existing queue has
> size 0 if not available.
>
> This was actually a documented way to check for PCI and MMIO:
>         Read the virtqueue size from queue_size. This controls how big th=
e virtqueue is (see 2.6 Virtqueues).
>         If this field is 0, the virtqueue does not exist.
> MMIO:
>         If the returned value is zero (0x0) the queue is not available.
>
> unfortunately not for CCW, but I guess CCW implementations outside
> of QEMU are uncommon enough that we can assume it's the same?
>
>
> To me the above is also a big hint that drivers are allowed to
> query size for queues that do not exist.

Ah, that makes total sense - detecting queue presence by non-zero
queue size sounds good to me, and it should work in the normal virtio
device case.

I am not sure about vhost-user, since there is no way for the
front-end to ask the back-end for a queue's size; the confusingly
named VHOST_USER_SET_VRING_NUM allows the front-end to configure the
size of a queue, but there's no corresponding GET message.

> > and a spec-compliant device would probably
> > balk if the driver tries to enable queue 1 but does not negotiate
> > VIRTIO_FS_F_NOTIFICATION. If there's a way to reset and retry the
> > whole virtio device initialization process if a device fails like
> > this, then maybe it's feasible. (Or can the driver tweak the virtqueue
> > configuration and try to set DRIVER_OK repeatedly until it works? It's
> > not clear to me if this is allowed by the spec, or what device
> > implementations actually do in practice in this scenario.)
> >
> > Thanks,
> > -- Daniel
>
> My patch starts with a spec compliant behaviour. If that fails,
> try non-compliant one as a fallback.

Got it, that sounds reasonable to me given the explanation above.

Thanks,
-- Daniel
