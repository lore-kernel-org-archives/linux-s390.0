Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6227E25CC74;
	Mon, 12 Oct 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810124; cv=none; b=iGNTYPJr206SIwgCruEEe0+LyclGBDlMddif3L54pDr7xEBSOyNhUhB9ZMaQ16t4X794a4dN4KqJLk67m67JqQ/0FZdWEh3R2/CJZoXpqq8NcSuxUxw5Kd7q5FN50cecjKoVVIAg87x1qMHmR+ypx/G5arBvCd2rH2Wnb9xqgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810124; c=relaxed/simple;
	bh=hBXoXhHM12gnFL9Jd7Ye30eFZSG3qJRfV+k8eRPxnAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3HctA6SfomiH/lihz1Dj/olVte7PuI3DZJbgYX36rKo+7RQPGyljJgsm3lHjFNyuQn/QNabO5Mq70IZov4g+VXnzCVFDiIpDPdIm8j19m9NwqSQuFZiJJ/nTERwLrRGm7twCdAq/DrUhTkapf+y/sA3aACtdPbOVQtdNEFfALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HTZkFH8O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HTZkFH8O"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCECBY316406;
	Mon, 12 Oct 2026 13:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kSxQTL
	yM4wswLQT74JvZKW28bZMH8VTBD5UedAIGkDs=; b=HTZkFH8OMI+h3bPuhHRbzf
	rNj9pZiZJ+PixXmY4dgMFoNP2M3Fvg2yTqS7RqQ2Tv8tggziQvT7cQGH3fCbVYPS
	Widv29EgGQu3vQxinjxR9xSCx6Hc8r1Q94ArhgOruOGZnSweGkJu8uAzfVal/9I7
	7+ZEXLICDm/FVvrMyBii/t0xAhftt+I6265TPbaG3ZBqNKk3yi3EDPoycNAO6xZY
	PklT4luwHc0lNLkeRyv0yVSw7tgeXgxhDJ04JOxewRGOQideLB5XFhwqHdnsJ9PG
	XpmTB05kxUiRE7fK4qgs9RDur73CWBEXisqcky07aeSOInMC4pjoeDcXVWV7uWnA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug8y91-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:02:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCJtGK1255442;
	Mon, 12 Oct 2026 13:02:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vnb0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:02:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CD1v7j44171766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43EB02004B;
	Mon, 12 Oct 2026 13:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B824020040;
	Mon, 12 Oct 2026 13:01:56 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:01:56 +0000 (GMT)
Message-ID: <f7a81358-0ff9-404b-9b27-1ea11c095694@linux.ibm.com>
Date: Mon, 12 Oct 2026 15:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/32] s390/traps: Handle nullifying program checks in
 get_trap_ip()
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-8-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accda4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fyzn-L8G_lW4U3_TlzYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SQ-V4Eg7ndHY4_P7exOfZlLdka-yem3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX1QI9A21ulZSG
 5WnXY7nfOgwN+4V1MYvgvgO39C1VmxSAoOSh/N+7OWblxRuSAs90MY3R0VWBJY7YY+b9LgROhLd
 i3Bvcfa05YXXC8ZpipTN90b9HV5glqFE2A/g0BnrO+OfAltsnDiZffDjxkcADf9iAfYatYRu3yy
 Fw3FQ4cSi6i6//klQCqq0oRBYNOzDo+uVq6hd711UEXmN/KREm/VrS34zBMUH9WlUx4d8FCGUMU
 moX1+LbuV391U/vte6TdsyyoQVdqPS0x9jYyCsLCF3nwCiJX/LPa5loVak9eUdGT8TCeyzOU4dY
 Ou7ArU3yYphWd/Oa1Eupk5DYu8E/RL25yqUTJkLF8ymlwgn3DiyS2oEtTGQTFppt2g3vKEhNqyx
 dc3bLbdjEvs2Fr/cFn+Ma5yV7By0D/cXXPXoBT0rTZitSO6dn48Kw6odTd0iotrbFwq8D/H83tl
 0igxixLMgqS3X95CRPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfXz5vg46xSEl1X
 wQ4ehMmREGioYgBvK2tK/d70h2HH9WLXTx5TC4U4LpEFFG4RX7ROJnRr8PtCGJaYwuOA7PTwIbN
 NI5HdEkk3ONRaf0KJVmgKtApwS2fbSo=
X-Proofpoint-ORIG-GUID: SQ-V4Eg7ndHY4_P7exOfZlLdka-yem3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120050



On 10/1/26 12:32, Heiko Carstens wrote:
> get_trap_ip() always rewinds the PSW address by the instruction length
> from the interruption code. For nullifying program checks the PSW
> already points at the faulting instruction, so rewinding is wrong.
> 
> Add a nullified[] bitmap and return the unchanged PSW address for
> nullifying cases, or if PIF_PSW_ADDR_ADJUSTED is set.
> 
> No functional change for existing callers, which only deal with
> suppressing, terminating, or completing program checks.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/traps.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index bfcab4592299..5e63032a56db 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -26,6 +26,7 @@
>   #include <linux/entry-common.h>
>   #include <linux/kmsan.h>
>   #include <linux/bug.h>
> +#include <asm/pgmcheck-defs.h>
>   #include <asm/entry-percpu.h>
>   #include <asm/asm-extable.h>
>   #include <asm/irqflags.h>
> @@ -41,15 +42,19 @@ struct pgm_stat {
>   
>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
>   
> -static inline void __user *get_trap_ip(struct pt_regs *regs)
> +static inline unsigned long get_trap_ip(struct pt_regs *regs)
>   {
> -	unsigned long address;
> +	static const unsigned long nullified[2] = { PGM_CHECKS_NULLIFIED };

Maybe just [], to deal with the possibility of expansion in the future?

[...]

> @@ -152,7 +157,7 @@ static void illegal_op(struct pt_regs *regs)
>   	int signal = 0;
>   	u16 opcode;
>   
> -	location = get_trap_ip(regs);
> +	location = (void __user *)get_trap_ip(regs);

Should location be moved inside the "if"? Now it reads weirdly: we cast
the pointer to __user before checking for user mode.

>   	if (user_mode(regs)) {
>   		if (get_user(opcode, location))
>   			return;

Regardless:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

