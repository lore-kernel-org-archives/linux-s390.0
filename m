Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2D364942;
	Tue, 14 Jul 2026 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025683; cv=none; b=qDjnk3gGT8a71B8Abq4L+OmhUO3vVyNidyhbHh1CcDnpd5QrJSinRl5BMXFklvU5hCIsOsy2bxAAy/7H53FWk/ObYnfKndmCFvuYtxgdZ1Tz0lzM7Wg/X4mVsP6HU/Ykl3Kh0jmAPSmgBewFovEok0pDn6CbDk4ZPZqlYLSKuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025683; c=relaxed/simple;
	bh=22T0+19k2lVgfbfO+jVJvs3dj8Q/7cpmdpyPuAvdnJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTLeFRelHetGr6ZOHI9S7DxesiU1ucV/JnepbDONUoPkGKH47VmIROVUJg8Gi4uaQorDC3RJ7J4FgSc6jix2trhoi/kn9s+zwzxubVtG7O3EmG4I+wSEmF2bP9fjJrwLDuZnPeJsA/P0P/J6IS1+pTI1HcDJIfu0Aacn0Avv+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4xZ0AiN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4xZ0AiN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6gDx92860262;
	Tue, 14 Jul 2026 10:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sGLletzsKjGe132byb68wawCWrly6k
	VE74XitY/8ZF8=; b=P4xZ0AiNgMXz60MS7JUOKKe8Ns38GrUGI6eJq5oF1nsx7V
	/7iyWKUGVimtZwVz5LibEa1VRhl48abj0IUtyS5QYALBlC1ODLU+hsOJLHojYCKi
	UDJ5OYGBR2xtMEz4X9PFxLt1fmJTCuhu/wBS01+CpDeo7B6uKIn2BdJwJwCmINd2
	qdQxmyAexr9QlQtpzlcMpdyjmPpGB4YXS5dL7nO6la65u80Pu5Z8YglXq43nJhGS
	eJPFOZ6CUh746SvvSH3xNC/EiVQOOLk0KEVgCWrDDCVFa6ssG6MxR/BpHobXA2A8
	OI8UhHCq8UKWhEs6Gynxg0eWrn6Ca8ATVApQ8Ncg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv3366j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 10:41:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAYcxa031255;
	Tue, 14 Jul 2026 10:41:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cga4vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 10:41:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EAetls46530944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 10:40:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E4D20043;
	Tue, 14 Jul 2026 10:40:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E0520040;
	Tue, 14 Jul 2026 10:40:55 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 10:40:54 +0000 (GMT)
Date: Tue, 14 Jul 2026 12:40:53 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 13/27] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Message-ID: <20260714104053.55132-N-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-14-seiden@linux.ibm.com>
 <20260713183829.63e570b2@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713183829.63e570b2@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX4u5qQWyQJPIB
 11L6w56UK/FXHI6QjFMwv0htBNPDkcffRO14etCCDYvqdBLL1RylRsAI+t2hmNPqfD/8kFDPE8+
 u9+sSSlmH+Zxsk+atitSWgzB6nHrCeE=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a56123f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=QIr4ZWLDNz3WxDQMryEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: AeTppKg7eukgrPJsZlICq3KA3FK6CJaV
X-Proofpoint-ORIG-GUID: AeTppKg7eukgrPJsZlICq3KA3FK6CJaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX4crWCQojltWm
 1RaRZlGjpwq2D1gcoK+fqNkQ6gi7F8qfAFsLtbiSHrnhgHOuqsht6CPND4fG+ttEjEChpRXQbDu
 IX0hmHkgOTF7yiFWNxKP0ko+PUFP6DaCu8xoopeDYHjUkZspl2c/nCtDSeiXTm0Qwvo7+h8Vufy
 FBktkbBukQhx9Le6Ltu1z0ThnMPDba+cbc29BzjYQwTOsyQpn1/QxiIaZKBxECUjQ+/r1AqVKAe
 tHQ048Km6l8af/Z7m2msOUVzTlapgh8FTFOB9YOgWX6lQeIOW+tZZ1hkXfsmDxCmGgm1J4Ejmud
 x0MQAMx1VJAosj1sygp6aRxD0UuSX9rDsNz9zkeF2CtcHaptC93vnIm4/oD+JJ42Af5CKfIzrML
 vCdU4T/AK+dm303nQYbGPq81tn/8kG07CfC6xeDMlLFAMsgxEU7PTMURncBhPAQIilRZQ1MCL6K
 c07bUFFkPvF4AJovzdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140106

