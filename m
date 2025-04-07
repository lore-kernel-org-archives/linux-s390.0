Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA22A1ED
	for <linux-s390@vger.kernel.org>; Mon,  7 Apr 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016307; cv=none; b=oPeyOpJqkvb8imuH0RVZo83wc3/33tgU9j1MZs+FJgpeTETG/zKSZpWDQVZePEY0J1kiCzlrrmmUBNxz6q17kxtN0FVU5CLEy/UQH8FLxUr0n+dMVZplvr6FGcANIwEYLOSo46T2eTC68vsD5TnHb+uoVykkUQg8Cp9SFE5IJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016307; c=relaxed/simple;
	bh=CG8MriHLl4x6ooaR3HqW98i5p2ZNjETviVu5KLjC8Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdKNXPrMQ9M0s1fkuNNAvUVG75bOYPZUMIrREepFpLTdoEAtyAwcJKTPxXkut+QSvT1cSjeSLFQrkha4j7E8pUMmPGnJIr2KJYOPooiCKoRooTR9ff0noH1f+IzqcXzd6/oQ1Oyb2k3pAV3f6hpfSotQWAknIjjIDTgl6fsuvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JECNUsOk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JECNUsOk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV2HmK5xoNyWQTq3ZOPhBucA+WbSSx9NK0eZZiZro+I=;
	b=JECNUsOk6InsM64N6tecTWiUJZbDV5wi+58pL+l1zC3Cf2FklXMtmuTJZL+N1t7pKg5JC4
	Lx25XgsH/dNGtITptNHqiE82oG02Ou36fq29T31AmhexBRem6Zzf4EfWHXwFijhZ1GzJbz
	p4BHSnL4t5A2RINqzrx2PTAVtMndmec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-1Z9B7N_wNEaBuIXKv-8tVQ-1; Mon, 07 Apr 2025 04:58:23 -0400
X-MC-Unique: 1Z9B7N_wNEaBuIXKv-8tVQ-1
X-Mimecast-MFC-AGG-ID: 1Z9B7N_wNEaBuIXKv-8tVQ_1744016302
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so32075645e9.3
        for <linux-s390@vger.kernel.org>; Mon, 07 Apr 2025 01:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016302; x=1744621102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV2HmK5xoNyWQTq3ZOPhBucA+WbSSx9NK0eZZiZro+I=;
        b=DTyaPgOsdJ8BkHAFutcJexAaMhFnF7tx5NxS0U3HAjQXUrN/BXcqmq5ZGfZwjJTRkp
         9XzQaK5+9H6T5/TclGVl+ZtHoD6Q/7+KuiRc8plL9SOiia04Ee/dh/SJ/63826FIxanT
         IlqDRpeYtj0U9jywLVv7jTMMGvwH71PGB9XgP5U1+yf+3MinU6bbugE2iTUdQqw8FOGA
         Fmm8jyB1k6yShWsy4u0W2ofYw146LzF/7tNcjVygwgM7QqwVUtItWARMBkUv6b38H9GG
         Dcr2HmBofZ5sA7SxxnDi0bsfEHnh+gTzqNG5SHu8wKC0rEFb8QgVQ79XYsElfxPEax2E
         Styg==
X-Forwarded-Encrypted: i=1; AJvYcCWSWsHSiZHv3YI+X8Wu/YNhT1nJBKNYuf9zIQhtWo84Jq0UtNHbXnXVnAK7IW4gzmtdn8vEiOCZ1Fqs@vger.kernel.org
X-Gm-Message-State: AOJu0YyssjmU+IWY6olt0YhqkleGPmClx5YQBYynQL4gxb92xxi7ncMT
	Cy4jKOZjVeXArPkiFBf4ky4tyW7kESAb8u8QrrW5cCIsU66HMNhiLBqgvMwmN6ORNjkuNXc7vdK
	DNnLYj66diHh299Ydub91XtWyhRiZwTq0GAbFSXBYcmfTOWm2J3iatXEA1gA=
X-Gm-Gg: ASbGnct7G4ktfNaaIeWgqzIVSXYER/51bMZ+GvwlvsiNsgvjvMjGEx0J49TGtfKw6bR
	Va7fq1bewrmyPU6Wtel0vWft8Fr5hMbZYNF5qgzejWa+ZI/3p1e0yhd/QdW+trPPrnyNJH/IyHQ
	b8cvNFLE2+nskz6Z8VNDCd3BBKv0kCLw0i2e9U/cJD3takBxAUKQtlTTP7E07yNArQpLtOQIaqb
	01gWe9tKaza9QIZCg3f9U6vQnqL0iKCNqwcK8mcY4eyeq4ZvFVjdndMrzy7bJNksXjhAvKki+cF
	GiCP+U+cLQ==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr115799995e9.13.1744016302269;
        Mon, 07 Apr 2025 01:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhKuX0mUrFJVEgLqylU9xtfrLnxP9uo0MumXdr880MeHJm8lYFGfF2ifqGSX/2NbtuHhA09A==
X-Received: by 2002:a05:600c:468c:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43ecf89dddcmr115799665e9.13.1744016301907;
        Mon, 07 Apr 2025 01:58:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342827fsm124494865e9.6.2025.04.07.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:58:21 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:58:18 -0400
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
Message-ID: <20250407045456-mutt-send-email-mst@kernel.org>
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>

On Mon, Apr 07, 2025 at 10:54:00AM +0200, David Hildenbrand wrote:
> On 07.04.25 10:49, Michael S. Tsirkin wrote:
> > On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > > > 
> > > > 
> > > > 
> > > > > Whoever adds new feat_X *must be aware* about all previous features,
> > > > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > > > 
> > > > 
> > > > The knowledge is supposed be limited to which feature bit to use.
> > > 
> > > I think we also have to know which virtqueue bits can be used, right?
> > > 
> > 
> > what are virtqueue bits? vq number?
> 
> Yes, sorry.

I got confused myself, it's vq index actually now, we made the spec
consistent with that terminology. used to be number/index
interchangeably.

> Assume cross-vm as an example. It would make use of virtqueue indexes 5+6
> with their VIRTIO_BALLOON_F_WS_REPORTING.


crossvm guys really should have reserved the feature bit even if they
did not bother specifying it. Let's reserve it now at least?


> So whatever feature another device implements couldn't use this feature bit
> or these virtqueue indexes.
> 
> (as long the other device never intends to implement
> VIRTIO_BALLOON_F_WS_REPORTING, the virtqueue indexes could be reused. But
> the spec will also be a mess, because virtqueue indexes could also have
> duplicate meanings ... ugh)

what do they do with vq indices btw?



> -- 
> Cheers,
> 
> David / dhildenb

