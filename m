Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E03101C7
	for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383555; cv=none; b=WD2rdVCbXUiRxHNV4Xz+VmzlaMIbflha/OXmtSuoEppk7oZAZSUbLZ3FN74tOfCK9O607/JmpIbXRSP71jS4qxCXSi50rFtz5PI02rbMNEH7m6mNbzb+vX00UBVaGSW6CHm/cp3QugS0agGy9CRn2ZkhnXY5bWghiaAPPrv0LS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383555; c=relaxed/simple;
	bh=F+mheq4O2TyVZUQvPtr2Mdpd5dqUvirPgEbavwBKIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiUgU7zCSoD3VZkJ4WD6BUafp+KrAdjplqfQs+2ynGHvuqhW0KLrnXWPYJZaAE+B2pIW4uLaboc2b6e0ylfj2Z9+T/NtGrLI1wsnNFj/XxKlLCKxBu5gbcdSA7GNGfIi+m72I2YRPckh0bLV4SzBTtyEw2WB4fRhpiupOYFI76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+Uy1ghK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+Uy1ghK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
	b=i+Uy1ghKYiQB9HQ83HISdWBR0JyfUiRGEZpRkLTypgF7udxY2vpvs4T/5PrWyV869wa603
	9MvlQ1N+Um+31Syf+BGbq/IpekxpQKk/k2xo9gIu59FbF10laTjwOyejYsozbD0acwO56V
	EJYKDsUehaFtMLs9c1zIkeEf39mZHV0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-eU1dLIiBPeSmgFt9hrQf3g-1; Thu, 28 Aug 2025 08:19:11 -0400
X-MC-Unique: eU1dLIiBPeSmgFt9hrQf3g-1
X-Mimecast-MFC-AGG-ID: eU1dLIiBPeSmgFt9hrQf3g_1756383550
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c79f0a5feaso713924f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 28 Aug 2025 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383550; x=1756988350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq9u0cnhGJ/BdyM1GbcnyYUNgnWTAGwoq7wtSCyMB/E=;
        b=U5zbyGLpexPNAj6d6ZDCDm9KbrT2ovaPICY39iQIcllJbKGNKc0Uj/ymzw6S+DktQG
         hnxhuwX+otpfSdzHnMIM5gOqI/l8NXSmP5/irLaZbkuxInBgEsvJvofMa3x+rPu49Jei
         hI73yTttCIpi8u1+wjVgXKjrmYGQekIZ+FHlf80xuxu0UfI0zY0sb38vuD0VuJ64yQxC
         UbexuABSEqNFtcc1ybhs6oSDPashcHysudua4x88NLF6H8NVNrsU2GKYN7PGWQlFuJkb
         6E47kvbijAXIJnejxMXRW3hSTL1gMOLBVGMVKFKcBuP/+D8rZCoTvx84BeE8v9AZskzE
         dJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvjWOy3Ef7UI8jp6+UMY9pVQSXHcVPGzIBxflfcxdNhcIKA8EYQB6InhTXXwMJ0os99uzRwZa56/gM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TMWcGbtQRlt6OpCS6p+9IoPqYdRD45QDPvLOb5v21Tb4V7Nw
	FPK5a58w/LeCtgiSwR5xsY3UJpF9ZGsfItt28+7gU6tRmPWhDbEUWGc/vCZA0dHAVXNtZ8jkjQP
	RWV2AVcsKu52iOH0OUYVLKIQiSEw2IsXQCtdkA+jV11qocK4MOqwL0g5MQj4sDyg=
X-Gm-Gg: ASbGncu7xWGyJYc9SAv/6KNiYtQMREsFRXaiG+eJp8K7nsGI/xypzJgo6e7TtJXF21o
	LLzxByn4Mkcp/MX6gHgHXP+d1PF17CWFpZMrIpMRTvQenkEtKHr4CYRVT8732UNlk/xt3HyICX4
	6daACuvdp7ayU5soSc4/6xx42Chs3O2abYzT6FNzl3lvnbtctLmD16MunOhZ0ur1vnbmkIBCZak
	2hNX4GPCipfQqbTOWN9k+8wUhcIXY0i6QQbtVtAb0TKVhR5KP/ZqkKyNXecIoHWNT1FTzUyWsil
	6CmhqBp9zy/tQmCg1EsQi4eFgFosjacB
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105120f8f.4.1756383550297;
        Thu, 28 Aug 2025 05:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4J85snhq1BAsqwZjK+n9dKliu/Y1mrIx2XDMWIXXrAB06TFT0/Jbg+him3WiQwpHNUEOCTw==
X-Received: by 2002:a05:6000:402c:b0:3ce:d43c:673f with SMTP id ffacd0b85a97d-3ced43c6c3fmr105090f8f.4.1756383549792;
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7112129b9sm24574050f8f.34.2025.08.28.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:19:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:19:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250828081717-mutt-send-email-mst@kernel.org>
References: <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org>
 <87frdddmni.fsf@redhat.com>
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <87cy8fej4z.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy8fej4z.fsf@redhat.com>

On Thu, Aug 28, 2025 at 02:16:28PM +0200, Cornelia Huck wrote:
> On Thu, Aug 28 2025, Parav Pandit <parav@nvidia.com> wrote:
> 
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: 27 August 2025 05:04 PM
> >> 
> >> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> >> >> > What I do not understand, is what good does the revert do. Sorry.
> >> >> >
> >> >> Let me explain.
> >> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> >> >> It prevents the vnet driver start_xmit() to be not stuck on skb completions.
> >> >
> >> > This is the part I don't get.  In what scenario, before 43bb40c5b9265
> >> > start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
> >> >
> >> > Once the device is gone, it is not using any buffers at all.
> >> 
> >> What I also don't understand: virtio-ccw does exactly the same thing
> >> (virtio_break_device(), added in 2014), and it supports surprise removal
> >> _only_, yet I don't remember seeing bug reports?
> >
> > I suspect that stress testing may not have happened for ccw with active vblk Ios and outstanding transmit pkt and cvq commands.
> > Hard to say as we don't have ccw hw or systems.
> 
> cc:ing linux-s390 list. I'd be surprised if nobody ever tested surprise
> removal on a loaded system in the last 11 years.


As it became very clear from follow up discussion, the issue is nothing
to do with virtio, it is with a broken hypervisor that allows device to
DMA into guest memory while also telling the guest that the device has
been removed.

I guess s390 is just not broken like this.

-- 
MST