On Mon, Jul 13, 2026 at 06:38:29PM +0200, Claudio Imbrenda wrote:
> On Mon,  6 Jul 2026 10:52:13 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> > Lay the groundwork for a second KVM module. Guard KVM/s390 behind the
> > KVM_S390 config and turn CONFIG_KVM on if selected. Move all the
> > kvm_host definitions to _s390 postfixed headers. Prepare local header
> > include guards for a new location. Move gamp related tracing into a
> > separate file. While at it, rename the main KVM/s390 files from
> > s390-kvm.{c,h} to just s390.{c,h} to match the naming scheme of other
> > architectures.
> > 
> > No functional change.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/Kconfig                             |   2 +-
> >  arch/s390/boot/ipl_parm.c                     |   2 +-
> >  arch/s390/boot/uv.c                           |   2 +-
> >  arch/s390/configs/debug_defconfig             |   2 +-
> >  arch/s390/configs/defconfig                   |   2 +-
> >  arch/s390/include/asm/kvm_host.h              | 774 +-----------------
> >  .../asm/{kvm_host.h => kvm_host_s390.h}       |   6 +-
> >  ...kvm_host_types.h => kvm_host_s390_types.h} |   6 +-
> 
> I really dislike those "almost renames". I'd prefer to have a prior
> patch with the differences, and a second patch for the move.

I dislike this to. I tried to reduce it to a minimum. 
I could prepend a patch that changes the macro guard before this patch.
This is the change in question.

In fact the whole purpose of this patch is to reduce the almost renames
and let the next patch be a pure move ( minus one keeping stuff compile
change)
> 
> >  arch/s390/include/asm/kvm_host_types.h        | 347 +-------
> >  arch/s390/kernel/early.c                      |   2 +-
> >  arch/s390/kernel/entry.S                      |  10 +-
> >  arch/s390/kernel/perf_event.c                 |   2 +-
> >  arch/s390/kvm/Kconfig                         |  10 +-
> >  arch/s390/kvm/Makefile                        |   2 +-
> >  arch/s390/kvm/dat.h                           |   6 +-
> >  arch/s390/kvm/diag.c                          |   2 +-
> >  arch/s390/kvm/faultin.c                       |   3 +-
> >  arch/s390/kvm/faultin.h                       |   6 +-
> >  arch/s390/kvm/gaccess.c                       |   2 +-
> >  arch/s390/kvm/gaccess.h                       |   2 +-
> >  arch/s390/kvm/gmap.c                          |   2 +-
> >  arch/s390/kvm/gmap.h                          |   6 +-
> >  arch/s390/kvm/guestdbg.c                      |   2 +-
> >  arch/s390/kvm/intercept.c                     |   2 +-
> >  arch/s390/kvm/interrupt.c                     |   2 +-
> >  arch/s390/kvm/pci.c                           |   2 +-
> >  arch/s390/kvm/priv.c                          |   2 +-
> >  arch/s390/kvm/pv.c                            |   2 +-
> >  arch/s390/kvm/{kvm-s390.c => s390.c}          |   2 +-
this almost move is required by the compiler (change header form kvm-s390.h to s390.h)
> >  arch/s390/kvm/{kvm-s390.h => s390.h}          |   2 +-
this change in theory could be prepended but would leave the comment in
place invalid for one patch.

> >  arch/s390/kvm/sigp.c                          |   2 +-
> >  arch/s390/kvm/trace-gmap.h                    |  45 +
> >  arch/s390/kvm/trace.h                         |  14 -
> >  arch/s390/kvm/vsie.c                          |   2 +-
> >  include/linux/kvm_host.h                      |   2 +-
> >  35 files changed, 103 insertions(+), 1176 deletions(-)
> 
> [...]

	Steffen
