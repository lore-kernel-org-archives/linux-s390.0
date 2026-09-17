Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6164E4C35;
	Thu, 17 Sep 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661164; cv=none; b=qGpN5z0A6QfkYKkti/tpUNJ+GjvXYX3EdmiECfVMQ91y8X089a7ntlagjCHzg8ucxKJquLqeXmltRhRrUqNOgCiUlGK6ocCvIGpfgs6Hzk4a5VN1ytL/VZ0IjeB7SZHcFYQ26nmhNoTk14E08Zmn3/QFYJsFaJ6sxDsn+Jd2KrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661164; c=relaxed/simple;
	bh=9mcxnDc8qxIpxmpk6T3Tp+BnQwg+ATLN/zS0rC02bj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9FByVXMzEcCDDBbQ7RCCNMpyvVj9s9fZXRbUufRcrN695BZJDf2DLj9oMBu2Px2+GcnqrIUtk6rVGJmEteVKtn+9OkY3BYpt5RoDRr62y7SADwhAP/lKebE2/7p8Vm5xdpTri0xcd9iCMPfHDw40EL1IY1LR/2kNgrSHVqnxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iSTmFOj/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iSTmFOj/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 723D01476;
	Thu, 17 Sep 2026 09:05:57 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0930A3F86F;
	Thu, 17 Sep 2026 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789661161; bh=9mcxnDc8qxIpxmpk6T3Tp+BnQwg+ATLN/zS0rC02bj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSTmFOj/SjkZUclQCqE4zTW0vk94VTD2VbErQFckNg1Hf9DqR+Wb+AcjT1kbXrZTY
	 9NCVL8hRLjredBc9QRerBZnnZDifRLrHjsitRjiaswGzll4lpHF3AB6KbXTdEHKJsU
	 MLwoOZ4/t3+aNJhsyRfmX7PHIpukuOpzzytXFkiM=
Date: Thu, 17 Sep 2026 17:05:53 +0100
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
Subject: Re: [PATCH v4 4/5] dma: swiotlb: Add an overridable architecture
 pool opt-out
Message-ID: <aqwP4ZKugUpFezV7@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914070135.313337-5-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:33PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index be3962a33fc6..ef7a776ee508 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -20,6 +20,8 @@ struct scatterlist;
>  #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
>  /* Initialize a default-sized pool that requires architecture remapping. */
>  #define SWIOTLB_INIT_REMAP		(1 << 3)
> +/* Do not initialize a pool unless SWIOTLB is explicitly required. */
> +#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 4)

Nit: maybe better as SWIOTLB_INIT_DEFAULT_OFF. "Force" sounds too
drastic and it can be overridden on the command line to re-enable.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
