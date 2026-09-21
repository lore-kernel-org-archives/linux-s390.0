Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C87484235;
	Mon, 21 Sep 2026 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995021; cv=none; b=W7MVf62YX7OPZfI5DbJTP2JwP3z36bzUaoumvQd2dnPwt3kMyB7A//Q+VrSq2ZeZrjEDZbKbyNqG6VGsY37ycbW1cTTc7FURYEBaq2QVa8XFOuA4GfTbWbH8pkqX0GIOLa5uyITPCazMn3jsqkiYXUcdiz2kryzl1UC5tcGdIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995021; c=relaxed/simple;
	bh=TQv7l9aU1HPhSsH6yPVKN6maCdi89qI1I+QaGJPz64U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk1nZX9r8witgBCMT9fRAjLkVJUaeIEEYMGCa+iWdXJHUFjdt3HtvZErVI5mGQJYFyFYDgobnk2cIn1/lXk4fBni5Yj8klQhJySB+1O1R/AoR/O+4laoiw1BAHDAAkBIWGR3lPCfMAi97AJS9rIqQeCnpfHV6L2CFtVcDgXs7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A1SoKiy+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A1SoKiy+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4588F176C;
	Mon, 21 Sep 2026 05:50:15 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2AE03F86C;
	Mon, 21 Sep 2026 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789995018; bh=TQv7l9aU1HPhSsH6yPVKN6maCdi89qI1I+QaGJPz64U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1SoKiy+LIZ9OZR6QAKSKC1Ux368ZuAKB18oX6607x3al7a+KRnZc9iDJhGX3ZePO
	 aT176Jp0/eANP5NLj9yCAhkVS10FWvTpr9OikBj7j5132HFZWEeyUqhAkayVoeKSwu
	 OMGqtJEAqxDVi+EZSvFdcDPrspc5Js6YggW/hMp0=
Date: Mon, 21 Sep 2026 13:50:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
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
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
Message-ID: <arEoAq9mhsx2mt1P@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921063628.362078-3-aneesh.kumar@kernel.org>

On Mon, Sep 21, 2026 at 12:06:24PM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb= command-line parameter.
> 
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
> 
> Record whether swiotlb= supplied a numeric size and add
> swiotlb_default_size_changed() to query that state.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
