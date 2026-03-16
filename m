Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF6329E5A;
	Mon, 16 Mar 2026 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688841; cv=none; b=CYtrsTHGJ0zd7RhxxqPuDKSxDISjTlJ5miknFAxiBbl06N0eF6Tfcki3WrVm30hORShzPo3cYWlp7XjVCTPAGX0CsmEAKFQWc0G04/A2HE3XhYdDJ5ZYxvDOv36dvEztRDbvNMaEok5lkRKuUIJydswtP5FcSJIWYImP5tuvoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688841; c=relaxed/simple;
	bh=ghecX/TRClf9jdNxIyvzrm1vSXQOiBgXK9i72vDd2OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMwJn05szYb+40wI6NqXytbzvvYsexKrUZWP176w3vi/yhuCg1l+FcHqR8O81jB+BU0o4DUyXtA2pRlhiji1Gc03knYdIXAS6j3Z0hR57pauKhx+INMog+yzsoILiNLQUdKTd2B4aJtLcUICvWiPTSMGb2o+2NOryWWaY3xGZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IRSq8PAU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IRSq8PAU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFM1VQ1210659;
	Mon, 16 Mar 2026 19:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=htOOsfPxQtEw1ymZnt5FkdJyKmisz6
	7UUaUQUuiGxK8=; b=IRSq8PAUx2pKC1ZyemmRwTfHH1EOc9N0VwvglEnONmExQ8
	6rveNkTA8nSCHtNwmtQYMwshBhYe38C/5MK/XihVK/4tsAOsBo8N+k83a1RWU/PC
	agXaMMoihkkW7mOX3g7PZPd/jrDl9JPNbC28Xb684sDWOwwgaDglHxP7sb+MQhQj
	PrZVmkmqwBWB624wUlyzLQuahm6iKOYm3Y+1d6lRdJl4/t/42Jas5GH515Zlj640
	93EhzpzfHO3qctPzz9/eGuGMR68jeqwb1fNopT1p96mPVJxGcQK+0wU5U5PO2dSg
	UAcd0qdKIzmSHyyIkBmen+jHlTDzLtA6jFeLXWIA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64hfj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:20:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFaSxx015601;
	Mon, 16 Mar 2026 19:20:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n61tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:20:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJK1c113959640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:20:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE56120043;
	Mon, 16 Mar 2026 19:20:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3307E20040;
	Mon, 16 Mar 2026 19:20:00 +0000 (GMT)
Received: from osiris (unknown [9.111.14.147])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 19:20:00 +0000 (GMT)
Date: Mon, 16 Mar 2026 20:19:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC PATCH v2 5/7] s390/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <20260316191958.13160A9f-hca@linux.ibm.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-6-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316052401.18910-6-kprateek.nayak@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jp63ROdJGEqzzLPAkEfcmot0NjlplZOh
X-Proofpoint-GUID: jp63ROdJGEqzzLPAkEfcmot0NjlplZOh
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b857e6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zd2uoN0lAAAA:8
 a=VnNF1IyMAAAA:8 a=sh9O2zOncRWe_GGrdyEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX07XWBQ+ozw5f
 F3KjCxzVjxWd7xGV5akZ4pfsS2LeRiXR+//q9VqeLcZF7PmrTiJfkacvizmdC3aUghFmGPQ9BBg
 hoagh20PTWAIGzVFYakT4pSofpy6ulh118ODja/+iwpGZCMKPepyQJON8Xx2KwW7YPV7JU5B/QD
 hGQP8LPXGhCHn9VP7fLQiIE3MIrvwwMhpubuCe5mBGWDW33JE00QDJz5NwRLtGTG60xGmFVxlPH
 M5BIzVCP4fipuqsEG8nDtRHBivedaVvg5bycKExWZJRwZA6qwTZhRdlZc8Bfjh8L88FKEHtM1YJ
 VHapJsw+4Hs2Jp6nyROK976O7E6vl6epfvtu78z30bDc3e9c+gtQMJY9QNAuoGx8HUqYfXk05tM
 TWdUH8z9P4VZDY46HVM2IY96qyQgcp/ksHCAFh2E/LSS68+4YOdMnN+MiuQr5GvkYNexUarnHZc
 f446VCGObLHEUESwxtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160153

On Mon, Mar 16, 2026 at 05:23:59AM +0000, K Prateek Nayak wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path.
> 
> GCC generates a:
> 
>   nilf %r1,<imm32>
> 
> to tackle arbitrary 32-bit masks and the same is implemented here.
> Immediate patching pattern for __runtime_fixup_mask() has been adopted
> from __runtime_fixup_ptr().
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  arch/s390/include/asm/runtime-const.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

...

> +#define runtime_const_mask_32(val, sym)				\
> +({								\
> +	unsigned int __ret = (val);				\
> +								\
> +	asm_inline(						\
> +		"0:	nilf	%[__ret],12\n"			\
> +		".pushsection runtime_mask_" #sym ",\"a\"\n"	\
> +		".long 0b - .\n"				\
> +		".popsection"					\
> +		: [__ret] "+d" (__ret));			\
> +	__ret;							\
> +})

The nilf instruction changes the condition code and this must be reflected in
the clobber list. Besides that I would also appreciate if you would move the
existing comment above __runtime_fixup_32().

Or in other words, if you merge the patch below into this one feel free to
add:

Acked-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index c0f0d59066e2..7b71156031ec 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -42,7 +42,8 @@
 		".pushsection runtime_mask_" #sym ",\"a\"\n"	\
 		".long 0b - .\n"				\
 		".popsection"					\
-		: [__ret] "+d" (__ret));			\
+		: [__ret] "+d" (__ret)				\
+		: : "cc");					\
 	__ret;							\
 })
 
@@ -56,12 +57,12 @@
 			    __stop_runtime_##type##_##sym);	\
 } while (0)
 
-/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_32(u32 *p, unsigned int val)
 {
 	s390_kernel_write(p, &val, sizeof(val));
 }
 
+/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
 	__runtime_fixup_32(where + 2, val >> 32);
