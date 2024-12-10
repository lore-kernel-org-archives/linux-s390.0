Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7100238731
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850617; cv=none; b=CNJiXlnjfIxD7b9Bs1Bu7J4x2znWlzNw5e+dhNQbVFB/dFm9OF7kiBLs5tETYlwEEIIXdlVnDLVfn6U8Bx+CgJGO5PHBvm8a+bMzmtnzz2AHke2rXD/43FGaHxRAYRwkC4tAclrTydDAekwfpTbiK3FLi7X8aMyu5+r5GjylbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850617; c=relaxed/simple;
	bh=dOcgx4vsAaKPwnMQs4DZgk10sp7QpEKQF5PwdcJZOW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJCDiw4DxVqNO1lUR64pQoIOpI1gUwvibQRtss/TaiG5+lB0rGCVA6/4Tn/kBIPmHcbMAh7RaTwzc6hquqp5xqJlgheZlyYjoXFVwtpuTq3amMv3BHOhRhsOJyUWaKxnbz4NL005zd49eqmy+a0No3IPqdbchlFcl2PVoR9oJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qxp9XfwK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qxp9XfwK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21670dce0a7so13637045ad.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733850615; x=1734455415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ywDe46rhLkZ9bsyw9G5gDKVK+sDMoiD1i1tPx8KAFg=;
        b=qxp9XfwKCdJvPLoO3j3nSZ2OJHe0lKjQDSh1rw62gdfaf+7FzvSbbY0COO5S7ZJ4xJ
         z1X8oJ8ejpk28v5zEBHe4CrThSH0h8og8zv7dEWpYH7nJVk3mWTWsSDozQPxW9bj7R1a
         o3rH4v2/CeVRve1pAONJRtPl+ci4XOvQIhfxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850615; x=1734455415;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ywDe46rhLkZ9bsyw9G5gDKVK+sDMoiD1i1tPx8KAFg=;
        b=Saux9EzX9PdZLvzRdpdLjQC8iW2pDRmR+ZqMkqLbmub4dwS3r1nEQcJkgW2wMni7rt
         XmjutW+mjx0sP6/G7Wd24o1+EM8jOm0K9qOeFx7p3W3ZLMR7OvQotIcntv9Dbiloc6Nb
         nF6hb6WG4dfGoy2M1DVFSrxnguNlsaZiDX3TcS/m5QpzPGHHng/HbveeQ63WT9gbsicZ
         KkXD712QnqOK+KrLR50UEVie8QXkyWZEQDpzDkE3UPqvthtrs5CZEYTaNDE3JLg5BcQe
         vnIdIyby3LvClKR4PIkpAu1kdrsEi6/Slma4sSk7GF02pjVjtje5B19QzzSoLDP99Uq9
         pQyg==
X-Forwarded-Encrypted: i=1; AJvYcCV53BW42LswE/3DzZ7pvU0aizd/GJJfVpdQgBBpeYod/3y3+w8USqTfd2dsg3BOGLrBxGyb748gO/Rh@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5Cm4iAEZQ+/5PQ5d1mP6hWo1DJh7tqBpbBby/TeymSc5pJgH
	tTKbgKgFP0Y77zJ5YRfYdtYKTklE2n6hPCbI9YmZ8JF1HYc0iJOgebeZX/yWXjY=
X-Gm-Gg: ASbGncsLslc3IsA2MT7TEwAExpqapJzFeoxr63ZO5wvevfV8Q7kiLPF2+rhCwPUvPPG
	anvf069avSUZJZa1+8t3vo9pVdouCR/gSINVbxOzQ7FvWnJ0kzHtjHk9cRhv+wSsx/5q0G5Dx8D
	x6+S09uvXBPKynX1oKnixDCve7kKGK/jSiuGSrky5XqQY6wcJtvxVR8RgvDjBwTOknzpkcS5kOv
	sRwlETvaSDk5690PBiQmyUviTLmell73uCm5R7eIHY4u/TsX8zVCV38s6wcr8kr+p9SO8rdGS7E
	yi5jNc/nxQ/PgLGpx5sW
X-Google-Smtp-Source: AGHT+IHUOOB5pTTIy2MHsVvW23BzqMe3H8KuiJav8M/pdsu2J52R48xEMht0knZ76z0znc0x05NmqA==
X-Received: by 2002:a17:902:e887:b0:215:4450:54fb with SMTP id d9443c01a7336-2166a0b58dbmr74822495ad.55.1733850614753;
        Tue, 10 Dec 2024 09:10:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2167dafcb5asm8234895ad.211.2024.12.10.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:10:14 -0800 (PST)
Date: Tue, 10 Dec 2024 09:10:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
Message-ID: <Z1h18zpbbgT0QaoV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
 <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>

On Tue, Dec 10, 2024 at 02:54:26PM +0100, Alexander Lobakin wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> Date: Tue, 10 Dec 2024 12:44:04 +0100
> 
> > 
> > 
> > On 06.12.24 16:20, Alexandra Winter wrote:
> >>
> >>
> >> On 04.12.24 15:32, Alexander Lobakin wrote:
> >>>> @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txqsq *sq, struct sk_buff *skb,
> >>>>  {
> >>>>  	struct mlx5e_sq_stats *stats = sq->stats;
> >>>>  
> >>>> +	/* Don't require 2 IOMMU TLB entries, if one is sufficient */
> >>>> +	if (use_dma_iommu(sq->pdev) && skb->truesize <= PAGE_SIZE)
> >>    +		skb_linearize(skb);
> >>> 1. What's with the direct DMA? I believe it would benefit, too?
> >>
> >>
> >> Removing the use_dma_iommu check is fine with us (s390). It is just a proposal to reduce the impact.
> >> Any opinions from the NVidia people?
> >>
> > Agreed.
> > 
> >>
> >>> 2. Why truesize, not something like
> >>>
> >>> 	if (skb->len <= some_sane_value_maybe_1k)
> >>
> >>
> >> With (skb->truesize <= PAGE_SIZE) the whole "head" buffer fits into 1 page.
> >> When we set the threshhold at a smaller value, skb->len makes more sense
> >>
> >>
> >>>
> >>> 3. As Eric mentioned, PAGE_SIZE can be up to 256 Kb, I don't think
> >>>    it's a good idea to rely on this.
> >>>    Some test-based hardcode would be enough (i.e. threshold on which
> >>>    DMA mapping starts performing better).
> >>
> >>
> >> A threshhold of 4k is absolutely fine with us (s390). 
> >> A threshhold of 1k would definitvely improve our situation and bring back the performance for some important scenarios.
> >>
> >>
> >> NVidia people do you have any opinion on a good threshhold?
> >>
> > 1KB is still to large. As Tariq mentioned, the threshold should not
> > exceed 128/256B. I am currently testing this with 256B on x86. So far no
> > regressions but I need to play with it more.
> 
> On different setups, usually the copybreak of 192 or 256 bytes was the
> most efficient as well.

A minor suggestion:

Would it be at all possible for the people who've run these
experiments to document their findings somewhere: what the different
test setups were, what the copybreak settings were, what the
results were, and how they were measured?

Some drivers have a few details documented in
Documentation/networking/device_drivers/ethernet/, but if others
could do this too, like mlx5, in detail so findings could be
reproduced by others, that would be amazing.
