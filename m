Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D596154C0D
	for <linux-s390@vger.kernel.org>; Thu,  8 Aug 2024 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146121; cv=none; b=E7Vavh+lel44EvibgFL1akELwZ8WdrR5i1uxqjT4rDNQfSUq1AgZxHZwp0A0cZ/ubw8D4rO3nvxUFvMXTXRhwagDZclaiFu7B1SrWYfaJdK+l0tKo84Cac2lToN9VkUMogrh8n8Aj2vUwr4Raf3ws4LW36AkgNf6Z4vMqpNPnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146121; c=relaxed/simple;
	bh=tfohJsfe91Cq8eQD/ZDuC0uUPLKbEmFWl0olIpR+tUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A08iV+K9M5Ed0eeofZ2gcQLHL3fSxcNADVyo99IK3Daz1myfiT6oK8HK0+HkKjCl3gqM6hgqrNva9pfFe/4Fr7vtG7/cF5ugW4L+obuuc+hetLOuf5hcuoIBDLTDutEs50UEI8PR5XE3oaNW7/wpXSvuU1v6dl000+AgPRueIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dUtyubKe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dUtyubKe"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fea2d40adso7562171cf.0
        for <linux-s390@vger.kernel.org>; Thu, 08 Aug 2024 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723146118; x=1723750918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKlfsJF0CD5HfJ7xy5871QLT9TMYxhiJPetjQ2Zc8oM=;
        b=dUtyubKeRbRWUvQUrV/afeHB2Q3T+6h+eCWWK5v9ZJTV4EcyJelXCcav5Bv5L9fR1o
         lBurXWp6RIHc7Imk7My7It52vQp4UMFSTlyfDp1P5Upuy4iT3oOaNRpodc5w5nPP44in
         fTtWAzXnssxGwSa6zubxMbqC9s0xRUyitA79shb22I/UNLunUorla0+JZFJBfqF6qXEX
         2Rq0txIdl5CfwEZWcBn1I/dno2hQhp0TKYTo0xNxGdmaDuqrlPu3A2KgDngfCVdXpQTn
         NNgYWq65ZCS0mepbJXKxnrJalbDznMD0wEU4sZ2o/q6Czf+lrsZtXL/AYovPXzBH+PYt
         P6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723146118; x=1723750918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKlfsJF0CD5HfJ7xy5871QLT9TMYxhiJPetjQ2Zc8oM=;
        b=AQA0K/BHpMGNdJoFr/APknrZzmCPkVIEy/+fzSNgHVeqc8ICFEgX12ScfiQw+EFcD6
         4v0xw1q5Do7yIIG6X2cCgphgQZ9M2UBClS/XftxAEhtRPY3Bum3IWqKgt6Ndhj2Y3Bwa
         dVnG2GdupJL1oNRXQPwNWNT6PnekPzy/IPQfkJhjIEIgFwtPN9oy/C0yJpoBbRmvrG9K
         Y8wwyDjEoK0Upv2yP339cuT9GNxTgbs2XL3vnufLIjOWG5JXV1/fHJ5J94QX/u7sZ/BQ
         Vz45DFJ+hP74klvAAR3XxG6K20Pv3nT9oAvlqhQ46C6V+YbLjvnzF9Vs94+6R+s/2Gw0
         v51w==
X-Forwarded-Encrypted: i=1; AJvYcCUfrU5IO2Q3Xhv75FBvKFbgbzcNmLrr08t4usLQxh/66jJZNl2q1gojHwzjBzwLlOJBbvdiOF/6nkzL1beoTk+VG3f62sqn49Ruzg==
X-Gm-Message-State: AOJu0YzNdoxT5odPaukAzg6GdsdemnHM5jXIhmFGpUxZ0VrCJoJZaUJW
	qrEPhnntevNQkabTieLfHP3R8/xRpQVAjk9PDb+im34lQ/uyvx7E4vvGV9Itsk0=
X-Google-Smtp-Source: AGHT+IHeLz+52p3YFQ1GzW+PZ1L4qdGCbBqLPLxf3eHvw9bY0A30iXZCHlJ8zQlSzy7jCcRCtrr3rw==
X-Received: by 2002:a05:622a:1e09:b0:44f:ff90:b153 with SMTP id d75a77b69052e-451d4275f68mr29137941cf.38.1723146118315;
        Thu, 08 Aug 2024 12:41:58 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c86fe411sm15618681cf.18.2024.08.08.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:41:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sc91H-00Axc5-S1;
	Thu, 08 Aug 2024 16:41:55 -0300
Date: Thu, 8 Aug 2024 16:41:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Implement blocking domain
Message-ID: <20240808194155.GD1985367@ziepe.ca>
References: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
 <20240808134451.GC1985367@ziepe.ca>
 <0abe7286-ae33-4637-b0ea-f1f2e352eb21@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0abe7286-ae33-4637-b0ea-f1f2e352eb21@linux.ibm.com>

On Thu, Aug 08, 2024 at 01:05:36PM -0400, Matthew Rosato wrote:

> Since c76c067e488c ("s390/pci: Use dma-iommu layer"), we stopped
> checking for a NULL zdev->s390_domain during
> s390_iommu_release_device.  This causes a crash specifically if the
> last attach_device call failed (we exit on -EIO with a NULL
> zdev->s390_domain).  I suppose we could also fix the specific crash
> by restoring the NULL check in s390_iommu_release_device, but this
> seems like a band-aid and I'm concerned that there's more lurking
> here when get to this state...

Implementing the static blocking domain and using release_domain
should fix all these crashes, I think. The core code will sequence
everything and zdev->s390_domain should never be NULL. You'll get
trapped in a blocking domain and can't exit which will trigger
WARN_ON, but at least for the first step of this problem it should be
enough.

