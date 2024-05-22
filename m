Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04C8061D
	for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716419937; cv=none; b=MWA9W/8gyfWa83oSFVq37apBP4aLxbwLWGFO9igB5/W3cOYoUHeI1n6oMPQeV5LTZWLS2XAHxKqVuANCvRJmu2dfDnG2RqZayd3Dp6VSUwYNq7zetJzlvT3oKCYo71WLIO3jN+otLrQ8AJ+cBIDopU0GSyuv+E+xtFWOI/EM+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716419937; c=relaxed/simple;
	bh=a8AQZsl0hHp/MWuPJC+3jCzAsXNov1TbjZ4OUKXyAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrmIq9mtF/dsd0itrTTviat3iDhia4Bm39Y+vTaO63fiO1ptywejI9SXJCEaV8kQ7YKulktnHJFi/9wJVPGwnuoinEw1LS0fsdqEo4y18vwuxjVtdCp0HRMYD7UA9+SUNGxvmuO7jbFl5FSQE2gpVmCyJdEKpaFpeR4Ed9oyCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hioXa44l; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hioXa44l"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f12ff2da3fso2475953a34.3
        for <linux-s390@vger.kernel.org>; Wed, 22 May 2024 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716419934; x=1717024734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lEc0q0NFwchKt04aNPxLlVagWl6RQJdUVl1HVjQyus=;
        b=hioXa44ltZN15LYNqtx5XNRjodlRtHndmCZ4Z9alzNul/62PAyCi+Xzw/2YZmIOPTJ
         dj/9SUGKWskskvM/xlrOlaY/9HsaF1xDOCp/nrnnPkzf8jlFvqeb/o13ihL8hI0NVLjC
         p8IqYndv/4hZ8rNfUBFyA/VVuy82mQkN+wsweY2tqXjZPVEF6AoEFX9A05fFFibCT84A
         ZqUv32IxIGDzqWMYECtgFFGea67/7PhDo+ucN2bglz8jjqBaHcYLvWwo/ITOY69Fh+XW
         bX40dr/iqXhbKAA+cT8mdfhKCKSLWGB6CyGI41AU3jiYyzYm7friZvphjpl+J9wSnH1S
         xexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716419934; x=1717024734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lEc0q0NFwchKt04aNPxLlVagWl6RQJdUVl1HVjQyus=;
        b=vfZ+VPWCQl+buy6RJQfYPnkwZY/IEA+wOsIZrbYT6Djd1frHcx+srg7BYTaJHR6lLL
         f2au62UM/BIG1bcWitKm30sO8gTXnD0ziwOQUu3Fz5JhiTy+XOmLs2xmoOpA8iUgQiUr
         yB6VArfvvaarZd2ofRhec83b4r4fnCPZNiTYF+ucJnsCWtLKbBesd2u+lYsMHPi6lYzl
         SWrhVZsrQ3bop/EDatwJj0r86CPKcwx6/E4WeuWNO1SUTROch6Hw9tjvgZn21UBNO2Gh
         2V4ANgGbTkAR1Xu2bLRCbGT1YEDcdvGe2DV0Ef0cirdGYlbbR7qABKirBlRplEzvMJQS
         AZTA==
X-Forwarded-Encrypted: i=1; AJvYcCVrvuf+j81jLak+jpMyhmKMaAyAj8c3pyqgmh/GXYKGvK/TSsXDFuapmlHG/hs+/HlHCKmCS/3wGkAYnYT6wrekjOFq/8IB4xAFwQ==
X-Gm-Message-State: AOJu0YwiMV7u7ayStck7B+hyHNoI45QK2o0be2Zb2Lq2Y0uTMOyjQgBN
	EAu67AMY+WlTt0pmhSfJ4thd9A2qXQk50+mhhAR4Xo4ej81kYAl+Vh+XoUW9tzE=
X-Google-Smtp-Source: AGHT+IGXTwA1P98f2K83E/XepnAUDe0bm40qM8+ZbtN36/xHnQTOXwlXxoFwX2cK74BW84EIAoMvyA==
X-Received: by 2002:a05:6830:18ca:b0:6f0:4201:973a with SMTP id 46e09a7af769-6f665c2bafbmr3446974a34.13.1716419934009;
        Wed, 22 May 2024 16:18:54 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792eb3c1039sm956315885a.73.2024.05.22.16.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:18:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9vES-00DcAY-9Z;
	Wed, 22 May 2024 20:18:52 -0300
Date: Wed, 22 May 2024 20:18:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/pci: Fix s390_mmio_read/write syscall page
 fault handling
Message-ID: <20240522231852.GF69273@ziepe.ca>
References: <20240521-vfio_pci_mmap-v1-0-2f6315e0054e@linux.ibm.com>
 <20240521-vfio_pci_mmap-v1-1-2f6315e0054e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-vfio_pci_mmap-v1-1-2f6315e0054e@linux.ibm.com>

On Tue, May 21, 2024 at 02:14:57PM +0200, Niklas Schnelle wrote:
> The s390 MMIO syscalls when using the classic PCI instructions do not
> cause a page fault when follow_pte() fails due to the page not being
> present. Besides being a general deficiency this breaks vfio-pci's mmap()
> handling once VFIO_PCI_MMAP gets enabled as this lazily maps on first
> access. Fix this by following a failed follow_pte() with
> fixup_user_page() and retrying the follow_pte().
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/pci/pci_mmio.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
