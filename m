Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478458;
	b=nIRuzlpw4BrRY1S6c29Eis3S85DGz5rizDImSL9zIOd6XC5J0UVAXi+gGt5FMgBIzohJ
	 sv7MDentg+1DK3ObCLZjuB4tIQbmwxZt6hRlSZ9SFoSz6FfXuI08U0XxW+5tcF0DF9ien
	 t0XJ6cU+oq2brjLF0q/L59pTvx5QdN0tXwp91DCnUhRbHSD/br0sJ41pfrba4/2jWl2D0
	 fh/fuSqB42+e+YdBKJuhuAwafWiHgo17OIj0P9OAY4Qsi5G6hpmE22MiXJy5Zc2+nJ1Pl
	 hVYGzGvnDHNNQc0fJ1MzBph4BuxoWi/Joxw4SnzuWpxuZQJt2K07p8bozNxV7Hoeysg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478458;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=Y6qGWFGnpPL1ZkxmjT2jfKkaXhHx34ppHOpZ4kDJJ7I=;
	b=IKgTXIVCSeBxqpi3sM+YwnN4XPuYdR/DLugkpU9gooytPHk9Lx9T739pH6dCin8vnAtw
	 2zNq9+iLXnq8yTWqMqLYq7kojUEhAPmDkE2Txbh5PmoIJyJOB4JMW5csPWD2/FwWYwt47
	 oLxzT7mx9oKWRNXtrFnle7+eHYrHH5X8oVBmiss7kOS7Ka5b/CeNq/ZfmqDzVbDIvLMVG
	 ruwKZC+zHnXuqWm/oG1HlQSARd+dck96sK/uMqJ/HaoQBgS7IFRdaAYPzRjUQ9vPgUimE
	 IyPSlore5k5FbjquXoN3VC5SLJp5UhTyKqxsc74PkOB6XYn3lnfH4R2BcA4fTwFbwsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBTA1Nam;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE4606A323;
	Thu, 12 Nov 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBTA1Nam
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF6C1F00A05;
	Thu, 12 Nov 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478458;
	bh=Y6qGWFGnpPL1ZkxmjT2jfKkaXhHx34ppHOpZ4kDJJ7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MBTA1NamdzwTkZFr1duA2LSuyBzBxb6sNOwn0iO8KEGEo5pBXxgtCA30N+7GE/2Pw
	 GLLvMwMZMI+da7JzcTnuS0bMCdJanR2u9J/lPT9ckfrvKZNg8LhcDu8V7C+TbIeSjw
	 8yAMG4KCQ37LswDNHi5a/WIuQLaVB3XmEBALQQYzAaV+Q8iEdtJJ3Dxcj6qOxTLYnK
	 jVkJEIC1HFd3EBLbKlThHyGFKsjs0LGuM/niOEOMAHspsHAU9Gpim1bszdlXVU+ehU
	 fummkjIScD+yhHq9nloKuZ6lIpGJGM30bseMr702s+Ru+2cT98q/Bl763g0e0qb8DX
	 66KW6Lsjq8WcA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
References: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org> <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
 <yq5a8q3d9oe6.fsf@kernel.org> <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
Date: Thu, 12 Nov 2026 15:43:59 +0530
Message-ID: <yq5a33t6qrvc.fsf@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Kohei Enju <enju.kohei@fujitsu.com> writes:

> Hi Aneesh,
>
> On 11/01 09:47, Aneesh Kumar K.V wrote:
> [...]
>> >
>> > Hi Aneesh,
>> >

 [ ... 35 lines skipped ... ] 

> Overall, I would prefer the dynamic sizing approach. However, I believe
> the initial pool size still matters.
>
> Also, as Catalin pointed out earlier in the following message:
>
>     https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/
>
> the arm64 adjustment also reduces the target size used for dynamic
> pool allocation, since both the initial pool and dynamic allocation
> currently use default_nslabs.
>
> I am testing the patch below to decouple the initial pool size from the
> dynamic allocation target. It adds swiotlb_adjust_initial_size() for
> callers that only want to reduce the initial allocation, while keeping
> the existing swiotlb_adjust_size() semantics for callers that want to
> adjust both sizes.
>

Should we instead update the logic so that reducing the swiotlb size
leaves the dynamic allocation size unchanged, while increasing it also
bumps the dynamic allocation size?

-aneesh
