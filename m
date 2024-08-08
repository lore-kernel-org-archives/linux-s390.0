Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F367189F2D;
	Thu,  8 Aug 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109712; cv=none; b=E/h29in2kvlpIMVrmuUPCKScq0/JF9p3RoNbcak3wtYnCbsawv0bjg3DCkRDR4QoNc6Muv5y/Mgy2OOxJhqbpVisiF4k6x8OIc9vVVXEnubdx9uPh1Bg9DZjaz8BCewg9shat3GRlR9aZO3cwYF6svxom8F9tDCnXODu/6hlgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109712; c=relaxed/simple;
	bh=BPdEyns2vofExNibOqC2X1gKKZcLa3X3/0PaHKqnnX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roAYCeEkv3lPg0jL9YghFvu6/wmrLI9/ir/adol3mXl53UZ680l88DvyCSvFRahdmeb8zOY/CApIidWnQ5l22N+wLyOBYjTWE7nmpG6VQcqlWgv+F9pTToN0IeUGE/eDgfhFAF1Nsvb+spetKH/+ay6Q2he+g6aWqVxdLXt4/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=qGrIUqr7; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="qGrIUqr7"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0482F1D0273;
	Thu,  8 Aug 2024 11:35:06 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723109706; bh=OrVMJm9n5L+C5eEnO6iB+J7yRVKHj0t1YZskeASy1vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qGrIUqr7i5bJWaSfTsv9tVZkeF2nUb+btmsHGvceU/OqrPMDCC6tzRa7qpZdMrbp2
	 wZ0J2RYYk5B+LLRupaWcJRZ1OY5z6+PAX+pljiOMbu0rLsw8ywJkpMmc68F/Q9mJ2Q
	 HxVfp3ufqLO+NhlJwFU8ZybuXwZq+ycpvAvtJy68oSHYCiJcOJz9gzOVt4yCKhcNU8
	 n0Yjd6KXn8ZrEyQq41vNblLCejTpMrK1nVJdusLskvv5a3Dhpvhn1G8fksnfTtL7Gu
	 CX+iM7h+PqddUEy3HRsCO+a/els+D8+xGOaLU5gSs8ejrkrFQRYnqlRQ3oUai/0psF
	 vthRYpAiZOFDg==
Date: Thu, 8 Aug 2024 11:35:01 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Ramon Fried
 <ramon@neureality.ai>, Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <20240808113501.4fde4cb0@mordecai.tesarici.cz>
In-Reply-To: <ZrO5okGUljTc9E7N@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
	<5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
	<Zqyo4qjPRHUeUfS5@arm.com>
	<20240807161938.5729b656@mordecai.tesarici.cz>
	<ZrO5okGUljTc9E7N@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Aug 2024 19:14:58 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Aug 07, 2024 at 04:19:38PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 2 Aug 2024 10:37:38 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote: =20
> > > On Fri, Aug 02, 2024 at 09:03:47AM +0300, Baruch Siach wrote: =20
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 3b4be4ca3b08..62b36fda44c9 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -20,7 +20,7 @@
> > > >   * it for entirely different regions. In that case the arch code n=
eeds to
> > > >   * override the variable below for dma-direct to work properly.
> > > >   */
> > > > -unsigned int zone_dma_bits __ro_after_init =3D 24;
> > > > +u64 zone_dma_limit __ro_after_init =3D DMA_BIT_MASK(24);   =20
> > >=20
> > > u64 here makes sense even if it may be larger than phys_addr_t. It
> > > matches the phys_limit type in the swiotlb code. The compilers should=
 no
