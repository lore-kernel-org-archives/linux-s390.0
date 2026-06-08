Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848923909A6
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905711; cv=none; b=eD8JjY6IPPuByVVUqy3BTB9LhMQ/JFqUo0IZSCzGnqUeB7rJC9XmOp3S6MjOTbdUQ/6jlrrOFox5wTx1l5U/CN3Wj00GVPCR2UnyMpA+NgJauD0KNccQqZSPkq0kVoET8UqYB0O53C5PAWZxMWuwdQ4Rto6mFcCCnUk5IV5Hujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905711; c=relaxed/simple;
	bh=hWRSjaspUQyt+0UFmfBKoIQlg4V9ag9cWDgDGGDqQbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdb80YwgTrbl6k25Q8L0ZWQOgxqw6a3Btt/qLlgJKVqAGUMrQwkWZeylIaoDarsicqcdreGFBgbmzRW+PKJpihx59fUYSRNP/SNuForY6P7bnPHc+OLXiOOaFb0HgjEbSr0hHS4G1Nz7VXX/7GradTbEv/kIj8OsUAuaZ9nLpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rVOXfjMr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rVOXfjMr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657MuWlY791195
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FXPw6G+CDB/wU5KEGE4f1oJEf0UspP
	wgUn6e4d6TNcQ=; b=rVOXfjMrCw1qDl6kJn0b9iEdMEhJTmbsGHFlxITgZbZj5a
	tt36S1az3VKf35u5Qrlha2gUSrAj9Jz1hX224zXiVZQMqpeV6o4iheszT5a3HYta
	sj3tdGVtGIHbZIWl4oulluKO4rOerJrj05XNNqG0A9JcViQi6EHFDfx0VRXarV9f
	pVa7/yvssxVOy/eLmwynOIyy9TgXxLJHFS7KXAXMaMD+xPVhmACdSEZzdKizJAak
	ggbR+3PgauXZWvLuBMrway8oi7XH8/I08nX8QJWHLpZaWZeFEs/Vc5/HXhKczqg9
	8SkBGe/WwXbK2W8Vs9+UHjohW5i/MJpJPCFuJSQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydx9jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:01:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6587ncOq030885
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:01:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fv6tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:01:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65881i0W49086954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:01:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBA9B20040;
	Mon,  8 Jun 2026 08:01:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8780D20043;
	Mon,  8 Jun 2026 08:01:44 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.139.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:01:44 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:01:43 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/8] s390/string: Convert memmove() to C
Message-ID: <3408b4d5-7542-417f-9da6-67e212071d97-jchrist@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
 <20260608053754.571282-4-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608053754.571282-4-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NCBTYWx0ZWRfX10gCsau7E6iJ
 ssmmV+EcvwHfKbkALqPwYNmRdPGEumJ8/TGVdVWXD2HSApv0ERvvyfAInHPLzf7k5pROlZqeEtr
 7yy5KQsZTtP+Tf0rDxErRtuUieDxpX9OrP555MntxXWKf8mlwzI3OmUnh6v4MRdsKmHjp+8oJUJ
 wC0ujuiZUqF9tZqqvsHIN5+M4puu7gR6xjtnFW4GGOfnkbdnbxgTAc3t6Oq/u5ccuuh2VUCOBdz
 xZnb3pSub4WCBcB8I98JjVr570dNYVuDskpgo3sSDxlwGBQTy2YNNSTn8j5Sm9yOyb6hmd16TT6
 ADlIQbmVm0NXtNK/s/bQFY9PYGaRUuDb4UIoZvAkY34sQFDMTGPB7z5n9EcyCurYkNWKf40X2rV
 +i2gbKjCbiDARcWguJI6U1d4eMu/yFpIljC9eYN+uvGooIlfSQUKB/IxbClI+zD5qAyFqs2x/zS
 QbUXYnXvi8gmpi79Fjg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2676ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=t9BTIzqf2ZDYZvhkXSkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: PWazFLU1G-6xermjkvAsSS16ov6IhFvP
X-Proofpoint-ORIG-GUID: PWazFLU1G-6xermjkvAsSS16ov6IhFvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080064

