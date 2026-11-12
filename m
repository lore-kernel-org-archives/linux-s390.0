Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483594;
	b=ApvJEHWyiHIa3FTM28LVrLTk0MPDmpn5Fwi0aCC/3ZMAr2vQVGh8EBHu1z98wX6WJlcu
	 Xt0mg9qa0uhUoBBeiQmx9YYjXoPlavyGqaRHOB9qovdzqQIDdlWZz/9GAjQY0u+XDF97E
	 kT0UDe/5xXup5Wytm5OQ4bDdnZhSU9sfZHPW1hZQvUw8kT3YR7SkOV7i80VYY3TLCmuIW
	 SPL8/ipjHxdc70tvHwJtF44qBBxdyvNMnc2RrnBuFvxSXi2s2GcEtcwRLFn7C3jdguN4T
	 3LvxIYmkP0rleedELlncCWR65odY7JtfdH3vDq7Ql8Qpgu4d1CD/D95iF6ZeMaMl0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483594;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a8r0GCkPJ/Slz0ZSm+mqu84I1prvStukMVZF1rmhO5M=;
	b=1zwK+vlXw1gs5bAQPDBN/Oiyd2/x7ENq1NDM3EaA1mpOaf0pKSkvcgWpOsClRo82gj9/
	 f7u96RPmXbvqT/dURw/vNPuVz+nu+7dbelSFZj0DbaF2ZdGDvN5QjzdkVDRv1sVjtmA8V
	 UCd53JVvSvjpTi7oeInX57QqNUemd6a1t7Ejsak2WMb91sIlaG/jbO3ld5I9PUQKlYHHk
	 2wtozvVkpJ0fJ0gIYOOj+BAqBDkeData3DFn3JGNOAgCwsQ5u2CR5u0qXUY0pT+qhhWUW
	 tOZ8MjOOqL5wZEdxm5LhGaBWrXKXXo3cchDOtosRBI8AWkqANwr6uY70oIbA0OqmKJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=der0ByUY;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8D606A331;
	Thu, 12 Nov 2026 11:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C8D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=der0ByUY
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2j9xs2857162;
	Thu, 12 Nov 2026 11:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a8r0GC
	kPJ/Slz0ZSm+mqu84I1prvStukMVZF1rmhO5M=; b=der0ByUYwcTXrPjPXxVn4X
	ApUAnDz3Iq4iKnmrWXRuIfS66RjWgqsyyhU1pM4aGz81TcC4gjy3opI3SmEXTvGI
	uf/mde7jgxv8i42Mx8PuI1p7NrWSA0EJfbKysjDIj1sHLtS9GHcsBDbDSWrIH8TO
	XIRFcDyzGcDUzkFRIztAFfIx4FMDYp8W4J4otdmabDepM1+I2twnLnGhqPzSka1v
	cry4MSb7WRTfDBHPrh2kOnD0m03VAmxOEwfM2zU7tONwm+dWdlRM6vgAEN3rY9xZ
	5JNTndShGuftJgBlXuTTMz+noChOppG/SJbYzaalvK+i2M3b51H6KjGFhHSDIwgQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq773tc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:39:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8QibM097816;
	Thu, 12 Nov 2026 11:39:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0w3cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:39:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBdkpr33554776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:39:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C436E2004B;
	Thu, 12 Nov 2026 11:39:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56DD020040;
	Thu, 12 Nov 2026 11:39:45 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:39:45 +0000 (GMT)
Message-ID: <05e31641-158e-4cfa-94b9-464d294d56ee@de.ibm.com>
Date: Thu, 12 Nov 2026 12:39:44 +0100
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
Subject: Re: [PATCH v6 3/5] KVM: s390: Fix idte_crste() clobber and table type
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-4-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX/J0M6ntrNm/J
 A67DJEabFrLkzbsvXEZ5o3ZgRLMBTTQeUa/7Y52gA/XFXSyFJ7TdUPyHvbPigIY2qQMuLjqu+TN
 epJmfJsuRLeeULj76F4iOzgYyYDcumU=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af5a588 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=G5FI_Z7t-7XGJ5nj1RcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0ZQ_luWxBEi_c3i04bo-_7Y_Pp1JhYxm
X-Proofpoint-GUID: 0ZQ_luWxBEi_c3i04bo-_7Y_Pp1JhYxm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXwaS6zTIFbnVE
 t4pMmiEOCCmgUPg3HXYzL9th+n6D6EzO0aqS0SPj/19JNWOrSWLqeFFNIyc0lEZVcVCmknP55LX
 g4XVUDo9CSDvvrLeuclIUVkty4HwzCZiIBJapakZ3d0frBEWKK+CSaG20Am250H0s/nMRd0moDI
 CVrLPvi+UVlrmUXhKMAxUAx0957VVHw8u8NX1K44dkuHYdcZudZb6oYUhM2/5sosM+lt72zGJMm
 DQnbT554HHhXJjhEJnYFnUMn6flSmmjisyd3P2GF05Ulz8DC3nD9Lx67Vefu85qhJX7DrNc/4QG
 KUDAhZXa7MhH+jjVtijZqJAdWcE1nv6GhNJ/QQcSOCM2DDdg1CY2m5I4idunXFtrK/bguzTWejr
 Aeuwm8TzdsGS5QKL9T6mAcxC0lJ2RhRAGKYStTt0vvi1PKyZ/G+8B+1Wx6FhBIH/5F81oI5N8Rs
 sM3MI7AnUsTGsHoZX8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120044



Am 05.11.26 um 16:37 schrieb Claudio Imbrenda:
> Fix idte_crste() to add the missing table-type bits and the missing
> "memory" clobber.
> 
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.0+
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/gmap/dat.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 9cdd1f122d7a..79efc56710b7 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -646,20 +646,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
>   	unsigned long table_origin = __pa(crste_table_start(crstep));
>   	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
>   
> +	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;
> +
>   	if (__builtin_constant_p(opt) && opt == 0) {
>   		/* flush without guest asce */
>   		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
>   			: "+m" (*crstep)
>   			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
>   			  [local] "i" (local)
> -			: "cc");
> +			: "cc", "memory");
>   	} else {
>   		/* flush with guest asce */
>   		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
>   			: "+m" (*crstep)
>   			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
>   			  [asce] "a" (asce.val), [local] "i" (local)
> -			: "cc");
> +			: "cc", "memory");
>   	}
>   }
>   