> > > longer complain. =20
> >=20
> > FTR I have never quite understood why phys_limit is u64, but u64 was
> > already used all around the place when I first looked into swiotlb.
> >  =20
> > > > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > > > index d10613eb0f63..7b04f7575796 100644
> > > > --- a/kernel/dma/pool.c
> > > > +++ b/kernel/dma/pool.c
> > > > @@ -70,9 +70,9 @@ static bool cma_in_zone(gfp_t gfp)
> > > >  	/* CMA can't cross zone boundaries, see cma_activate_area() */
> > > >  	end =3D cma_get_base(cma) + size - 1;
> > > >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
> > > > -		return end <=3D DMA_BIT_MASK(zone_dma_bits);
> > > > +		return end <=3D zone_dma_limit;
> > > >  	if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
> > > > -		return end <=3D DMA_BIT_MASK(32);
> > > > +		return end <=3D max(DMA_BIT_MASK(32), zone_dma_limit);
> > > >  	return true;
> > > >  }
> > > > =20
> > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > index 043b0ecd3e8d..bb51bd5335ad 100644
> > > > --- a/kernel/dma/swiotlb.c
> > > > +++ b/kernel/dma/swiotlb.c
> > > > @@ -450,9 +450,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_ma=
sk,
> > > >  	if (!remap)
> > > >  		io_tlb_default_mem.can_grow =3D true;
> > > >  	if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp_mhttps://lpc.events/event=
/18/contributions/1776/ask & __GFP_DMA))
> > > > -		io_tlb_default_mem.phys_limit =3D DMA_BIT_MASK(zone_dma_bits);
> > > > +		io_tlb_default_mem.phys_limit =3D zone_dma_limit;
> > > >  	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp_mask & __GFP_DMA32=
))
> > > > -		io_tlb_default_mem.phys_limit =3D DMA_BIT_MASK(32);
> > > > +		io_tlb_default_mem.phys_limit =3D max(DMA_BIT_MASK(32), zone_dma=
_limit);
> > > >  	else
> > > >  		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
> > > >  #endif   =20
> > >=20
> > > These two look correct to me now and it's the least intrusive (the
> > > alternative would have been a zone_dma32_limit). The arch code, howev=
er,
> > > needs to ensure that zone_dma_limit can always support 32-bit devices
> > > even if it is above 4GB (with the relevant dma offsets in place for s=
uch
> > > devices). =20
> >=20
> > Just to make sure, the DMA zone (if present) must map to at most 32-bit
> > bus address space (possibly behind a bridge). Is that what you're
> > saying? =20
>=20
> No exactly. What I'm trying to say is that on arm64 zone_dma_limit can
> go beyond DMA_BIT_MASK(32) when the latter is treated as a CPU address.
> In such cases, ZONE_DMA32 is empty.
>=20
> TBH, this code is confusing and not entirely suitable for a system where
> the CPU address offsets are not 0. The device::dma_coherent_mask is
> about the bus address range and phys_limit is calculated correctly in
> functions like dma_direct_optimal_gfp_mask(). But that's about it w.r.t.
> DMA bit masks because zone_dma_bits and DMA_BIT_MASK(32) are assumed to
> be about the CPU address ranges in some cases (in other cases
> DMA_BIT_MASK() is used to initialise dma_coherent_mask, so more of a bus
> address).

Yes, I know.

> On the platform Baruch is trying to fix, RAM starts at 32GB and ZONE_DMA
> should end at 33GB. That's 30-bit mask in bus address terms but
> something not a power of two for the CPU address, hence the
> zone_dma_limit introduced here.

Yes, I was watching the discussion.

> With ZONE_DMA32, since all the DMA code assumes that ZONE_DMA32 ends at
> 4GB CPU address, it doesn't really work for such platforms. If there are
> 32-bit devices with a corresponding CPU address offset, ZONE_DMA32
> should end at 36GB on Baruch's platform. But to simplify things, we just
> ignore this on arm64 and make ZONE_DMA32 empty.

Ah. That makes sense. It also seems to support my theory that Linux
memory zones are an obsolete concept and should be replaced by a
different mechanism.

> In some cases where we have the device structure we could instead do a
> dma_to_phys(DMA_BIT_MASK(32)) but not in the two cases above. I guess if
> we really want to address this properly, we'd need to introduce a
> zone_dma32_limit that's initialised by the arch code. For arm64, I'm
> happy with just having an empty ZONE_DMA32 on such platforms.

The obvious caveat is that zone boundaries are system-wide, but the
mapping between bus addresses and CPU addresses depends on the device
structure. After all, that's why dma_to_phys takes the device as a
parameter... In fact, a system may have multiple busses behind
different bridges with a different offset applied by each.

FYI I want to make more people aware of these issues at this year's
Plumbers, see https://lpc.events/event/18/contributions/1776/

Petr T
