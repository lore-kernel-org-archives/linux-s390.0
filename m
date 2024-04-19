Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0713B5B6
	for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545274; cv=none; b=j0RXTyV61dItj7c8b3GFS0gGSSchyzUzbkd6K8W5cUcGLw60Sb9iq2MDLc4ddw3JdQQNPQfDibLidG9O0WBHz2AceENKrfrYL6Iexz2WIid2Qd2SPJ4DhJk7wp288L7T7KhL7K0EtRnWP1GzMzBLlnq07IPYQrGeJ/qARifnAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545274; c=relaxed/simple;
	bh=T02q1rb4rsBReuQXcflU1n69DpjcnWDg8hoiph/WLoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiw4/6MauFFDpdSnh57pXd3gdP28v+9iDoQ34yPH1Wad2039X7e6W9wrH4/FGbAfqBUy8S8VW2QJEAxKddIUjqJT5lxWed15aVsBiu3kUysLiV/nYQ/Uj34OsEhxoW9CIIqKfuKyGvJhOKzDA2DPPym4e4ID27dL8YhoeBBZZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BW406ytp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW406ytp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713545269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RodqwT5IeuGNfIZiWO2QXlPoIuB+k2ixWxyrvN6drLQ=;
	b=BW406ytpQWIYhNpnTJTrRIcTDgzBdUm8U4H2JYGJvznAGmUvWCsFTTrDLwW9LIM5mo1jga
	mKRH2kyM4f3u/trpidjpxaoh78vT7jyFq3g7l5aofO+FhgQF8UZlr6DWOK03gIi4gMfbv6
	x5gBo7zsqRisiffM1bJqlVlf4ow/b3M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-XKcaHfWgP-CtqHi3NGHQhw-1; Fri, 19 Apr 2024 12:47:48 -0400
X-MC-Unique: XKcaHfWgP-CtqHi3NGHQhw-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da1e2fc445so244258039f.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Apr 2024 09:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713545267; x=1714150067;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RodqwT5IeuGNfIZiWO2QXlPoIuB+k2ixWxyrvN6drLQ=;
        b=gkfL+2dzmnkgTlcBBNSmib1u0To479r4IVBCuE1KIYuJXN05tqDgfetyUL8OCtFGOW
         9HKYILnGj8zLXk8mU0VOWLVvdN01MyLWzH22Hs2v3q6R0aWF1dyr9o1so+8i2nCOkThu
         9+lFzrbKfCokL2Zk6/1nFTHpFICKJ672vgLh/QL9YFrTHwKUgMiJ3nu5S6cUvExgBGP3
         yZo/PrdXXJnyV1gQd6rcauKedLWY5BZVgP/YAIqg46499FCzSr3D9X8g3meq+SG/dq/U
         94Wo3xslqlQ2g2VwktFsQdlu6inT/go4QMQWiQ3u0MThjKGGRLN9Qsbm64zxWdbdfU5x
         MDYw==
X-Forwarded-Encrypted: i=1; AJvYcCU6m9SL/rrBU2nLYWBM56+7jQNJVuDWx42FXCZh5xQ3BfDpIIa1Xq3BEwHdDR8eZtOYGyAm1oHXmEvaYBSRtBSKKerz+mOys5slig==
X-Gm-Message-State: AOJu0YziM44ieUdN2mxHGfQ3GJt+Pn2MmsTKccecOEZlguvBjw3SguTS
	HMaTBVkv2bc8GBr4qj9ImJ+ke4ekRB9Jdq2hEh9j9SyDm7VKIGIsfueH8DI/XDaV8AI70lofGAz
	Ax3FGnFK6YjF7dHMB2JPfVuIAqhSZyFwkKsBCvxedRvzgcqsRXqnFOXmOwGw=
X-Received: by 2002:a05:6602:4fc1:b0:7da:19a5:625a with SMTP id gs1-20020a0566024fc100b007da19a5625amr2754796iob.21.1713545267433;
        Fri, 19 Apr 2024 09:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGghQ9Ch+rGJ+S9P4TDh5J127Ym3OX7IdSCqtYp36nRCCasOaS18mX+MmALWdBucddy6VSbYw==
X-Received: by 2002:a05:6602:4fc1:b0:7da:19a5:625a with SMTP id gs1-20020a0566024fc100b007da19a5625amr2754776iob.21.1713545267098;
        Fri, 19 Apr 2024 09:47:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id fb15-20020a0566023f8f00b007d6905cc017sm997636iob.4.2024.04.19.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:47:46 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:47:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>, Ankit Agrawal <ankita@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, Ben Segal <bpsegal@us.ibm.com>
Subject: Re: [PATCH] vfio/pci: Support 8-byte PCI loads and stores
Message-ID: <20240419104745.01ebb96f.alex.williamson@redhat.com>
In-Reply-To: <20240419161135.GF223006@ziepe.ca>
References: <20240419135323.1282064-1-gbayer@linux.ibm.com>
	<20240419135823.GE223006@ziepe.ca>
	<c5ba134a1d4f4465b5956027e6a4ea6f6beff969.camel@linux.ibm.com>
	<20240419161135.GF223006@ziepe.ca>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 13:11:35 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Apr 19, 2024 at 05:57:52PM +0200, Niklas Schnelle wrote:
> > On Fri, 2024-04-19 at 10:58 -0300, Jason Gunthorpe wrote:  
> > > On Fri, Apr 19, 2024 at 03:53:23PM +0200, Gerd Bayer wrote:  
> > > > From: Ben Segal <bpsegal@us.ibm.com>
> > > > 
> > > > Many PCI adapters can benefit or even require full 64bit read
> > > > and write access to their registers. In order to enable work on
> > > > user-space drivers for these devices add two new variations
> > > > vfio_pci_core_io{read|write}64 of the existing access methods
> > > > when the architecture supports 64-bit ioreads and iowrites.
> > > > 
> > > > Signed-off-by: Ben Segal <bpsegal@us.ibm.com>
> > > > Co-developed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> > > > ---
> > > > 
> > > > Hi all,
> > > > 
> > > > we've successfully used this patch with a user-mode driver for a PCI
> > > > device that requires 64bit register read/writes on s390.  
> > > 
> > > But why? S390 already has a system call for userspace to do the 64 bit
> > > write, and newer S390 has a userspace instruction to do it.
> > > 
> > > Why would you want to use a VFIO system call on the mmio emulation
> > > path?
> > > 
> > > mmap the registers and access them normally?  
> > 
> > It's a very good point and digging into why this wasn't used by
> > Benjamin. It turns out VFIO_PCI_MMAP is disabled for S390 which it
> > really shouldn't be especially now that we have the user-space
> > instructions. Before that though Benjamin turned to this interface
> > which then lead him to this limitation. So yeah we'll definitely verify
> > that it also works via VFIO_PCI_MMAP and send a patch to enable that.  
> 
> Make sense to me!
> 
> > That said I still think it's odd not to have the 8 byte case working
> > here even if it isn't the right approach. Could still be useful for
> > debug/testing without having to add the MIO instructions or the our
> > special syscall.  
> 
> Yes, this also makes sense, but this patch needs some adjusting

Yes, I think so too, falling back to 4-byte accesses of course if
8-byte is not available.  Thanks,

Alex

