Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019849;
	b=oMto75eCSftSu8mkQdg5XI64Q9FTBaYH3hhdWYNLRHgBpWzcu6aH3Gg6XZcozwhx/N9t
	 58frBlnRRW8dWdRamOLN6MAlX91Z82uYoQC9XkxKUsy+ZQx6tRVFVRToxLyEOoilOWjU9
	 yjDTHEyukI/YMI8c2zTD2LkvqlHb/I8bVAGp5kUz/M9cGl4ff27NxGCcf4K8vzoP0MWvp
	 Vz2WcS0DgkevbjWdQ3qtxANlg5LWUUmA+b+2f1ULED7Q61a61ZiCvwG6qvX9IsxXGfzEL
	 b3gdkmr0EJ+1XONi/jPA7WliJLufW/HCUQAWCs20Z+lydMcDwZmcigkJGP9TF1mJbPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019849;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wunO0TNI/doV0xV97P7JBiy+Hf4WD5xHBuyJwPfif/U=;
	b=svemVi5rGmF6JRuvkvJJw1gP2FrTUqVIAYeUuuxICc+bbZ01hSEnV2HdIFfVPng77Wdz
	 JsSD0S0Syd/Yml3HUZGerwBYvT03wLT+TC5yaNyBPfWRxno2VnouncTfllUl659d44YvX
	 JlMVzArUClzbvf8ec+YAwV7TUnMO0ri7JxAl8oVpgli3V/2ETIyWscmAd7dPbroBrIWUa
	 a2PNtF7sF/GOGjt6YK5mG/f/s3KpjqN67QLmran34Htvw2InmxFOnUDk1nnjOpRs6GrJj
	 /V/vVYX0CoqYHY1KrkwbwHsIZY/VldIW7OPollJtezFMwoqdk6Wig1SXgQhCPSw5DBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IfXlQmW8;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C942606A323;
	Mon, 26 Oct 2026 13:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C942606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IfXlQmW8
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEmYa3358105;
	Mon, 26 Oct 2026 13:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wunO0T
	NI/doV0xV97P7JBiy+Hf4WD5xHBuyJwPfif/U=; b=IfXlQmW8eQpMsvCEIRZ+in
	6Fdi5dcJmFwvgCrOUyz7xrhAjjhnZJXSzuksbWldwPJS0nbxymmWskETNHgJXFcE
	yJ0hNQMWMJohUhRN+eoID/7s9QfVwqeuWnZIeaYtTutmNgHUK5sr0FG0bEfXJqa+
	nu0HJ5KFEzQNuY8GYB6EgChOqv4UXEwqkxBqc+ZrwqiBYqmFSRs5lIUsXRlywFMj
	maFP8zBQpp9GS6VLP9RIa7Dj73zLz7oytMmJRvay6wJmcWetTEDQY1kBgLXQoTOe
	O82By76rX4q/cS+ioc28aAnYGNff/CyrgGalz0PcSKz79obaGjuXKudbps2vS3NQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav9nw8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 13:04:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB4ukQ1270410;
	Mon, 26 Oct 2026 13:04:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gnt13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 13:04:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QD42r151904964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 13:04:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1EDC2004D;
	Mon, 26 Oct 2026 13:04:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520E320043;
	Mon, 26 Oct 2026 13:04:02 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.8.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 13:04:02 +0000 (GMT)
Message-ID: <b27e1bb4-9112-4df0-9595-90b5419acafa@linux.ibm.com>
Date: Mon, 26 Oct 2026 14:04:02 +0100
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
Subject: Re: [PATCH 4/4] s390/maccess: Remove spinlock from
 __s390_kernel_write()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-5-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261026120329.1792436-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf4fc7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=surRbCUiQUJXvdXw5N0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3K7lI_RHne9GqijRnIj00SrDdwxHbA0T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX1z9UKx+LkRwB
 Q/eWSE+I6H9y1Co9zdK0BVQkDvtvuGQBWoGD37afXa7nrxs11Vk4+tEWSMFh7ZsmSgWL2v5L9Z9
 hN5ApZCrMUHNyEruhS1hmNBgqs3tjxo=
