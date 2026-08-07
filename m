Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1C377541
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126821; cv=none; b=VqYtLNIzqwv3tBAGIMOi9tip4C2UC+3LXFKi8jbjEovsJDQmWujwaznqw6OzAULIfe6TrQiI42sDXgs0tTNvS+9OLW2HoVrFRJOqr4kn42NWIWbJE/xHmwH0odID1vIT0uC8jb5ty4LOB9RtC5YoshIkggBW3zr5VZuH6yOkJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126821; c=relaxed/simple;
	bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzKSZ2abahAHzZQPGuC1lLfKN5ExOW9edV7U4UMdaG9V0/Qc7qhufL2waWubfyfcK8LyHN/Zj+2rgXHIWMkyBvlA4C0KcnVEgCjAffXZ2kXou54RFaqs7xmYIaIFgTvctvnrE7BStPN/DNwP6zhgdgT3yERft9R9oeqEPaukDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gobB/266; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gobB/266"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e6c4a867cso250134885a.0
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786126819; x=1786731619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=gobB/266UURhr/KKQGN5iI83m6iRcbjU82uIunv36GYQBQprtygYtoAzBaYHTYozyQ
         gHwa1mmkek21PN3rw9rUejICAnV+X/eeqmzFOgoh5/1ANykxwiA8+fOUWxWg+jIsduKn
         +eMKc1RIo7t0v4YvkW0AI+MhLkaqWnw5SKNwvY549eZ7NjzB8jeT22dAKJlBAb3BI8po
         bsY4sra7r4Q4DNDaSi905L1ZaXBuLiYiu9pqKcPXVKj/J+xjBsLp/DLbtgQDq8RwiReP
         MC3BnVxaEZ+UbL7m37RNgwhLpYe3+T2r3cUbG55Y3wem+2MV3d0pl1DT8s05oub//tm4
         /T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126819; x=1786731619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQJoR9F+JTLHFeALKkUq+Q0MNEImv4dProP3GHVEWS0=;
        b=Pqnp8HKLlO1gWm20sxq3Dais8nv8mvjS3pq7Dbf7vLBjGs9e3U00YJZn/wYOq/VhbW
         UYgOkygeUNI3ZylwttMivgHkRclnC+UptzLxRpbHeWtAEMs0KVVTYj6j0aoQ7QidG37p
         0s1wL5KgsrOiEFyaw+78qtb8GWzXkhNiU20duDqABUIS1+7RcZmu38KfhHZeMf/WevoT
         B5bDkEmwI2aRfXQeUmGXusq9h9aBXoAe5HogrYL4hcl3qo0MnjD4zhaar4ZOJ5ZIDiPf
         KR4VxtgxSdrhKNtMk8Jr+xx2nFtYjUSy0ckk+o/j9IbiUHQxCD7IHeDrDAn7tIL69BB2
         He3w==
X-Forwarded-Encrypted: i=1; AHgh+Rp9oVI1AVUIJNqjTc2ZwGrD1zbne5Z+tZ8bD3e1ZqjE4h+C4VCcib4vb7opFVBWWcW1FdS0KmghzTwK@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLD/D7RRzqxVny5cMd630a57g+Tu8XdR9F2qLQdIbVpl64A9E
	eEGN5Dxu7zlttBqGY86m26iLclYTP13UrJobRwfmif6HVr5bxeUvT4QGJtzUVlNZlWo=
X-Gm-Gg: AR+sD12yT0jcl6T7mctp66ZIlyblnr1bg5/ZZumWVql7JqYf2aZCP2zjMG0MrEpEq0X
	0yucHlSOz7FNVQyard9If2sVTDcPkMG78cXD3q//0Fa71aQsSo+RpokaITh4P7eIphkLYw961O8
	bmLzwR5rjJDbkBc+B4u061/rmLwAN3NrZgBt66gYc2sqETsSKUcEUtDoLwLy6hb4NfD8sn/D/Vr
	ZpKS979qke66vg9OZxccYDzgC974r5F4TFmEvGWbl6YaC+Oaj0dsqeLCt4nP5KKofpVqm9woKsr
	RKjWow5YQE3zfXrSouzCYrmlQkQNmFOihf3De49I6atjhDjftMtlaaCXT6cdGi5Kp2AJLlxISXV
	ohUkZA9hNkrHWik8uDsGzY+L9cwYltqDV3qdrOW2loxvnxwbv8CbOV4R5N8/cSDFenbXOgJ+lPY
	x0ACJvHPFk6IPX6cSoNt1/ECqEaTMEyAKTrwxWNoboIwBGIDewx7ZKJuM+P/FK
X-Received: by 2002:a05:620a:628e:b0:930:a38d:4030 with SMTP id af79cd13be357-93671eae149mr628522585a.29.1786126818655;
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e02d54esm204051085a.6.2026.08.07.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:20:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsPB3-00000001Bmx-1xNi;
	Fri, 07 Aug 2026 15:20:17 -0300
Date: Fri, 7 Aug 2026 15:20:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807182017.GH200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anYgXSR4VAi3TpOj@google.com>

On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:

> But the whole thing is best effort anyway, the kernel picks
> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> how many devices or how much DMA they do.
> SWIOTLB memory is wasted if unused so we should be careful around
> that as it would be the other way around and users would have to
> decrease it manually.

Yeah, it is why the arch code shouldn't really be sizing it directly,
it should be done in common code and, yes, we are probably going to
have to do something alot smarter to have the common code better
auto-tune this for the CC case..

Jason
