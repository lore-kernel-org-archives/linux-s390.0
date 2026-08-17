Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D293BBFDD
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957397; cv=none; b=tVV648Laei8WmEhYrESRsUXEQAroLp1jhHrl/88C9ZrnpYTCigBq2YYE7EJHRrei6JQ/FH86C1jnvnczg8WPKWUWEiA8i/zlo8r0FMpaTo9CkHKOAXeAfxMuMLmIQTmpsZxNPmMkioPji5VPC8tRMIq+tTNQaCInySWyffuyXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957397; c=relaxed/simple;
	bh=7N46meXce7ITPQL8CxEwy+LJ2fPFZE9OnRA9DWM+X2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+yxioECC5MUA/FSRNzOpgV8yUQyC7VdYrmjnhfGhuuN3yfXLRN/gkiIwQb1UMoK2EgxZ0+wM7emogtNcm9/G5RNTRBXGW8ohICAQUqLYGtib+ojoecgTPzWlnunD37RXSxLM/StsjxuiCNHaWyhyBdUM82mXd09n+Fr7um2lpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FxxTJMDx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FxxTJMDx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVtf53636306;
	Mon, 17 Aug 2026 09:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yeWnVt
	VTz89MJpF//teU1pDJjrrUDlieDgYwlcmm8n8=; b=FxxTJMDx67OGeIjOSj+z5L
	S2pVUYvjxDwEvYvoYJ33NTalIUtQNF49GB4cSTECro0XevQxDfEoOJquVdiJbF05
	B6XYi+FzOG9QYOzt1Ozgd3cY0Baij+lBD3OhgEP1LyaS2vWOAK5W+ReTTJyEn+fI
	E29IpO6Hcc5Z4wkkOOfM76m+VfaRQ7qstGNhnP5gvmOJZoLWf4u9CmAraX7DNvJC
	UAGMgtD9Y+tvev7jKQPMOEjgAZ4kCz/I3p1E1lkuTfdyqsxkegRi6MIJyBwa2eAP
	1S80bi8a1+dHGW7fIHq6eDCPpzkiC92q+PYC1usiVTALgq1TPKhJMolwnZuBj4cw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhksdc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:03:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8uIsi023709;
	Mon, 17 Aug 2026 09:03:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epwf0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:03:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H930Au40829328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 09:03:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B240B20040;
	Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FFB120043;
	Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 09:03:00 +0000 (GMT)
Message-ID: <733152db-5b26-443a-b1ac-5fc1886f60ab@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:02:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/19] tests/tcg/s390x: Add tests for CPACF
 instructions
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-20-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-20-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfXxVzqd8MpQIJx
 F3w9OlOQlTEmWIvz/M5FrS+SqdDNKq8g2WNM+mbgF57jvfyDQ7k7PIh54feHA30BTzU4gBEv+UT
 6P+3atk0lFObciocLn04g8LnzEOzg/hl0b/ZlZ+XHm4uZlpE5B+E+BK/HHVk3SpgTZYW5XkzNWo
 qaUAiRsJsg657sgJWeXm07rnMdrBKa1poYmRpmWrlae7ydvm8+FYP4sd/LdfEZltbhVspYV7gpg
 niwxC1Hj7vngvKJ6dvE/bTnZQAGQ1gf5MiRkP+WvSvLhasGkWALZ13i+IVUEXbqk5lvSpgTyonl
 JFmUS4VbUc5ocstSY90iLvOMEZwc8x/+OIhYO1IJp+JdcX5lc0oRG53CtYxVTPQ8mQ9erHBo3XE
 uM2KrmWodNmEYaoK49xYYYbvcJo3zK7O3x5ujswfEy+uK531jJUt19CVcVzyPVD1CDZOaR1kd0k
 gMy8QhdK2xHZZglzNTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfXz8KRzDi7u95f
 ybFvweBFxkoOyY1UMA4PT4EhS7ac0e2xklRqGtOHbxI2JPymzY6xpNfacOM7vOd763PiwlWdIxK
 X7T6q9gv5Smxcs8hMzVyBtRi8YKiuCk=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82ce49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=uJYxwXyaNrLBgnZ-awYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4E-Lf6DwPzM7j-bu9Sj063Bf_pJxxeAt
X-Proofpoint-GUID: 4E-Lf6DwPzM7j-bu9Sj063Bf_pJxxeAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170067



On 8/6/26 17:13, Harald Freudenberger wrote:
> Add simple tests for the CPACF instructions implemented:
> - kdsa - minimal as only query is implemented
> - kimd - query, sha256, sha512
> - klmd - query, sha256, sha512
> - km - query, aes 128, 192, 256 with clear and prot key
> - kmac - minimal as only query is implemented
> - kmc - query, aes 128, 192, 256 with clear and prot key
> - kmctr - query, aes 128, 192, 256 with clear and prot key
> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
> - pckmo - run query and check for SIGILL
> - prno - query, trng
> No test for kma, kmf, kmo as these instructions are currently
> not implemented at all.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h        |   7 +
>   tests/tcg/s390x/Makefile.target |  10 +
>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>   tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>   tests/tcg/s390x/cpacf-pckmo.c   |  45 +++
>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>   tests/tcg/s390x/cpacf.h         | 571 +++++++++++++++++++++++++++++++
>   13 files changed, 2798 insertions(+)
>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>   create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>   create mode 100644 tests/tcg/s390x/cpacf.h
> 
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index dc29834cf8..2f0cabc85a 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -223,6 +223,8 @@
>   #define CPACF_KDSA_PSIGN_ED25519   48
>   #define CPACF_KDSA_PSIGN_ED448     52
>   
> +#ifndef CPACF_H_INCLUDE_FOR_TESTS
> +
>   /* from cpacf_sha256.c */
>   int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                    uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> @@ -254,6 +256,8 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>                     uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>                     uint32_t type, uint8_t fc, uint8_t mod);
>   
> +#endif /* CPACF_H_INCLUDE_FOR_TESTS */

Could you please split this header in two instead?
For example: cpacf-arch.h that is usable from both emulation and tests
and cpacf.h just for emulation.


With that:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
