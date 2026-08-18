Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67287451980;
	Tue, 18 Aug 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049180; cv=none; b=izr4VtsBqVBBy4Mex7Zs265kFEE53ay5a+omWpdBJlwiZKrAz6P1m0JN895Xw4gyf4hAuyCEvbboIlHCPrdlm9EW/M1UTzq27b9h09Hxs9+CNh8J1dTh/pCdYoamPyBDmL/qoqYchDHKMjVHEovZCZi11L0N/YuwcKbRSn/M/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049180; c=relaxed/simple;
	bh=bEVr771Fp6ErIecYdQly0FOL88jGN0M/9m7YWEXkljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWyJCSmdxMtflqNSMtezqx/Kromkhga34NJYlujESM6TeBL9BglWDC7gziAA+lxELIVn4DKfeIdLSuxVui88Ny2UkMLxG2UayB8bSV22dER0lAbD2hpL9WDuFxQZimHL5eVyrBitbodPpxG3iMfZYzPHKjFgNaWJbs8nTVqijjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpiN/h8g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpiN/h8g"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I9o9fO2526480;
	Tue, 18 Aug 2026 10:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sZ4pw/XK3onHnxHvvY9dq2qMv8IvN9
	4zcW6LPt9RemU=; b=fpiN/h8gIPlnD3ffIBsLBO+0BeMAK9G3cowJtmWTOcMHAa
	FZtzRcGToNfDJHgGHJWw2MI5IaV58bNPaFDMTQkvHWOOJ/oBA4EZvaLMo/n4beZr
	cN5kTTRJs2tut7sECZmQvK0v3C8neYy82okKscV0Vt/3GkWV/p6FGuGbPrYg5aIC
	ZecXg8BFR+uPig73SUh5pagTZGbUaI4PWLRL++OdX9p5j4JABpwm6NuLRY4RIdpl
	02aOXGVNhf9P5nhdVnQgR5CStPUFAHE7kmcp0lvUWXEoJfsaCtzPfWdFk/CzELH8
	mAoMcMdwiukRMWmqq54JxOH9gFgGtGIElwPxeViA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkye5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:27:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAQLZq019030;
	Tue, 18 Aug 2026 10:27:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek2py3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:27:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IARSCK37814680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 10:27:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42BBE20043;
	Tue, 18 Aug 2026 10:27:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D64E420040;
	Tue, 18 Aug 2026 10:27:27 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 10:27:27 +0000 (GMT)
Date: Tue, 18 Aug 2026 12:27:26 +0200
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
Subject: Re: [PATCH v6 06/33] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Message-ID: <20260818102726.21865-D-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-7-seiden@linux.ibm.com>
 <86cxvm1i27.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cxvm1i27.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfX9fAfNNXfrBTV
 SJ3ap0/nUsTFi2G3il2zTaSsux0NT/wJ96Qb1m5LhL71D9/jePqSD3GYwWLKd0OxW0d0TzdM/ga
 6c2U8K9yt4/DEshXG9KmAnHEnrs8w8vQ529duwSqri4Cuo2rIpuzDbk+6s4WeAqKYC5z21/UkNn
 RzDQJ7df7L4ZibHd4Ot1dUk0N2lQmukAHmQPUoXdAU/zBO6ucyIrf6+obgGVQJQUtNjqmJTdElC
 Uxuo56JHxwmqtc2EIIqprCFqjCnRqSYa/pGQzuhSy648pOlWaiT8FKM+HKp+r8USmg+O18ll+FI
 ewli/db01+cmS58Nqz11diuVZwbjapeYySkFHBGfwc9fHjFisGvHZdBbw8Ls2w8LnvMspgyY+1k
 btKOv8diNNHhhQikittXUD4VdhhR25ld3mLugjq8HSs+mhpY3GgQ5Mgbx4za43e2MXN0U1rHr9l
 rNukHlruTCS4S+NVsBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MyBTYWx0ZWRfX23UAfse85xwU
 SyI8zP92O0tRHw6tmFSikwZBBERKU6PLjb03RFbCdDrHWgTlCDYlKJYm23odi/Bdy91vLpFxUwf
 aqESyLkjQKAz+AQrs1aySXx5DrE+BKs=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a843395 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Zt0fK77-MjUkHxfXvCQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: S759Y-c2gQVVWiTgZ8-PqUPUtxL5m9VV
X-Proofpoint-GUID: yzzR6Eo0scx75FyRV3-iHmuguSWB8vKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180073

On Thu, Aug 13, 2026 at 10:33:04AM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 16:36:02 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> > DDIO616 2026-06. No functional change.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h |  3 ---
> >  arch/arm64/tools/sysreg         | 48 +++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 4bfdac9401bd..1aa601c95188 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> 
> [...]
> 
> > +Enum	4:0	M
> > +	0b0000	EL0
> > +	0b0100	EL1t
> > +	0b0101	EL1h
> > +	0b1000	EL2t
> > +	0b1001	EL2h
> 
> I think you need to be consistent with the way you represent things,
> as you are mixing two representations:
> 
> - either you have a separate M[4] representing PSTATE.nRW, and then
>   the M[3-0] enum is a 4 bit field (and for simplicity you only
>   describe the AArch64 ELs including EL3[th], which are missing here)
> 
> - or M is a 5 bit field and, and you represent everything as a 5 bit
>   enum, providing all the AArch32 modes and EL3.
> 
> The former matches the JSON, the latter is closer to the
> representation in older versions of the ARM ARM.
> 
> Pick one, stick to it.

Ok I'll do the first/JSON approach: 

...
Field	4	M4
Enum	3:0	M
	0b0000	EL0
	0b0100	EL1t
	0b0101	EL1h
	0b1000	EL2t
	0b1001	EL2h
	0b1100	EL3t
	0b1101	EL3h
EndEnum

	Steffen

