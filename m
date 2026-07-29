Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72F3B058E;
	Wed, 29 Jul 2026 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337827; cv=none; b=JlZtEj8LMt7aEpmzOd1Q9Z48+vk0Z4eRA2e5Y0f/tuXXFqazRp3Pc26rj/pFUeKcU8OCPf7x9cCPD5gp8IU8h5PdDf//mS220+MtayZAkQ5nMaZ4KTRs7gsD708eEU5qdW8tDSPFiWChWpH7ccT7I1Uul9xqPcJjbhD+dV44e8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337827; c=relaxed/simple;
	bh=kaS/7DVujmTF+PbASm1u2b+N3ygqRLKL+UbU33lypCA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gGPs5f6xWXUOgoyxB1aMCKLYxNuqEtbZqw4aHTA9J2HH78o6CNDbzOcpsaaqjdLPXJ2lSHxjfC9qGnrcUnjfF5rFKmZ/RCMyzSKkhS8fXY/zGXUFJsI78cgwvet4h7uV9WMXwZO46Atrn9jrSDtgGbxJATpbEx3Ic2JeG/BqSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gHl6iJDh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gHl6iJDh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEmVlR213493;
	Wed, 29 Jul 2026 15:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=W5mOsOZ+CEyCjOwoCEaMmv3o3s45JpdrzL3ZiBhPA5c=; b=gHl6iJDhXgU4
	08a3FRhedgEPcVR7I7hmukQX6PVibf650yUJFPyfgLaV8zipRZj+BfRqAgSDuK14
	oViPEOibDERvGJMGLq85rWwmTvNU0KmfmmeqP8PNpTeJAjFZzGnfrdnric/7gsNR
	hQB2vFsIPVTX/eXoLm8N/MHxGLonMhJwEDBganuBLMeZjLwyxzXGsgvmWhc11F6J
	Jc8XYVt+iEWORPwyEcHAwFxV+2bK4XHYN93tc/30HaMbcCJz1r/sskQ4KyYgdQpx
	zzUGx2AUVU9MRg8Ph3e4V7rgdkUC8kSpZi46iG6FEzx7ishR+KqERwIA6Vv31Lt6
	BDajC1Schw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjahch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:10:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEuJGG030738;
	Wed, 29 Jul 2026 15:10:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqfd4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:10:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFALEk25821922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:10:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B218258055;
	Wed, 29 Jul 2026 15:10:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1752F58054;
	Wed, 29 Jul 2026 15:10:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:10:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 17:10:20 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v8 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt
 misc code
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729145251.92AC01F00A3A@smtp.kernel.org>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-2-freude@linux.ibm.com>
 <20260729145251.92AC01F00A3A@smtp.kernel.org>
Message-ID: <2fc9f0d48a38f5102d77a8bb9ad6c9d5@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXyPs3uyb1YJoZ
 hOte1pEVJs3mIyg2B0owMw3I0BuFDkoXdOC/OGqkAyTuTTrbwvyfaZqbTT4xl8N8t868NlfLGnS
 jMr8vsqm2Vp720h7o1dtSuv6bqN+F/A=
X-Proofpoint-GUID: MSE9YPN8L_CGJjOROOLdy8YauhzwFB-c
X-Proofpoint-ORIG-GUID: MSE9YPN8L_CGJjOROOLdy8YauhzwFB-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXyldqWoadxWcT
 cIdPQlRMfKVGHpp5Rlw7l/LW3fyWt5dQ3TelH4LglgcqGat9Og+38lvQMFOBtuzuzqf8VRtM6WT
 bmGKT/cZCU8GKj2TELiUPzh71v3HH3xhpVNSqLqvLxc4tw4ilTs+0kc6YvDxfqvl+MlKSy5UUab
 5N7Z9Q1tlHX3eXqAi72GyH2K6Q3gF9dPUPR1t5/mYWX7BZ+svo6fpcJFM/cVyURXFybX/B/XFfM
 w9bvwTQT8pYZ/vBnFwFrWr4XHq2xjdyqUmUm4MFZIpvE4oi1O62+bXzF84KLVFiBV/gXX+Ir31H
 XfPAApfQEmN4+YEvEREBGvQpk9fhzg8NMYBihPdWgPJjyGCRcpkzFh3YKi4lU9NC9bPoYti8tWE
 fu5XaHpsrhSOSxMcgJl5+QoI/14dMk7Mkz1Rcmqdrskhko8tYLn22lkDLBjyymTHOTiqvDoxXrA
 j9Oi0UmNzrWf/51M0AQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a17e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a0thUojPa2NhPUL91_AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290120

On 2026-07-29 16:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Medium] Incomplete memory scrubbing in `free_cprbmem()` due to
> missing 4-byte alignment rounding.
> --
> 
> --- Patch [1]: [PATCH v8 1/5] s390/zcrypt: Fix CPRB memory allocation
> in zcrypt misc code ---
> commit 8719946bc97657e1ca3c996d1d00474456aa0ef0
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
> 
> Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
> did not round up the memory allocation to a multiple of 4 bytes as it
> is needed by the zcrypt layer to process the CPRBs.
> 
> Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
> guarantee that the base CPRB struct and a possible parameter block are
> aligned to a 4-byte boundary and the backing memory allocation is
> rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
> updated and scrubs the rounded up amount of memory.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index 3dda9589f2b95..e604c100ccce2 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
>> @@ -355,21 +356,24 @@ EXPORT_SYMBOL(ep11_check_aes_key);
>> 
>>  /*
>>   * Allocate and prepare ep11 cprb plus additional payload.
>> + * It is guaranteed that the memory is aligned to a 4 byte boundary.
>> + * Furthermore the memory allocation is rounded up to the next
>> + * multiple of 4 bytes (with taking the payload_len into account).
>>   */
>>  static void *alloc_cprbmem(size_t payload_len, u32 xflags)
>>  {
>> -	size_t len = sizeof(struct ep11_cprb) + payload_len;
>> +	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
> 
> [Severity: Medium]
> The commit message states that free_cprbmem() is updated to scrub the 
> rounded
> up amount of memory. While this change is present for zcrypt_ccamisc.c, 
> was it
> missed for zcrypt_ep11misc.c?
> 
> Since alloc_cprbmem() now allocates the rounded up memory size, does
> free_cprbmem() in zcrypt_ep11misc.c also need to be updated to scrub 
> the
> matching size?
> 
> Currently, it still uses the exact unrounded size:
> 
>     static void free_cprbmem(void *mem, size_t payload_len, bool
> scrub, u32 xflags)
>     {
>         if (mem && scrub)
>             memzero_explicit(mem, sizeof(struct ep11_cprb) + 
> payload_len);
> 
> Could this leave up to 3 bytes of the newly added padding unscrubbed 
> when an
> EP11 CPRB is freed? If the cryptographic hardware writes sensitive data 
> into
> the padding bytes of a 4-byte aligned response, this data would not be 
> zeroed
> before the memory is returned to the allocator.
> 
> [ ... ]

Right, this hunk was on my disk but did not make it into the patch 
somehow -> v9 then.
