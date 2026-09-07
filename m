Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D346D09D
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786822; cv=none; b=O6j2wfFxiMLJuD58MQYfvgLdv9IUODnRH8w8JvJ6qt4PvJWkFyd9kitSoSY7TaOle63VbbFxou+ivhl8Pa5dyS0Kbr9k+qipY0ZvF62dX31KBbYLUCXvOcZxEXfJcAMsYCNQSm4onyg0CabDXQ/kEYA2shdV6c8FusXsFzp1yn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786822; c=relaxed/simple;
	bh=bbyM8+xnMNKO6fyiNZM2V/dxEjYjP4AdG79mC8RAzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbVYu+7hVpmDPAtQcwwomjr5ecGFcEmQ/LToHjl0zkIHgvFV2YXeODA0E9850kfc3RmQe+n6YMajZM5ao16vgloLjVd1F7DbhMn24Ar4PDQd4RI2Z3Ot5sX24Xj/pz1T1hzoEVmJGLhQt20X0QbAg8fPyQ+16Xyu14RyPxEYC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHNlFA48; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy0OdkN6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHNlFA48";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy0OdkN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788786816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
	b=BHNlFA48L6Asxjk6Ul+pWL3mabZqd5KTjnSteMGdxnnZyajaCr5ADj0iKLTlFUGCEO5+WY
	YAMEizLB05z4sEZqsrsQPDfWoUgbFoV+jn7DI2SyMJWuZOgl9rx2C6l4WjjfohV8Mx7FQP
	6MDH0UD/97lsDKfJ6/Lk9lzKva4/Idg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-H2H6NCP6OWG-1jRY7uhWoA-1; Mon, 07 Sep 2026 09:13:34 -0400
X-MC-Unique: H2H6NCP6OWG-1jRY7uhWoA-1
X-Mimecast-MFC-AGG-ID: H2H6NCP6OWG-1jRY7uhWoA_1788786813
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so24459915e9.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Sep 2026 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788786813; x=1789391613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
        b=gy0OdkN6w26QFaOXv6fYnw8KuIo1/jlD0unXb1oGGSeoNrDrS7mYYQLaJiR6oDbzMF
         teCyJbW66P7C3M/aCB9FZfW+5GRRyDB/Rq23ykl1KB6k6eksjLwb7l90ZQy4ALCGjylK
         6ZOXfRnWwOfMy6iTBarbpaBKWoubHxdVWsuBaQu9mHs5IfpFxxQCrLk46MSzhThSPjri
         hJsPXQCudWjdBKNId+zsEFwKwQ+gw1HAGxC4t2g7VTaF85nzmkRhKfrBlJyDA26flBYq
         Qxwzw6UqsPJ8Xu/wgOVuhnlDkwpo6is8QNCtDEqp6tzuI+6LnV0tahMLVEy12wjsjcMr
         fvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786813; x=1789391613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5punYBPTQYCYDbZdD+Tip6UD659TFwSyiVivgWnd/bQ=;
        b=O3u4/5pjSD8xw+fUqBQvG4Qe37LIFrF7w2M2D5W029ZtOnfss95RCOJ+yupCxJmvd3
         3IzS5+c64toAKnIgCnpYhtW9VzB9aB7IoD5Veyu4kPiQICyezteF3gUDeUodsBAaotao
         Dl8R6KRg4ChzR6TglbFdvfy61VPp7DEPH6yX3L5zXkApRJOHTosrt2K2E6aXtIyAVgfE
         48inrmhbIm0qHrKcl9PTdBTsKh6TJa1Fk/CfnBcI20HvJPnX9zis12LljCSVp3y7JeP0
         tR2NQ1e2RtAsatpF5dwergHdN83UXUOoEPcR3Y0d3DKGMZaXlVI3gMMb6qFMMYR/IsTR
         YR8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxF1004cI3JXVELe32ql0dNMs6KrooVqKhjbfU0yJcCBs3bII+Jy4E1+bA89fcG5wOpaPJ/D1O30Srz@vger.kernel.org
