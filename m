Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608909;
	b=06naJi/O6KN8aJVq63Q0dfBzdvDHva6v0IM07+zjZ97I7LUJ8WZYjLJv+88Ga20xERuh
	 uJ7tCKSInZK6vG0F6n9ipmNTFS2s1TUp3l3yIaCnbLofGcpRmCHqbhnlZxmpMdJQLBtMO
	 JCKD2XA0TkQWlREvkSwoMd6jiETLBCiC2GXbcgCbcuf8rW5UCkGLSVNZQWlGY5YTI5lzi
	 GoH+71vktEosAFyqEVAqpBkO+cK0IAhedJJJRqm16NV0t/3UOMHSBXsSkBVRKEEV0yAzn
	 5YJ7X3CCtPrWgVdrnmdCaeGlcDUpL0EA6mG36dBxZjxmf1DsPzHlZ9cd8WMNv5+oBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608909;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=TYp2bDJ8pP9dKAkvlU2tO/OGYv5ZQ//lb3iN0JKuFWs=;
	b=0+ObmEMfgFJh3GXAoaVxVDkVaYIvWUeReX71+XEE1KHF2Vs0AswSPCD0CZdmSBncQEm7
	 kMCijDieiL4Z931qNlQcom/TeuJSjahSTXbvpcsmjk8B2I24oXOnyRCG9zNMtKSO2td+J
	 imbtsyrw4zHXgli0gEY6IoVuz/7R5UPpT5SbkUqq+bPrubWskZx16XaJI199bPQnsO2wf
	 jz+AgyaEvlX9cGSgGkrA8v5Ke8tH4leOGRJHudA+1cV8L1axomMW+cn8JpK12gpU18pnC
	 P2CBq/3s8wz25znNsyPFaPA0VoLvSEX6oF+mAIenSs8x2kJ9jxQIq6VAQVTjgbYIO5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S4a9BYyF;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA020606A330;
	Wed, 25 Nov 2026 12:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA020606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S4a9BYyF
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4ftq3596886;
	Wed, 25 Nov 2026 12:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TYp2bD
	J8pP9dKAkvlU2tO/OGYv5ZQ//lb3iN0JKuFWs=; b=S4a9BYyFk0/f9g9DJmWgJx
	GIoT5nj7Z34pSON8AaMuAH3xHr+CAa2jDW2VD6lMQe5eZsnVk6tnO6bkVxAdLEHh
	mqvblr6yHh7LIy6lip2QA6d7wdBl9+YucPRQ5RwHc/98S2ZPtCGqLW1ZUda2Evgx
	qFQvwt04yJKdtXC9Khx6IMQT7LC2gMWLfG4YdxF3QzjV71KVU51A7U/2BHeVVjPf
	YWVHPv5MtakSQ4w4BCJqxJepY5zJ+s7KtY+WwG0q8LiPSdTur4TPjMk5uLWFLRgt
	pXHehPyC7BDN07DdBBpPqj6bpho4VtEPMtWL9FQlGg5PbQQuy/yR9o1oAuoTKpbw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3ccu6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:15:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nWRn3650118;
	Wed, 25 Nov 2026 12:15:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa21jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 12:15:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APCF33w47841660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 12:15:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30C992004D;
	Wed, 25 Nov 2026 12:15:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FF220043;
	Wed, 25 Nov 2026 12:15:02 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 12:15:02 +0000 (GMT)
Message-ID: <f243aa68-5b4c-4dd8-acdf-4a57a090b2a2@linux.ibm.com>
Date: Wed, 25 Nov 2026 13:15:02 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390/mm: Add ptep_ipte() helper
To: Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261124135948.1295745-1-hca@linux.ibm.com>
 <20261124135948.1295745-4-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261124135948.1295745-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b06d14b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=c9EG_qTls1SWuyDDofsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0OCBTYWx0ZWRfXzwtQq3MQYGLn
 B3iJPKszswUPj6cCn7VxpuQfPtigjuiiTBaJA9NnU2MIDNUvVtjsVKy/Vy2E8CD6hYDKid8fbZJ
 xiy17OlZwqOuQEI+BuCxLakglHbaLrk=
