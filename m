Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C9245012
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196187; cv=none; b=iFMSRVWmsnDNkiDl/B+PCNfCBdswNM099blqaXjApNFan3URsQq1mqmPqZbWQ4ZSdqOwmN+bRjj2q8UK2p2AS9SE8UJ1dbNf1nONW6zGQ5MQ3u4HFjklqRbkvMyGLKH1ptmNjS7TnJ2sdrQqwl4qEO/JlzpknTZOOp666NTz71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196187; c=relaxed/simple;
	bh=LTCwaImwKuvWXY2scLkUXgWwOFI49yWpZ+qPbyisx2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ9IMmxugZ76855thAVBfzVAZGpC66ikJo+G1jCJC/3J61Y/p0BQh96PCsgt0dO9qNGFXmRrGQi/FT8yYV3e/suHBPQbQqjc+oEWjki9GAxP5DKmkNutj8nZpOsUsP3zkqJB7+seZMhCRDkx1CDgTytM5cOlb1PfIJlwX5gXFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZpzofv3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZpzofv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744196184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Giukvq1XMekOaAYyLauP2qjMQgVPWM9Bad3lqnf3cCw=;
	b=GZpzofv3VnlMlF3TsU2dcxEsH6EXSUW7C2SaH7X0djruiyD2/Y3D39WLchoMk/OXpwnETM
	MLiE0oH5eSzrnY5zCpOJIvb3Gu1yiu7eX9UUX4HVrGB0JoqjfMcX5V9IdW4V+Sldo6YNYU
	x3voRVE0/a+19sHqdgTlongZ2FiTShY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-e1sTZSpuNbKBAZrupyl6tw-1; Wed, 09 Apr 2025 06:56:23 -0400
X-MC-Unique: e1sTZSpuNbKBAZrupyl6tw-1
X-Mimecast-MFC-AGG-ID: e1sTZSpuNbKBAZrupyl6tw_1744196182
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so36279685e9.2
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 03:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196182; x=1744800982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Giukvq1XMekOaAYyLauP2qjMQgVPWM9Bad3lqnf3cCw=;
        b=l0JLmQBMISeneZ7U70zhhmzhXXF9Cnbw+T/8k/zhow32XzzwjAcysKGGcxJhZXqaqe
         nHK7R2qMN4t1C+/XMBtafL2VDd6Ef9JInKElod3dCUbcTYLv5oynoEHyMqVE0DPrbahY
         N7KBp1BXpB0a4ysdtuvVkOhLdycujj81UHeqzbBtVDIKcJ6+WhFTGGlG66wkK+7D2zuE
         SpPSzxcG0o7wWmbw15RZxlw54MtdZyCbRZXDbcPIr8Fvkb6ucuqMe2cu06nPpPdfiE11
         EuPgW5Kg6qDR57ttZTIyRm4NQzMH+/xKHT2xOjhLgec+GdqUhDSedhhqOa/wuM9fTNzJ
         nRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2+oHd2k22ZCWBKSgt1cxDv4dgu4VIFly9TzbQGRSwuE7cHA/taGqelW9C/5EqVn28QrhalnHQSfUw@vger.kernel.org
X-Gm-Message-State: AOJu0YyXb8rvsTQ2YnWgP4t3G9n9fOasAZ9Q8ZwSR/4SthFJa4YjlAl6
	U7l0puqcAzqsfTOV/1Wf522x9rmN42N4BcuN1v2CYoVfX9jlLZ1Nc/Od1a3HcQPmjC61MG2LwXY
	YxVqZ1ZYSdLTmgWml5KU0Wq9fFwQl5OJP08gK0KQV6hIEMoSf7RfLmsTdEoE=
X-Gm-Gg: ASbGncvyM6sEw8XI20pGdtwu50xseGcPBMwDg+ZUbtTzGhfG2vJvI2qZSO+ORD+LTv1
	xCEzPpH5cBmvgKSC6Fy5IXJnC1mpBR2M5ECu8o/mrILxbdnzFstr+Qot3Rj1SHEpKHMdp2v36II
	5yVQt/v8hD8XT76BjdlCuwL8/cD7E4w6cWYH/3giHpEhgaq5FYGrdtQuD4EpqgCiw4VZTrsUEtt
	LLe0uDjytze2dl8s7a0ugROeW7sIDg5g7LnsgyauqFVv/2XGr1VpdtukoKO2pWOGiiafj/kcvr8
	QKw5Ew==
X-Received: by 2002:a05:600c:3b0d:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43f1eca7da6mr24601145e9.11.1744196182105;
        Wed, 09 Apr 2025 03:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNLH4SJp0xl9ym+oA6t+X06BpgXTrGstDaDUYdeGqpHCubYFfAQEql88GLYD8pGId9XSYpMw==
X-Received: by 2002:a05:600c:3b0d:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43f1eca7da6mr24600885e9.11.1744196181679;
        Wed, 09 Apr 2025 03:56:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20625eeesm16142845e9.11.2025.04.09.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:56:20 -0700 (PDT)
Date: Wed, 9 Apr 2025 06:56:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250409065216-mutt-send-email-mst@kernel.org>
References: <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>

On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
> On 07.04.25 23:20, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
> > > > In my opinion, it makes the most sense to keep the spec as it is and
> > > > change QEMU and the kernel to match, but obviously that's not trivial
> > > > to do in a way that doesn't break existing devices and drivers.
> > > 
> > > If only it would be limited to QEMU and Linux ... :)
> > > 
> > > Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
> > > implementation at least for the 3 involved features only, would there be a
> > > way to adjust crossvm without any disruption?
> > > 
> > > I still have the feeling that it will be rather hard to get that all
> > > implementations match the spec ... For new features+queues it will be easy
> > > to force the usage of fixed virtqueue numbers, but for free-page-hinting and
> > > reporting, it's a mess :(
> > 
> > 
> > Still thinking about a way to fix drivers... We can discuss this
> > theoretically, maybe?
> 
> Yes, absolutely. I took the time to do some more digging; regarding drivers
> only Linux seems to be problematic.
> 
> virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
> problematic features (free page hinting, free page reporting) in their
> virtio-balloon implementations.
> 
> So from the known drivers, only Linux is applicable.
> 
> reporting_vq is either at idx 4/3/2
> free_page_vq is either at idx 3/2
> statsq is at idx2 (only relevant if the feature is offered)
> 
> So if we could test for the existence of a virtqueue at an idx easily, we
> could test from highest-to-smallest idx.
> 
> But I recall that testing for the existance of a virtqueue on s390x resulted
> in the problem/deadlock in the first place ...
> 
> -- 
> Cheers,
> 
> David / dhildenb

So let's talk about a new feature bit?

Since vqs are probed after feature negotiation, it looks like
we could have a feature bit trigger sane behaviour, right?

I kind of dislike it that we have a feature bit for bugs though.
What would be a minimal new feature to add so it does not
feel wrong?

Maybe it's in the field of psychology though ...


-- 
MST

