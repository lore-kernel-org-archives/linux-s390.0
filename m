Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E525F988
	for <linux-s390@vger.kernel.org>; Wed,  3 Jun 2026 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448098; cv=none; b=fFNPIzVFuBNxdRlmU1xM9ASZq3VbzwzWTmLOFE5gmVSRF4Ozj/yai2fan7O+S09xc7kVNlSY9J9hBtq4eK0inlCSlLbHZkx6nMHXOU9KHQm6AiDo39K8LPxafiHnaiTHgqIRG7b7xlVapemYQPDjdXAzs+2ZbmqinQnl6Pe5Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448098; c=relaxed/simple;
	bh=W/c+ST5uf3ZVEZ/AWys6/pG+OcAIML9okmITgYiOjr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDa3Fa2Rkpz5qVnlaGVX686Gnq1qvbP3paZTUh6crBIF0uErSv01lihDvkX+jjR2JNia/qdH1h6CDv0/vQrSvaRVkmnT4qghC02+uVcrso3elUFjzIhfR8uVQtsmq7bqdH13pVCcoL/VXdsA+RUZ9wtEBsRvH1VAlB0wwxqrEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S1odct5j; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S1odct5j"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9156b74006aso186924985a.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448097; x=1781052897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=S1odct5j2nfkl79Sv2FPAJ9SSk7u2EVjBUEYBP5n2vNzzZWrOMCYXYSS9KT6+9TTsW
         4IAr6o784B59XB5ULJHK6589ZMKiurJZ/gxuFDuU4UaCbyE0vQZmkbBrkcHogHkGEN6y
         kezoiRAFsHYCUNcvDdZapDx+j78Dtd38bG5TMtDPyXxLJU5wO5zHFEpjQLPIrdBCJXau
         w8dkCUeffXbX80+OGLOryRzx8KtEg4Gae8smiuXPWtWy+UX3QXeSfa8s/puhYsu7Fz4L
         uZfL1RmglYTGQKuc3Ihyiw2xNm0CDOkt4V0Hx6FRHSbCTpaq7QSd7WR+iMEtvGjtRHIK
         1DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448097; x=1781052897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=oMMCFaCtGz2AU4y7BXWjlgi0gSJXMXSDEw7jguav8F91V7A5ui0nnGE0TW+NGLOZmX
         eWAJaIldNmjnSyLxA8fE0K6L9l0W11GXc1y5R4dKP0a9e0PnFe7i56qbul7HdL72VCfo
         ycrzYA2KnVYuhOee+bQo1vlaQP6nzRo9YRN5ig6W11FPg9zTSDStPesLiTXSjd/Yhywo
         6OvpY5UNAkyxl6GyXCgTLB1+eScULXvkXeph008dfGjWEL+gP9WolF90RUgkqEwagwDP
         fUmKHkK8fJArwKQfyDkiXfQc8IZhmKRfi0o4wa4V/R2bsFclvFuX7cX0tG/NieZlcmDG
         tAzg==
X-Forwarded-Encrypted: i=1; AFNElJ8ddjpFQ7TYl85XParjAu9XAQTXiH9HUFV7l6rEqxVgDSaPbkspBtW7aYeblU9Tj6GJhfB4DxMOWdbp@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIXrsOco+PvmY0StKIERnZY4CxREsRQG5WD/jXetd59BZWPcY
	SJEUPNsjwtf6qUDzX1q6ktOpk4tVuBF3xm7YF2R/8+W0vQhW74+ii5chsjiC5RknAug=
X-Gm-Gg: Acq92OEo6mdumt6P2cF8fT/DyE9SDjStOYFoJX+wqxzHT64OfuL/m8KVX1CA+MOU4wT
	+HmPtxoL+opf+0A/jSZ6fWBxr6z7cfaZD0439BkXx4k9VP+awMG6ORli/0YoHurvFHNBrPHoKOH
	+g/Y9tla/5+yaTC4w82sqkaZJNwtA4w5d1Hg7MUgvp3r8u9jdPLXJSEPpxwGEeL8zILUstxpwF2
	9nG3ZOTJNFuLefoUfkqXSxhahuL/PDeNxb/sqOUzgmNOWxxVgHw/YKxT1sP7glgqz1TI+Qu78Iz
	6h40YmxwXq/ompJeJY+sSHImxWgve/e48vTbuUnFwTkwBOjPIguVNpWBTIvhabIaMXzBvX9vYKq
	BfsFgiumWYdxssCRUvfB/RQWUPRGrCZIPcTGjQtxa7FS1OA5t5PayCHOMeHoiTcigFgEbzoGUEz
	lo8QLTuUwDOO+VH+Ul83Zx6bNLu0QzLLkUogaAbKR/y+yiaxFrkHPPiT6OOC319MFMLvwAGFe7M
	vv93V+DWJ+/WK34
X-Received: by 2002:a05:620a:4409:b0:8d1:a75e:2f8c with SMTP id af79cd13be357-9158a86b6acmr242337785a.53.1780448096650;
        Tue, 02 Jun 2026 17:54:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm100630585a.16.2026.06.02.17.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:54:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZsk-00000004x1y-3mPP;
	Tue, 02 Jun 2026 21:54:54 -0300
Date: Tue, 2 Jun 2026 21:54:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260603005454.GM2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:

> Except that in a normal VM, the "unencrypted" pool attribute does *not*
> describe the state of the memory itself.  In a normal VM, the memory is
> unencrypted, but the "unencrypted" pool attribute is false. That
> contradiction is the essence of my concern.

I would argue no..

When CC is enabled the default state of memory in a Linux environment
is "encrypted". You have to take a special action to "decrypt" it.
 
Thus the default state of memory in a non-CC environment is also
paradoxically "encrypted" too. "decryption" is impossible.

Therefore the "unencrypted" state is a special state that only memory
inside a CC VM can have. A normal VM can never have "unencrypted"
memory at all, so having it be false in the pool is accurate as far as
the APIs go.

un-encrypted = true means "the memory in this pool was transformed with
set_memory_decrypted()" - which is impossible on a normal VM.

Jason
