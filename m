Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5547A86E
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556582; cv=none; b=obXQWggkcSkqENI7oMfSJocrobvlrXwdlR8UoqUcfSwb1S3tB7sV4lgRK7ICDrta9LLBCqgGMvtuEhdf32DeiWEaO8VU/TmoqddIGZ5FfpTi8MQZGKF1tEh7xxdxFGTKjcpNAG6ODWIbM/xt6bRG9V9Delc6C/dSeT9TmG5YZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556582; c=relaxed/simple;
	bh=R8K4AhpTTGabp/TpyA1fPLTe5/En+9HZcWa+J+NqaoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeSi58c8MQW4WCrOHsSMKM987cJ+1Wwb3qQ+hpkB8VoRpaUTV7Oi6+YnMmDH/38iyamGPW2eILR9Ep9Kq1nuolA7dkkzUB5ij363xKvy131WrZ11fa86pF2qFyjS/7is/w3e7zd/C6eZhM6E0BkgIeFPQn6SDLYSybG02iDKOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HAet0nyA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HAet0nyA"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c08df8513so9160371cf.3
        for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786556580; x=1787161380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=HAet0nyAadkR4pZmyOXbUhSqRehEHiZNaUea0AO5U3L+3IQpKTxHfvLg5DSbspSFPi
         3AOnv5PnaVcuUoPVMoIJrq77QCKBSZwzgKYygbr6tf6c6K1pevOmLKTWgu7AjxiabXwo
         rREelaDYSyR+yj3kQZtgwSzvU7rs5nevHAmbhehoRZGPaD7ntshCpr00YIHLwwz1bdg+
         JRfFm/3v4NSrtvobYO3r7XfPz5c5j7QmqN2eUUix+YW1Bj/xXpyQr0gHkgZIuneIv12c
         3wfOuK12Oc4p6QbQc40TjdiPFUfadlRwxgFbr/m5wEws0lyOTUgEpEIvR4+ntgDxnA3A
         QpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556580; x=1787161380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRy7TSLv7XgtK7yVOoP/4PPtFt0r1aZ67kTGnhbzw7Y=;
        b=WcIgewkv6keQxsZOZr3t3pzXiSY/AXNhiHIXLaZY0Bzw5zFn+k9fT0bIEIMatEksT7
         mi12wjvDqHju7y6IwnOfIPA9njj0/+M6Qywv2j3P//EzknnbsyEoiuQ6NXasN9H3v41w
         uCKpH9o8dn/n7tCKfOXcmnJPJ6TaOHXjqBjOoAVK0QntM60GKbu0qXsKeYHyKJw6k3Ff
         +86jzKrbiWS4wSgljYyneSmmMZ88se4SvHmnkpveVJOmPigIyvF23tOwBWMjxyzvmeWX
         aXvMk+fV8rNlmQaiGqjQC4cQ6sSoMKZ/NgGFJVOdJ2iRKq1ORhM/U8A+nhwORFOq7D7c
         ieDg==
X-Forwarded-Encrypted: i=1; AHgh+RpH5JJNzdzUT2I5npqE3L+05UTNwP85IT2OS1cIlPyfGQOlrzxr7rzPujgyB2tmdxXWdYPCh/stA1T7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BbcozZ2F2bMxo8+5YQAvKc1i2d38CRO8j9RLw8Pr5omhm3/u
	csnpEeCSuUEeJ3YQ+a1TpaXygeoAbkAzFOXHusgxLsHUL7s3NY1WTJdAeeH7bb/dXZs=
X-Gm-Gg: AR+sD10ogqTE58aA3ixPzpq7KRmC88CsdWykMJSKllpCegpKTvpLzFAsGzYDsoHUUQZ
	anf5ty59xZjjwXS5rRl7QlEVncb1FGT1H4LyHBnMlykvwn9zhnt4tKAwPezCUSPd8ZiOZLbyqdm
	vqF3wE4j8Z7UBY5T3/cCeSECjl3Q/5iR0DtxWjUB4BKkjYuNHvbyBrDEZeTmByI+9G3adB2lK5w
	7W2xvQVoLbQscfkvZ5C+N6ZKO9GPkZUNJpP4E4Ry3iDdkkNOaexeomsfKeKXivLfUahmL8nCQl6
	letJaYpKfIv4zDewe80FC16DVZA31IAHVYeE4Cx3wjAJH9YT9NGlC8FaWB5XoLrq0cR7NmERAqi
	9ld4MYw0PPDLUxNpMBJOFmpoSDUNleLOAUcH5z4s0gNLagFwcAD2QRAulS4rNk6IfHWdJFU8l1n
	QEfMmr1uNYJw8VH0uZYywLu7VLcetLwFGJhgzUXQ==
X-Received: by 2002:a05:622a:145:b0:528:38b1:b54c with SMTP id d75a77b69052e-52d646a004amr57067221cf.2.1786556579927;
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61d91199sm22262711cf.14.2026.08.12.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:42:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuCyg-00000003IL0-2V6p;
	Wed, 12 Aug 2026 14:42:58 -0300
Date: Wed, 12 Aug 2026 14:42:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <20260812174258.GF662699@ziepe.ca>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anysnQFVTO_RAYxp@arm.com>

On Wed, Aug 12, 2026 at 06:25:49PM +0100, Catalin Marinas wrote:
> > > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> > > option in realms?
> 
> It's still not clear to me why we went for CC_ATTR_MEM_ENCRYPT instead
> of CC_ATTR_GUEST_MEM_ENCRYPT.

Yeah, this tune should be only for CC guests that have the
shared/private issue.

The AMD SME issue with the address width on bare metal is an entirely
different problem that would need a different kind of tuning.

Jason
