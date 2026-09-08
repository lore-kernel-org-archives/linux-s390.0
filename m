Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389D41F5D9
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855966; cv=none; b=g7z5oMBzEH+PQFE9+TCULKL6Xtsb1pfz9m+NKbjisUEaOJWYznhPZnPh9bRrdGCaKL2V+5dOQNh+eSj/j1PVbSljT8FLdRVKinuOrzN7Rt7aqYEgrFoUPfByLI75nI1nAQ3Il6UoJwEukkiyQmLH2jwGvVqgs0sRxnyLWsiloSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855966; c=relaxed/simple;
	bh=mtlzNqSHslbgTL1E+s1EGrdbdVuzUh95XoEfQxCcoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gri6CCH/U5vGNJG0M0lUYMoEsE+jPedk34PmR6Vz68ne5eEm2dnJVP34Q7nHntbWtePJlMWHnAIkVhvn+Nnv6sCdH6JM8wT2cqY/u0gRFPRSbzCNwxuwMe1d3FVPmkJBRV7/3JsM4nxoTYxD2YqZcMIsufoK2P/htWxcT8SdU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUKW+cRB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=blHQ7m7q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUKW+cRB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="blHQ7m7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
	b=QUKW+cRB1vgNMh8fgJCHLMmXMprE18hgjlH8ruQ4mKP0QEdME0Bd1bp6oFUehRhSOObasJ
	J7EmHViJb1sqrLkkZGzcUu5I1kKHZvnXtnF8P6Ekqhe3jfIfD5aRcz6JqZzj3963hxYzOu
	DKEer3pEpYfvnVv+cuhlM2gVxZon2X0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-z9LP9f7xNB-Azc2Q8rLzfw-1; Tue, 08 Sep 2026 04:26:00 -0400
X-MC-Unique: z9LP9f7xNB-Azc2Q8rLzfw-1
X-Mimecast-MFC-AGG-ID: z9LP9f7xNB-Azc2Q8rLzfw_1788855960
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499913d1a79so29150045e9.0
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788855960; x=1789460760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=blHQ7m7qqboFW3r6pTJA/NJjuXOUcG3Y9jU/uGSV8i2+NXm26ccxZXSXFlN67Azz4v
         oxM8bQat53/aYMj0lbrhefkbLS7J0pfdt6hRtaPJA0eV+l6qEHKT57tH/4ucCnNVZOyn
         ttLKh/yZZ4s9hsUptbven/he7AO4Fi2Wn7Eje4FHcC+6T6DLPVYCNFNgMK4ZBOEJGqf9
         lOH/AXFL35a6CF0xLC2ilTJ9J2EwVm2ddCB7Bh2GLxAS3lWpxuZgjrZTg/GdT94R34Je
         XId37U9W27Mitf6e+aZ2jhHRbgRgnlcnWnztjalp8Po+czyD/UaSXQ0zhRFcVgg5qMbx
         R7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855960; x=1789460760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=hmNjLfwjZB3TG1UbjGduf30ferSrigObC0I0ibjrIB1U0jowe78Zg+OhPmcLhm5g8G
         PNZ6v4c7RhFrbSIxCteXmH01i3GsyPyCwA9L6dLHWVhy/Ux0SmNrleMPWkFqAbfq7Br5
         C69qf0AwxN6aFoWONJjpNg0eRqnssbP1BBOPJrRUuaHVntp4Nr9FUP6XL3lVJEmXRigm
         lH4owo8H2YnO5hoabB6FgSWVWiOrntJ9v62e7lEI3ohrMbG+UYPOD87+KXMF9z1J9Hfy
         B8LfbGCiRfEEReMhNT+mMnGNeGDdxbKQFCqcuomkaCoZtVKZ/atzNMozvFe4K60TZRy+
         VxDA==
X-Forwarded-Encrypted: i=1; AKwUvBw8Pzpia4OycH3YoR8X5e7c/J+8QJnq4FLkUvJP+9pVSSDQ2f6+be8pxVuW8Wm2B7tmgi9YiiR+Y1Pa@vger.kernel.org
X-Gm-Message-State: AFuF++l8zEO2XvupNzR4jMa4ngOAcYUYLcW5UfoFijqvZFMTrHavXYz/
	zPyrKNBES2HPtxCxxw82e+6c7SexURio6l+IBgzQ62CMvZAszfSeoU4On8Qk4hqMadS8p88VshM
	4G/M+leA0QdfqwsosPyCN/6cpC0/gx8J6CJDuZRoO8JWeyGAFzBZPCwQQ1ANDVJs=
