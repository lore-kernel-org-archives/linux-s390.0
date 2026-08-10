Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A083AB496;
	Mon, 10 Aug 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354195; cv=none; b=pNja+PzHDVktWJlMIMxb0+fWXQ+41bE54nBzmaHGxGhTdPTXAWw4VVnK6ezup4q+fZGtSLozWQyt5LdK1icYzMvTVyWC9vjoU/eBDLOEosIgOMq3fjhCtSILb/8ggGQpo50odtYymbqEcaDBNCuXeSHdq+/7BFVzdmNJ2A1gAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354195; c=relaxed/simple;
	bh=ePzJdMR5XS4l0T+U+JwL7EAJw0TvLA27eLAbg0PvUSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHHCE7Nm6zlzLm1mEbvA1bfnVH0cxCvjV3RgWyzATSmM0tycZL3a/8naT31Vi3Q6SAh10d+elzxU+vuWPgdeqySKSC/AfVPieGj2vzPE/zNKrLMbXT/IF/w440ea4yKeKmtT3B+t2fUhGT4NP9sUosHXKyAShgQ0DH0gxhn0N7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOZ5btVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOZ5btVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A721F00A3F;
	Mon, 10 Aug 2026 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786354194;
	bh=ePzJdMR5XS4l0T+U+JwL7EAJw0TvLA27eLAbg0PvUSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EOZ5btVK5wc2PRm7y+pa82bf3EF9Q2evs44jC9f7gpN6kM6uHUCiuwM/CQt4buzLp
	 DvHbec2P6GdoqL8LuZU/Gp2huwKC6TNH1usgp+1qSI0OPhXP+jlNLEvRYgs4rrvLZj
	 l6SC7NOcbBVPs0B/jDmCJ5lndL9VLQZant1O86GzzUwTAgB31/rfQ4jUTM6GwATKT2
	 v3632dOTCea49nhxBk+pLY5vDnGLk1o+g/UNwr4OcDX9GQH6d3QaJY1fkwdush9HYo
	 vxAF5lClYDTXMP/FeWosYTJwRJDLhO850dR/2D38G+l2Vjw3KjfDR12j3puAsWRWj5
	 EzAp8I7p17uYA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected guests
In-Reply-To: <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
Date: Mon, 10 Aug 2026 14:59:42 +0530
Message-ID: <yq5av79iiard.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>>> But the whole thing is best effort anyway, the kernel picks
>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
>>> how many devices or how much DMA they do.
>>> SWIOTLB memory is wasted if unused so we should be careful around
>>> that as it would be the other way around and users would have to
>>> decrease it manually.
>> Yeah, it is why the arch code shouldn't really be sizing it directly,
>> it should be done in common code and, yes, we are probably going to
>> have to do something alot smarter to have the common code better
>> auto-tune this for the CC case..
>
> What about the $subject patch? I assume that it is still needed to
>
> restore the behavior that was altered by the "[PATCH v8 00/23]
>
> dma-mapping: Track shared DMA state through direct, pool and swiotlb
>
> paths?" patchset?
>

I would request that we pick this patch to fix the regression described
in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.

We can then work separately on improving the default swiotlb pool size
in generic code based on other metrics. I consider this patch
independent of that work.

Even with such an improvement, this patch would still be applicable: a
condition that resizes the swiotlb pool based on arm64_dma_phys_limit
should not apply when guest memory encryption is in use, because the
purpose of the swiotlb pool is different in that configuration.

-aneesh
