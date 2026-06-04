Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41237F8BA
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597463; cv=none; b=U38Dmpqiitnzu8g13ItsS0O5Advjjw3oxFhXWlOWWdyvuiopjoSUIaiixfA2U/rOINhUVm6i3Flp20KpygFVUECndfFq5a8vRDYMTRfdOmn+BmUAHN9zoFps5AcMz9tsfM3QSJuwMC/bHGE8HA6ZdmcJZX5KJHU1AOe21iMQwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597463; c=relaxed/simple;
	bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XACzrxii3QCWTQrqavGYXyu8CqbKrT8ktTA7srf4oU9NyuHUYc54D+f3t3i8UDlVGjBsyYUdi03LeKO1fFues/z2rwYYlgf9a/olpFA5CM7tmOzfjaS0ypukvHtLUT2gmtLa80hi5hkCXHgc2qslWOMRKunHYczgewhETBhlfFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BD5tD6Op; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BD5tD6Op"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517654b8dc5so9769131cf.3
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597461; x=1781202261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=BD5tD6OpPztx/62eQvNizgF9P2yNbFLuDMp3p2WZQny97abL+HDgFEexNUun7VMWNU
         6ZTDIR5shgF30m4oJC0/3/7Rr4fFVV3wMQz/rXsyjrY0kIVuwYGBlhG8Gqe4W3wYh35K
         D3/YhEfU90ebYTblCM9Ew0TcJ1NZGsefVg5YMpDB1e8udQvGQp6Y9KvuH0bDY8jLHMo6
         k1ENiUGe5ubuxXeCr8ZCuvAb2uIiQ4jGPY392RcA6ZvAKXP4zAKqW3rjHFhwa9ElO/ty
         TCLJH9zQmQh0YqHfJTI3SA1dgKwrUpf5obMMlRk7+5yXnYd/AAlwcfAyxmmAATI4WV35
         t2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597461; x=1781202261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZk6YMYYl+ylqDKIH+EcQ0Ik0ycwrFRfvhKkDvlO978=;
        b=TClgPEEndlf+wvaMiczwj1Q6qim1eLaYPUngRYdD46jLmgPsj0jmkp5dh0XTGwP68R
         tI1odnE2jYfuosAICqFpCa1RZeFGI+9dou1V4u2gc6ayw6NkyXQx5OJnEXcO2D8PBuXb
         euiNV9pJi0yB5NLFIn9T6KX5mDJAK3+sXZjcb6Kcl/FGVQgf9YH86+wOJBD6QJjdOWi3
         MWSG4au4f/1ibAN7lb+bDH22JbHsoYBXtf1QNbBSlgtVnXgJSMnzltK8ejNNqK4gfVq6
         Y++UgfheTSOGmxwToCXWJwACPww1IYUjNpdiUind3NVJp5OoWKrpz5FQRq5egkNZ2GCX
         B3dA==
X-Forwarded-Encrypted: i=1; AFNElJ/CjTg0KYu6+XLrgK46gSiRaEuOjyAaqqzChq7nnV5YTKr6FdelBucP/XdK9yz2TShIa3pCXE5aD2Uv@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa6/Vx4wz92Wow3RLYJHVeN6qRb6WAfxW7/zUnByS/kHMjeAz
	r8BNR4Xfm3jYm4CESnC0yXjNtlPp58Zy4hzHKyYj8zScMpaLTkSnDYWnv3pODLQ6Zq4=
X-Gm-Gg: Acq92OEwFF7niqxNVo1MmU2AmVctCJHzZXc7Bwo3xGuMQZs0Cyp7UQLH7K7cNC8l8AG
	Cw+VMJ4ZDzQodShcUYUakuXGniF7mRk6Ay4edb36Had6dUl2abssSOqdQ/dePeBvizwhPaDtdDG
	7rP8lZR51Jf5q9M4C8qEymQ0li3wXuRt4W2eW9/GMeEW/Hloso5UueB17srye8LiyjE65MCny8n
	BkwOoVxdCsyvHI+yP/gOBEfxYSN/+s1TsiZVOA/f/JIChjkFaAme66Jy1gLVnKfaF46zPDN9iv5
	WWY/xiU5p7inbxY1QLKpC+D8sPZjlZqycdxKE6Bx3gEsSLrKI3pno91/GK0Ycnp/zH38rwCeiog
	RAZpi4OM84V4PcIJsKXfts6EaOORFiCUAt1FwtIhWLmyrXlvI9SrRHPPQURZ+BQlsi4/C6i8D/X
	szZf+RTLUzvLpVeism/dczC43K/9UyZ+yL9ygBpP8h21evbgIip6B8IA8tKdU9s9y+iXQLF3gvt
	rBejvBERV4B0fe5
X-Received: by 2002:ac8:598a:0:b0:517:7277:9362 with SMTP id d75a77b69052e-51778751a59mr126094041cf.48.1780597460764;
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dd2e53sm57509021cf.24.2026.06.04.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:24:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCjr-00000008f4K-2dN0;
	Thu, 04 Jun 2026 15:24:19 -0300
Date: Thu, 4 Jun 2026 15:24:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
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
Message-ID: <20260604182419.GC2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5apl26qrof.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apl26qrof.fsf@kernel.org>

On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
> I already sent a v6 in the hope of getting this merged for the next
> merge window. Should I send a v7, or would you prefer that I do the
> rename on top of v6?

I think it is too late for such a major change, but this should be
imaginged to be for rc2ish next cycle. You also have to spell out how
the pkvm patch will get sequenced as well, it would be best to push
that it gets picked up right away.

Jason
