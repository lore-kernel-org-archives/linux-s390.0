Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691577;
	b=m2G7+mYvA8c/w7oz3dJgPibSdtCXief8CjTxbFJXD9au6t6RJ4t64MIo7XuIUsVStiOl
	 z7A56g8krNWn4D3Cv3M+tjxVYHE9Qv5hQ5Df9Ci+VfXYEdl/SvV9fYbev8pu7oxqj8ndi
	 s55bDFnW61ZDPq8pL2C2OWxjR3vj9u1uXnChTOJzm0PeasAMcf1mwlhiMHvtVhf0jwqtx
	 PCkKhvMWbq6Te3iFKnYyQrds/ZxY9VmRn2SEgV6TyT2I5m8P2Tz8ly+Z4UN7S1Vg/Czju
	 tjeapOwBQccT8Hlj+5+VGGU8Jg5c4LCDft0RGEWBBmZd5Y3dYZGnnd1bvnRw986MSYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691577;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1IOWT/d14QlycRCg1JO/Jw8AIofZ/OvIL8rsv66jEYY=;
	b=Bqcp78/DBQjN4j60WnxWQNgonVoiVUhJUQrE/EVVX30clBZ0tTL+fRNFQMjrpQOmu7Bp
	 sP8egQAC7TvlBTyLa0kmtthEMREfztyUVeAAyKfLmSkJ8BEKLFl197+mAfxVEe7TuRvKQ
	 BW4OQ8fOl4T01pkpsfyNQ/gOKlJtjLlk7hJojW9Z/J48VlYuGDvvYm7mAFXWLqGhySStM
	 AGA9aL9nxKi+H39ITHvC0HY5RDiX6K4aIFhl+kGpOCCsklPKQzzbdJaP4/9Pi50Q9PiVk
	 r85i/aOFOzBXiMXzB4K9Z+Moq2A2CKiWSRWAiO3OYqWKRUPQcnKP1Jasuv1r3yqR/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="K1/kCLR0";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E1606A31C;
	Thu, 26 Nov 2026 11:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=K1/kCLR0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E821BA8;
	Thu, 26 Nov 2026 03:12:52 -0800 (PST)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 799183F632;
	Thu, 26 Nov 2026 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795691575; bh=hEzuUTn3NIQ9D3Y7opBppSoWZoPbrfaVx4Stp1mWYZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1/kCLR0+zsGKueO4tdlfcGvC9uI1tsDD16FNl70XtlY2s4dLuG8uxI8AV8mSTvpW
	 CYpB7JHabMm7QHU4onorSCZylhv92pJXFgeQ4CsC8UURe2rU824wndSsxeMuszHm8d
	 Ny0uSTvsItVYs3DLx4g3j6wwY6T871PnF9x+Rqvc=
Date: Thu, 26 Nov 2026 11:12:46 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 02/23] KVM: arm64: Extract number of sys_reg_desc into
 a constant
Message-ID: <awgULp1w79g4HvA4@e143914.arm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-2-75e95980fb10@linux.ibm.com>
 <awbw3NyDifa0WjhZ@e143914.arm.com>
 <20261125153027.117976-A-seiden@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125153027.117976-A-seiden@linux.ibm.com>

On Wed, Nov 25, 2026 at 04:30:27PM +0100, Steffen Eiden wrote:
> On Wed, Nov 25, 2026 at 02:29:48PM +0000, Joey Gouly wrote:
> > On Fri, Nov 06, 2026 at 05:07:35PM +0100, Steffen Eiden wrote:
> > > Define the constant `num_sys_reg_descs` which stores the number of
> > > elements in the sys_reg_descs array. Replace all occurrences of
> > > ARRAY_SIZE(sys_reg_descs) with the new constant.
> > > 
> > > This refactoring eases the integration of handling system registers for
> > > arm on s390. s390 needs code from the shared code to define the
> > > sys_reg_descs. But also the shared code needs the definition of the
> > > sys_reg_array and we cannot forward declare arrays and use their size
> > > before it is properly defined. This patch solves this chicken or egg
> > > problem. For the time being s390 cannot process the full arm64 defined
> > > sys_reg_descs array.
> > > 
> > > No functional changes.
> > > 
> > > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > 
> > I see later in the series, the include of sys_regs.c into s390 is done
> > before the s390 sys_reg_descs array is defined.
> >
> 
> Are you referring to [PATCH v3 08/23] KVM: arm64: Share system register code with s390 

I was talking about arch/s390/kvm/arm64/sys_regs.c in
[PATCH v3 16/23] KVM: s390: arm64: Implement arm sysreg managing infrastructure.

+static const size_t num_sys_reg_descs;
..
+#include "generated/sys_regs.inc"
..
+static const size_t num_sys_reg_descs = ARRAY_SIZE(sys_reg_descs);

> 
> There, the sharing is done from the arm64 side.
> 
> As this is a new file for s390 the sharing only gets effective with
> [PATCH v3 16/23] KVM: s390: arm64: Implement arm sysreg managing infrastructure
> 
> There, in arch/s390/kvm/arm64/Makefile.gen I add the sys_reg.c as shared
> file. Before it will not be processed (nor included) by s390.
> 
> And there in our sys_regs.c I'll define that array.
> 
> Or did I miss something?

Sorry, I wasn't saying anything was wrong, just reading the code and
writing why it makes sense to make this change!

Thanks,
Joey

> 
> > Reviewed-by: Joey Gouly <joey.gouly@arm.com>
> > 
> > Thanks,
> > Joey
> >
> 
> Thank you!
> 
> 	Steffen
> 
