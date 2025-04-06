Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE742E62C
	for <linux-s390@vger.kernel.org>; Sun,  6 Apr 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743964975; cv=none; b=EfOUs68V6L4Ws3vsrQKy2y5DGS07ouaDR2J1wGzlQPVIrRkDHFhu4v997rJBJD3szQ9Yj9pmH/TKVbN+uVGe/U83zIaCw/lDmSVYZPD3sr8Kzp9B88k9DrnZAKcnUNyREpmoVTKjWy6xjSEV6v+1/otYxI3sUHg5Klm39I9+HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743964975; c=relaxed/simple;
	bh=jkthnwIu4x2ab3rryn7gQmfrXQCW9AmPrBXkvq286QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECJ4il33pZ31WJ6Tj3S3EcfHhpX1e+Dn6Cpf8vpFrWHziniYtm/kx54X28kSKurmjjdBeUZ2pNIPfkDbAF9qDolZPby1OTslh6WkGKXd03mTkVMjVX/hUkEgjfMSDLL8vdrKDENNJuCAwSObv2wXmqWDuX+wWTE/vr13EbSPIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPbiR3Vz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPbiR3Vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743964971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4c8B490RwiITrJ+PXzql/YyOvDN55S409ylH6Wlhgw=;
	b=jPbiR3VzmzK3U5KM0ypg2bdnc/f5urhMk2YtasnzBBMEdXv/tNfx9gUb4veFj3Vezn4exT
	LYZRyZuoW4vUExMLdn0VIVJcrDPTLb0QWp+0irSM8mfLUDEsSoC/V/1X20fVWs6YlbG2N9
	VT/9/X1Sc8Im3K3TzqrE3ay6D1v83bM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-OiAbZXM-MoOrNMeUu9xC7g-1; Sun, 06 Apr 2025 14:42:49 -0400
X-MC-Unique: OiAbZXM-MoOrNMeUu9xC7g-1
X-Mimecast-MFC-AGG-ID: OiAbZXM-MoOrNMeUu9xC7g_1743964969
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso23419395e9.0
        for <linux-s390@vger.kernel.org>; Sun, 06 Apr 2025 11:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743964969; x=1744569769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4c8B490RwiITrJ+PXzql/YyOvDN55S409ylH6Wlhgw=;
        b=tJevVYlEErslRgon3A+9+YAqKOOjLkBHSqRSHumUUU2XvluvHDVz4VnT66/4QtKG9d
         eJ3PBo5+muUMquhCJvP8r5XjYRJ+yDVeCCrWLvBOFI0I94HlKVoh7GMiTFoKUnwiPKqD
         vgnBPCK1ysLvjWQ4ExRn0xAsbYRe4leavbol2PPc3j4ZdqKlu14ajqSKoexmDCyAoOTo
         btb4nxR5DvWuJ91Z5LOG2Dahyou+aTdu4HggVh+OkU+qcqdnclEqM+VjsCrhWMvJkqmR
         JJnhtCVwQcuGv/SIF4B2IeY2m/JOfBo2WXJeS7X8U5ue8b3pZnvx9N5Tk6FA5TqUMM9p
         kgTw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ttfvP8wfXenUL27x1Aa5fCkGnpdVj3InlnHIQHVdL/cjHiSUSmhK/1Cjh7TXfU6TyCPbpBY5Tx4i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8U5PdZQc+r8Q6lUS5X00egwya0JedAuaw5CfuEAwJyXOavxfY
	3PWhHNFohX3hJkBHAzQJ+BWJehF77qidHHn0LHSxA75+Jd5VsD+bP076M54O0bFmfdOuj14f6QX
	lAAqOhLKuWKtLKBhIdTmwuTx2IZGPBgV1lrUXrL7DpByAMCWoP5W8I2G2ff8=
X-Gm-Gg: ASbGnctBkezGKpveAPSIQCIWtQVkZQGJ/4bHNvxX38E8G7QDYEYOeMRtSNa9T7HnNUc
	kNWAlq3DglJbjon8cldToSSjCDC+DclK4O62fwCpF2VZKRyBdVuL5rnS343OfG0hBMBatXRsjsl
	LdUeaIA/V66cf++VyD2jMTvJfQnbmZ0wkTUiGrPmOinAhi8W/t8CTacePkuLthM+dm6F7EBxNmk
	KNahxH3Fv06ePAu8DlXheNKBaoHKWXSDZtINvjinHpaE3CeS0jyZOK/1eMFNF1xqXCtuTPTPR1Z
	DgwMw+06Ig==
