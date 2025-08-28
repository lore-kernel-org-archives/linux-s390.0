Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBC30FF20
	for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386056; cv=none; b=k/V8SO5v4PB/TgXyv3dCReNuhpstnOpxqdmOUheR1tULQtkMCEcd+zw9XIn1YeZxiQbREOUDGFnh5qPFqhx5TQ1MIA14SFNGcCs0FI/uLnM4eH3Ohw2QiLCmU0pqYpt4yvfNulnyzTDV//Ay/Qf0ikxHY9BZi1Mqez23m5hHKmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386056; c=relaxed/simple;
	bh=jKUgrkKGxwjF/OmmVzVGTm7SLGw0brqesEGq3+BW44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTjJscqWchIpA/HEMgnqn7TMeszP/cOosguW5mZtWF+NDxXgklEB2/SITFYp9ytAHLAaqG29FfB6Afgm3AzHZaGefi5UV8sWIHc/4DnTYZhmWVQOW4sXT+uxfqlY7ZqHE4FznIJzh/WplLlvOORmLBvVF6ipMTZSWKFTAsg6104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wzi0buhq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzi0buhq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbvuB6Au0zhNqXABCgDm8J3gFB0IHbInVCTp8q39tsI=;
	b=Wzi0buhqCMGaIhkel7ejT+AOpqQzxxgNDbCYqaIe1FIDGNSTq3YftD43YYGrveax9KAsxZ
	MhLAMVikdGMtP8UlAy1V+AtqrefxugThsOgpJPBlfvBWuY3KOUYi7aOkCHAXJIM2fzLpY8
	wug37TSyK4Kv61DbPdta8O7eCSq4Noo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-mCjf6RcRM9y3fK1b-SKlbg-1; Thu, 28 Aug 2025 09:00:52 -0400
X-MC-Unique: mCjf6RcRM9y3fK1b-SKlbg-1
X-Mimecast-MFC-AGG-ID: mCjf6RcRM9y3fK1b-SKlbg_1756386051
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cc3765679fso352086f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 06:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386051; x=1756990851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbvuB6Au0zhNqXABCgDm8J3gFB0IHbInVCTp8q39tsI=;
        b=JtNkJiMhj74KwaDqxK64gzud9boDMIVqNHL5OFccqa4lyr2zgtYkQF48Dnjzi+wxgO
         zeUE4AQcoaViav0mxttEwqAuKPuZj4m0cbrzDsiaENpU1A/GDTnq7uUQmRc5iLIoo4db
         9BppWwy+lU/TR2ld/hXF4MVJQKFZ8dZFxGZinc8pi8tl87JqP6/vhJKmSNEjbSVpoE3C
         fiGKcllLMKpgi6CkA7LdnhcykU59kczyccppXapl3CfkBb+b4H/AbLY2wApj04DRssQO
         LTMGSVAJMDc8QxKin9bCGLHywe732rvvPp58WBpthYxLp02qKArw2edPdkzdhI+f7nzP
         sB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVFLVGBvXcXGDANxDRTFHPZSp52BSs26UfOQlcEaqBGFG7Qa0GLyBFNzqQsopHWELElfW5aup+epXhc@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaC9RRBEbymmLwfsXJfa6zr/rCCYYGmFqP2OmBBkuJRt8tGHc
	kfz8sY3gGp43/ijb+uUfPLIGUV6+T6h+4QFAkRNrE+EwFT6W1iaiqPZVKSKDZMazGyMXG6nXuZG
	pCD2ZU3O+YUmN1Gm7idiQ6e2i+uLOP2wx1yCpOBwuprT8Pnzxdw838a1vsWLfNvo=
