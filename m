Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C674E3239;
	Mon, 28 Sep 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612665; cv=none; b=NwFLW9IN1A/VwvLoUq20M+YoGrTAkWBxYavAmenFLqC04eKHsMktC6jEFMfebAZGLCksBlbC4/L38U5trwdrbQpurWLxBFwRrzspRcwc2meTuzJy4bz8YperQbne7RQe9K1iHX9jw1nmVY+TmMY+d52GmuQDem5xHfu/fjo4ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612665; c=relaxed/simple;
	bh=CKeGjsBriDwViMhek9702cWAOUseeZZLcgTO2SXicOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4/N1wGxCDefY1YPee8nTSrnUjs38IA9vdDnxuNt3579vR6IBHqKGZGmJMycjhfLQYF50ZONRpB4KxkV9J+qrDY/+eU6iF0/FoM8bQ1FlrK0nhrGqEz6M7xh2zbqvDt/2En1wXOaaHrRsbDwOFBD9rTYTnRgc7vstKhVU2tg7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nocdA3SQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nocdA3SQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5XIH1487752;
	Mon, 28 Sep 2026 16:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aMlVso+WQlUxjaoq15heyETXmqcWCb
	Kin55T9fbrSgQ=; b=nocdA3SQ77snM0bDlUJRP91SkyyMLm0VV61jcE0Id5Anjz
	f0JiP4oVF6Eo2Iitwne7oYHypeoy9dN6ROCSwVEeraqhkOuMmNNuI3TCj/mA+DKV
	nxCke/ykpujigtSQelvIKlGC4robSUsC7hUztvakAJ0VJck0ZkWT767T6ffVQtDf
	1yHRGM+4cWOx591QtxR3iAQS7odDG592qKe0CY1Q0iJ4jTWi3DI2pYWdaDDaXMqW
	xKnbw/YRbVq487wKTPVsEfRUEerYY1vwsRt6dPxfDKVVt5oXmEMwtZcoESt19+Y/
	78fNlSHOt1KZ7M+WaWwVKeu3me9rs9WpZ6nCMZiw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j52pf9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:23:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SElaIY3181836;
	Mon, 28 Sep 2026 16:23:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg5vt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 16:23:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SGNmeS49217796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 16:23:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF9252004B;
	Mon, 28 Sep 2026 16:23:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 057B820049;
	Mon, 28 Sep 2026 16:23:47 +0000 (GMT)
Received: from osiris (unknown [9.87.129.112])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 16:23:46 +0000 (GMT)
Date: Mon, 28 Sep 2026 18:23:45 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Message-ID: <20260928162345.428362-C-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arqQ2Eat4VUBbl49@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3B1A1lovMjXN
 XvN8MDt3gkZkAj2DeazXr99aqg/pvvxIi70ZifPjR0fSGd7A9lQLC7HevLJceIO+o+2Txj/RYwS
 Gymfkwk2yUOIfhuo/fsgLK37gzdmP3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXx1urNdwJzkRD
 KBCa1ci283x5RHFf7HaCoETm7yx7SoMQFoX4mHZ0Y8cvkAHubFPn7fSGl/1t3WD6h5izGshb1jG
 pP49z0EGpHyeYpRoSaAEtKnr8EsBCTgQ1bIR1UExnxWaSfh3oO2SWqaQgwBXnVFFu7IqjaKNDAu
 toIt3eEUvWUiW5w8eEwGq3IfYY0vfqeWVrYZmdHx8Sx34f34GlXTgSLGkmGOY6EM3DVCazBybKh
 yFraYLolu9X5ahx3SE+a22MmSlrIuF6gMB/pBVqZ/49gzlDph4DOtfCPQi/Qjfw/kFZq2ghFXA9
 WB9gqDFLnZJNLuQ3z9vFVxurzozeL1DSxLRRr//k56IsPT+H0NYNyI+o1Qw9c2tdsaLx7RBwcU7
 wRI/voNVZHT+8UaUiuZxPwz6iqlh5xW3kN2bx9+tX/M3rnl6E3EFudM4GpHjmynxzclErclYZOp
 10rjHZDNyNWgd/tD0Zw==
