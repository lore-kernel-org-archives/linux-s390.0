Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7243712D;
	Fri,  9 Oct 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541100; cv=none; b=in7cU4F0s9aw/k3/XWYTWtWpqNMSGzyGEDom/fLcKUNuu3dQnpfCxYgodHXWVu+dFRXFRlQ+oQI9E/57zPFnGq+u7cwY2QuOzriO7MHVog+LpmYaR1ZZxDLo8kcvxd6UR6dgwjJR7HzO5+tdu5YrRPiWezB9L6ix/Ze5a/dGw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541100; c=relaxed/simple;
	bh=Abb6ExL+zdNLeWtkL/SrnN/NL/IFI90mg1+qHNwetUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw6x6sP2tndr7frUWpaHDD39oSplC+uoPZ6CYkqDMUB4iX0dfBt8XHZdJMmLleVmKv9CzxOpys7HtepgvoAUDQtuZMLep2RtvmfOa+lnGtWSoMR3QfaNNgWuVdW2t1UG7IeZtybITOLkmsBLNBOFSGh/9jHES6VJT5wKPKcUWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Ulp1ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Ulp1ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FA51F000FF;
	Fri,  9 Oct 2026 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541098;
	bh=wxARsjGuquaiLxgSm18RK/GYX/5yHnqt2BOAs4KeGsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/Ulp1kiU/fHLorufnUGZviVewHpZ4i2nh7ovjmbgtSVM9rKK3zfjolFAXlJiCoG/
	 BMW5Ubh23ZkHDtz2gC3M7BH0DoQb7aWS09Fvb5ai3Tah7LXu0pj6waoAyV4+Ys7d5Z
	 +iywIF9ht9ECEh7ry8yPogWZ87BGl4TKzbkbZrEJI5fQcCBS3ROhYfkTdcqveZDJbP
	 aeEe9F9SdlEQjf4RfVxNp6TljhzSQkjK1V50hbw9FBfJgs2u42Zj9iTGwDxFCYK4CY
	 7TdAyz5T7sPBsEmViOMRCDgegOg9M7rT99tg9OQAo14hJB5idOZRFpneZ6VooRc89y
	 jEHJjjoVpql9w==
Date: Fri, 9 Oct 2026 11:18:05 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asi_XW2FaVjjWhxk@willie-the-truck>
References: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <CGME20261008143238eucas1p1ee087352709f2a82d2aec95540ae2031@eucas1p1.samsung.com>
 <yq5ao6d48dqr.fsf@kernel.org>
 <c2e38455-cb31-4854-ab84-4a370fabc1f9@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2e38455-cb31-4854-ab84-4a370fabc1f9@samsung.com>

On Thu, Oct 08, 2026 at 05:32:44PM +0200, Marek Szyprowski wrote:
> On 08.10.2026 16:32, Aneesh Kumar K.V wrote:
> > Patch 3 is a fix, so you may want to take it even if we drop the rest of
> > the series. Perhaps the first three patches could be taken together?
> 
> Okay, I will take only the first 3 patches to dma-mapping-for-next branch now
> and wait for the remaining patches until they gets sorted out.

Thanks, Marek.

Will
