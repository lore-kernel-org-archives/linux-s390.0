Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F53497B8B;
	Mon, 12 Oct 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817682; cv=none; b=U1gmz79a9uc14VLdc1zMJCONG8KUy1jcEQALwrIWKTNWctp0dXjqj/o2/LtXnK6P2NSGpkdeMy/zyZal3HOegkLqX3SjBMsY7dQHz/nDGSHN3O7L7JC1y2FjWRVF0SCi+spq2WtL2a9PNZqzF0AnfmobEI8IPV/GD4Tcqhxxqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817682; c=relaxed/simple;
	bh=M71XsccWePjbDRtYBuK5SRL5j+lSvyX8bPPQQtgCY/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROmoz0eMybwwBeTwn+Is5x96gMwymw60f/nspCkRkfeWUkZXnUyUguECfKrdsl7zyjR4CWc2etZUk87n9/eXq3+jyPVhJkcnQYVuC4UcPZ+/JgI9zziyeCCiwF8rMiDsd3WnL4CUqoXCCtHAkYahyBBbJT72LTVS68a/a4cxQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JrTj3N0C; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JrTj3N0C"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE8gR316315;
	Mon, 12 Oct 2026 15:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=InfA8f
	75vvvjPCjzrGfyJsUEWetSv5vgXTrgOkRCUt8=; b=JrTj3N0CL1dyjWDFWaP3Dw
	nt509y8WMrwZtdpPOpuSncj0kXHJKeS7H1FdY4beduR1TA3u1o8hpBUkcnd/FxgP
	SCSBEcGo45CLaFsp6F0yf6H7OTdzX7qeuY3z5b17wV52kjDcYqDltmfptlMJEbjn
	rc1mDC3Rf9GCrM4ZRMKiIQ43cZy4oGutWNsJpMKZr7v+vrUhMjb9bzTRJP9DAuaw
	ee27rcjpHJnKVjJptbZu3ncB5sawOVd0EuIOPmpCdPhbuopoB8VqTYmfZkYAXl9j
	Rs8UxwtBS3ihHAGbW1I0N6JXB6p2fu4FYtmR5wMlb9n8ellpyEFkPsrYz8wlPSlA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug9hv5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:07:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC51Jm1212074;
	Mon, 12 Oct 2026 15:07:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnq4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:07:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CF7rKE14156062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:07:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC7520043;
	Mon, 12 Oct 2026 15:07:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC6082004B;
	Mon, 12 Oct 2026 15:07:52 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 15:07:52 +0000 (GMT)
Message-ID: <b85d6175-5587-4bca-9851-30241bc96158@linux.ibm.com>
Date: Mon, 12 Oct 2026 17:07:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/32] s390/bug: Indicate modified PSW in disassembly
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
 <20261001103247.1989111-5-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accf7cf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=BX07Cdk8x4Z_pagRTk8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cH6VSp2Li-NEBrazbPR15VLP614VqHJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX1NAKRBVa1oAj
 KLzpXqoB/7eC/1rM4F5K1kqG+tANeDB1KoFUiwPKhjCwjvIUULDd9VZ6iyOnqlaXFfSd2xgqF4g
 UjJEKxbgFtWklevnfBEH12EdeOeQzowE6CN+EGumURvVVnYiYPGm8Anur14JpP7sN5KYq4CTsS/
 Xu7HL5245ofIARY3xm4RuyhWlc7xSL+PwzsnhXXyIUjWDM273bWWvs0Sxog8wq5M51nPocRQ3cQ
 rzl236jPeHPR7r+w5KLiH/i5vdak4m+1j2tGyhHw2XU4fQrcVJIBLwaThxBzKm2nJAKjSXGerBM
 P+gL/N+K46Ko994SL+vbvbeDs+v1AHPcwWum83Xyxxtxx4mgAG2g3fAadsJMIJobQqBr9VK8h1n
 1y9NdnjbzZ7XM/gbTXZjtY9TGU28Xyak4euFmaxlhDdZDN+u3jZlqO2d6oU6dfWQe+zq6NttpTJ
 /3gfG6YCLc4iw5Ol7JA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfXxctiS+6MBHBq
 8K+bRTDuqh+9upz9qXJfsPt//A6SIAq1pBFxNi3NG+FZl/fzLwbtJCU04zoFFyYyB0loIq5ju5U
 Z2RwrkHGYkfyLH80orjXe0rZwnXlsWg=
X-Proofpoint-ORIG-GUID: cH6VSp2Li-NEBrazbPR15VLP614VqHJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120058



