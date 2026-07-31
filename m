Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654F3F3265;
	Fri, 31 Jul 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509472; cv=none; b=RQKOpnLEISYk9U2viOATFmhel1svQgfvG/ylI0/hpqjI4gELnvVNnekcPVKJ+mB6Z2+Q0Yz1JzladZKoo5Dp2Hdtau9Pj9sYsHW3og/TVQxtwIFgz2GmqI5uIX6l3Ei71zTjqAV3RI+V/M7bsrUxQ2ChyezsL2ce/4xvhF5LDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509472; c=relaxed/simple;
	bh=Zu0ekwT05lUBF79pmY7OZ4tjlK3oi3BVRF1lRM0GcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpUtdey5/56lIeSFRIYrNpV3ClowteT1UQr4//T0sIc6donA9Tee56LGEt6TM2heXBbtOoineU2dxRL1U7mx7MjQsuWXcKPl3RW48Lo7z2via8sktMu+dZCT2nG+MPkND+jMnVAvb6XFcKVNnoHQtT4EjOTL+fpjkHhmr8U+MII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O0y4XFBT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O0y4XFBT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBmU7k1732345;
	Fri, 31 Jul 2026 14:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=msTjt9ovCp55/jv8JM3tfyLpDda2Mq
	yxxIJoFmTCS0c=; b=O0y4XFBTSOTWjmfF2QuOike5JQuCsE9Uk3K7+73bmVXfMe
	idzBI4VETcYBr/GfUYTT6L6sHwTfth7W8agVwU+JMlgOvZSl31WDeeze2GcYVjXC
	ha/27e3HxJaRt6FSxDld+vn1cCnKltvcj29zkTv9+WzTNenHrTbO/JwlOP+C58hB
	q7wMyDHqn/5MJcaI9iarxSej8gskVhlrbj65xThDB55PYlieWHxESbNw2oYi0Mox
	oSycIrWq0jy3/YN6cuiJWupKUSjSBsnDPiSu9Q7tjJYUUBg1yupCttoRZmdMuodI
	5TKY/cq1yloLlZRdZGa8v2KLUDsIoyncUf4d2d2w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7wkc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:50:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VEfHHl024198;
	Fri, 31 Jul 2026 14:50:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgr57y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 14:50:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VEog3i17826200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 14:50:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2BAB20043;
	Fri, 31 Jul 2026 14:50:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4A5D2004B;
	Fri, 31 Jul 2026 14:50:40 +0000 (GMT)
Received: from osiris (unknown [9.111.39.121])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 31 Jul 2026 14:50:40 +0000 (GMT)
Date: Fri, 31 Jul 2026 16:50:39 +0200
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v5 06/31] arm64/sysreg: Convert SPSR_ELx to automatic
 register generation
Message-ID: <20260731145039.1016137-A-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-7-seiden@linux.ibm.com>
 <86bjbnckge.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bjbnckge.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vfPmpKOMLhAfiWmTk8SICmYmFgUzRJeL
X-Proofpoint-ORIG-GUID: 7dSkOPs6jV62dQ5msdvicZhLLQ6hkmSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfX/zzVQqF7gPiR
 2WETnBc7I2gDjPTDVBD8zUbin5HavD3mjFLxs0+F/VZaZAnEhb92if+tXXfD2XY8jU87s/Fgl9j
 Y0fSvvsrgxg3vPlEb1Tr00UOFKzBgP4bqLEu5lXOrU4k2V17fC3vsQuaR17Shj/a18nEStMQx9o
 q6kGldh7Wdkjh1mzj28F2mxjtF5KDHqElF1e+jGE6XZJTA+UyiwKJsem9A9jZGyRLAuUhxphpEo
 l55mm3oF41YWJuL1tPSUkutbQhRiAiVdcWp+z0eYR5Cwe8ZGf7D+Cmat8jTNQgaf8s0db7Fm2yN
 dEJJkemCouWZ3rwsMQG/WhknteyewD2AYuXHlCacLcS9sXY23NZb0KlZNu2BrDVPqeC8QMNv2XK
 o6PhTQJTWQvAp2jn8Gc25jAFXTNwQ0lppTMHxOlww8dfh3Sz7GBjBpuZ1xbIHmVe4m+nEOh9TvF
 OFogZb+lRfOkUdgNzyg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6cb64a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20fFOLQ9k4DZ6xVQLREA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExMyBTYWx0ZWRfXyIt6Pe3/YoLx
 OyclkoRVaTDoTkevi9+MoD2L5phRQYcisNLA8tDkqPtI0kO01F8/3MQ8EXyUDvBSCduhScdnuFF
 cmQQuITycm1WzIIghIVadacARNktt0M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310113

