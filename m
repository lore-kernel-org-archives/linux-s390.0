Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF233E1D0B;
	Wed,  8 Jul 2026 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493560; cv=none; b=Vbi5lBB/1xpLDE5cXfV+m77lIKzYXbAx7Bys9z3wrG+TFWftHw+LIDT1viWJ6jNiuOB1GZ2zJYCqTQMDpMXBAWVqEaec42GxE9JHYlu3zyp78NaW/C3Lc6xHfP8XHUqB81JJl5dt0wqFmyFi2DTGhwjznbhWySlFWuhZWhl5X2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493560; c=relaxed/simple;
	bh=NC+UAucr4BtA+L8Redg3pcqhHOiGH6Z6REGfg4019bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDxDDVAzCZBU83Jv3b7TCC8rz8ezo/PVQ/xmlOVqCsBzmEL17blTaRtaEsCWZXWI4pNDI0MYtZUTHBfYH2AhLRi4eysBSTEFP8dbQmnZsx/GyM/SecYFLF40t2WrABZdrnXjYTMlVmIUI+9ptys4NuLOHoxIUsbbnGkK8J8tToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HbE2LrI0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HbE2LrI0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmSYt1572023;
	Wed, 8 Jul 2026 06:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Aw9iRK6Rsso52PQ5ppgSnxDvjHojjy
	gfPfvoXQltGk8=; b=HbE2LrI0lh37yava6HgliQ/Jpfurywmzv52RcCx1jhQl87
	/RWFsm2Gqu/QSi6qNQ0hwBI6MRY/1oTizT78DM0i94K2G9/VLgJCdR/ZMJ+2nZy4
	bRbgadCXS25L8D6yzxAQFz22kwroAk9z73r8jkOqz+WzbrgJcJ3dtwxThcmL5b2v
	Zgc7WDDfrittalR3RYiXXjjLjXCFoGSnLzZaZiK6R/FxRlULGv+gLUnw//MPZzyq
	8Lze1CDxjVHweVFMzjOeLcv/UZvzsJCiqSAygLOnEB8eNUUvwFSR/ndE/rJL7DHn
	tHsrFbZYiAdlszd6YrGutD/5P3o8MH2s+6UbP/eA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknjm0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:51:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6686neQG005665;
	Wed, 8 Jul 2026 06:51:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk6dyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 06:51:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6686ppiS50069990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 06:51:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29C820043;
	Wed,  8 Jul 2026 06:51:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728A420040;
	Wed,  8 Jul 2026 06:51:51 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2026 06:51:51 +0000 (GMT)
Date: Wed, 8 Jul 2026 08:51:50 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 24/27] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Message-ID: <20260708065150.583632-C-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-25-seiden@linux.ibm.com>
 <8633xuq1ic.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8633xuq1ic.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4df38f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Wq-2yyKVzZd0Sq0-aLcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hfPSuFXwe_2IBBAWx3l80NDomi6fZ2go
X-Proofpoint-ORIG-GUID: hfPSuFXwe_2IBBAWx3l80NDomi6fZ2go
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX+Du9LcSDl8Hv
 lbcP82N6DL6RF0yGgTJv3h7PYfO2gvlZ8KEbx0mZ3iFC+s+yL5cliEUzhYg8reYP3ZyFEfQadoJ
 gPpImWZsCqujLZsNzTse+DqZiz+Ue/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2MyBTYWx0ZWRfX7ArL2wGBPYhr
 HdsgGhFzUsQbEZ54eFFUU138oXqZmYbwhKNgS8xv8qQiTkH9UM1cZWRdcPhLLZ/kfJ0C6hg61o0
 qex5KL0pBzgQKSiDdX/mwZ/OCVmRH/wNmwLQZLek6+kvi7UhBWC+uLw46IUoQ/3VwcAP6f0xJwc
 NUk7T6WVkg/x6EFRJnSDk0jLsN+aixq7o/TKZfSbAlLo95SEQo5abxFoDAapUugK4KJR3MdBbj4
 YC7WIcTe5YTlJOzJmGDT8YgBLgIyDGZG4/g051h/knNbyclwRUdk5/cFNQ7nfl5Yxp/o/Zo8Y5J
 CLTxsNIRfwRIjpiBt6SvMdYkcyZmyNkdfQnp2hnw67k7aLDT2kPFYf0Hq8WIqkyx0auQs56YoUT
 S9hahiLnW9IYxxp3ANGTYbpARafomJ3joZL1bG/HcPOjx+Fqw0AHXyg3cSowCkFt4NpVhx8b0tm
 D3zlSoQdhcB6DDVbPSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080063

On Tue, Jul 07, 2026 at 04:10:19PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:24 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Implement init and destroy IOCTLS for vcpu and vm.
> > Implement arch vm IOCTL. Use s390 gmap.
> > 
> > Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/kvm/arm64/arm.c       | 190 ++++++++++++++++++++++++++++++++
> >  arch/s390/kvm/arm64/arm.h       |  56 ++++++++++
> >  arch/s390/kvm/gmap/faultin.c    |   5 +
> >  arch/s390/kvm/gmap/gmap.c       |   4 +
> >  arch/s390/kvm/gmap/trace-gmap.h |  13 +++
> >  5 files changed, 268 insertions(+)
> > 
> > diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> > index 19249ec5c539..3a4092698fae 100644
> > --- a/arch/s390/kvm/arm64/arm.c
> > +++ b/arch/s390/kvm/arm64/arm.c
> > @@ -8,6 +8,10 @@
> >  #include <linux/kvm_types.h>
> >  #include <linux/kvm_host.h>
> >  
> > +#include <arm64/kvm_mmu.h>
> > +
> > +#include <gmap.h>
> > +
> >  #include "arm.h"
> >  
> >  static unsigned long system_supported_vcpu_features(void);
> > @@ -31,6 +35,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> >  		break;
> >  	case KVM_CAP_IOEVENTFD:
> >  	case KVM_CAP_ARM_USER_IRQ:
> > +	case KVM_CAP_PRE_FAULT_MEMORY:
> 
> arm64 *doesn't* support this yet. Please make sure you don't deviate
> from what arm64 currently supports.
>

I hoped the corresponding arm64 series is merged when we got this :) 

I will remove this advertisement. I'll keep the implementation as the compiler
expect that function to be present anyways, as native s390 KVM now implements
this CAP. OK? 


> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
