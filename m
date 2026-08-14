Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BE279DC3;
	Fri, 14 Aug 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715694; cv=none; b=lJVxcJ70tFTM5Ymn5q+1f9NJSWRXiZibeW7ZaYXwvH5DBa71Wm03rtTmyW/NdGHgzbUCcc6UC/uxodGVbdkI1m97GxLtXSx3O4BMGvAFMVK+xf/EXMTOU40Gf/MSkZqIJ3Z5E7B+NNXWeHmcwelQUyUv0SERJbcFaDNCjgshfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715694; c=relaxed/simple;
	bh=grB5FPZ9Eww8d8ehQXaPRsZdh4rDSUGIjnyat0kHqKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoadvSFx3g+Bg6iF0YRfqu3eBgYJnmEMIIhnW566AhJeHhS2QDOLaZw6JNCBNFRcq9ijrnc653O0dB5ImbKt6nj7hVPFPwUkVAFrtaRkDzlJfr49krhiB/5irujVty74wzQ24/9CUunvr8l899aWoyw8grhPtLAHva7Pf0fX7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S61SNTyG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S61SNTyG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1hx0984592;
	Fri, 14 Aug 2026 13:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QndIn2
	0mdSm2sCH9rzl9NEjt/OO7WWG1ZZNLQPS9EJk=; b=S61SNTyGdm2Sx20V5wQqWQ
	xe/hOOHqPeNQUv6pQpijJzWZrFfPnUKRUVPLACohjqKuYQJW58LxmbcWnnqXlHDL
	RrX2wtaz4Fg/jLD+3ntI/xbbdHHO5tuYn308d54EohN1xmcCvsqE4E/vH9KuJ9bU
	jilVzSA5h6qcDYzqTl1sC/2dZDW5fkw5jf3vHPqVEhcFvx2aPytMw703r+iItBc9
	7B9+9XC1e9//ZCsEN3xbRRSSzbt6IH8v0hsG01quUOLWim6dzgLJM6H57amKRt1S
	M/sHWz1CDQ1As3Ljp5cj5TEO1VsvRri+gXTgAIxLzA4YT0i5fT51tAW3SG1nn2lg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwkvu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:54:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EDfS7G016352;
	Fri, 14 Aug 2026 13:54:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk7g6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 13:54:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EDslob27525508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 13:54:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 795192004B;
	Fri, 14 Aug 2026 13:54:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CBD220049;
	Fri, 14 Aug 2026 13:54:47 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 13:54:47 +0000 (GMT)
Message-ID: <12f907b0-dc4f-4712-bf47-f84b2331b099@linux.ibm.com>
Date: Fri, 14 Aug 2026 15:54:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390/cpacf: Unpoison instruction results
To: sashiko-reviews@lists.linux.dev
Cc: Christian Borntraeger <borntraeger@linux.ibm.vom>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260814121559.1240939-1-iii@linux.ibm.com>
 <20260814122756.6096B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260814122756.6096B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7f1e2c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_SsXKjM1MBDal4IfaaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l7gu51EWLd9vRj38CdnGzJif7PCOWG5l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfX/61P9PpM+tqa
 1zut3sOwgmdkIOkIf/8YLmzhOsV9978NysEO5Auw560a0n0QO+U7OkBLu/q4+fLgLZpKLjRXMAO
 a3zatRiACo2iprcnfOW1xtF5VkkPjEFJVzkWdjTCjj+tliD4bqGdFEqYhcyo6iQ9WtDcCEgfblL
 9PgcJmQb1zzENZMH5xkwd+eJn04HV+fVoSZCejBKA+7AtNQPH8QTPVw9h9fno2T5ZItNTPlPWaK
 IQRAKH6s9OQPIw9RMaLtSOCzZyo3qIuYoZfFRwNlfoasL2c6arzeoYmSB9Na4zFi5Ng6UEHRUih
 gElBHFEZg/pn9Z0Qjw/ySpDJcIpCoKQJNLrYo9fm151KMvlVk9kVOm287Y4fjLduu3GS/Jfbj6M
 SrHh/eG7M25hRY2x+kat70mfNNxUSr4e4n0UdkudgR8j2F1PKqVdIzJhJkagE/JxrVmpqWhhvNQ
 h1K6X6Lg1ELOGqEhchA==