On 10/1/26 12:32, Heiko Carstens wrote:
> With [1] the PSW address is set to the return address of the calling
> __WARN_trap() function in order to provide a more useful disassembly of
> the caller rather than the helper itself.
> 
> However, since regs->psw.addr is modified, regs->int_code has nothing to
> do with the exception. In order to make that more obvious change the
> disassembler output.
> 
> Introduce a new PIF_WARN_TRAP_SKIPPED pt_regs flag and set it whenever
> __WARN_trap() is skipped. In the disassembler output print a "WARN RET"
> prefix to make it obvious that the PSW points to the return address of
> the warning trap function.
> 
> Also do not print the interruption code and instruction length code for
> this case, since they have nothing to do with the modified PSW.
> 
> Example output:
> 
> Krnl Code:
>             000003ffe185bc1c: e3f0ff98ff71 lay     %r15,-104(%r15)
>             000003ffe185bc22: e3e0f0980024 stg     %r14,152(%r15)
>             000003ffe185bc28: c0e5ff45ed94 brasl   %r14,000003ffe0119750
>   WARN RET >000003ffe185bc2e: c0e5ffa052b9 brasl   %r14,000003ffe0c661a0
>             000003ffe185bc34: c020fffe86d6 larl    %r2,000003ffe182c9e0
>             000003ffe185bc3a: e548f0a80006 mvghi   168(%r15),6
>             000003ffe185bc40: e548f0a00005 mvghi   160(%r15),5
>             000003ffe185bc46: a7690004     lghi    %r6,4
> 
> [1] 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/include/asm/ptrace.h |  2 ++
>   arch/s390/kernel/dis.c         | 23 ++++++++++-------------
>   arch/s390/kernel/dumpstack.c   |  7 +++++--
>   arch/s390/kernel/early.c       |  9 +++++++--
>   arch/s390/kernel/traps.c       |  1 +
>   5 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index 6411e3584283..c844b8aa0fd9 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -17,11 +17,13 @@
>   #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
>   #define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
>   #define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) */
> +#define PIF_WARN_TRAP_SKIPPED		4	/* __WARN_trap() was skipped */
>   
>   #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
>   #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
>   #define _PIF_SYSCALL_RET_SET		BIT(PIF_SYSCALL_RET_SET)
>   #define _PIF_FTRACE_FULL_REGS		BIT(PIF_FTRACE_FULL_REGS)
> +#define _PIF_WARN_TRAP_SKIPPED		BIT(PIF_WARN_TRAP_SKIPPED)
>   
>   #define PSW32_MASK_PER		_AC(0x40000000, UL)
>   #define PSW32_MASK_DAT		_AC(0x04000000, UL)
> diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
> index 1cec93895b3a..5a1a24d211c3 100644
> --- a/arch/s390/kernel/dis.c
> +++ b/arch/s390/kernel/dis.c
> @@ -540,34 +540,31 @@ void show_code(struct pt_regs *regs)
>   		start += 2;
>   	}
>   	/* Decode the instructions. */
> -	ptr = buffer;
> -	ptr += sprintf(ptr, "%s Code:", mode);
> +	printk("%s Code:\n", mode);
>   	hops = 0;
>   	while (start < end && hops < 8) {
> +		ptr = buffer;
>   		opsize = insn_length(code[start]);
> -		if  (start + opsize == 32)
> -			*ptr++ = '*';
> +		if (start == 32 && test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
> +			ptr += sprintf(ptr, " WARN RET >");
> +		else if (start + opsize == 32 && !test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
> +			ptr += sprintf(ptr, "          *");
>   		else if (start == 32)
> -			*ptr++ = '>';
> +			ptr += sprintf(ptr, "          >");
>   		else
> -			*ptr++ = ' ';
> +			ptr += sprintf(ptr, "           ");
>   		addr = pswaddr + start - 32;
>   		ptr += sprintf(ptr, "%px: ", (void *)addr);
>   		if (start + opsize >= end)
>   			break;
>   		for (i = 0; i < opsize; i++)
>   			ptr += sprintf(ptr, "%02x", code[start + i]);
> -		*ptr++ = '\t';
> -		if (i < 6)
> -			*ptr++ = '\t';
> +		ptr += sprintf(ptr, "%*s", 13 - 2 * opsize, " ");
>   		ptr += print_insn(ptr, code + start, addr);
>   		start += opsize;
> -		pr_cont("%s", buffer);
> -		ptr = buffer;
> -		ptr += sprintf(ptr, "\n          ");
> +		pr_cont("%s\n", buffer);

Should this really be pr_cont() and not printk()?
The KERN_CONT doc says:

     only done after a line that had no enclosing \n

and the new code prints everything line-by-line.