X-Gm-Message-State: AFuF++nowoG6DY5Rsunycgt0aWWRahhHRIy0+X7mQhtx5tP3hTMW1Lt9
	dEScNNWyH8FK/FDQjoC05JLcH+IvzMT3B6spSkdtIv6cnhOjk4C4/oppiV+XXaIgmBHzP6dVAbf
	LzFimmoEgCThT+13mj2MphNgeMIvwGan0b9rLtI3cpx5vLN//HeNaYyCyD8sNPLc=
X-Gm-Gg: AYBFou0IwiSpaXOycKHxZgw1dJ9AOfLbjwPgtrYlmToYihRiI1vB0v/aMT7IYUOKd1f
	+Bs89pY18DlokedtdPIX2gDNTJrpudV5euee9wjVWk3NeHIej6L81VPEcJQfqLDF5Fs9ARxGjiv
	YKG+/Zwn1trsolLJXCj++3Sf9ANqHZKkvKpOa1NWYO9ANbEAoroMPlFSgMNfDYAwu3fR8TUuLMp
	ArjzbHe4rsQA1t90XwUUA+m5cvhs7I6HcnwikHWI5JH5YKoDklQEDayej/+E5c7gYmo9PhQ7oNm
	rkkScgjKEHVP+296tyIJR8RO06t8cJ527arxYUz0GsrhufLeqEpp5MlNzgZgBh/acUYSIcNcPzM
	F3TomNHxonlwALWsCPJoOXxQ=
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197561005e9.26.1788786813396;
        Mon, 07 Sep 2026 06:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr197560545e9.26.1788786812906;
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm270920615e9.3.2026.09.07.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:13:32 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:13:28 -0400
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
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907091033-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:56PM +0200, Karl Mehltretter wrote:
> A virtqueue callback can outlive virtio_reset_device() and race with a
> driver freeing the state it uses. The reset helper documents that no
> callbacks remain in progress, but that depends on the transport:
> virtio-pci waits in vp_reset(), while virtio-mmio does not.
> 
> virtio_input has a related ordering problem: it unregisters the input
> device before resetting the virtio device, while an event callback may
> still be using the input device.
> 
> Patch 1 moves the callback wait into the core, using the existing
> virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
> order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
> remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.
> 
> The new hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset; fixing that is separate
> work. The event-virtqueue DMA mapping issue is also separate.
> 
> Changes in v2:
> - Patch 1: move the wait into the core instead of fixing only MMIO, as
>   Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
>   wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
>   for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
>   for transport version 3").
> - Patch 2: keep draining completed events when ready becomes false,
>   instead of breaking out, so teardown does not truncate an input packet.
> - Patch 3 is new, at Michael's request.

got all 3 patches now. it's a good start, thanks, but they need
a bit more work, in particular addressing sashiko comments.
I'd also prefer patch 1 to be split: moving code from pci to core
is separate from ccw fixes.

Pls write or at least edit commit log messages yourself,
after reviewing Documentation/process/coding-assistants.rst

Thanks a lot!


> I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
> vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
> reset returned with the callback still running in all 84 overlapping
> cycles. With the series, it waited in all 103. Over PCI with per-queue
> MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
> lockdep reports. These runs predate the per-rproc change, which leaves
> the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
> but did not reproduce a use-after-free: with evdev attached,
> input_unregister_device() waits for an RCU grace period that the IRQ
> callback blocks.
> 
> That version also passed QEMU input, rebind and shutdown checks on arm64
> MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
> UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
> shutdown check. The changed objects built with W=1 without warnings on
> arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
> on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
> lifetime KUnit tests on each, using mock remoteproc devices.
> 
> Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (3):
>   virtio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
>   virtio: implement synchronize_cbs for remaining transports
> 
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/s390/virtio/virtio_ccw.c         |  6 +-----
>  drivers/virtio/virtio.c                  |  2 ++
>  drivers/virtio/virtio_input.c            |  8 ++++++--
>  drivers/virtio/virtio_pci_legacy.c       |  2 --
>  drivers/virtio/virtio_pci_modern.c       |  3 ---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  include/linux/virtio_config.h            |  6 +++---
>  12 files changed, 86 insertions(+), 19 deletions(-)
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
> -- 
> 2.39.5 (Apple Git-154)