X-Received: by 2002:a05:600c:1c02:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-43ecf9c3318mr77649465e9.26.1743964968812;
        Sun, 06 Apr 2025 11:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ7Ob0gGk+5s+Q1YLlqY/Rv4sutBh4ToTvYFi5jKg1vPDkOglX+EoRqjaRhaLmLLp6Pxa/Tg==
X-Received: by 2002:a05:600c:1c02:b0:43c:e6d1:efe7 with SMTP id 5b1f17b1804b1-43ecf9c3318mr77649235e9.26.1743964968402;
        Sun, 06 Apr 2025 11:42:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968cfsm10197854f8f.16.2025.04.06.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 11:42:47 -0700 (PDT)
Date: Sun, 6 Apr 2025 14:42:44 -0400
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
Message-ID: <20250406144025-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>

On Fri, Apr 04, 2025 at 03:48:49PM +0200, David Hildenbrand wrote:
> On 04.04.25 15:36, Halil Pasic wrote:
> > On Fri, 4 Apr 2025 12:55:09 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > > For virito-balloon, we should probably do the following:
> > > 
> > >   From 38e340c2bb53c2a7cc7c675f5dfdd44ecf7701d9 Mon Sep 17 00:00:00 2001
> > > From: David Hildenbrand <david@redhat.com>
> > > Date: Fri, 4 Apr 2025 12:53:16 +0200
> > > Subject: [PATCH] virtio-balloon: Fix queue index assignment for
> > >    non-existing queues
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >    device-types/balloon/description.tex | 22 ++++++++++++++++------
> > >    1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
> > > index a1d9603..a7396ff 100644
> > > --- a/device-types/balloon/description.tex
> > > +++ b/device-types/balloon/description.tex
> > > @@ -16,6 +16,21 @@ \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device I
> > >      5
> > >    \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtqueues}
> > > +
> > > +\begin{description}
> > > +\item[inflateq] Exists unconditionally.
> > > +\item[deflateq] Exists unconditionally.
> > > +\item[statsq] Only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> > > +\item[free_page_vq] Only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> > > +\item[reporting_vq] Only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> > 
> > s/is set/is negotiated/?
> > 
> > I think we should stick to "feature is offered" and "feature is
> > negotiated".
> > 
> > > +\end{description}
> > > +
> > > +\begin{note}
> > > +Virtqueue indexes are assigned sequentially for existing queues, starting
> > > +with index 0; consequently, if a virtqueue does not exist, it does not get
> > > +an index assigned. Assuming all virtqueues exist for a device, the indexes
> > > +are:
> > > +
> > >    \begin{description}
> > >    \item[0] inflateq
> > >    \item[1] deflateq
> > > @@ -23,12 +38,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
> > >    \item[3] free_page_vq
> > >    \item[4] reporting_vq
> > >    \end{description}
> > > -
> > > -  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> > > -
> > > -  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> > > -
> > > -  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> > > +\end{note}
> > >    \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
> > >    \begin{description}
> > 
> > Sounds good to me! But I'm still a little confused by the "holes". What
> > confuses me is that i can think of at least 2 distinct types of "holes":
> > 1) Holes that can be filled later. The queue conceptually exists, but
> >     there is no need to back it with any resources for now because it is
> >     dormant (it can be seen a hole in comparison to queues that need to
> >    materialize -- vring, notifiers, ...)
> > 2) Holes that can not be filled without resetting the device: i.e. if
> >     certain features are not negotiated, then a queue X does not exist,
> >     but subsequent queues retain their index.
> 
> I think it is not about "negotiated", that might be the wrong terminology.
> 
> E.g., in QEMU virtio_balloon_device_realize() we define the virtqueues
> (virtio_add_queue()) if virtio_has_feature(s->host_features).
> 
> That is, it's independent of a feature negotiation (IIUC), it's static for
> the device --  "host_features"


No no that is a bad idea. Breaks forward compatibility.

Oh my. I did not realize. It is really broken hopelessly.

Because, note, the guest looks at the guest features :)


Now I am beginning to think we should leave the spec alone
and fix the drivers ... Ugh ....




> 
> Is that really "negotiated" or is it "the device offers the feature X" ?
> 
> -- 
> Cheers,
> 
> David / dhildenb