X-Gm-Gg: ASbGncu8KnioDUanRuE5pwq+AuG74bvGisZp3LT9ryV1KcqGol/eQDw4mKS9So4cKQl
	7yW45x4vqmlAvgc8fTxMVjasvitypFJP7lunOEi+ydAzHs9OcmtwG9/IzeBg1oRGRs5Tb1NluZd
	WlA5FdFdqlSURXpn6rj7/1rqQI/XGiFJIsMV/Tcfm2gtF9+Ehjj0JhC6QsVgCRAs0Fd81RT8ipY
	TxLrYI3gFZEpEZmAigo0GSAY4da38uZPbv1aQzu23Sj+Sgj1r+S1P/bFH3W7qNKH00cyRB57nly
	Zm54pTgOzumqi8VDS5ywPgZs5yrECFBM
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea2 with SMTP id ffacd0b85a97d-3cb46fc90eamr6842050f8f.6.1756386050901;
        Thu, 28 Aug 2025 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFwS7Qliz/HxgGv2dXJpTk5nUZcNUDdFuQrU+BPOwYcdT0gczDl4R2JQKuapyawZNMQWWyqw==
X-Received: by 2002:a05:6000:2386:b0:3cb:46fc:8ea2 with SMTP id ffacd0b85a97d-3cb46fc90eamr6842013f8f.6.1756386050171;
        Thu, 28 Aug 2025 06:00:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd5997658fsm4839515f8f.46.2025.08.28.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:00:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828085526-mutt-send-email-mst@kernel.org>
References: <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
 <20250828081717-mutt-send-email-mst@kernel.org>
 <87a53jeiv6.fsf@redhat.com>
 <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719591FB70C7ACA82AD8ACF8DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Aug 28, 2025 at 12:33:58PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: 28 August 2025 05:52 PM
> > 
> > On Thu, Aug 28 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> > >> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> > >>
> > >> >> From: Cornelia Huck <cohuck@redhat.com>
> > >> >> Sent: 27 August 2025 05:04 PM
> > >> >>
> > >> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >> >>
> > >> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> > >> >> >> > What I do not understand, is what good does the revert do. Sorry.
> > >> >> >> >
> > >> >> >> Let me explain.
> > >> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> > >> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb
> > completions.
> > >> >> >
> > >> >> > This is the part I don't get.  In what scenario, before
> > >> >> > 43bb40c5b9265 start_xmit is not stuck, but after 43bb40c5b9265 it is
> > stuck?
> > >> >> >
> > >> >> > Once the device is gone, it is not using any buffers at all.
> > >> >>
> > >> >> What I also don't understand: virtio-ccw does exactly the same
> > >> >> thing (virtio_break_device(), added in 2014), and it supports
> > >> >> surprise removal _only_, yet I don't remember seeing bug reports?
> > >> >
> > >> > I suspect that stress testing may not have happened for ccw with active
> > vblk Ios and outstanding transmit pkt and cvq commands.
> > >> > Hard to say as we don't have ccw hw or systems.
> > >>
> > >> cc:ing linux-s390 list. I'd be surprised if nobody ever tested
> > >> surprise removal on a loaded system in the last 11 years.
> > >
> > >
> > > As it became very clear from follow up discussion, the issue is
> > > nothing to do with virtio, it is with a broken hypervisor that allows
> > > device to DMA into guest memory while also telling the guest that the
> > > device has been removed.
> > >
> > > I guess s390 is just not broken like this.
> > 
> > Ah good, I missed that -- that indeed sounds broken, and needs to be fixed
> > there.
> Nop. This is not the issue. You missed this focused on fixing the device.
> 
> The fact is: the driver is expecting the IOs and CVQ commands and DMA to succeed even after device is removed.
> The driver is expecting the device reset to also succeed.
> Stefan already pointed out this in the vblk driver patches.
> This is why you see call traces on del_gendisk(), CVQ commands.
> 
> Again, it is the broken drivers not the device.
> Device can stop the DMA and stop responding to the requests and kernel 6.X will continue to hang as long as it has cited commit.


Parav, the issues you cite are real but unrelated and will hang anyway
with or without the commit.

All you have to do is pull out the device while e.g. a command is in the
process of being submitted.

All the commit you want to revert does, is in some instances instead of
just hanging it will make queue as broken and release memory. Since you
device is not really gone and keeps DMAing into memory, guest memory
gets corrupted.


But your argument that the issue is that the fix is "incomplete" is
bogus - when we make the fix complete it will become even worse for
this broken devices.





-- 
MST

