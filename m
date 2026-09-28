Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A24E534C;
	Mon, 28 Sep 2026 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610843; cv=none; b=qBb00aoOMsPvApruijzdoc+zfmbl76lQNyt/itGnWHt4zTbMudAYjfuv0FfxLt8p0WTDcsIQfe4x2g9rTsd5XVtMCOExCBxJSBYzGDNoBng1FSqrGIvKEiOVeFtctcxt67OykiFWiRy6MdDHRh2s0XE7P8RtMM+dNpMfDxXW4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610843; c=relaxed/simple;
	bh=NVtFynJ8KsAw/2yx2bGvGlsPGSZ1qQhJI4ugZ9fGnz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOCxNqbpkHEu7SsMOtOwzYYvL+POFr2TbuJ/iRRuDzgaPwXPNKKlIakDNj7Q6/vFYSZ6h/56TmSvcTHmff8hkYJ/RukbCaLmxgvRZXwYAKYgw7cYPkFXECvlR1fZU75nKzWCbIkOH4wGixaFcNFxFRZdLY1gF/GauKyu6fq4JVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nEd9jI6m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nEd9jI6m"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SF5URZ3815523;
	Mon, 28 Sep 2026 15:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VLDc/l
	lN13lUZSgqW0UV1cwNBVNzFn5mHU9k0O/KgSI=; b=nEd9jI6mJthJmt59GZ8Kg2
	olIXgtmbDEDVIYzBSsFY3XyzFr4ySb3NkgNnNGYfo3oltuNPllNxdG0gHQLlsH/H
	QZoOuCijUG/J5k4vOZEyk1gXekcKeEFo3EAojEcsTXmHIb60R/myKzXIs1VJo6XQ
	O0e9abItDpT483haENdm/PWnP8kaAn5lGJ2lt3B/0a1S8YL3mswQPuLv+f94IAWw
	U/FEJ/MMx7t6Pq3Y04W82qohdcCfdBn3FthHjlY1/zMJhZgeMtZBRBazw2kBd3MX
	rz+p51nORDPbcN08PZ12mrq4x27L6+iEAh4fh3DRxOQbf6bmhmioF34lSOysvwsQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr2e8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:53:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEleoc252320;
	Mon, 28 Sep 2026 15:53:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck5y4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 15:53:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SFrY9941615810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 15:53:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9B02004B;
	Mon, 28 Sep 2026 15:53:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D302B20040;
	Mon, 28 Sep 2026 15:53:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.81.16])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 15:53:33 +0000 (GMT)
Message-ID: <1e3b65b3-0c21-466f-ae09-8426eeacb97d@linux.ibm.com>
Date: Mon, 28 Sep 2026 17:53:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/29] s390: Introduce Start Arm Execution instruction
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-21-seiden@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-21-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX5IOLAQ1ypl/K
 KjNK6PnfBVYS+0nkqmog3tLJpLvxJM6ZvyCspTl/9oHY1E9yENoXvgUQS+8ZXERc/4ljr1ktcj6
 iz4G0b/EXOQtOrHCJAIjGiPzF+tVFbH5BtqIi3lqIyNvAaJGaTDCY2mPXe09meD6w5bpTYpLvtv
 1ypIa2begl4Ea/LrNmnqEdxhApFy+a6cuHTlrAkU95ZTwOw2PIUJzBmoKs2fxLtyEj+iVfq+pBl
 fd7DCSmcI0AdXSDpH5o5cdv8ocb+/Wdpgn482HGS18WYvp/IL+1OUZj2MeyGNndj2qV3oZH04uQ
 0+8WEJvxb6UdG9jjbcrAn92uN9UVwAiuEDxYHj8/uAxyZ/AjqV6qIRDfWiHBGKgCYlsrD0DduK4
 pTZktwRhz67/tOw/rFH0sJuQWh4yvC+m6hZhO7dA7pBJRM57JpohUYGoTS5aqY39RvV42hNBdzq
 WKciGdET8taUIQn19NQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba8d84 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=d-oHUx1cmsw_BqqcsnMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gCzI-DYnJRIhG47JVwT8pS87k7M5ioA0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX7aoz/WWt3x7T
 DYX5ffMGEY+FCJVk12ryEWaSnJhmoUQm9TXcQt+3yrU1dRmvkORfRYxlzk3wN0rZufi3Oyg4PT4
 xUZUKelvJfcv+VQc3FZeYFE/dp8dDHM=
X-Proofpoint-GUID: p67iJAw6OpNowhkMyzhw4cZIAv9bM6SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280062



On 9/18/26 15:30, Steffen Eiden wrote:
> The Start Arm Execution (SAE) instruction is the centerpiece for
> executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
> enable accelerated execution of arm64 virtual machines. SAE expects the
> physical address of a control block as the only argument.
> 
> The host is responsible to save & restore
>   - GPRs 0-13
>   - access register 0-15
              ^^^^^^^^
              registers>   - breaking event register (BEAR)
>   - vector/floating point registers
> between SAE executions to guarantee host consistency.
> 
> GPRs and BEAR are save and restores in the asm functions. The other
                     ^^^^^^^^^^^^^^^^^
                     saved and restored

> register are handled in within C code. Access registers are handled in a
   ^^^^^^^^             ^^
   registers            not needed probably?

> later patch and SVEs will be handled when they are introduced in a
> future series. Most arm64 registers are handled by a satellite block
> called save_area. Some registers, frequently used by hypervisors, are
> placed into the SAE control block itself.
> 
> Enlighten asm/kvm_host_types.h for the new header variant. The new
> header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
> is defined.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/asm-prototypes.h       |   1 +
>   arch/s390/include/asm/kvm_host_arm64_types.h | 124 +++++++++++++++++++
>   arch/s390/include/asm/kvm_host_types.h       |   4 +
>   arch/s390/include/asm/sae.h                  |  58 +++++++++
>   arch/s390/include/asm/stacktrace.h           |   5 +
>   arch/s390/kernel/asm-offsets.c               |   1 +
>   arch/s390/kernel/entry.S                     |  22 ++++
>   arch/s390/tools/opcodes.txt                  |   3 +
>   8 files changed, 218 insertions(+)
>   create mode 100644 arch/s390/include/asm/kvm_host_arm64_types.h
>   create mode 100644 arch/s390/include/asm/sae.h

[...]
    > +#if IS_ENABLED(CONFIG_KVM)
> +/*
> + * __sae64a calling convention:
> + * %r2 pointer to sae control block physical address
           ^^^^^^^^^^ I guess it's just a physical address and not a
                      pointer to it?

                      ^^^ sometimes it's called "sae", sometimes "SAE" -
                          it would be nice to have some consistency> + */
> +SYM_FUNC_START(__sae64a)
> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers

Strictly speaking we don't need to save %r14, but I guess you do this
for unwinding?

> +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
> +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register
> +	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> +	xgr	%r0,%r0				# clear guest registers to
> +	xgr	%r1,%r1				# prevent speculative use
> +	xgr	%r2,%r2
> +	xgr	%r3,%r3
> +	xgr	%r4,%r4
> +	xgr	%r5,%r5
> +	BR_EX	%r14
> +SYM_FUNC_END(__sae64a)
> +EXPORT_SYMBOL(__sae64a)
> +#endif
[...]
