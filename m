Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50052F0673;
	Wed, 16 Sep 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570837; cv=none; b=f3eVWlOq3kz7Iesp7IvbUtQS+vsQ7n41QrYLxrVMryprJZ0Pn0tajVWp5Ghe7Wsv0KscI0U6OlmY2ZKAfTVk/+oN3scsykV31dyUgm8o7fhG5QhwJjGxxwC6me6Jn37OWLV87wzI8M7iutcPQq9Z6tgm7wlVTmOPJJDGiUJ9x/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570837; c=relaxed/simple;
	bh=4mYZuYY/4TWRRwSCtvsKG9o4ifIS9Tyl9n2rO1QSNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvMXxk6j2SzH38bjEok2MM5rUeD9p7T2JFBTb3q0SjDQT10dtfJOgZbyXMg3es4zkSdBhdwz2mSqv+yuoUNA3JMPX63kofR00iKyPcyh9ZW8Sd/XgDo7WPIreNd27oz2Sdw/7HsU0jli+Pbh6lV+zYX7Db2PXzD0vnWlll5fKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DSW5uGXc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DSW5uGXc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVxdJ3863290;
	Wed, 16 Sep 2026 15:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=j9wYFqkMO68SYOCGbriFllUPMhixN2
	gtllHySmb7w5g=; b=DSW5uGXcNBEav274LLwLVkQJJXunKRGXxm0hv6idwZZISp
	jNx9tZ9aNgkx+oEM1BlRNdtXGx3Cc4ARJgmyUfNis7HfO07p6U0UKavc97fP4TvX
	oUcKb36q2dUDMm8TJVws4WFM9cJ9al6mM7s9nLrvqdsO0eaFsWJLrcrt2t5Rxnmy
	3t8fBs6c4Tiv/7v2y0dlBG0Fu4Dc2oqUQMAMGah5/jUTvPz8CLIwIe4myfy2ySV9
	W/BBCPM2X/1Dd12JPrdXNmuwK4osTJfDO8sj2iYqVv41qJ9SUTMTBST9uZvh18Az
	oRfEATaVPd6dFEd0FsIWB4YjaGjhMJuMTNVnbaCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hw4vu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:00:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaDkJ1571790;
	Wed, 16 Sep 2026 15:00:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bxty3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:00:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GF03fh49873402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:00:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA662004B;
	Wed, 16 Sep 2026 15:00:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5059C20040;
	Wed, 16 Sep 2026 15:00:02 +0000 (GMT)
Received: from osiris (unknown [9.111.20.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 15:00:02 +0000 (GMT)
Date: Wed, 16 Sep 2026 17:00:01 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 21/23] KVM: s390: arm64: Implement vCPU IOCTLs
Message-ID: <20260916150001.202565-D-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-22-seiden@linux.ibm.com>
 <d706435a-3984-4ef3-b319-1efc92517650@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d706435a-3984-4ef3-b319-1efc92517650@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE5NiBTYWx0ZWRfXxeAY1ElL61t/
 DSYaS/30ktfKLmCi1Je1B8oA5SSK0YMYFdINg32ZZXjlxEc9UVimA+x4ax64svDgzOof3EE+8Cq
 Vl8VAQsLH6OyJehRfezU1Slb3TVCSuZRAL9WWS3smLcYBp41FSMALFI1GRXyRzvYpwhzchIjlIb
 CkraEYnR4xehufNRYTAt45GmKn5YprnOrEXn+lXaPv8GrkVyfwHxDdUH/jkyYa+BwuOXTH5DASu
 kDegQycer+tXRRKiwObfFg6xsGp1+6tFw5IjK0QCpvpWHQ01ArLIpW1V7WjxcWuRkSv3LPrY4WX
 WTvUpoy2w1zB1MT+a+DaUVsEOXz87JpHkY8arJG1M5FfIGhZmq5O7Kpopd6aVb6eogrOYMABlIe
 vitrrgpi7QOp3DeMtsyo4XAdnUcOb3Oh/j+6VjF+J1g12DjFVEw5gMZ+jmN4OVH6vugtF3ro7tt
 US9PSysZIEbXkVY+LSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE5NiBTYWx0ZWRfXxG44vfSHFzXS
 7DdX+PaMTaaPE/YyCzXnSUPL9HrecC741FwX1UnjFTWpWFPm3oI14f3lIBWA7I+3UY306cDUbZK
 R4kIROXqO89uOkaiabda0mrXWcATLjE=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaaaef9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=2EDVkJ_xZdsl-fsxt_cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: CcjZPhrNXuk_fD7ZBanhcQxmk7O2fTAK
X-Proofpoint-GUID: pSdKo_eOc1M7lhhBdE68zGvs-QjHxbP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160196

On Thu, Sep 03, 2026 at 03:27:16PM +0200, Janosch Frank wrote:
> On 8/31/26 4:47 PM, Steffen Eiden wrote:
> > Implement all required vCPU (arch) IOCTLs.
> > 
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> 
> [...]
> 
> > +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_sae_block *sae_block = &vcpu->arch.sae_block;
> > +
> > +	adjust_pc(vcpu);
> > +
> > +	local_irq_disable();
> > +	guest_timing_enter_irqoff();
> > +	guest_state_enter_irqoff();
> > +	local_irq_enable();
> > +
> > +	sae_block->icptr = 0;
> 
> We already do that in the function below, no?
> If possible I'd like to avoid setting ictpr here.
>

yes, removed it at this location. thanks.


...

> > +		kvm_vcpu_srcu_read_unlock(vcpu);
> > +
> > +		arm_vcpu_run(vcpu);
> > +
> > +		vcpu->mode = OUTSIDE_GUEST_MODE;
> > +
> > +		kvm_vcpu_srcu_read_lock(vcpu);
> > +
> > +		ret = handle_exit(vcpu);
> 
> ARM increases stat.exits here and since you copied the stat fields over we
> could do that too.

Good catch, thanks. Adding the stat.
> 
> General question to the ARM maintainers:
> We'll be adding more stat fields in the very soon future.
> Are you fine with us adding them under any name or should we prefix them so
> it's clear they exist because of our architecture / implementation and will
> likely never be added to ARM KVM?
> 
> In the past we've added a lot of stats and I'd expect us to at least add
> stats for every intercept reason.

That is the exact reason I copied the struct and not reuse the arm64
defenition. I already added a gmap stat we have but native arm not.

If the stat is meaningfull I am all for adding the stat to arm as well.

	Steffen