X-Proofpoint-ORIG-GUID: gKrdrGhC7IfAb-ipe0AvoLYvvZWPCe2L
X-Proofpoint-GUID: gKrdrGhC7IfAb-ipe0AvoLYvvZWPCe2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0OCBTYWx0ZWRfX0LUPepZtqDxY
 nZtFF8qR4E9Dkc8VRQs/1mG0eTnu269AKqEQQimJ2giHgLWhGH4txNss8UGtMQ/A4njRhDFg68M
 Jb4dBZceT5AmuJFiuc2E+C/foY4PI0Mh7wfbL/91KGfo9eb9TvM5KA3A4MW0EKZ57rcem5ULTey
 eOjBUxpKz2JN9IM7OY0e8hEXtxauwV9vX2UWKaIUBUhcGYXv2zIspAslnjzU2RuA5UrU9IblNQI
 6SsFQfW2VMyVEx16VPGWyzdxa6iJqvfeaIwa6PcMdRp762D0EeSsCDdyVwt/3scLgO4ZaWyQmMM
 CBRQB1w+QBIP8WLevzhE5Uudr2HaJgjyHoOVpnDyUvpcit+NAbXF+VJrLdCyOs74M4VtwFnbmfZ
 LRZm6R9sQ7kqILUN0rZpUhOGohRpMi1WQre3L4CiASA4mMpQZVggWwGKtLk7uqUTCRFxG8L1St1
 vpXepnB7csh1UTd/Wgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250048



Am 24.11.26 um 14:59 schrieb Heiko Carstens:
> Add a common ptep_ipte() helper in order to avoid the
> repeated machine_has_tlb_guest() checks.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



> ---
>   arch/s390/include/asm/pgtable.h | 11 +++++++++++
>   arch/s390/kvm/gmap/dat.c        |  5 +----
>   arch/s390/mm/pgtable.c          | 10 ++--------
>   3 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2d5c2ab06de9..378d2db6e6be 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -21,6 +21,7 @@
>   #include <linux/atomic.h>
>   #include <linux/mmap_lock.h>
>   #include <asm/ctlreg.h>
> +#include <asm/machine.h>
>   #include <asm/bug.h>
>   #include <asm/page.h>
>   #include <asm/uv.h>
> @@ -1156,6 +1157,16 @@ static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep,
>   		: [r1] "a" (pto), [m4] "i" (local) : "memory");
>   }
>   
> +static __always_inline void ptep_ipte(unsigned long address, pte_t *ptep,
> +				      unsigned long opt, unsigned long asce,
> +				      int local)
> +{
> +	if (machine_has_tlb_guest())
> +		__ptep_ipte(address, ptep, opt, asce, local);
> +	else
> +		__ptep_ipte(address, ptep, 0, 0, local);
> +}
> +
>   static __always_inline void __ptep_ipte_range(unsigned long address, int nr,
>   					      pte_t *ptep, int local)
>   {
> diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
> index 7a25e41a1423..909d665a67a9 100644
> --- a/arch/s390/kvm/gmap/dat.c
> +++ b/arch/s390/kvm/gmap/dat.c
> @@ -173,10 +173,7 @@ union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, g
>   	if (!old.h.i) {
>   		unsigned long opts = IPTE_GUEST_ASCE | (pgste.nodat ? IPTE_NODAT : 0);
>   
> -		if (machine_has_tlb_guest())
> -			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts, asce.val, IPTE_GLOBAL);
> -		else
> -			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, 0, 0, IPTE_GLOBAL);
> +		ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts, asce.val, IPTE_GLOBAL);
>   	}
>   
>   	if (uses_skeys) {
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 1aa5fe0b30d8..f6a960f39abf 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -38,18 +38,12 @@ EXPORT_SYMBOL_GPL(pgprot_writecombine);
>   
>   static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> -	if (machine_has_tlb_guest())
> -		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
> -	else
> -		__ptep_ipte(addr, ptep, 0, 0, IPTE_LOCAL);
> +	ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
>   }
>   
>   static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   {
> -	if (machine_has_tlb_guest())
> -		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
> -	else
> -		__ptep_ipte(addr, ptep, 0, 0, IPTE_GLOBAL);
> +	ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
>   }
>   
>   static inline pte_t ptep_flush_direct(struct mm_struct *mm, unsigned long addr, pte_t *ptep)

