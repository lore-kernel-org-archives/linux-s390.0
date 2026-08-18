Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52B74028D9;
	Tue, 18 Aug 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045697; cv=none; b=Ha9zqOZ6HcjrV9gXxebpStS2K+15Qkev9QMeIVKzKqtA+joVQ8+1pWdiK9iTlXnnwUnWya4ErASCmuWub9Hmvg7+PoX5Z6YZHS1H6+X9MxWJWOYhYtSkToK97XKurYmaz87wXKAat+Y/Lj0/DkIHWtY2r5xtItoVVtPtz6+OBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045697; c=relaxed/simple;
	bh=FKBwoi/3Seg99DeFtLUGTV/78i0NNSvtkMa1n1zcOAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WF4uQS+qvt0qfZxc2OukcPloqfjIr1zIdz51u9jJN7Cep5zAv3BEb0Te4EvFMoZmZmIJAwOGAPiiKrVXf4jRqcNjcNzlf6WDyN+ezQQwcKjDbNXkZDXgkzR+dBuvqXEEHsQhsHXKBqiJQibtlxJFVzWTeUNCW3xq3H6MCn8+MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bLdi0L4G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bLdi0L4G"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1nw02669356;
	Tue, 18 Aug 2026 09:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UwOIwqYoIY7QlNJ8U8wOacBdHmLDOz
	+rxhV0rBc+F/c=; b=bLdi0L4G5+rWnmkDSJy99P9qnm4+AFVIuwiBJCiqF8//af
	ib49jdGSQSMKEQsJPUBuU/4VuzBqHtue4A7CtKAp4ZC0hGDAIxgJv232AfQSrc3i
	O22hP8DNRTaPXrDf3xjomg9j/z1OfkjRiYNDJ1ZnXOEZ73CK/cORgDGv4t85pUj7
	NiSc+NzPl9OPrv5rD91lPpepBgSoc4KqeP8NyvYMfMyxb1s/DXbf4l9OnbRQphX3
	/rKr4trMlP4g3yIhCeeq/EM1SPKxbe7drSxml0TupEQDz79lqrf50w7Ss9zf4ULy
	j+MbMqc1QMgfJloetwjfP3OCNg/c0n/xK1XHVCEw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt6ssh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:29:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I9QKBM007045;
	Tue, 18 Aug 2026 09:29:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek2f2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:29:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I9TPej35324400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 09:29:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D985320049;
	Tue, 18 Aug 2026 09:29:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74CE620040;
	Tue, 18 Aug 2026 09:29:25 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 09:29:25 +0000 (GMT)
Date: Tue, 18 Aug 2026 11:29:24 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 08/33] KVM: arm64: Use accessor functions for core regs
Message-ID: <20260818092924.21865-C-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-9-seiden@linux.ibm.com>
 <86a4qq1gyy.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a4qq1gyy.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8425fb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=gIllJY12jZb-1DfbplwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NiBTYWx0ZWRfX8/5ZkSFcJu82
 NuPfXVkoHVCwGRBoEvh882KcFTaoR4D8H7GjYWKEg8nvMxPdGfdH+FI2j2ZpPZvFfVYznXYdfhU
 8IaI/zFJuWH/Zuwlg0lK8zw+bUVaSWg=
X-Proofpoint-GUID: 1FFAv4Y26TX30cefOc3x2JLRTu93s4LN
X-Proofpoint-ORIG-GUID: hImjYitApJsqmB6QcrKs3tTr7h4jhQ_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NiBTYWx0ZWRfX5Ak6vZMWnPP0
 U+jJMl2cidjQtT1y6WIXisSFE3qMftgmsd32FguB1ShnJnZq2JfoTzTIZS3k+X+bBnk6eJH75dD
 lQD93lhGWqsIBnPewGo98lyVYFaKsThNzzHeXWFoul8SZK7EgSzmHqD8iX8c+WarkXxJZOU6w1a
 YHjHG3FdbonH1U/70MSi/xkRYL67MUjSSacXlwz+Opy9ZDvTOIDYLl0teKuirelWw6KMpmVclCt
 p1+uI+yr05nnO3C/dkCiDS93BaaGaLGE9Wc5GEDifdysZbmImi9k+6R7+oCwGMBm2eywFQhsoWd
 WkrgnKq3s8udSoMBIwPi3SzaDeInCIjD3e0Fnb5XF5SD6zI2wGfNf/xGloYtx82NaHKlcH96sRB
 6etZ2mjDf1N6MMIxdNqJ4tZJJ9Tz9a+lXlqBWxV3iuUv3VXfRunzlEKZ23c2ve9QtNUuYtSmtuG
 BVSB+gzL5EhvRs02Zow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180066

On Thu, Aug 13, 2026 at 10:56:37AM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 16:36:04 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Instead of accessing the value directly use assessor function that
> 
> s/assessor function/accessors/
> 
> > abstract the actual location of the register values. Add a helper
> > function to reset fpsimd registers. Enable other KVM implementations to
> > reuse this code.
> 
> to reuse this code by overloading the accessors.
> 

Will change

...

> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index b01d6622b872..773f6c8e5026 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -134,19 +134,19 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
> >  		off -= KVM_REG_ARM_CORE_REG(regs.mregs[0]);
> >  		off /= 2;
> > -		return &vcpu->arch.ctxt.regs.regs[off];
> > +		return &vcpu_gp_regs(vcpu)[off];
> 
> Doesn't this belong to the previous patch?
> 

My thoughts about positioning this change in this patch:

The previous patch changes the semantics of vcpu_gp_regs and just
touched the part where the old semantic of the function was used.
This is mainly done by not using vcpu_gp_regs where it was used before
as it cannot be used to access e.g. pstate anymore.

This patch then introduces and *uses* new accessor functions for
abstractions (and uses the vcpu_gp_regs abstraction where it was not
used before). 
-> The patch changes direct accesses to using accessor functions.

However, I have no strong feelings for this. If you want this in the
previous patch, I can do that.

	Steffen

