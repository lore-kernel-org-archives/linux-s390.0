Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE015680
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032743; cv=none; b=Y23/SxRtgc/uWrfkfe63ozU7q3Ugob508OC1Kb9MhfXaV9DL70Vy3vyxSLMz6tayk1/i+rea12lPY38FSQI73LCpGaw61brJA5Wb0VjvFFw4iae2M94GQuRWQx424AU7+kBGZghwd2PE5gKPo0hxXd69FxiFqPo82RR4b9ladOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032743; c=relaxed/simple;
	bh=OuqnqTBRovbLLVo3HjN6qkc40vRHSouYVZwbCzzmelk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqyEnlYd2M2z5sf6+b9P+diXSNvYqzT25kELruRVmnY55mm2FPrDzzUzywKTfXhx4rEoE1yx4khzXlrzpOmBQOPzhsSpgztezBqOs2W8MQLFf78oCRtUinOzkrAz8bCZvcvNQ1x/iC++dXFVbQX4Dm0y0pErx5Kl9hG3Yhq5/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcCbgyRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcCbgyRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744032740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h2t9badq02L1YqSPP4iwtiUyd5ByYzFMz5Gq8uEjc+Q=;
	b=QcCbgyRZC1Aqfk2KumHdOp+2tEJTmf0OvgK0XsRfAp5aFGx+JaY8CqK3fH9UJ0Kpyzj9l2
	uC6BY2cNcbb0+Fob/5s+RjLnIn0Y1PVVgu4KSNt6ZG2Niv977eeGFyRYkPsoOiKmSPYj1S
	fmSmyUJhc+NOSvPZRi6517G32BXRiD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80--nPoxOgTM6SXX19S1VksqA-1; Mon, 07 Apr 2025 09:32:19 -0400
X-MC-Unique: -nPoxOgTM6SXX19S1VksqA-1
X-Mimecast-MFC-AGG-ID: -nPoxOgTM6SXX19S1VksqA_1744032738
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aea90b4so1776752f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744032738; x=1744637538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2t9badq02L1YqSPP4iwtiUyd5ByYzFMz5Gq8uEjc+Q=;
        b=MaWYZqwEm5fgIErmmFq43M1JTv9FzbPpX724d8Xi3do/NdJwSDXsug5fUbUvcpMIjR
         ONrjJGCP1oIBG7fZv7/T5I67+nn5dbNgyuVi9sGVEUbADl71r74bGWncWupfFabfUXjR
         /bY+CPDdVgffo0X6sZGuWVOOTT9lWqbu9tPvIBJIYACPdNlFCUj76M+0XXwuYnhc7EGx
         nkSbAFdNH8HuLwy/9ptwHtlIG8aJaFzfsV508ufPlJpNiOUZn0QQO5uwgUPBDMlCi43i
         KZCH9UMKoW4nEIyvNNIAQtkcmVnGBjkvn04ntPDAz+1Hh1leNTt5LEclb6mzbFmidzEG
         hrTA==
X-Forwarded-Encrypted: i=1; AJvYcCUcF1xv7PPiQWp4sGzNvrsyPtJsr7fu+lQxgTAQ32rkTcmv8AJOXP56UzZJswR5zMkpVGgdLrNc2e4r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5e8bjDxGsUQplCSUUvSeKESim48evMC+YFkdEz7x8vuYgOcvP
	MdRvbZ0XZ6FrbuzNBWMRBsZ0QF1x6qXaMaxTd7RrB7LPgjelfzheXgZcmVXB4OnJqiXdgV17FH6
	SwZxzzib7ewpIdaxivMKGsgZIXT3WJPr41iiaTJN2Ov0D5tfrDVHlWKZ2URQ=
X-Gm-Gg: ASbGncsSMNXlUK5tM6LWa79miPTbCe1e0D5m70KpTKA15bfiJe76wJTinhElBKLMlIP
	Jfs61Z9WJ2mI0bsnuW7A56Bp+h0JDGWBP7UZ3xeRwQNwszMnIeVP8x+iizvYhU1qNEbXF/4xKep
	e8x2PpkvQFJDW5tRDoF6tBTj5jaCYyEJujSRpLQ0KKCcBZPDw4JDZlaFTt7eNVrG9FGuemo6jUD
	MR7WFgHBdUrYkSMXiGfYXp1RQp/rawTZ8jSIyuwDVtgl8ZqUPlcUul9VJTkvzMYb5jTFAcwaSVY
	wCqnXmjQKg==
