Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E342836F
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202185; cv=none; b=qyTOPTkqzxFEyvmOSCGLlKOJlLtSNqr74bcf7vQo3Sx04i5+2CIJCeXBoX2Ghw7OxYOhM02sY16EfI4d10btI9OH/9Pw0PhRjIq+xh0XHGFpbo8KXqA0zbJwtvek8kUhAohVNL9urgqW73jUPkqqUs6oRvdoqsrezx7PDes5+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202185; c=relaxed/simple;
	bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5Z8JYOsv6DuWZdqui3TdFuxW1K8JPtO/PoKpDWFsLhgrxSgNQtEWTKn4tAjJ1T+6G+JdnUoJjViLJUqOavGpnQqB3Ftt42qjrpXJnYutCQRwdzOkcLGQrjrPfoQJJTAY7hUfj9bOZbTNUGZdsNwTM7QNgb4NB/+TXEb1mdBjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PO2O0bal; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PO2O0bal"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-902deb2412fso469264685a.3
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202183; x=1779806983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=PO2O0balOwKft4cvvTQKeyiaOJ8URBoNsepkbbNTzqg7940aeI7qQcnzXeZNgS4lhp
         4WvBHZKCQUPNcC8sOwj461D7Lw6ExuIB5cNL6zuEYkQ5b0gErkJ3F3jhwF+hkl7KuaWG
         Ry9dCcKherg086ox5RTpcQmFjDowYSXH77GIySzeFV4keGBakc/KR5m+pacPYrHlvrEz
         fngvw2zNMOwucs4BSrcCabzhhKU9holA5FDBtxFJkicRrz9wFnu3VqVmO9cfUlkh8ZSJ
         Ier+LOhqGUfEQ+NVdrVOHo4BGFF+o2+VLUJe3/t3+RwQJP0LhGOuR3O45AhJJ+waSC5t
         GNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202183; x=1779806983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf/OGUGuIRiuTTXYie0rUXZGqyUUzS6jn0J2l0v1FPs=;
        b=F3IL2AsSO9MqOENFNksNUib3JZu5ZXeG8Qud6zrEFuiH9mMQ5FpV6VRdBoXFOivwp8
         WqkecmopuMqT6WWoIzI1fw/IRWAYlbNuqA2APvYeC5cYqo50YOf7czIp3ZTlbIYlagjL
         HeGeiTHLcbsQtPk3z2bKolyzV4hlu0Ly1ZyO5Dy4FtegbuzNbZEqxXHNwdwEAuBk1S9p
         +K/AEr2CIYEeT8C5094QuHI79g8qIQ4vqP7ItIupf7+ZXjQhZ3gDXoAnW2STlg+7KwND
         R7p2fVO1N7Ji59BO7vA5jMHRJuJWNoPyodLF5esbkfovquzVvf3iXvcBHqZQt6DdzORZ
         4jXg==
X-Forwarded-Encrypted: i=1; AFNElJ/sJcpCP38de34p5uvsXgh0E4lqd7Va+meiWgMn1jcwsGnUYfM2IZKOo4QhMcnrHsiX91sZt9FRPZfT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g27PA46JsjcvNvKP/lCZP3QK3KA7Q1A+x5vQRqj7rKDQ1Fn1
	09VzPnGwAB3MjSgtsoc+nZkXb1jHCSoz6W7kk5k/Bk5VrgLFoGQ30XOIzh0G1fRi2H0=
X-Gm-Gg: Acq92OGOXNUYp2uZpgEVc/NNgmn1NFrBD44KnaK5Cly90CtGPaod7tWF0SX17BO7Rwk
	QBqjhWH9uoVK8p0M4ahPLDEUCu1429lFYgl/o5M5hMXpyNiA9aVmPWRvnexZ/ZXq7PARTVS2uQJ
	b9fEAzhfgz53gXDbCWg4y5cHA7hBgUg2AJjsOAWQWU5+baEHLAc2xN/7QKBDTs+heaYU22dM1qO
	nr8CVGDIOGXmN9caH/evWhEFBkeNZbTTrc5YBwZ1llupX8IMyBgTTF2a3LwPz341w1POfZWwxvR
	+u9n/NtwJUQekxUMM9ULYwrWoXh7pAsOW0CUY6Cy44EDwAhf1SJx92BySNbc8xfucg46zGP9qVl
	+9K6DkOerqX+qYzHjSl5dvlnVBTpMy6qxUoZZ2F3DRpcyIx7nNZHf3PJ0Ut6RvhjWDVZyYOrFs0
	Uhq1S8MFPrNXR+dBfP2O0bfZXLVDMvwr9OqoJA5XABbUuvF8jz6gne5mxGamSneMm2d6Pw2NYy5
	gwWbw==
X-Received: by 2002:a05:620a:1a14:b0:911:411e:2e4b with SMTP id af79cd13be357-911cd46df94mr3109274985a.23.1779202183344;
        Tue, 19 May 2026 07:49:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e68csm1851459085a.10.2026.05.19.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:49:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLlO-0000000F92G-1VL1;
	Tue, 19 May 2026 11:49:42 -0300
Date: Tue, 19 May 2026 11:49:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519144942.GJ7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <20260519143529.GD7702@ziepe.ca>
 <agx3j6Oc8QivZ3RG@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx3j6Oc8QivZ3RG@google.com>

On Tue, May 19, 2026 at 02:45:35PM +0000, Mostafa Saleh wrote:
> However, it should not alway use SWIOTLB? It can trigger decryption for
> any memory returned from __dma_direct_alloc_pages() which can come
> from alloc_pages_node().

The alloc coherent flow is seperate and different, these are not pages
'passed into the DMA API' but pages fully allocated internally and
owned by it.

Yes, it should cause decrypted *allocation*.

Jason
