Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0519CC3F
	for <linux-s390@vger.kernel.org>; Tue,  3 Sep 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356391; cv=none; b=U0lHnR/cd58EDCeDJ5WlLSBSlFe4PDTMHMQhAbD0vSWNA3qzQp8O+F6LuKxPHGl+00DD1h1wA/5HJvRU3SyOXjet9LkFrug6LO4IFCWvgqfVlAT3dWf+sjbPnJA8EopQcuMmVQ9Sao2yQQYYfCl8xwc6k6beOMLpwqrNH9P9fw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356391; c=relaxed/simple;
	bh=pE3Mr0PnS9xl+CUiCEH2hxI4fWM92/vwv+iNfIiq4l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDS8IgomyiDPCQ5suMHmLnIM3GuGztJhLoDI3S1D/xgn62DHmuTBkoxS4f34lcXE0+qT1TdRpRoEFS0o9syvDtTPXdxUNctHJGtlU++2Rcd52n0Gcifx8Lw8d5rT0xUhFidCGdTLptCX4wjufbYg+hMjK7AbUb2g3eGEuAU97EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmisxTY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmisxTY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
	b=fmisxTY53Y4E/VGqtgvHNMeW0Q3vvFvQ393P3rrr30xxTzISWya8NIcYx+PSEmTsr1yJXi
	FNnyvq1D5helKoIah8wIzx9HO+adBJRjZY7qFcRzHSZey/OllkVwi8ZdedULqp7mFGeCMx
	c9hun3MkAikIXEGP+bkhrlrTZ0eY9FU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-xqYjH8LEOPOyP0ft67KTLQ-1; Tue, 03 Sep 2024 05:39:46 -0400
X-MC-Unique: xqYjH8LEOPOyP0ft67KTLQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb8610792so45160675e9.3
        for <linux-s390@vger.kernel.org>; Tue, 03 Sep 2024 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356385; x=1725961185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
        b=qZXT0oR8zCHimdopHRgcU/puWxa/DPlJrJeXdzdS1tup3XEM4zsnYXFnmNbPann783
         PgM4P7nYsxSqF4cCQfn+vfreWgTcLvEFKMXAh0M0uafvtRZV+/RDFm08vCImrnd9H8tb
         u5SNMzjhZDKTmnA0KakXcwmIAHKfoIhw3f4RDrA1KCfVaS497ewX6zIPxYHIHYrDYQfr
         Whfwzfa7JPAGe2KndT8l7kTHrsltF1+sE5mEQdxwsSr0nhdEHrLEX68zxVlX/rET8mKf
         p2uMD3mfNgiiSt4UGkJ+LGykPV+AqWy4G7kIXZByIwK11xZLBpVrU46dAK0N+Tya8pD6
         JhkA==
X-Forwarded-Encrypted: i=1; AJvYcCXwRY7qzh9KApoh4zfTA+elBBhd7bOl9VsDXi4RJxJ0qnk2wfy9wPKxnGHUaQbakh9Z/ezmgkg/06t8@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxwWFA4OiCzcfq8YrZgayh6rwnp0irt9bcN2RbaW5CJ0PBZoq
	5sDhxniMT3T4GfHuqqK9JWK1IJ/xkglQyZ8KU2qFNSqi90dEiCcvpnwDnDJZf/0lHP1TM4pByNj
	5YMGTLdtgkweHATNa6NsEeXW2YfezV+65IuSK3gqsQK752VeTj09wVS3TL1U=
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124596375e9.12.1725356385058;
        Tue, 03 Sep 2024 02:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx9ZT+cp/JOzMdJ0eMMwlRMn2QkU5Mi38V0c6sZIqJTMhc/MD50iSbcQF046e0ymvaKlJlng==
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124595995e9.12.1725356384137;
        Tue, 03 Sep 2024 02:39:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0f41sm164222235e9.19.2024.09.03.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:43 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>, Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org
Subject: Re: clearly mark DMA_OPS support as an architecture feature v2
Message-ID: <20240903053917-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240903072744.GA2082@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903072744.GA2082@lst.de>

On Tue, Sep 03, 2024 at 09:27:44AM +0200, Christoph Hellwig wrote:
> I've pulled this into the dma-mapping for-next tree, although I'd
> love to see one of the vdpa maintainers look over patch 1.  I'm
> pretty sure it's correct, but a confirmation would be good.

Missed patch 1, I was wondering why I'm CC'd. Looks good, thanks.