X-Received: by 2002:a5d:64cb:0:b0:391:3f64:ed00 with SMTP id ffacd0b85a97d-39d6fc4e930mr7966126f8f.26.1744032738400;
        Mon, 07 Apr 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXFTZnDhg+4j5062m2TfC0SmlVES+KRW+YMFO/ahaSOai2rwVuCa6Gs1wgPmSJN+hQ8wtpg==
X-Received: by 2002:a5d:64cb:0:b0:391:3f64:ed00 with SMTP id ffacd0b85a97d-39d6fc4e930mr7966079f8f.26.1744032737999;
        Mon, 07 Apr 2025 06:32:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020da49sm11908898f8f.80.2025.04.07.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:32:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 09:32:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407093047-mutt-send-email-mst@kernel.org>
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <20250407151249.7fe1e418.pasic@linux.ibm.com>
 <9126bfbf-9461-4959-bd38-1d7bc36d7701@redhat.com>
 <87h6309k42.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6309k42.fsf@redhat.com>

On Mon, Apr 07, 2025 at 03:28:13PM +0200, Cornelia Huck wrote:
> On Mon, Apr 07 2025, David Hildenbrand <david@redhat.com> wrote:
> 
> > On 07.04.25 15:12, Halil Pasic wrote:
> >> On Mon, 7 Apr 2025 04:34:29 -0400
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >>> On Mon, Apr 07, 2025 at 10:17:10AM +0200, David Hildenbrand wrote:
> >>>> On 07.04.25 09:52, Michael S. Tsirkin wrote:
> >>>>> On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> >>>>>>>
> >>>>>>> Not perfect, but AFAIKS, not horrible.
> >>>>>>
> >>>>>> It is like it is. QEMU does queue exist if the corresponding feature
> >>>>>> is offered by the device, and that is what we have to live with.
> >>>>>
> >>>>> I don't think we can live with this properly though.
> >>>>> It means a guest that does not know about some features
> >>>>> does not know where to find things.
> >>>>
> >>>> Please describe a real scenario, I'm missing the point.
> >>>
> >>>
> >>> OK so.
> >>>
> >>> Device has VIRTIO_BALLOON_F_FREE_PAGE_HINT and VIRTIO_BALLOON_F_REPORTING
> >>> Driver only knows about VIRTIO_BALLOON_F_REPORTING so
> >>> it does not know what does VIRTIO_BALLOON_F_FREE_PAGE_HINT do.
> >>> How does it know which vq to use for reporting?
> >>> It will try to use the free page hint one.
> >> 
> >> First, sorry for not catching up again with the discussion earlier.
> >> 
> >> I think David's point is based on the assumption that by the time feature
> >> with the feature bit N+1 is specified and allocates a queue Q, all
> >> queues with indexes smaller than Q are allocated and possibly associated
> >> with features that were previously specified (and probably have feature
> >> bits smaller than N+1).
> >> 
> >> I.e. that we can mandate, even if you don't want to care about other
> >> optional features, you have to, because we say so, for the matter of
> >> virtqueue existence. And anything in the future, you don't have to care
> >> about because the queue index associated with future features is larger
> >> than Q, so it does not affect our position.
> >> 
> >> I think that argument can fall a part if:
> >> * future features reference optional queues defined in the past
> >> * somebody managed to introduce a limbo where a feature is reserved, and
> >>    they can not decide if they want a queue or not, or make the existence
> >>    of the queue depend on something else than a feature bit.
> >
> > Staring at the cross-vmm, including the adding+removing of features and 
> > queues that are not in the spec, I am wondering if (in a world with 
> > fixed virtqueues)
> >
> > 1) Feature bits must be reserved before used.
> >
> > 2) Queue indices must be reserved before used.
> >
> > It all smells like a problem similar to device IDs ...
> 
> Indeed, we need a rule "reserve a feature bit/queue index before using
> it, even if you do not plan to spec it properly".


Reserving feature bits is something I do my best to advocate for
in all presentations I do.


-- 
MST

