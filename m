Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF1386453;
	Wed, 10 Jun 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080325; cv=none; b=KE1KYq/pR+i4wytKb6GIYKoFKCxq51P6oR/W59Rc94Kg65wuSMAuU8HmxyLCbht7H9nWbMfwYGRSd88b+wtCn1MxTyXMtRe0XgqhZWJJpo9k/rVjjt87HnZCMFOujqYbZ+l0M1GNVkVQ9csLzPF9fqKkgMZdHfqlOBsVRXS11ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080325; c=relaxed/simple;
	bh=8j/2SReMPBKwiPfM1zlJ9hlEC0luvJYmS+ZwCf49daY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNoQomuTQLzU5UB3doiJs+r7RtQWUqMCukI+rR90ONOHBOJ2zSxVz2UnDQucQoLmo9CWO9OD2GE51fsCU5YxgIjWIkdUsTekkbn4P3pm4x4aZ1cRgOiiOIidcQt88A6SB1yzvruhuAqookoR1fHdw0ferL0WDpSJqb+jiRLEbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CADMmn9g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CADMmn9g"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7H8DC3134026;
	Wed, 10 Jun 2026 08:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gsqgT1L8GlUvjVEyoVN0CjEjCJ7lWM
	1KEW8o6L6f69k=; b=CADMmn9g3GIiN84a6Wh3GVeT862MGYxi1wAl/pL5VqxIr5
	ekPFQeV/aGKkwOfEKlDTqalwScuyyoKyhK5nzaRsFKVdMYL1XM/okdEFn6jo2GZa
	a6rv52VNpOdMbxlIAg6Lep5X8BaX//houA96+t3us9hoJUf5i6yoV/zKXQCfLtfd
	W9908ij74VGNG1bo0DH/4lyFXOv0AqI/4re7neiNXVFJi830ubiNkI9d5v6z4tcs
	Pdor0IyAIr1YtJtWA0yV2GaHnrn2mX6j5Aqw6yW0oHQaLMhmcLhvC/I0HDh253b6
	yFBtv4WxR4SlzqcyGSpioijl5ITm6PsGdeLuZduw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95g7d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:31:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8Jb3P028350;
	Wed, 10 Jun 2026 08:31:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq60ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 08:31:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A8Uu7e42860894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 08:30:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 105AC20043;
	Wed, 10 Jun 2026 08:30:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA92020040;
	Wed, 10 Jun 2026 08:30:55 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 08:30:55 +0000 (GMT)
Date: Wed, 10 Jun 2026 10:30:54 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 13/26] s390: Introduce read/write ARM sysreg
 instructions
Message-ID: <20260610083054.151573-A-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-14-seiden@linux.ibm.com>
 <2d73aca5-1858-4a7a-a304-0971e4789dc1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d73aca5-1858-4a7a-a304-0971e4789dc1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a2920c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=RB1mEpRu8beSFINCoVEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rkH4BTGK461Si0Q9cLKjWcrqdRB9jrQ0
X-Proofpoint-GUID: rkH4BTGK461Si0Q9cLKjWcrqdRB9jrQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3NSBTYWx0ZWRfX759nmtSYBCtK
 OKztLB4YBBvkqAJiVWHa0lvNpubxRsfOlLx2KUZJaV23kUwR22A69MRJel9dxDfzuT38zTEwKeW
 IJIunCCS4RCeF6Tnww6DQX1HJSCU3c8ls4FyaHMlRFBAm/hWqKpgnHGwXznPkvNLZtzr8kd5tgu
 F1xPqwrF6ykDULEZB+ujCSIXu2m35kJf1t3wgi0fKJrr9e8/IYJ0LYWtUG+WPOApsDbvDp6th8x
 ZoYhmfTSp+lh/HnM1J5ZYrI3li0/HsyvgWYedEy4h9N1+WklI0E/nxKhag14KXBbKQKpLgXLPRo
 Qr7jDL46fR9iCaI21z1nlQ/f4rr7y0QOjSBeYn0jvDpfwLNCD2QRxuy8juDc6DntVYmWMPog94I
 t/jAu+6eeW55eeAy7UYOZ+QjSBUFoeYsFd+NuAE6hW0/KM1i1VCgn5p1M5AUk6e+y5GhYqMLZmn
 VUSZ9F5NmINukCX1KGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100075

On Tue, Jun 09, 2026 at 05:04:10PM +0200, Janosch Frank wrote:
> On 5/29/26 17:55, Steffen Eiden wrote:
> > Introduce Extract Arm System Register and Store Arm System Register to
> > enable s390 hosts to read and write system registers for arm64 guests.
> > The new instructions use the new RIE_H instruction format. Add assembler
> > macros to create instructions in RIE_H format manually. Add Support for
> > disassembling the new instructions.
> > 
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/sae-asm.h | 48 +++++++++++++++++++++++++++
> >   arch/s390/include/asm/sae.h     | 58 +++++++++++++++++++++++++++++++++
> >   arch/s390/kernel/dis.c          |  1 +
> >   arch/s390/tools/opcodes.txt     |  2 ++
> >   4 files changed, 109 insertions(+)
> >   create mode 100644 arch/s390/include/asm/sae-asm.h
> > 


...

> > diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
> > index fe010a1a7729..1d9a16b91b23 100644
> > --- a/arch/s390/include/asm/sae.h
> > +++ b/arch/s390/include/asm/sae.h
> > @@ -4,6 +4,7 @@
> >   #include "linux/linkage.h"
> >   #include <linux/types.h>
> > +#include <asm/sae-asm.h>
> >   /* defined in arch/s390/kernel/entry.S */
> >   asmlinkage int __sae64a(phys_addr_t sae_block_phys);
> > @@ -12,6 +13,12 @@ asmlinkage int __sae64a(phys_addr_t sae_block_phys);
> >   #include <linux/io.h>
> >   #include <asm/kvm_host_arm64_types.h>
> > +asm(".include \"asm/sae-asm.h\"\n");
> > +
> > +#define _SAE_ASR_REG_SHIFT	5
> > +#define SASR_FLAG_INITIALIZED  0x8
> > +#define EASR_FLAG_SA           0x8
> 
> s/SA/SAVE_AREA/ or SAVEAREA
> 
> I think both might fit.

yes, might be a good idea.

> 
> > +
> >   /**
> >    * __sae64a() - Start Arm Execution
> >    */
> > @@ -20,6 +27,57 @@ static inline void sae64a(struct kvm_sae_block *sae_block)
> >   	__sae64a(virt_to_phys(sae_block));
> >   }
> > +/**
> > + * sasr() - Set Arm System Register
> > + * @arm_reg: ARM system register identifier; compile-time constant
> > + * @val: Value to set
> > + * @save_area: Pointer to SAE save area
> > + * @flags: Operation flags; compile-time constant
> > + *
> > + * Sets an ARM system register value.
> > + */
> > +static __always_inline void sasr(unsigned int arm_reg, u64 val,
> > +				 struct kvm_sae_save_area *save_area,
> > +				 u64 flags)
> 
> m4 is 4 bits in length, any reason why we use a u64 here?
> Same for easr.
> 

No real reason beside my preference of using u64 by default.

Do you want me to change it to u8?

	Steffen