On Fri, Jul 31, 2026 at 03:17:21PM +0100, Marc Zyngier wrote:
> On Fri, 31 Jul 2026 14:08:34 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> > DDIO616 2026-06. No functional change.
> >
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h |  3 --
> >  arch/arm64/tools/sysreg         | 72 +++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 4bfdac9401bd..1aa601c95188 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -295,7 +295,6 @@
> >  #define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
> >  #define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
> >  
> > -#define SYS_SPSR_EL1			sys_reg(3, 0, 4, 0, 0)
> >  #define SYS_ELR_EL1			sys_reg(3, 0, 4, 0, 1)
> >  
> >  #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
> > @@ -518,7 +517,6 @@
> >  #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
> >  
> >  #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
> > -#define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
> >  #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
> >  #define SYS_SP_EL1			sys_reg(3, 4, 4, 1, 0)
> >  #define SYS_SPSR_irq			sys_reg(3, 4, 4, 3, 0)
> > @@ -604,7 +602,6 @@
> >  #define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
> >  #define SYS_TTBR0_EL12			sys_reg(3, 5, 2, 0, 0)
> >  #define SYS_TTBR1_EL12			sys_reg(3, 5, 2, 0, 1)
> > -#define SYS_SPSR_EL12			sys_reg(3, 5, 4, 0, 0)
> >  #define SYS_ELR_EL12			sys_reg(3, 5, 4, 0, 1)
> >  #define SYS_AFSR0_EL12			sys_reg(3, 5, 5, 1, 0)
> >  #define SYS_AFSR1_EL12			sys_reg(3, 5, 5, 1, 1)
> > diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> > index 7cb61aca3797..2a4b94e8c62f 100644
> > --- a/arch/arm64/tools/sysreg
> > +++ b/arch/arm64/tools/sysreg
> > @@ -401,6 +401,78 @@ Res0	3:1
> >  Field	0	SO
> >  EndSysreg
> >  
> > +Sysreg	SPSR_EL1	3	0	4	0	0
> > +Res0	63:37
> > +Field	36	UNIJ
> > +Res0	35:34
> > +Field	33	PPEND
> > +Res0	32
> > +Field	31	N
> > +Field	30	Z
> > +Field	29	C
> > +Field	28	V
> > +Field	27	Q
> > +Field	26:25	IT01
> > +Field	24	DIT
> > +Field	23	SSBS
> > +Field	22	PAN
> > +Field	21	SS
> > +Field	20	IL
> > +Field	19:16	GE
> > +Field	15:10	IT27
> 
> I'm sorry, but this is complete nonsense. It looks like you have
> lifted the AArch32 version of the definition, and not the AArch64 view
> (which really is what matters here).

dang. Yes, I successfully confused myself here. You are absoultely right
I accidentlially picked the AArch32 variant. I will fix this with the
next round.

> 
> > +Field	9	E
> > +Field	8	A
> > +Field	7	I
> > +Field	6	F
> > +Field	5	T
> > +Field	4	M4
> > +Enum	3:0	M
> 
> I don't think you should split the M field as such. The AArch32
> encoding uses bit 4, and should be described.

Ok. I copied the defenitions directly from the arm architecure and it
differntiated between the frist 3 bits of M and the 4th. (for 32 and 64
bit). I will merge it.

> 
> > +	0b0000	EL0
> > +	0b0100	EL1t
> > +	0b0101	EL1h
> > +	0b1000	EL1tnv
> > +	0b1001	EL1hnv
> 
> Please do *not* invent names. These are EL2t/EL2h, and cannot be
> anything else.

will change.


thanks. 

	Steffen
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
