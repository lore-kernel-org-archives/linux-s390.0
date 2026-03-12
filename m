Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB43DD510
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334493; cv=none; b=VPxSVOyjL6LrGBU1bJuFR4VDs6FWoQxNuetLMTU4koEPvTELsxo6SrHMscvresTlYhRg0mtSJgbUHljVK/vl38N5YrIX3rrhrf/K/s3HZmD6iBKOacCqALh96/BCYIlwYAr+A2fCjDp3QRmZPpC1f+l59Ma7bf0gQeeckJvJNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334493; c=relaxed/simple;
	bh=ENv0+4bH9YdpFLGeURNwJ3+rEUsnNn74RNCtOl26SEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP6iTvng5toZXtHmkIxRhCg0rZjRcQPyWOTUwk0jJJs8Se8cPWNGYlZa+kxXRhhAK+wteDlRxDv/QMsNqmvhYW4WIvXBz2TxgE/rjqYPl+3ebCDW8RZJzbtUhuXiNBILzT6iRgufO44ZoloHCa+xSJ8iQ0lAxWExPVYgP8eBP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TCUycPJz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TCUycPJz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509149ab7d7so10174591cf.2
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773334491; x=1773939291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=TCUycPJzE2fI+UEqk7FktReSuNB+qmtoLxCPQIhObf2GoM3FGGUoUzmOL4EcJ8nqrV
         31wLWw0iuRrm5q/A3vl9oGJab4nkcB5GgE9L87TaBE5zWVhGKUEWMOYZrC4hQkz7+K+y
         MdSN9PZxg9+VlLOffdwRmQphGTW7UoGABbBRu3CtgROAhKqAusDMmmrNFgCXGsGgS+um
         4b3n9KF8H9mgZuxtPx/c84lVtPd3kX8R2XT1vLZ+RjANCZT5FGS44RpBGA5cN1JRJXTn
         oCOtB2FnqO56y3+c6Fos0prISIneHSMHrQ7vAs2p/teTVBOn2DfneDCxuRpkTU9D9cja
         6IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334491; x=1773939291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=WjN5YiSm+rgH8nokuITPGoeWjvHU1sZH3AjByuScP6q60o+dN79Z5AijLc0SnCgeXO
         zr/rderiWaiQc0Zt4deN7burnVpF4Jzi7TXEWqmRClicY8v+mos9CPSAGsN031MReU55
         ss6TA9fOjmBnMrFq2sqRuFBRHhAvtL4xi9XZ9Q46MksO+8xyQSfOXkP6g7fEOEvJRZwT
         itaNBAzqn82dQ6bfsqjL1rqVvL9QtZoPn4UHiR+H8dYWeWa1Jg1ibkGgZ8neoO3C9pCL
         ZgPIhNYhrWU7hU7PSRkODqPFuXFKmcn5DEifmELBJ8yesI4uoM1CahuBnXD+qGpnKM51
         rvMA==
X-Forwarded-Encrypted: i=1; AJvYcCUc2C5S9Nn4XEYIUychTAXT6hhrzxMvLd/Q6N9Y6misdGxuxrODZjr+v/B/EWmpY74GIc1y90TL7XwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCukf7udXmNmGmY8ZZj0rb/mGpyTPLVzf27V9Li7Y5Q4QqFgIM
	u3wDB3QeTWUvnKmZ9ki8+c6RleF7OGNslwasz51p1lV8qB8awd9wDzC4LrMbKOA1OMA=
X-Gm-Gg: ATEYQzx+QKZed1V5Fw/PxZobboLlndg9lCAvCkHkjzN6sB9BdSQCYxeKIpYA9OX9bh+
	Fe7yp9A7dF2YTLLkOoIoyZuD0m2aq4paBL4BegLUJoZ/iaNbux/soAiedzHBj0SxO+zZcXDdFcy
	iUy86GKTYvEiWdpl3u7AJqDXm105X/tYKUpWiGrAHjlCuX1MkGWNroZxv54Zclb7dHY9I9gTCav
	EdFYRUNImrdBcmi+At9eoOeERUQB3/4NZOBvN/OUVK9OfbxnNih3mMGle+4OyA5Sab7etgbyvjp
	PrS/lqIg2kFd2qUmlfxCYg/IhFcEV6rhIuY1NymDYzY1Sj1gTE5xX9vXkbnTM6pIqp+cfKPmUqS
	98oIVc13/9eOElSTzln4F8KRViGfa31rBRI0sYRaRluWWqOJV8XWK3DQyv5DhvA+3PVVtwom6M/
	eePmDjYNsBojV3dMjwhZtqHKD5fFk24I5vz8iQqQs+GtGz4Q8aZqyvUrcvx+f4H0z+hynuT/NC3
	sfWxBAFqFX4/+DRGXM=
X-Received: by 2002:a05:622a:289:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50957e10673mr1403911cf.52.1773334490530;
        Thu, 12 Mar 2026 09:54:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a119602sm36658181cf.28.2026.03.12.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:54:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0jJA-00000006i8N-40X9;
	Thu, 12 Mar 2026 13:54:48 -0300
Date: Thu, 12 Mar 2026 13:54:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
	amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312165448.GN1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
 <20260312125730.GI1469476@ziepe.ca>
 <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>

On Thu, Mar 12, 2026 at 11:32:37AM -0400, James Bottomley wrote:
> On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
> > 
> > > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > > confusing or flawed API design. It usually implies that the caller
> > > is unsure whether a failure results in an error pointer or a NULL
> > > pointer. 
> > 
> > +1
> > 
> > IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> > little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> > pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> > implies ERR and NULL are semanticly the same, so fix the things to
> > always use ERR.
> 
> Not in any way supporting the original patch.  However, the pattern
> ERR, NULL, PTR is used extensively in the dentry code of filesystems. 
> See the try_lookup..() set of functions in fs/namei.c
> 
> The meaning is
> 
> PTR - I found it
> NULL - It definitely doesn't exist
> ERR - something went wrong during the lookup.
> 
> So I don't think you can blanket say this pattern is wrong.

Lots of places also would return ENOENT, I'd argue that is easier to
use..

But yes, I did use the word "suspicion" not blanket wrong :)

Jason
