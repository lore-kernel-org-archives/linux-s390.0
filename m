Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225228;
	b=NCYLO0z3RL5A2QcfEZwlyenYMByD6+mH1hnk4EzdX0FL8Zmhdf53H7qsdyLGI0J+Ts1j
	 j44Ir9b3sOKnyRbIS5pOtj5ocZ8uXhRjYINbXRdZBFOtA+dQNtvc2C1OnIK+D/sK9bRBF
	 2dWkf7a/2FNrAMJZlkAqkUDggNt32i1cDxpg5fmvYTywa7ryIK3KSedl9t/0FBPPSekQO
	 5YV9LNAcPDTs4+7wUN+A/BTXcLHEvMzGrzs6vl5wfuL8xT2E5d25I7OARQSot8aH6yeOQ
	 yFj1FsRMrC12keDSHxgzki3wjLfWz/tZJ5vXjrITUc28lzGTKr5gyNYnmnwfqGKhUTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225228;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iFOnBd2Fsd3/8Giimws7lJb1PY5frjcIav1S/Ve2j8Q=;
	b=hhd/wqRZQ3VMPj1fRLCviJpY4vmJIfkYAs75VYUH3T4zad34a+Vx4Bg4nClDwC1b3ebA
	 goXse19v1WBnqH2hcW73ODWSyBu8RRaXDRUXH9uE4YG9H6lK0RfZ/tF6fK10+gc/gEjmK
	 fWNJ4FVcQ4owqs2OrVQ7WWUVVEtqMHbrL4PZDWQtFQ1O9ECynbDk9JeD9G9Dy6GwHukV5
	 nsylPnSczlq6n80WPegpUpbA5H1Pf6CP1eBCbPH6qqa866+CQcKEa6qHmdyZnO9xbF1Hj
	 VVpj2epy7+7VX7Gz3GWPONRlKe/8GgAg60EzQhil2l/Ovbxoglx+nPobODCT5PFYowQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lw0PfL7j;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E94606D82E;
	Mon,  9 Nov 2026 11:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E94606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lw0PfL7j
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AENGU1916121;
	Mon, 9 Nov 2026 11:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iFOnBd2Fsd3/8Giimws7lJb1PY5frj
	cIav1S/Ve2j8Q=; b=lw0PfL7jDtuHO7GYK2HWyLo1a500HSjxeNP7mdxIJ/dHd8
	bNJ4DmbKDNmVpuBzcEKh+80YRGWtOb+wU4A12/rFMLpM0oK/iOnXdywmRFMd6Xmr
	+W2NY+GoP7FOEYyQN8Xnbe2spl9On9ipX0s6J6cApxl4R2RHOhrHCPyE1krIQPcw
	o7bK0HaLRfpKi6l9INIa/6D6c6wlcKFV3zkJlPfPltWE0De0Gd/AW0GLOoTKq0HJ
	t5pdaPuy3mLQE4bE7Fq7RjgTlkCbkUDkeh46gwRVwA+Q5Ree3WE+Z0YRF1zDbPP5
	ja7rxXyW6fVgIXEm2nLCYwKhnFoEwraL22IMI2gQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfvqj3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:53:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4vLt4004490;
	Mon, 9 Nov 2026 11:53:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajyjk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:53:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9BrgBo30015860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 11:53:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E9E620043;
	Mon,  9 Nov 2026 11:53:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE4820040;
	Mon,  9 Nov 2026 11:53:42 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Nov 2026 11:53:42 +0000 (GMT)
Date: Mon, 9 Nov 2026 12:53:41 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
Subject: Re: [PATCH v2] s390: Guard emitting assembler macros for
 insn-common-asm.h
Message-ID: <68336e70-8420-404c-899f-58933d1a0ddd-agordeev@linux.ibm.com>
References: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af1b44b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3WwxFDiQG7SU9cBGjFoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfX9/0HLWq6p/so
 Te/y5fu4/8O34zkWtwz2SZPCNZ3w85fX1nC3FTUEZj3k+GtGMgqE5bb2q0L3SJQDWFmInOf59Fm
 nhOg0ughj8R66fVSu/T2KiugeRnKGC1p1XX3JRpHdfGdnklXH0oBawtjJfypmcTLYqBUX25hc0z
 nEz1fJkDevzLvfDZs0QLXEFF0Ltdgs6NQd0os0sxUkXB7aFd30y4GbsZ8Y1TP3SbZgB83cwsHte
 3Tn+1yFKnI8LvKNLNSRNbCVA33GrT5FsznUUYjXJzL105T3YrZImP308ohUeeF7+wGjaCXE+GOM
 F3JGYwLWADPyrDJ1moSXV+H4rNMRJ+yhTtdQAP1Lrb4rsBQW/Urtrf9d/W/vpQ8Slze5cycj0tH
 m8+F/YCyEh2J+sMSjuRG/+5372tSQTKFn4PQaKy+xrMO+E/1/Z9bssQz9bO+wou837doHdOLdGM
 rLICP6vWvpywtxsARew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfXz7jS/DrmzR6D
 R+i045YeQXdqIoEsbE6jbfalOCCxbWyyzqz1l3O1kQxBg2bRYomWEIp97kxdkjLnZEK+KrvN6qC
 W0S7phWzGJOjOkXLHMy3DRYOuaR2+sE=
X-Proofpoint-GUID: OqXKheqGHfx6GPcD_y7vu82937ukp_TW
X-Proofpoint-ORIG-GUID: OqXKheqGHfx6GPcD_y7vu82937ukp_TW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090046

On Thu, Nov 05, 2026 at 02:46:14PM +0100, Steffen Eiden wrote:
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
>   (Andreas)
> - Link to v1: https://lore.kernel.org/r/20261102-insn-v1-1-df048a0be0d5@linux.ibm.com
> ---
>  arch/s390/include/asm/fpu-insn.h             | 2 +-
>  arch/s390/include/asm/insn-common-asm-emit.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
> index eeb0a233d5c7..aaf1faeb3dc5 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -14,8 +14,8 @@
>  #include <linux/instrumented.h>
>  #include <linux/kmsan.h>
>  #include <asm/asm-extable.h>
> +#include <asm/insn-common-asm-emit.h>
>  
> -asm(".include \"asm/insn-common-asm.h\"\n");
>  asm(".include \"asm/fpu-insn-asm.h\"\n");
>  
>  /*
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

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
