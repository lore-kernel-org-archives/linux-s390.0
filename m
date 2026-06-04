Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA961304976;
	Thu,  4 Jun 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585073; cv=none; b=dLIXsapRUswz5TncDYffzaMLOAleLxQEPm/5+udEAtJmQCCBSenXkUX+dXJmScef3NG+3CRgEdiqEA0NZr0NlRfrOz7eXkRmMNXqHyywrLLykwMf4JVEeINd3yD5RZkFP01jxNHAPQjPkQgp5cYjmVS4f9Y7GG+/itPYMBigvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585073; c=relaxed/simple;
	bh=8cpjPIvztbnevrPtt4AvyqY6O2DjvwxefutWTr7MmSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=to4jr29QO2f8v7SGTDPesh3mbfinuxRlkunrN1yR9rDPlMniciaBJS+P8Tu33e8jllk9QkI2JLk/A45pWYPDu52mULSRLL3XPVY+meqSlNJu31nhYq0yNWl19BSDKqkDXk52YUPHIftI7vjCO85nVnsrLEz4yFhFYkKj4Oruhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPWVmrL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPWVmrL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FCF1F00898;
	Thu,  4 Jun 2026 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585071;
	bh=hYpE8ScA3WgBcN3vhg/AglZszMwb5uF85NWSIx0kbMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kPWVmrL8guiyc8M71azpVpri2D/uzclh6JoLyKNzyoo4OxN4agAWchTRxJjWIqJ2q
	 UtcCBus1mVx0a/I8DtboPOq/GBjzm61oZmXhDyCjcmifakXbxSMF72Q9Vr5TzFoFkh
	 Q8TOXNTKOqDXevhNGLhbxVb/6qqknzC5ebPnVeNlk37O5tQ+YjJ50srz4rcVPiOTCZ
	 zoUWZTgYQ9VSABiBHxcdG4TxBCB9zKt/fo3E0ZZLIZoVDRDTTcOdIoi6vJKJ2Dg7L3
	 j32qrNj5EkbQiih4TEEVu90fxL2Lx7UWE3w8deLFZ3bhMFmkT/hb4euyZAfcM9jKg8
	 bkPIf1Pnb7Z4A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Kelley <mhklinux@outlook.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
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
	"x86@kernel.org" <x86@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 04 Jun 2026 20:27:36 +0530
Message-ID: <yq5apl26qrof.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
>> 
>> On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
>> 
>> > Except that in a normal VM, the "unencrypted" pool attribute does *not*
>> > describe the state of the memory itself.  In a normal VM, the memory is
>> > unencrypted, but the "unencrypted" pool attribute is false. That
>> > contradiction is the essence of my concern.
>> 
>> I would argue no..
>> 
>> When CC is enabled the default state of memory in a Linux environment
>> is "encrypted". You have to take a special action to "decrypt" it.
>> 
>> Thus the default state of memory in a non-CC environment is also
>> paradoxically "encrypted" too. 
>
> The need to have such an unnatural premise is usually an indication
> of a conceptual problem with the overall model, or perhaps just a
> terminology problem. 
>
> Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> Name the pool attribute "cc_shared" instead of "unencrypted". Having
> "cc_shared" set to false in a normal VM doesn't lead to the non-sensical
> situation of claiming that a normal VM is encrypted. The boolean
> "unencrypted" parameter that has been added to various calls also
> becomes "cc_shared".  If "CC_SHARED" is a suitable name for the DMA
> attribute, it ought to be suitable as the pool attribute. And everything
> matches as well.
>

That is better. It would also simplify:

	if (mem->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
		return NULL;

to
	if (mem->cc_shared != !!(attrs & DMA_ATTR_CC_SHARED))
		return NULL;


I already sent a v6 in the hope of getting this merged for the next
merge window. Should I send a v7, or would you prefer that I do the
rename on top of v6?

-aneesh
