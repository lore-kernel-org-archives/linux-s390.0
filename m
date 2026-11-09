Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225760;
	b=epVYwWYkMerjCxCYKgcNMjnp8NzSk9OQX8r3ZzB8hobQRw8WAynVwYzSxSS0KxC58I7F
	 kKgQtE1BWTlWFnp+w3jWFEk63pRVynLM/E95/GV47dO6shWuDw384J1Q3Abna8QtLx+Tc
	 pB/WIsebRGsyXckQU3BDW4dKPrkWKtgq8EYXmxsdzks2oTkzMyRh7H3rZQpYcvBB8sZEZ
	 Q8Avdd6+JMnRzgK0lKJ1fFwSjxH06LCHG2DPd/N7iMowjnbB6ddp0eLY/1gl/WlCthKEX
	 8khf+7o52eMp6cZmM6rQSvHVXBTBrUpIbnRm8KE7jag5wI4Il5VJm5WxQWwjFL0yFhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VOZzSzEpmNtfvzG2qO1eY0yK/YBvNo2Yl7ZJRUhzM/A=;
	b=jJJZdCVu26okfRwPiHqhxbThCArrq7rM/BnVGR1Ax6G4VEHndcSP2ZOv6WjKFg30p4PM
	 pNm/FYSGa4dccui5j/gDyhYhpk+IIsD0mBvVdfQLy4R4d0I/3J5NnoA5O352wtwmOeHic
	 WeQuVMQrw9mRdiqmBmvzgUhDqN8vc2PmcCKEhh4sTC9BHNRyVJQSr30/dwO8UOjOBX3k0
	 lJXm5WllPQDftjVCRHTIi3ehwh4UM5OBLJYR2L/7XPGUdTYGfnPNgDt2SU2y74UTJ7pqn
	 JSs8aWKsQ4cHnImkkVRdDUbzF+BTXDU/kUnSN3n1E4kixcZfrWhMU2wRDHNGBvOHgrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CwNn6JMt;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFE606A31C;
	Mon,  9 Nov 2026 12:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FFE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CwNn6JMt
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEYwV1481111;
	Mon, 9 Nov 2026 12:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VOZzSz
	EpmNtfvzG2qO1eY0yK/YBvNo2Yl7ZJRUhzM/A=; b=CwNn6JMt9uDpo2aSJAGA6o
	1SH0e44+qfTsHn0Og7ZRCO5pyurjiIsgH1qGO6YsiyFeywx0rlzA1jp0sBSnuO11
	8JJUud/omDsFNlev1o4r9Z62JRJ8O+jnhzSQuWl8MVdgaKQ/7O2wndAyQfY//YMy
	rNC/C6vqM2/5/Xe2zyZNAlA9UJKZcJN27TejhNpsDP6tRCTXt8NE8ghRMYwGKt4q
	LDEC6cKDb0qPTLVOLC2pHsa9deiR6lmIeNWxGv5EtXxQnQjr0uV6abV00VrnvZuY
	L2HE1pHqjnvPyI3VdsJzCHjwfnr4+TVk3QPb//H3qtuKbblZcNxMb5rhdH/CSAuQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunsvxdk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 12:02:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4tPc4140993;
	Mon, 9 Nov 2026 12:02:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthffj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 12:02:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9C2Yri47841558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 12:02:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DD1F20043;
	Mon,  9 Nov 2026 12:02:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA2720040;
	Mon,  9 Nov 2026 12:02:34 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 12:02:34 +0000 (GMT)
Message-ID: <50ea2597-15ba-471d-968b-546ce358d20d@linux.ibm.com>
Date: Mon, 9 Nov 2026 13:02:34 +0100
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
Subject: Re: [PATCH v2] s390: Guard emitting assembler macros for
 insn-common-asm.h
