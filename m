Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162A374162
	for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623593; cv=none; b=R6eyjCcyG1smIDz0UERIsyD+l2/R4oJ86T0ksSbrSOb4HMygkpOqmnRzPz5+/q1X8BMV/KdHtYHfZmFreMRFTaBa3Lh+kfb4EbNS7f0QcjpTdwvm9KgrsXo9l4niQITDlvuM9LPRJ+MqdtgHiFq7hj3AHvFUA+ZPp6q1V5sI3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623593; c=relaxed/simple;
	bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNqfiofPQO4wDCJNbHj0/2uF7BKgey1+w6Z8CIUvRjsxTXJm9NwnzUQ+Y4VfRYVwzg3jsfinagNdxUGvLDmKpU7qPYU5JdAi4xElUgZq9qZZTMAi0P93Ha6AfMk1DB4UmEuPQ8bl99zQoE9/xYou3KXkPP9JJVHJZcrArYAam9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H8mWeFsS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H8mWeFsS"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a50c17fdso15810685a.2
        for <linux-s390@vger.kernel.org>; Wed, 28 Jan 2026 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769623591; x=1770228391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=H8mWeFsSdwADWoWWfEA0w+bwR8tO5PHsGO8YFyoPYpDKG0sMyli8Ex3dHcuo63SAE5
         r4Gn6lEHuyjoUITTiyG053SeObk1eqjhP5AGP/tx3s1n/WvyZEqqNNkdn1NUNZYB7Mj8
         1majS3rb6gLXjS9Kl/S4X/nshAyAfPVXIRkGKYhVU/ks0d1NMjTPrD3WCLJmYjQ7egD6
         x97U1qiMggsHkQCrXUdyxC1z1FymH3HVJjnhE46eO9UXV+l7ZKoGhkW9xrMgkFTt2Q52
         NAvCR/D387hBy/DvGoiX1EYiWKTjqS4Pw8T3QNUVmojUjIalMdRtayzMk2OEBNPw2Lzo
         IcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623591; x=1770228391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaIZPczUt0JTVA89TpBrq/++CRfdlHNIhDlOkzrTVzQ=;
        b=lm8NqLQNAhijBOWtnMJwN+68R3xxFBMDoUXw8mHrDvvP4SFptTV5NKS/meMeHCt6fp
         c9Ko5Xnu7+I/fvsxAHu1IpwA+20EXvFzf+xWVsnM04x+CO6X3iiJvnYySLpygBUVGKkJ
         opxpPTNnG2tgmNYeEOZoXDJg2ByB3Q2SNUH8BgXsYehpvyBBWDtk1ZYA843u/wJq0FwL
         DOn5JMSqv2GRv5notH5cCjQU3IhAgmEtOxEIhVOSjEeVcjULwoxmAZDUOSZ+Fi95UVqw
         Tl1ficCbsnT6NuzWGazKlbiJvtR47OCSntfwQJO2UeHU4YKd5udQy2CPtrghHJCAj/yL
         SK+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8V6uTQj8DIh3iJi5191i3ka/TUy4fyNTPTdtq7vhCQ/1DXGZEcqypV4ly4ocBSSKhe+nSO1TfZZ93@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMgf9o21MDHds2k9dLicbFiXqL4gbJT6xGrhY0B9rM/5LOy/S
	Y/xyEpPgid1QktgA/Wr7jsGfzUD81ugi0kIye6JWAgO0f1YAqnN2rUgfrMlfd0lCqeg=
X-Gm-Gg: AZuq6aKhl4a+kLRA1j0xe6u9tBduZRTIZ4Fx4P1LiJkA4AriyegY+nV89hu1hVreZ0s
	aX4G1u1u2yrjh0QaWEnVjKfEY+nDGME6Pp15TU7iPxksI2Wu8dPMNRZ1n8Y1QPHgnOqcfzOwlNB
	vsC4lkVn5ld08OrZESGbS5y6pls8ZpobCcWC4cQKgDjV0I3SYMmZC9fIOxhkVASfQ4dPQiqsglO
	PoeyvvsyCLb2dH1JD7F2ajaS18CaEmavNugSbABjkm+CBXCBn00BnMfFoHwMrOPiIW1f0KX+T2s
	oOeQfkUEGqf86MUUvuhSIP7S0stna1MRQG9gW8AGqt7xqVZ5gBxXozzk/r5QloREF/BWZA2bYcm
	On5TQdBbmZ7UjU4vtt88MgnF9zmruM1JpNfJFCe9/afmhNMOEARTu0rixfvQwfoGa87w52s+mfi
	AVUpYcse368BQBi9y8QlUvLbne6WQOjLSa1nHHav5tc9ziur0uQ5Oxxf5vqQPYC3xo5qM=
X-Received: by 2002:ae9:f404:0:b0:8c7:136e:bad7 with SMTP id af79cd13be357-8c7136ebb3cmr341643785a.85.1769623591045;
        Wed, 28 Jan 2026 10:06:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm21598586d6.45.2026.01.28.10.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:06:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl9vx-00000009aHB-3e3a;
	Wed, 28 Jan 2026 14:06:29 -0400
Date: Wed, 28 Jan 2026 14:06:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260128180629.GT1641016@ziepe.ca>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034558.GA126415@j66a10360.sqa.eu95>

On Wed, Jan 28, 2026 at 11:45:58AM +0800, D. Wythe wrote:

> By leveraging vmalloc_huge() and the proposed helper to increase the
> page_size in ib_map_mr_sg(), each MTTE covers a much larger contiguous
> physical block.

This doesn't seem right, if your goal is to take a vmalloc() pointer
and convert it to a MR via a scatterlist and ib_map_mr_sg() then you
should be asking for a helper to convert a kernel pointer into a
scatterlist.

Even if you do this in a naive way and call the
sg_alloc_append_table_from_pages() function it will automatically join
physically contiguous ranges together for you.

From there you can check the resulting scatterlist and compute the
page_size to pass to ib_map_mr_sg().

No need to ask the MM for anything other than the list of physicals to
build the scatterlist with.

Still, I wouldn't mind seeing a helper to convert a kernel pointer
into a scatterlist because I have see that opencoded in a few places,
and maybe there are ways to optimize that using more information from
the MM - but it should be APIs used only by this helper not exposed to
drivers.

Jason
