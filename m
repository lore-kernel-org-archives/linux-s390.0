Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221193;
	b=MGlI1/sBJ10Hz4EvZrkaSyZCSASIZoNstJHV6pY3LBcUqOQDz3u7tgRq440ZYYkjziFl
	 39JUadqPF1HkY5rCOANwFjdu/qKIJsY0+ytrCzwT6DMI2WUAp+tRigvwXL9SgORBwZGcZ
	 QpaQRgmZ2gEOI0ctrSPgvxqpzpiofasm9fwQjjMIWb8u7pJxlVXGSHJrGMxytvexv9Trr
	 p/y6TULm6t6AhOQk7c4lXL8+l4cjaT+Q99Z+Xb02qTiwfkSMVwhLWdMo82EKUCgKKH54I
	 +C98P2QIy4bUCzPb5cA/0oeSRYjX/SniwpbV6FZTAEBc1rx7cc9FnL/+R6fVPC0tKNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221193;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B+ILGEghY39r13/JkwaxN9aY8a9WSldjM6rorjvMUhk=;
	b=po9lnJQzIhe+1V6+5FKgJXWPOeeKDLQLlWXdlVego3e7SZq3cB6RSH7KJaa1tqCFwmRs
	 oCdayMT9XfnKCK+omwYamj4y2vHg2HMS5gVo6yFHhcXk/+zSlX71TLAWRSS/gZSd0XYMV
	 wioBmZ846I6IUE2AvbV0gF9yQFloCfeln+4KIgFKk3lQpZJe7MynKuOIs60tA93PTRCsa
	 HmzKYjHYRQCrXzxeI4aGwNS4sTYNTHvZ7Ae84OkFhKHpSHOBpTcZgPPJ/Wmgmg4uMAQ/1
	 0m3FAimGHsQW9dwo2Wfd5Ei6isDxIK2Im+IH7V6jrKFufFOGKwbTpYqjFAPznG1Pw5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="paH15z/h";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F0606A31C;
	Wed, 28 Oct 2026 20:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=paH15z/h
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SJYsYe2340172;
	Wed, 28 Oct 2026 20:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B+ILGE
	ghY39r13/JkwaxN9aY8a9WSldjM6rorjvMUhk=; b=paH15z/hwHdy5wVGhXeZtt
	L82T1577Sv1lLspdy/d4IjMI0kpwgjmn/7YucyAMN1TimZXwHKo7K7j+a/oAoMMC
	Tra7KG+Itqwp42hw3Gi0YH3A9aTauhFDdLhBnfo+SIUP2zkOinU6sTdxsIAPVmhN
	a2xcjNZLT022iXAxlZo/u0XNSnDaMNuF8iebYHTpX1b5vDQt+gNPfhaE6fR58rQb
	BDPbiTZmtM/eXHV3bpMR78/2q8b3cWEre3+m1EjvJN3DNUKncYJuwO1yxd9YR2lA
	7k/UY53TeB0xPCkLN+gD5W2x6aUyoCNDSB6bzAx739V3ziU6pQ09cs8WuHthqyWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm646yv5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 20:59:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SInjTE1983896;
	Wed, 28 Oct 2026 20:59:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pc2jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 20:59:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SKxldU47317300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 20:59:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 327C720043;
	Wed, 28 Oct 2026 20:59:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA0020040;
	Wed, 28 Oct 2026 20:59:46 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 20:59:46 +0000 (GMT)
