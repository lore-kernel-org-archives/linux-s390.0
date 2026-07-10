Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CD6374E5A;
	Fri, 10 Jul 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690881; cv=none; b=ot3vOQ4oofk4ExFFDE8q8sUvhm53l5aYtVPVC53YmzZYtUP/+Na2Kltv4Ivi0n7TuPTXyqUxECY5PUUq18ycO79pFB4TeX1JFrD+dOgkjBFpOlcVbm76OQlxpG+j3cYCGDFnMkiswsR+CIS0jjh38KY3s86xsUdm1rpyQHHhE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690881; c=relaxed/simple;
	bh=y7imvDBUf0TciTUd+NP7o0tXn/u7oKHLwDJ7ePlVId8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0WRGv9XkLkDd507xbLVmWcrZw4XrO3wSIoGe3WSRDvkIqhiWS9okeJXGuJfThCSlA2r1iy4ZPSdlEJLYXuwgV75XU/LToEMWQKXDn00arNQawQqo92P2F0OJRC7RpYEPQei9ZpfFfoA0umfYk3bLsP/0mLOSZpUaqHakgEXoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i3rziSTp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i3rziSTp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ADIDXJ1713075;
	Fri, 10 Jul 2026 13:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N9LSC889O68KIxMLOEUoke37oASt8N
	T31vCJEcDdTOg=; b=i3rziSTpsz+IImWsw7MCjmADLQnmzEZtJSJSofxHoc8UlP
	OcKkIh/S1Zi84nC9S+iOsUeEHitZyqqlNhtvvD6dx1l7Fbi4dOSFxji4F4YYXdl8
	OlFLjnzqCt5xUuy3BuOfZ4cIjWc23VwAcNNB9bxgztxeDxq7iudAbz8hLL+TEHOz
	qUBVCrec9UtPMWbFbEdp+G5HUkmPiW/sRGZ6oa/+NuidZ95sCC2XUEfw3XACVJFn
	LeWl4ieDZXIKEXPkyt+PLJYhM+bk7dFEJgcRIQXXIyco06VOLo4LPGNnKve7CtHY
	k+hf857iZGVgsqccjDg3PBqAXL+PFerQ5CiIzwKg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur6qy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 13:41:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ADYjGu003964;
	Fri, 10 Jul 2026 13:40:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqjebj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 13:40:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ADepJ029360624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 13:40:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 931192004D;
	Fri, 10 Jul 2026 13:40:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5CEA20040;
	Fri, 10 Jul 2026 13:40:50 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 13:40:50 +0000 (GMT)
Date: Fri, 10 Jul 2026 15:40:49 +0200
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
Subject: Re: [PATCH v4 23/27] KVM: s390: arm64: Implement required functions
Message-ID: <20260710134049.984749-J-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-24-seiden@linux.ibm.com>
 <87bjcj7t5h.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjcj7t5h.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX3ROGKCS0YtfH
 QFpX266GmP1th1voyuu9ytstSczZDgwjBOmRrvn6c9sgbI0q8aeEo0cWUFMAGE3HKZY/ZrzDJFK
 KIkuuPqoSHNWtvcWI10i7kdjs863gPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX9sgiu26vVoXN
 gdez2/XVYkga5ITBLcWUbbTgmVuMFQ7cJWmwuRknWjQ6MDdwulbkITzSDOsMtEoX21jeYelo2he
 Bi9KI3h5SIKMPd13gqFG+Ox3gnoa9zT6r8QUkSa/oEdgvGGZ6PIDWdVKYxUPV9oJPk7Y85AVmuR
 vAWE4POrfzZTXoULkStEatexfPO1O/WY77rRD4gP6AS3cPPnpI0L7MrCPTSSPyRCRqkVzDIyqQM
 rIbMW8phIC1emakSE/CCF98Rju/vWGskunxZ+0tQ6qzHRFOfrBqjvynC5QBQqJTEsCCiVc8+5fD
 5KeUKIdXCHwjof8NI4/kdH6cc4m6A+fhFpZ2Ftyth27v6yhLlGniWWrLdMToM/9f39jtImpd+6O
 +uZO33TequZ1ic2fvZ9QdGs7ekNtRr+h87ry1rZtPNtSo4hbGBqI2QX0h+Mgn0OA/hQtXiJcnLy
 B6Cyo/X6UGU4gtA03Qw==
X-Proofpoint-GUID: 9G33u2V4ajpbDsBj3uLwc9D7zJAckEKf
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50f66c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=RsO_Ah-4iS8lBfzd37cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 9G33u2V4ajpbDsBj3uLwc9D7zJAckEKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100132

On Mon, Jul 06, 2026 at 09:35:54PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:23 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Implement the mostly trivial functions that the shared arm64 (kvm)
> > code & headers oblige s390 to implement.
> > 
> > Implement a very basic smccc handler that (non-compliantly) is just able
> > to stop a vcpu.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/include/arm64/kvm_emulate.h | 135 ++++++++++++++++++++++++++
> >  arch/s390/include/arm64/kvm_nested.h  |  11 +++
> >  arch/s390/kvm/arm64/handle_exit.c     | 110 +++++++++++++++++++++
> >  arch/s390/kvm/arm64/inject_fault.c    |  21 ++++
> >  4 files changed, 277 insertions(+)
> >  create mode 100644 arch/s390/include/arm64/kvm_emulate.h
> >  create mode 100644 arch/s390/include/arm64/kvm_nested.h
> >  create mode 100644 arch/s390/kvm/arm64/handle_exit.c
> >  create mode 100644 arch/s390/kvm/arm64/inject_fault.c

...

> > +
> > +#define SPSR_SS BIT(21)
> 
> We may be better off defining SPSR_ELx in the sysreg file and use that
> all over the place.
> 

make sense. I'll create a patch for this.

...

> > +
> > +#define __INCL_GEN_ARM_FILE
> > +#include "generated/handle_exit.inc"
> > +#undef __INCL_GEN_ARM_FILE
> > +
> > +#define PSCI_0_2_FN_SYSTEM_OFF		0x84000008
> > +#define PSCI_RET_NOT_SUPPORTED		-1
> > +#define PSCI_RET_INTERNAL_FAILURE	-6
> 
> All of this exists in include/uapi/linux/psci.h.

Yes. We'll use them in a later series as well.
this is just a placeholder implememtation so guests do not have to run
idefenitely. 


...

> > +	[ESR_ELx_EC_SOFTSTP_CUR]	= "Software Step (current EL)",
> > +	[ESR_ELx_EC_WATCHPT_LOW]	= "Watchpoint (lower EL)",
> > +	[ESR_ELx_EC_WATCHPT_CUR]	= "Watchpoint (current EL)",
> > +	[ESR_ELx_EC_BKPT32]		= "BKPT (AArch32)",
> > +	[ESR_ELx_EC_VECTOR32]		= "Vector catch (AArch32)",
> > +	[ESR_ELx_EC_BRK64]		= "BRK (AArch64)",
> > +};
> 
> There are a lot of AArch32-specific ECs here that you may not need.

you are absolutely right. This was just a blind 1to1 copy. IMO they do
not hurt but I can reduce 32 specific ones.

FYI
The code is not shared as I would have to spin up a whole sharing
infrastructure to share this one defenition from arm kernel code.

	Steffen