X-Proofpoint-ORIG-GUID: l7gu51EWLd9vRj38CdnGzJif7PCOWG5l
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwMyBTYWx0ZWRfXyVIXsN2xeK1b
 hRP7rdd7taBvkKb2/BCXDDOjuuyOm75U6+R7xT8sUl3pXgECigZmnYRGqoRyK0YyGO6FL9UIYkp
 itO+3D9TusAx6dCx8ruJ/bEyc0qBkAE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140103



On 8/14/26 14:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Unconditional KMSAN unpoisoning masks partial completions and information leaks.
> 
> Pre-existing issues:
> - [Critical] Silent ignoring of PRNO and TRNG partial completions causes critical information leaks.
> - [High] Silent ignoring of KMA operation failures causes cryptographic protocol violations.
> --
> 
> --- Patch [1]: [PATCH v3] s390/cpacf: Unpoison instruction results ---
> commit c65c87d6cf548eaef4bd0b06821cb0e68caaa4c3
> Author: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> s390/cpacf: Unpoison instruction results
> 
> This commit suppresses KMSAN uninitialized memory warnings for CPACF
> outputs by adding kmsan_unpoison_memory() calls to multiple wrappers.
> It intentionally avoids modifying variable-length parameter blocks and
> the cpacf_kma() wrapper.
> 
>> Also do not touch cpacf_kma(): this wrapper does not handle cc 1 and
>> cc2 at the moment and has to be reworked.
> 
> [Severity: High]
> This is a pre-existing issue, but does silently falling through on Condition
> Code 1 and 2 in cpacf_kma() cause callers (like gcm_aes_crypt) to accept
> cryptographic errors?
> 
> By returning void when the KMA instruction encounters an error (such as
> incorrect AAD/plaintext lengths or a hardware abort), callers have no way
> of knowing the operation failed. This could result in partially written or
> completely uninitialized ciphertext, plaintext, and tags being processed as
> valid data.

Yes. As stated in the commit message and discussed in v2, this will be
addressed separately.

>> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
>> index a83683169d98d..6174552d856dc 100644
>> --- a/arch/s390/include/asm/cpacf.h
>> +++ b/arch/s390/include/asm/cpacf.h
> 
> [ ... ]
> 
>> @@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func, void *param,
>>   		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>>   		  [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
>>   		: "cc", "memory", "0", "1");
>> +	kmsan_unpoison_memory(dest, dest_len);
> 
> [Severity: High]
> Does unpoisoning the requested length (dest_len) instead of the written length
> (dest_len - d.odd) mask partial completions?
> 
> When cpacf_prno() terminates early (e.g., returning Condition Code 1 due to
> entropy exhaustion), the hardware only partially fills the destination buffer.
> Unconditionally unpoisoning the requested length blinds KMSAN to the
> uninitialized tail of the buffer, potentially hiding active kernel memory
> information leaks.
> 
> It appears the pre-existing cpacf_trng() wrapper suffers from the same
> issue, unpoisoning ucbuf_len and cbuf_len unconditionally.

PRNO cannot return CC 1. The only documented values are 0 (normal
completion) and 3 (partial completion).

> [Severity: Critical]
> This is a pre-existing issue, but does the silent exit on Condition Code 1
> in cpacf_trng() cause uninitialized kernel memory to be copied to userspace?
> 
> Looking at cpacf_trng() in arch/s390/include/asm/cpacf.h, the assembly only
> loops on Condition Code 3:
> 
> 	asm volatile (
> 		"	lghi	0,%[fc]\n"
> 		"0:	.insn	rre,%[opc] << 16,%[ucbuf],%[cbuf]\n"
> 		"	brc	1,0b"	  /* handle partial completion */
> 		: [ucbuf] "+&d" (u.pair), [cbuf] "+&d" (c.pair)
> 		: [fc] "K" (CPACF_PRNO_TRNG), [opc] "i" (CPACF_PRNO)
> 		: "cc", "memory", "0");
> 
> If hardware TRNG entropy is exhausted, it returns CC 1 and falls through,
> discarding the unwritten byte counters (c.odd) and returning void.
> 
> Because the wrapper returns void, trng_read() in
> drivers/char/hw_random/s390-trng.c falsely assumes the entire buffer allocated
> with kmalloc(..., GFP_KERNEL) was filled:
> 
> 	cpacf_trng(NULL, 0, p, n);
> 	atomic64_add(n, &trng_dev_counter);
> 	if (copy_to_user(ubuf, p, n)) {
> 
> Can this sequence leak uninitialized kernel heap memory to any unprivileged
> local user reading from /dev/trng until entropy runs out?

Same as above.