X-Proofpoint-GUID: WOYeyJUxL43avsB7fNw_yFi0pq8QEsMq
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba949b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=6naXMVt7UYLB1SMyOlsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4ZGl1YFWqUOHofkVATNx10Qj2uFXn8Aa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 6b005c8fef70..12cbad460258 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -45,6 +45,11 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
> >  KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
> >  KBUILD_AFLAGS	+= $(compat_vdso)
> >  
> > +# Enable all code shared to s390
> > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> 
> Do we actually need these defines? They seem only to be used as markers
> for the awk scripts to extract the definitions. Why do we need the C
> preprocessor involved at all? Could we not just have comment markers:
> 
> /* ARM64_S390_COMMON_BEGIN */
> ...
> /* ARM64_S390_COMMON_END */
>
No technically we do not need those. They could be useful if we find out
that AWK is the wrong tool and move to a C Preprocessor + diff based
approach. 

if the ifdev is not closed the compiler will complain, but an 'arm did
not destroy us' verifiaction tool ( I will send one soonish) could do
the same.

If the idfef thing is a no-go for you I can use the solely comment based
approach.

> (also the CPPFLAGS definition was enough, it gets copied into the others
> automatically)

ok

> 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index ab205f9db94a..1c5c4df260be 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -16,6 +16,8 @@
> >  
> >  #include <asm/gpr-num.h>
> >  
> > +#ifdef ARM64_S390_COMMON
> > +
> >  /*
> >   * ARMv8 ARM reserves the following encoding for system registers:
> >   * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
> > @@ -50,6 +52,8 @@
> >  #define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
> >  #define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #ifndef CONFIG_BROKEN_GAS_INST
> >  
> >  #ifdef __ASSEMBLER__
> > @@ -123,6 +127,8 @@
> >  #define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
> >  #define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
> >  
> > +#ifdef ARM64_S390_COMMON
> > +
> >  /* Data cache zero operations */
> >  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> >  #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
> > @@ -832,6 +838,8 @@
> >  #define SCTLR_ELx_A	 (BIT(1))
> >  #define SCTLR_ELx_M	 (BIT(0))
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #ifdef CONFIG_CPU_BIG_ENDIAN
> >  #define ENDIAN_SET_EL2		SCTLR_ELx_EE
> >  #else
> > @@ -866,6 +874,7 @@
> >  	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
> >  	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
> >  
> > +#ifdef ARM64_S390_COMMON
> >  /* MAIR_ELx memory attributes (used by Linux) */
> >  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
> >  #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
> > @@ -1102,6 +1111,8 @@
> >  #define GICV5_GICR_CDNMIA_TYPE_MASK	GENMASK_ULL(31, 29)
> >  #define GICV5_GICR_CDNMIA_ID_MASK	GENMASK_ULL(23, 0)
> >  
> > +#endif /* ARM64_S390_COMMON */
> 
> I haven't checked them all but there are a few definitions in here that
> depend on arm64-specific configs: e.g. GCR depends on KASAN, TGRAN
> macros depend on page size, PA_BITS_52 influences some other values.
> 
> I think they should be outside the common definitions shared with s390.
> In addition, the awk scripts should reject any CONFIG_ (or at least
> CONFIG_ARM64_) lines in the copied files. Ideally report an error rather
> than silently masking them out.
> 

Upon Marcs request (and to keep me sane) we deliberately share more
header stuff than we actually need to
a) keep the number of shared regions low
b) have fewer prepare changes moving things to satisfy a

I do not see an issue if we have a few things shared that are only
active on ARM due to a CONFIG. 

	Steffen

> -- 
> Catalin
