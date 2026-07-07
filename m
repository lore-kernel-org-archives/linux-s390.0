Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B243634B;
	Tue,  7 Jul 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443541; cv=none; b=Tc595U6fu8SRQQhRkYOV+sdyhosNd7MMjBD8FXCzvxPYaJ/DQtoARJeSpp/IL0Nb+NyEIorKuQou8ViGRRruiA/TXRBIE50tx97YLFsUCBJ9KZ+ce/ybUeh7UwPYhL2vlyj8j9YsJeLew8eUiBB9Ryk34cUiGDIuQzFtp16KEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443541; c=relaxed/simple;
	bh=oftr5G3z6oBFV+GyZMslvtqhdQup3zVW7NYWudILDro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrvPh6Xyimzlnu3x44/NDpfwcZzwwKUGbjhD4hiv/mPji4o4hLTPLLmnG4Vjw/9dTRUhOm5yAaANMgNLAwOu7eae/Vy04edqGbZlS1p4LYkN25w+OAFLpp7nAoWrULoNEmPH69YELygo8vuPZiCgOhYX3W3XTmK6qajpYhEA+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J6v2nAcR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J6v2nAcR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A719D1595;
	Tue,  7 Jul 2026 09:58:54 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC683F7B4;
	Tue,  7 Jul 2026 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783443539; bh=oftr5G3z6oBFV+GyZMslvtqhdQup3zVW7NYWudILDro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6v2nAcRCNpFw9tipYNPbCKnfR8iFde0+KzBbP0B3K2mz0ujgYDRy+VwFGktKRv2z
	 X8AGtqBWVpyqZUf4u6DfAHxBW5lfZj+N0eRs5hl4SptX1ZSmjrqSPoGb2LgAo/aLPr
	 cSJFc8xIxc30w+dQMcq1+PliaWcEFwqlAXdZ5TMU=
Date: Tue, 7 Jul 2026 17:58:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
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
Subject: Re: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests
 with CC_ATTR_GUEST_MEM_ENCRYPT
Message-ID: <ak0wTKrjTDZ3COS3@arm.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-9-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-9-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:12AM +0530, Aneesh Kumar K.V (Arm) wrote:
> arm64 Realms, powerpc secure guests and s390 protected virtualization
> guests currently report CC_ATTR_MEM_ENCRYPT, but not
> CC_ATTR_GUEST_MEM_ENCRYPT.
> 
> These environments are all secure guest configurations. Their
> force_dma_unencrypted() implementations also treat the same secure guest
> state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
> the same condition so generic confidential-computing code can distinguish
> guest memory encryption from host memory encryption instead of relying only
> on CC_ATTR_MEM_ENCRYPT.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