Message-ID: <11f7072d-3c4b-4ed5-9954-49c39a012d8b@linux.ibm.com>
Date: Wed, 28 Oct 2026 21:59:46 +0100
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
Subject: Re: [PATCH v2 10/10] s390/maccess: Remove spinlock from
 __s390_kernel_write()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-11-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-11-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX2fKgjyz21dt5
 QBNA0TQX7CmL3ClPQUGDGNmxT1sWYd7ciFzKlS8CuvELhVNpIDun6byDqczJry3gJ9EZZrN+NVA
 U1oDUM+Sy6QCG6RmHbo60LjXJJbgUMw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX7xvIlHIQfss6
 6cE6WomK73JtdoyNY4Fvu7097Mcqprs0FtBwJpevfKI6QV9VN8QKAn/mffVQP0kw5jWHBuILJiS
 XQvRKUbiWcVS4bpSyl1d+z6WR/xCl5NS0udUC3C7MZdVKbZBDvhMRPopF7PK3AfABGevarcub81
 oQ5o8c02jyi2HY1EBf1V5LmTs+mFD1WcxIQdKZCPASrQH1lU5yVtOSw/TeAe9UaesNRZiXAmLrT
 laT0q1vwZEhViOD1D6B5/0uPwh2psPxXs3oxmJB9kQwvV4wZRPm9XHIhglRHi65rYiO1Q6J2G78
 Lunu+emFiO/qsO8F45ZkLOGqhgVicoE/jltqyiq4xRjxewJ291jHz+BHi98FDx+zsj59GZ/2HFT
 PykPWMOsB+eMs1mIwQsIrqfxsEa24jJ5LhyeLgOKrv6nhyGjcwdz3nMoVrricQMYOjMjDe6iA7A
 rEqai8h0oBcWRc2Gg/g==
X-Proofpoint-ORIG-GUID: Wcq-VWVUn41p_v4DZtlw5fgIPp2vwJKA
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae26248 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=5OG-X-8QiNZRF-oGS5oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wcq-VWVUn41p_v4DZtlw5fgIPp2vwJKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082



On 10/27/26 15:30, Heiko Carstens wrote:
> The spinlock in __s390_kernel_write() was introduced to serialize the
> read-modify-write sequence against concurrent callers. Now that all
> runtime callers of s390_kernel_write() hold the text_mutex, the
> spinlock is not required anymore.
> 
> Replace it with preempt_disable() / preempt_enable() and sync_core().
> Previously, CPU serialization was implicitly done by other
> instructions. Make this explicit with sync_core() instead of
> relying on that.
> 
> Preemption is disabled so that sync_core() issues the CPU serialization
> instruction on the same CPU that executed the stores. This completes all
> previous stores and makes them visible to other CPUs.

Doesn't preemption happen only via interrupts, which always serialize?
> Other CPUs need to perform CPU serialization, e.g. with text_poke_sync(),
> to discard already prefetched instructions.
> 
> To verify that text_mutex is held instead of the spinlock, add a
> lockdep_assert_held() call to s390_kernel_write(). To make that work
> a change to the kprobes code is required:
> 
> swap_instruction(), which calls s390_kernel_write(), may be called in
> stop_machine() context.
> For that case the task which calls s390_kernel_write() is not the task
> which called stop_machine() - lockdep_assert_held() will report that
> text_mutex is not held by the current task, even though text_mutex is
> held by the stop_machine() caller. Exclusive text write access is
> guaranteed.
> Work around that by calling the non-checking __s390_kernel_write(),
> and add lockdep_assert_held() checks to arch_arm_kprobe() and
> arch_disarm_kprobe().
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/text-patching.h | 7 +++++--
>   arch/s390/kernel/kprobes.c            | 4 +++-
>   arch/s390/mm/maccess.c                | 8 +++-----
>   3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/include/asm/text-patching.h b/arch/s390/include/asm/text-patching.h
> index c2f87f20ff97..a382a3e7c2f8 100644
> --- a/arch/s390/include/asm/text-patching.h
> +++ b/arch/s390/include/asm/text-patching.h
> @@ -19,9 +19,12 @@ void *__s390_kernel_write(void *dst, const void *src, size_t size);
>   
>   static inline void *s390_kernel_write(void *dst, const void *src, size_t size)
>   {
> -	if (__is_defined(__DECOMPRESSOR))
> -		return memcpy(dst, src, size);
> +#ifdef __DECOMPRESSOR
> +	return memcpy(dst, src, size);
> +#else
> +	lockdep_assert_held(&text_mutex);
>   	return __s390_kernel_write(dst, src, size);
> +#endif
>   }

I assume #ifdef is required because lockdep_assert_held() is not
available in decompressor and there are no stubs?


Anyhow:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]