> > But what is the backtrace that runs into this warn on? VFIO exiting
> > and trying to put the device back to the DMA API?
> 
> Yes, exactly
> 
> [  198.067373] ------------[ cut here ]------------
> [  198.067377] WARNING: CPU: 44 PID: 394 at drivers/iommu/iommu.c:122 __iommu_release_dma_ownership+0x72/0x80
> [  198.067386] Modules linked in: macvtap macvlan tap vfio_pci vfio_pci_core irqbypass kvm sunrpc s390_trng eadm_sch tape_34xx tape tape_class vfio_ccw mdev vfio_iommu_type1 vfio zcrypt_cex4 sch_fq_codel loop configfs nfnetlink lcs ctcm fsm ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 nvme sha512_s390 sha256_s390 nvme_core sha1_s390 sha_common zfcp scsi_transport_fc 8021q garp pkey zcrypt rng_core autofs4
> [  198.067424] CPU: 44 UID: 0 PID: 394 Comm: kmcheck Not tainted 6.11.0-rc2 #111
> [  198.067427] Hardware name: IBM 3906 M05 780 (LPAR)
> [  198.067429] Krnl PSW : 0704c00180000000 000002bbfc744576 (__iommu_release_dma_ownership+0x76/0x80)
> [  198.067433]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [  198.067437] Krnl GPRS: 0000000000000290 0000000000000000 fffffffffffffffb 000001b386842098
> [  198.067439]            0000000000000000 000001b3865b5c00 000000000000255b 000002bb7c586068
> [  198.067442]            000001b3ab82a018 000001b7ff0af6c0 000001b5d0e4af68 000001b5d0e4af00
> [  198.067444]            000001b389772300 0000023bffe33e28 000002bbfc744560 0000023bffe339d0
> [  198.067452] Krnl Code: 000002bbfc744568: f0a0000407fe	srp	4(11,%r0),2046,0
>                           000002bbfc74456e: 47000700		bc	0,1792
>                          #000002bbfc744572: af000000		mc	0,0
>                          >000002bbfc744576: a7f4fff8		brc	15,000002bbfc744566
>                           000002bbfc74457a: 0707		bcr	0,%r7
>                           000002bbfc74457c: 0707		bcr	0,%r7
>                           000002bbfc74457e: 0707		bcr	0,%r7
>                           000002bbfc744580: c0040025f71c	brcl	0,000002bbfcc033b8
> [  198.067468] Call Trace:
> [  198.067482]  [<000002bbfc744576>] __iommu_release_dma_ownership+0x76/0x80 
> [  198.067486] ([<000002bbfc744560>] __iommu_release_dma_ownership+0x60/0x80)
> [  198.067488]  [<000002bbfc7445b8>] iommu_group_release_dma_owner+0x38/0x50 
> [  198.067491]  [<000002bb7c2a1e24>] vfio_group_detach_container+0x154/0x180 [vfio] 
> [  198.067500]  [<000002bb7c2a0d88>] vfio_device_remove_group+0xd8/0x140 [vfio] 
> [  198.067505]  [<000002bb7c5648b4>] vfio_pci_core_unregister_device+0x34/0x80 [vfio_pci_core] 
> [  198.067513]  [<000002bb7c5841cc>] vfio_pci_remove+0x2c/0x40 [vfio_pci] 
> [  198.067517]  [<000002bbfc6ec7bc>] pci_device_remove+0x3c/0x90 
> [  198.067520]  [<000002bbfc75dda4>] device_release_driver_internal+0x1b4/0x260 
> [  198.067527]  [<000002bbfc6e2844>] pci_stop_bus_device+0x94/0xc0 
> [  198.067531]  [<000002bbfc6e2b66>] pci_stop_and_remove_bus_device+0x26/0x40 
> [  198.067534]  [<000002bbfc6e2bb0>] pci_stop_and_remove_bus_device_locked+0x30/0x40 
> [  198.067537]  [<000002bbfbde2838>] zpci_bus_remove_device+0x68/0xb0 
> [  198.067541]  [<000002bbfbde0780>] __zpci_event_availability+0x250/0x3a0 
> [  198.067543]  [<000002bbfc7e4528>] chsc_process_crw+0x2a8/0x2c0 
> [  198.067548]  [<000002bbfc7ec690>] crw_collect_info+0x2e0/0x360 
> [  198.067550]  [<000002bbfbe15bde>] kthread+0x11e/0x130 
> [  198.067556]  [<000002bbfbd930ec>] __ret_from_fork+0x3c/0x60 
> [  198.067558]  [<000002bbfcb233aa>] ret_from_fork+0xa/0x38 
> [  198.067564] Last Breaking-Event-Address:
> [  198.067565]  [<000002bbfc744560>] __iommu_release_dma_ownership+0x60/0x80
> [  198.067569] ---[ end trace 0000000000000000 ]---
> 
> > Though I feel like more is needed here if you expect to allow the
> > nofail version of this to actually fail.. For instance a force-blocked
> > device should block driver binding through the dma_owner APIs.
> 
> Yeah, that makes sense too. 

And I think fixing this should be another patch, though I'm not
entirely sure what the best approach will be.

One thought is that, presumably, when the hypervisor fences the device
it asynchronously makes it blocking, which is another way of saying it
has halted all DMA from that device.

So, even if we could attach a domain, it would never be used since
there is no possible DMA.

Thus, why fail the attach? There is no way for anyone to tell the
difference between an attached translation and not attached because
the DMA has been halted at the device.

If you can tell in the s390 driver that the hypervisor has fenced the
device then maybe just reporting success to the upper layer is the
right answer here.

Jason