> Convert memmove() from assembler to C, which should make it easier to
> read and change, if required. And it allows the compiler to optimize
> the code, and use different instructions, except for the used inline
> assemblies.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/lib/mem.S    | 41 -------------------------------------
>  arch/s390/lib/string.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
> index d026debf250c..712b955ea9b4 100644
> --- a/arch/s390/lib/mem.S
> +++ b/arch/s390/lib/mem.S
> @@ -11,47 +11,6 @@
>  
>  	GEN_BR_THUNK %r14
>  
> -/*
> - * void *memmove(void *dest, const void *src, size_t n)
> - */
> -SYM_FUNC_START(__memmove)
> -	ltgr	%r4,%r4
> -	lgr	%r1,%r2
> -	jz	.Lmemmove_exit
> -	aghi	%r4,-1
> -	clgr	%r2,%r3
> -	jnh	.Lmemmove_forward
> -	la	%r5,1(%r4,%r3)
> -	clgr	%r2,%r5
> -	jl	.Lmemmove_reverse
> -.Lmemmove_forward:
> -	srlg	%r0,%r4,8
> -	ltgr	%r0,%r0
> -	jz	.Lmemmove_forward_remainder
> -.Lmemmove_forward_loop:
> -	mvc	0(256,%r1),0(%r3)
> -	la	%r1,256(%r1)
> -	la	%r3,256(%r3)
> -	brctg	%r0,.Lmemmove_forward_loop
> -.Lmemmove_forward_remainder:
> -	exrl	%r4,.Lmemmove_mvc
> -.Lmemmove_exit:
> -	BR_EX	%r14
> -.Lmemmove_reverse:
> -	ic	%r0,0(%r4,%r3)
> -	stc	%r0,0(%r4,%r1)
> -	brctg	%r4,.Lmemmove_reverse
> -	ic	%r0,0(%r4,%r3)
> -	stc	%r0,0(%r4,%r1)
> -	BR_EX	%r14
> -.Lmemmove_mvc:
> -	mvc	0(1,%r1),0(%r3)
> -SYM_FUNC_END(__memmove)
> -EXPORT_SYMBOL(__memmove)
> -
> -SYM_FUNC_ALIAS(memmove, __memmove)
> -EXPORT_SYMBOL(memmove)
> -
>  /*
>   * memset implementation
>   *
> diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
> index 757f58960198..66286d486ef8 100644
> --- a/arch/s390/lib/string.c
> +++ b/arch/s390/lib/string.c
> @@ -17,6 +17,52 @@
>  #include <linux/export.h>
>  #include <asm/asm.h>
>  
> +#define SYMBOL_FUNCTION_ALIAS(alias, name)		\
> +asm(".globl " __stringify(alias) "\n\t"			\
> +    ".set   " __stringify(alias) "," __stringify(name))
> +
> +#ifdef __HAVE_ARCH_MEMMOVE
> +noinstr void *__memmove(void *dest, const void *src, size_t n)
> +{
> +	const char *s = src;
> +	char *d = dest;
> +
> +	if (!n)
> +		return dest;
> +	if ((d <= s || d >= s + n)) {

While this might work on current compilers, technically it is UB.
Pointer comparisons are only defined if pointers "point to the same
object".  To be on the safe side, you would have to do the unsigned
long dance around this C standard definition.

> +		/* Forward copy */
> +		while (n >= 256) {
> +			asm volatile(
> +				"	mvc	0(256,%[d]),0(%[s])\n"
> +				:
> +				: [d] "a" (d), [s] "a" (s)
> +				: "memory");
> +			d += 256;
> +			s += 256;
> +			n -= 256;
> +		}

I am wondering here if it is worth also doing a 16 byte loop and,
maybe, a single 8 byte move.  Background is that these would avoid LSU
sequencer.  This might be a good idea for zR since there is a problem
in that area.  But that really depends on how much data you move.

> +		if (n) {
> +			asm volatile(
> +				"	exrl	%[n],0f\n"
> +				"	j	1f\n"
> +				"0:	mvc	0(1,%[d]),0(%[s])\n"
> +				"1:"
> +				:
> +				: [d] "a" (d), [s] "a" (s), [n] "a" (n - 1)
> +				: "memory");
> +		}
> +	} else {
> +		/* Backward copy */
> +		while (n--)
> +			d[n] = s[n];
> +	}
> +	return dest;
> +}
> +SYMBOL_FUNCTION_ALIAS(memmove, __memmove);
> +EXPORT_SYMBOL(__memmove);
> +EXPORT_SYMBOL(memmove);
> +#endif
> +
>  /*
>   * Helper functions to find the end of a string
>   */
> -- 
> 2.53.0
> 