To: Steffen Eiden <seiden@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Grapentin <gra@linux.ibm.com>
References: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfX/f53oy/ssrtj
 YRGMRyiwTPcw6WV0kwDKDVXkd3UIxlTVgVY5OZUG7ZTtfo1+AlIgAd7wI7/n7F6Ezd1LkLItEs6
 o0PmxFWEiANtxzjxJtjITW5olPkC/pw/D79zKrOpnQhwB+53u3XIL9cC8FhPW7JEu5U7LyaNWVh
 E55kywchmVbFeCfa6u8fIO4GWC5qd/CWaMHC3ClAd04ILVFF/8J2pytp4mOlXh8+VSNNceQo2wN
 0G682PFlJEMZfeEUGBvAklLncIWOBpv48t3Jr4LGMMOlQHHgf6iiVDwF1IdyNre64mwvQXSAcqX
 yGBC+kYyrmdZ4VOtzribqxqzgLQQkq6SsWHA0bjURht/KrLW55ayOGgqRVJwsGHyXWiDRNlqsd+
 amOZ19WthXPxwHcB0Co0/h6OeyqLj0VxE8xxy8L1CjDT2wVlaJzdyGfY9MpTpbkyJtrlj6nOVEw
 zF6jJu1RGvIdAivSuvw==
X-Proofpoint-ORIG-GUID: KN_9cFbh7Mn83eu_7q_B0fbCkfT6e5SD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfX0FZDgQGO+LzU
 hxnOu2smSXT1qxFYSSnW2X7s1mm3RoMov52G+dNzw4SZLqkjpLFMoYM9hFn9BFrvEBtNYdEo813
 TNQeiXTP/vh79OMxC0uxmmzxb9nJlaM=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af1b65f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3WwxFDiQG7SU9cBGjFoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KN_9cFbh7Mn83eu_7q_B0fbCkfT6e5SD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090046


Am 05.11.26 um 14:46 schrieb Steffen Eiden:
> The CPP include guard of insn-common-asm.h is ineffective when the file
> is read via a gas-level .include from inline asm. The assembler ignores
> all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
> "Macro was already defined" if a translation unit emits more than one
> such include. This is not the case right now but may lead to future
> build issues.
> 
> Add a header 'asm/insn-common-asm-emit.h' that can be used by C/H files
> which want to emit those macros. The header guards the GAS include to
> prevent multiple includes in one compilation unit.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
> Changes in v2:
> - Use a separate -emit header and CPP Guards to guard the asm .include.
>    (Andreas)
> - Link to v1: https://lore.kernel.org/r/20261102-insn-v1-1-df048a0be0d5@linux.ibm.com


Thanks applied.

As we need this for the 2nd series of the arm on s390 support I will take it via the kvms390
tree and queue it for kvms390/next as the first patch on top of 7.4-rc2. So if we ever have a
(unlikely) complex conflict we can create a topic branch pointing to that commit at any
time.

> ---
>   arch/s390/include/asm/fpu-insn.h             | 2 +-
>   arch/s390/include/asm/insn-common-asm-emit.h | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
> index eeb0a233d5c7..aaf1faeb3dc5 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -14,8 +14,8 @@
>   #include <linux/instrumented.h>
>   #include <linux/kmsan.h>
>   #include <asm/asm-extable.h>
> +#include <asm/insn-common-asm-emit.h>
>   
> -asm(".include \"asm/insn-common-asm.h\"\n");
>   asm(".include \"asm/fpu-insn-asm.h\"\n");
>   
>   /*
> diff --git a/arch/s390/include/asm/insn-common-asm-emit.h b/arch/s390/include/asm/insn-common-asm-emit.h
> new file mode 100644
> index 000000000000..26a31e8439bf
> --- /dev/null
> +++ b/arch/s390/include/asm/insn-common-asm-emit.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_S390_INSN_COMMON_ASM_EMIT_H
> +#define __ASM_S390_INSN_COMMON_ASM_EMIT_H
> +
> +asm(".include \"asm/insn-common-asm.h\"\n");
> +
> +#endif /* __ASM_S390_INSN_COMMON_ASM_EMIT_H */

