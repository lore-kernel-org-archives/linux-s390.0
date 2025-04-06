Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C14A24
	for <linux-s390@vger.kernel.org>; Sun,  6 Apr 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743954044; cv=none; b=HxKMiGt3NaCKl/Nzv+qCC3YOGEnNKozDRxFbVn1nnJpI3/7cWJ2Psjq1p7i2U+UVBQpoAb1JxrbsfCVtZmPiHnftDhwhhchv2d7cXYt0sljqVnOEX9wHDO+fRxJaNEy7mzReEIXsWE42sgsr3UlmXfKkUf+2DjLmI1WYf9z4+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743954044; c=relaxed/simple;
	bh=QPQgC7kvXKpnKQQ0zZIdhCNfWb/+UL0O59Sg480zvCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUV8hMh/+XFBUT2hPPpfQXfczXFLTG/f6rWmXdWO2GCZTEh2QNNanyKC6Nm2Qjj+pNw+DjdUI9rMz+tFVG3sEGT8f1jdd5NlyOZ0WyVlZ9pGRci1vs7Y6e0R8Vhjukzw9EisMgINOvyPKzZjUFU1dfxK+gZj/OorIGMLUaQVeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2hhBRMn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2hhBRMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743954041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vB1cPTM6kQM0IccundSU9yqiAslJfta8o011pO2Z12I=;
	b=H2hhBRMn0xHNCWxqXR0nIdyRw7Co466K6daqZ7pjuPejbyjnsrPKooMtYO5mlElEIcAIa/
	cuEWeu16Pj+lk/mQaMQ6gKfjktvDLi8Bcfx4b/Kz4hOmwR6H2Jinn7WyuM1ZbMF8aZCT/T
	LjYQclC68d66WBvFpYCqn2duRpjx0KI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Z7TIvuIFNeKzd1hCHLg2IQ-1; Sun, 06 Apr 2025 11:40:40 -0400
X-MC-Unique: Z7TIvuIFNeKzd1hCHLg2IQ-1
X-Mimecast-MFC-AGG-ID: Z7TIvuIFNeKzd1hCHLg2IQ_1743954039
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so27817655e9.1
        for <linux-s390@vger.kernel.org>; Sun, 06 Apr 2025 08:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743954039; x=1744558839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB1cPTM6kQM0IccundSU9yqiAslJfta8o011pO2Z12I=;
        b=P6Vd7aTYdQOFedMCyVieufP4nmSF6+aDdCpejZig361pqO71zNBsr/6GVMXEonX8qH
         u3UjrwTCc2xha5qdl4NQfYdbi90HgFWmVUyLtwgRsO29rRAFINAsvKQQrHOVs8Qi/qDl
         xdrvwDRCv6O7TM/AWe/rkCNiP+4K+nqRtaFdrLp2PItqMisLxkj0qx6iNSiXdUbgPwUk
         ZUTuhtA4gmhKJ1FN9P23LupcppoxrRclDWBLng0BZRz12p7KpgCHlcJIkciTqew4ikuN
         Sd65+EsWl8st8b5hL30qDAMpKFApi25QAYx1Cv2S1oXxY04BFvnqs3pV1O/a2XBdALqq
         Q1iw==
X-Forwarded-Encrypted: i=1; AJvYcCW08XPNFgTliQt0RnwRmHpjcpqbvwA1d8vG9kBjImFOwh+2+Cbk6V91u+lvOkgQgF1/Z7RBk6D20hPo@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCodmzMNM2VkQE5Z86UCvpD8NydhGjKo0fpCsZ+0Jk3oMQlOa
	t2dRy3EOIcHTOoILiavzpFpxFWqk+q8N+//EyBxLbi8ro0Xv0Buqsq95uUnXzVG0oXs+fq33bJN
	LyGb26UrHg/0dUkv91ZyrgIvBOi09WhBtYx8f3wY2dE26Ud59Ga2cJIUzSQ8=
X-Gm-Gg: ASbGncuyUR35WQQI3Yz6DsLiHm1byLg98w+yfA1QryExtI5rskRv9UDOJshmHHUCB/t
	9OX9Uq5X0dG/tFg8vLlEL3LPp0WJoZDypDwl72V5NdBomZGZWL0LbIl7KbIqPjRonlcaZ32Yl8e
	PVcj+o70DHxfBWhc9P4XKKx7KAkgGksEcMNHkEn8+x2JG1fR5t5LwRCz77SPWsNQr1BrnchG+t0
	vLwT48Crri4flPrHWe//RmuVVq98agmYHX72+LJ7vUpOAXGPr3L2k2QItXCYZ0mn8mEOjtNwYNY
	k/ovp0QsSQ==