X-Gm-Gg: AYBFou1f8iuw9mg30HnsvWMud9JfIQa9CSXbA0L7qYVADQiQN0IC5x8nrXNmRHM2kP3
	1hsglTXSCI6LdCRJIGL00lrGseGSMvRVMJfEWnPI4S5TwIGpEAzNQKXGRaKcCDSdVY0W9uGQMe6
	mSnttIO/kO6AkBMDsu9fr1PuE1ucAXAJDLjDoDL2KvIKNAKo5SI1ADRVC/ZlCiZBSlGoe37GOBd
	ca4ths6BtSGRyAJDMz514R+3wItxglxMmBN98nf1/s+Dp6bsTHJAkZdqzW98rWQALZE4M1z1FYP
	B4rlx9EmnUu/fQ4pftnXtgbhZLLJ10OR/vbrfxI4F04uZPCcKOldo9ZKfjanDL1gJF+jlgC8bsU
	xYj+HDoRL4Is+11GKUo0DVuA=
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469629285e9.9.1788855959369;
        Tue, 08 Sep 2026 01:25:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469628205e9.9.1788855958792;
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm275644125e9.0.2026.09.08.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:25:53 -0400
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
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Message-ID: <20260908042440-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>

On Tue, Sep 08, 2026 at 07:38:11AM +0200, Karl Mehltretter wrote:
> This is v3 of the callback synchronization series. It is based on
> Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
> synchronize callbacks after device reset"), which already contains the
> core change and the virtio_input teardown reorder from v2.


Thanks I applied since this looks like a net improvement.
Pls keep iterating on the core change.
If you want to take a stab at some of the pre-existing issues -
will be welcome.
Pls do note which patches were tested and which were not.

> Patches 1 and 2 fix two bugs in virtio-ccw's existing
> synchronize_cbs() hook. After a fallback from adapter to classic
> interrupts it selects the wrong lock, and the classic interrupt handler
> only takes the matching lock when notification hardening is enabled.
> Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
> Patches 4 and 5 replace the RCU fallback with synchronization against
> the UML IRQ and the TmFIFO callback locks. The fallback already covers
> these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
> in virtio_vdpa so callback synchronization does not depend on the
> context in which the vDPA driver invokes the callback.
> 
> The UML, TmFIFO and remoteproc reset paths do not themselves prevent
> new virtqueue callbacks. UML and TmFIFO only clear a status field, and
> remoteproc does not wait for the remote side to acknowledge the reset.
> Without notification hardening or driver-specific teardown protection,
> callbacks can still start after reset. The new synchronization hooks
> do not fix that. The TmFIFO hook also does not synchronize with the
> rest of the FIFO work item outside the callback locks.
> 
> The virtio_input loop change from v2 (continue instead of break, so
> events the device already completed are still delivered) and the
> event buffer leak are sent separately.
> 
> Changes in v3:
> - Rebased on Michael's linux-next branch. Dropped the core change and
>   the virtio_input patch, which are there already.
> - Split the virtio-ccw fixes out of the core patch, one per bug, and
>   the transport patch into one patch per transport. The CCW and TmFIFO
>   changes are functionally unchanged from v2.
> - Patch 2: added a Fixes tag and described the existing shutdown
>   case. Removed the dependency note on the core reset change.
> - remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
>   synchronize with callbacks in __rproc_virtio_del_vqs() before
>   freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
>   hunk also applies to mainline, which added attach_work after index.
> - virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
>   check.
> - virtio_vdpa: use SRCU instead of a per-device rwlock, so the
>   callback tracking uses per-CPU counters, and cover the config
>   callback (Sashiko).
> - Rewrote the commit messages. Corrected the RCU fallback description
>   for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
>   reset race: the simulators disable bottom halves around virtqueue
>   callbacks and serialize reset with the worker's mutex.
> 
> Changes in v2:
> - Moved callback synchronization from virtio-pci into the core, as
>   Michael suggested, and added the missing synchronize_cbs() hooks.
> 
> Testing: the changed objects build with W=1 without warnings, with
> clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
> patches also apply to current mainline and linux-next. The runtime
> tests from v2 were not repeated on this version: the input, rebind and
> shutdown checks on arm64 MMIO and x86 PCI covered code that is
> unchanged here, and the remoteproc and virtio_vdpa hooks have only
> been build-tested. No remoteproc, TmFIFO or s390 hardware was
> available.
> 
> v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
> v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (6):
>   virtio_ccw: fix synchronize_cbs() after interrupt fallback
>   virtio_ccw: always take irq_lock in the classic interrupt handler
>   remoteproc: implement synchronize_cbs() for virtio devices
>   um: virtio_uml: implement synchronize_cbs()
>   platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
>   virtio_vdpa: implement synchronize_cbs()
> 
>  arch/um/drivers/virtio_uml.c             | 10 +++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
>  drivers/s390/virtio/virtio_ccw.c         |  6 +---
>  drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
>  include/linux/remoteproc.h               |  3 ++
>  7 files changed, 102 insertions(+), 15 deletions(-)
> 
> 
> base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
> -- 
> 2.39.5 (Apple Git-154)