X-Proofpoint-ORIG-GUID: 3K7lI_RHne9GqijRnIj00SrDdwxHbA0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX+VXUbBrCaMi3
 mmq/UH3KbitmO9kUgB3U0dOY3WgKdkoH1KtoAVP/TREmT868/AYoIkLgEj/t4yNydd6+cRRDUyK
 SYgdmd7NzDq8nnyN8AAQEYkhR0vmNHIydrODzVvbLUo9rOMTqvgj2sih9XNXhR5W094hbtaOZRy
 ni0wFFh/l8fyS/czGI185T4vjZmUOOUR6fQs/unGZVPFS1UFFRM9XGZHh/1upe3P1vjpXB6rh3d
 sqMTVkiIseUNstZrxXXEppsU7xBNdxWzeMag/oMVUrkrB0zzsFyB/oOcD8x2MfbBNpx8CbDdXDY
 CRkQzW2zhov77bCzinyRitdm4SXKAQwHtZKWoiSiWsyedIrUf89EgUvZsaF8tXBwGeRnonplnkg
 L+UIe1BSxQUeTRTPZLchdxsD/DcGmdEUe25+Jtfzgoirl1JwrIRMIZio6lvX3U7pTDVn7Onk7mU
 nHr6aNAAnYpuacrDFDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260050



On 10/26/26 13:03, Heiko Carstens wrote:
> The spinlock in __s390_kernel_write() was introduced to serialize the
> read-modify-write sequence against concurrent callers. Now that all
> relevant runtime callers of s390_kernel_write() hold the text_mutex, the
> spinlock is not required anymore.

Do we want to enforce this with __must_hold?

> Replace it with preempt_disable() / preempt_enable() and sync_core().
> Previously, CPU serialization was implicitly done by other
> instructions. Make this explicit with sync_core() instead of
> relying on that.
> 
> Preemption is disabled so that sync_core() issues the CPU serialization
> instruction on the same CPU that executed the stores. This completes all
> previous stores and makes them visible to other CPUs.
> 
> Other CPUs need to perform CPU serialization, e.g. with text_poke_sync(),
> to discard already prefetched instructions.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/mm/maccess.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
> index f39968dd8063..cda3f81dfbc2 100644
> --- a/arch/s390/mm/maccess.c
> +++ b/arch/s390/mm/maccess.c
> @@ -6,6 +6,7 @@
>    *
>    */
>   
> +#include <linux/text-patching.h>
>   #include <linux/uaccess.h>
>   #include <linux/kernel.h>
>   #include <linux/types.h>
> @@ -60,22 +61,20 @@ static notrace long s390_kernel_write_odd(void *dst, const void *src, size_t siz
>    * bytes from destination at an eight byte boundary, modifies the bytes
>    * requested and writes the result back in a loop.
>    */
> -static DEFINE_SPINLOCK(s390_kernel_write_lock);
> -
>   notrace void *__s390_kernel_write(void *dst, const void *src, size_t size)
>   {
>   	void *tmp = dst;
> -	unsigned long flags;
>   	long copied;
>   
> -	spin_lock_irqsave(&s390_kernel_write_lock, flags);
> +	preempt_disable();
>   	while (size) {
>   		copied = s390_kernel_write_odd(tmp, src, size);
>   		tmp += copied;
>   		src += copied;
>   		size -= copied;
>   	}
> -	spin_unlock_irqrestore(&s390_kernel_write_lock, flags);
> +	sync_core();
> +	preempt_enable();
>   
>   	return dst;
>   }

I've been looking at sync_core() and started thinking about the safety
of this interface w.r.t. CPUs concurrently executing the code being
patched, since locking protects only against concurrent readers and
writers, but not executors.

If there is only one active CPU, for example, during ftrace
initialization, then everything is fine.

If there are other active CPUs and we make modifications within a single
aligned u64, then sync_core() is required, because even though
text_poke_sync() nominally takes care of this, it may sync our core
last. However, I wonder, what would it take to make it always sync the
current core first?

Finally, and most importantly, if there are other active CPUs and we
patch multiple u64s, then we are broken, since the other CPUs may see
partial instructions. I'm not sure if it's worth bothering with, but
maybe consider adding a WARN_ONCE() to guard against this?