X-Received: by 2002:a05:600c:3596:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43ed0db35d6mr95618325e9.30.1743954038952;
        Sun, 06 Apr 2025 08:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN/IYHI1ly9zqzd/yipZ2IxNmlWWEkP3lQh8Sl8IvCxIbI13KHnpOGc/44mG1AnIZVtDsnLw==
X-Received: by 2002:a05:600c:3596:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43ed0db35d6mr95618065e9.30.1743954038489;
        Sun, 06 Apr 2025 08:40:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec163107csm108121185e9.3.2025.04.06.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 08:40:36 -0700 (PDT)
Date: Sun, 6 Apr 2025 11:40:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250406113926-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>

On Fri, Apr 04, 2025 at 12:55:09PM +0200, David Hildenbrand wrote:
> On 04.04.25 12:00, David Hildenbrand wrote:
> > On 04.04.25 06:36, Halil Pasic wrote:
> > > On Thu, 3 Apr 2025 16:28:31 +0200
> > > David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > > > Sorry I have to have a look at that discussion. Maybe it will answer
> > > > > some my questions.
> > > > 
> > > > Yes, I think so.
> > > > 
> > > > > > Let's fix it without affecting existing setups for now by properly
> > > > > > ignoring the non-existing queues, so the indicator bits will match
> > > > > > the queue indexes.
> > > > > 
> > > > > Just one question. My understanding is that the crux is that Linux
> > > > > and QEMU (or the driver and the device) disagree at which index
> > > > > reporting_vq is actually sitting. Is that right?
> > > > 
> > > > I thought I made it clear: this is only about the airq indicator bit.
> > > > That's where both disagree.
> > > > 
> > > > Not the actual queue index (see above).
> > > 
> > > I did some more research including having a look at that discussion. Let
> > > me try to sum up how did we end up here.
> > 
> > Let me add some more details after digging as well:
> > 
> > > 
> > > Before commit a229989d975e ("virtio: don't allocate vqs when names[i] =
> > > NULL") the kernel behavior used to be in spec, but QEMU and possibly
> > > other hypervisor were out of spec and things did not work.
> > 
> > It all started with VIRTIO_BALLOON_F_FREE_PAGE_HINT. Before that,
> > we only had the single optional VIRTIO_BALLOON_F_STATS_VQ queue at the very
> > end. So there was no possibility for holes "in-between".
> > 
> > In the Linux driver, we created the stats queue only if the feature bit
> > VIRTIO_BALLOON_F_STATS_VQ was actually around:
> > 
> > 	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
> > 	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
> > 
> > That changed with VIRTIO_BALLOON_F_FREE_PAGE_HINT, because we would
> > unconditionally create 4 queues. QEMU always supported the first 3 queues
> > unconditionally, but old QEMU did obviously not support the (new)
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT queue.
> > 
> > 390x didn't particularly like getting queried for non-existing
> > queues. [1] So the fix was not for a hypervisor that was out of spec, but
> > because quering non-existing queues didn't work.
> > 
> > The fix implied that if VIRTIO_BALLOON_F_STATS_VQ is missing, suddenly the queue
> > index of VIRTIO_BALLOON_F_FREE_PAGE_HINT changed as well.
> > 
> > Again, as QEMU always implemented the 3 first queues unconditionally, this was
> > not a problem.
> > 
> > [1] https://lore.kernel.org/all/c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com/#t
> > 
> > > 
> > > Possibly because of the complexity of fixing the hypervisor(s) commit
> > > a229989d975e ("virtio: don't allocate vqs when names[i] = NULL") opted
> > > for changing the guest side so that it does not fit the spec but fits
> > > the hypervisor(s). It unfortunately also broke notifiers (for the with
> > > holes) scenario for virtio-ccw only.
> > 
> > Yes, it broke the notifiers.
> > 
> > But note that everything was in spec at that point, because we only documented
> > "free_page_vq == 3" in the spec *2 years later*, in 2020:
> > 
> > commit 38448268eba0c105200d131c3f7f660129a4d673
> > Author: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Date:   Tue Aug 25 07:45:02 2020 -0700
> > 
> >       content: Document balloon feature free page hints
> >       Free page hints allow the balloon driver to provide information on what
> >       pages are not currently in use so that we can avoid the cost of copying
> >       them in migration scenarios. Add a feature description for free page hints
> >       describing basic functioning and requirements.
> > At that point, what we documented in the spec *did not match reality* in
> > Linux. QEMU was fully compatible, because VIRTIO_BALLOON_F_STATS_VQ is
> > unconditionally set.
> > 
> > 
> > QEMU and Linux kept using that queue index assignment model, and the spec
> > was wrong (out of sync?) at that point. The spec got more wrong with
> > 
> > commit d917d4a8d552c003e046b0e3b1b529d98f7e695b
> > Author: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Date:   Tue Aug 25 07:45:17 2020 -0700
> > 
> >       content: Document balloon feature free page reporting
> >       Free page reporting is a feature that allows the guest to proactively
> >       report unused pages to the host. By making use of this feature is is
> >       possible to reduce the overall memory footprint of the guest in cases where
> >       some significant portion of the memory is idle. Add documentation for the
> >       free page reporting feature describing the functionality and requirements.
> > 
> > Where we documented VIRTIO_BALLOON_F_REPORTING after the changes were added to
> > QEMU+Linux implementation, so the spec did not reflect reality.
> > 
> > I'll note also cloud-hypervisor [2] today follows that model.
> > 
> > In particular, it *only* supports VIRTIO_BALLOON_F_REPORTING, turning
> > the queue index of VIRTIO_BALLOON_F_REPORTING into *2* instead of documented
> > in the spec to be *4*.
> > 
> > So in reality, we can see VIRTIO_BALLOON_F_REPORTING to be either 2/3/4, depending
> > on the availability of the other two features/queues.
> > 
> > [2] https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/virtio-devices/src/balloon.rs
> > 
> > 
> > > 
> > > Now we had another look at this, and have concluded that fixing the
> > > hypervisor(s) and fixing the kernel, and making sure that the fixed
> > > kernel can tolerate the old broken hypervisor(s) is way to complicated
> > > if possible at all. So we decided to give the spec a reality check and
> > > fix the notifier bit assignment for virtio-ccw which is broken beyond
> > > doubt if we accept that the correct virtqueue index is the one that the
> > > hypervisor(s) use and not the one that the spec says they should use.
> > 
> > In case of virtio-balloon, it's unfortunate that it went that way, but the
> > spec simply did not / does not reflect reality when it was added to the spec.
> > 
> > > 
> > > With the spec fixed, the whole notion of "holes" will be something that
> > > does not make sense any more. With that the merit of the kernel interface
> > > virtio_find_vqs() supporting "holes" is quite questionable. Now we need
> > > it because the drivers within the Linux kernel still think of the queues
> > > in terms of the current spec, i.e. they try to have the "holes" as
> > > mandated by the spec, and the duty of making it work with the broken
> > > device implementations falls to the transports.
> > > 
> > 
> > Right, the "holes" only exist in the input array.
> > 
> > > Under the assumption that the spec is indeed going to be fixed:
> 
> For virito-balloon, we should probably do the following:
> 
> From 38e340c2bb53c2a7cc7c675f5dfdd44ecf7701d9 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 4 Apr 2025 12:53:16 +0200
> Subject: [PATCH] virtio-balloon: Fix queue index assignment for
>  non-existing queues
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  device-types/balloon/description.tex | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
> index a1d9603..a7396ff 100644
> --- a/device-types/balloon/description.tex
> +++ b/device-types/balloon/description.tex
> @@ -16,6 +16,21 @@ \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device I
>    5
>  \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtqueues}
> +
> +\begin{description}
> +\item[inflateq] Exists unconditionally.
> +\item[deflateq] Exists unconditionally.
> +\item[statsq] Only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> +\item[free_page_vq] Only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> +\item[reporting_vq] Only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> +\end{description}
> +
> +\begin{note}
> +Virtqueue indexes are assigned sequentially for existing queues, starting
> +with index 0; consequently, if a virtqueue does not exist, it does not get
> +an index assigned. Assuming all virtqueues exist for a device, the indexes
> +are:
> +
>  \begin{description}
>  \item[0] inflateq
>  \item[1] deflateq
> @@ -23,12 +38,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
>  \item[3] free_page_vq
>  \item[4] reporting_vq
>  \end{description}
> -
> -  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> -
> -  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> -
> -  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> +\end{note}
>  \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
>  \begin{description}
> -- 
> 2.48.1
> 
> 
> If something along these lines sounds reasonable, I can send a proper patch to the
> proper audience.


Indeed, but do we want to add a note about previous spec versions
saying something different? Maybe, with a hint how devices following
old spec can be detected?



> -- 
> Cheers,
> 
> David / dhildenb

