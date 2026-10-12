Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0D3033E6;
	Mon, 12 Oct 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811468; cv=none; b=ctjmq7imqffHMKomsTqXwUVxu5VgsTkmGJNnS3h4GC5ZleBwce5NAPlGW3VW1BLEkWD/bcmqZofz4fveLpgv2sL7jo5yWhuRPOWAA9M3oi5Oo61qAmwYm32tEh+edkk9+okaVDA/5HtJK85Duse7qJWtz7bIv3u1APQBzGBWUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811468; c=relaxed/simple;
	bh=12Xwbxa/Opdmoeu6TOAkknX92kjs9JxIRuVZ/xa5ytI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWcy+gc9DauVN+2qVn7KSbHvyXH+nt6KffH6/Mo/Wrw6FW4mpgeep9uZ2VLNuf51UuTXeynqlTYs0zJ1nIfGEcEDDtO6i3C3nK6r2hmgtyG+Y4rPN8AZGpSowE2w31eA1xwHysBvfDizvxrBHR7vQkzzxwq9EcUrqugBgzA4gLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDK42VSO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDK42VSO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEJBj316716;
	Mon, 12 Oct 2026 13:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pnJ1NTDLjXYtvGpJz+t5Qp1x2sXsRy
	MjhkIG5Qsa/II=; b=eDK42VSOiN2ajiKXG/xOCyTnosKYmLy7ZEK7uQh6KlI/hX
	zIARE0ack+jqwLVws/6MCPwCLM+y6mPcQUoEEdInaLk80v+tS9Iw1B4S454v9Lcl
	XZ/vzS8d+4EGV2nJKrOJ7xTtAY0yyDAAB3YUEXBcxUY3Mp87vNFgCDJ4Sv0laU/A
	Y/XEnns8QgvXZbxv/123UUSih7hUcSRmNwLEOQsLkrzJ1lp2iv0u4H7MmrlVwJjv
	9Kmjh9RC/qI3EUpFaRoaxjzmSnw0Pmng/l6wioqLw3ZAimnfy8wUj6tkr259PN6y
	BOlgiJfQCnCWeHQDUw/VBYuokwvfkdQsSGwLRYgQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug936n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:24:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC56A31238622;
	Mon, 12 Oct 2026 13:24:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnffm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:24:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDOMD943647304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:24:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2788D2004D;
	Mon, 12 Oct 2026 13:24:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080902004B;
	Mon, 12 Oct 2026 13:24:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 13:24:21 +0000 (GMT)
Date: Mon, 12 Oct 2026 15:24:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/percpu: Drop unused output register from
 arch_this_cpu_add()
Message-ID: <4907dbfd-3c5c-483b-be25-b0df83af2d20-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114249.2898572-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6accdf8a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=g6AfgPsxOp6YMNGq8AkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lUvr0M6lbi6pPE4klfczC5es8H7oOOQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX+Cjwn97vwnlr
 g6dsUcg+v3DguXJPKQPizkHcG44fdSIRT5IOmxbYBnnV2bsmXvMadSZi1mJHEVobO0ssfWKFtXB
 HwrR92FJ1uGo6FhPhmByrT9uydiCIDmgG7kyjJf2wD1OB9Qw5Rz6tMBPN34cjs+cR0JiAApWC1O
 5eYuMlBX5OqLqx3aTgNpBQcMsOhhxqIaqQwVtrLTllORId3WdgUgWKSrfGQeH5WjBCRauBeKvwj
 PZV05xRd3FcbFGRL7z8RveKC7UlhJ0VR3almoY3T1aINDbPEwy1wn9+1LjCSvKp8a4nt7MmmT3m
 qkXAti5knmcjycjk1a8DD9pSoz2o8wmgMCMruREvCwo9/QxzRS+7K3hFKPa7xIrngZyWQcXHeFE
 QtIYXKvirCWWDctY/VGseUxdvp9No4rNc+ouL1R+4hvY0tM6/v8PBRrzKTIf8ec+7QnljvnLq8h
 tfVX+055li9rh+NL/sA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MiBTYWx0ZWRfX9iO+Bl38nth7
 6NAEOpycEATFdXik8Xut7PpIJISyqEPCzFLXlzLqvy/pBPFQBLkXwwGVqXtYVn6dK2tYuEf1y6r
 V1uQSyZnmsibeS8dIadM4Ac4bo4WYBE=
X-Proofpoint-ORIG-GUID: lUvr0M6lbi6pPE4klfczC5es8H7oOOQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120052

On Mon, Oct 12, 2026 at 01:42:47PM +0200, Heiko Carstens wrote:
> The laa/laag instructions return the old memory content, but
> arch_this_cpu_add() does not need it. Instead of allocating a dedicated
> output register old__ just to discard the returned value, change the
> val__ constraint from "d" to "+&d" so it is used as input/output
> register.
> 
> This reduces register pressure.

Do you know whether the compiler is may be smart enough to select the
same register for old and val himself?

My concern is if we force the compiler to do so we might lose optimiztions
where the val could be reused after the op.

(CC-ed Ilya)

> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
> index dfab41b43b8b..fd0a3a9951ce 100644
> --- a/arch/s390/include/asm/percpu.h
> +++ b/arch/s390/include/asm/percpu.h
> @@ -188,7 +188,7 @@ do {										\
>  	typedef typeof(pcp) pcp_op_T__;						\
>  	union register_pair rp__;						\
>  	pcp_op_T__ val__ = (val);						\
> -	pcp_op_T__ old__, *ptr__;						\
> +	pcp_op_T__ *ptr__;							\
>  										\
>  	ptr__ = PERCPU_PTR(&(pcp));						\
>  	if (__builtin_constant_p(val__) &&					\
> @@ -209,12 +209,12 @@ do {										\
>  		asm_inline volatile(						\
>  			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
>  				     "%[pair__]","%N[pair__]")			\
> -			op1 "   %[old__],%[val__],0(%N[pair__])\n"		\
> +			op1 "   %[val__],%[val__],0(%N[pair__])\n"		\
>  			__PCPU_END("%[lcreg]")					\
> -			: [old__] "=&d" (old__), [pair__] "=&a" (rp__.pair),	\
> +			: [val__] "+&d" (val__), [pair__] "=&a" (rp__.pair),	\
>  			  "+m" (*ptr__),					\
>  			  "=m" (((struct lowcore *)0)->percpu_register)		\
> -			: [val__] "d" (val__), [ptr__] "a" (ptr__),		\
> +			: [ptr__] "a" (ptr__),					\
>  			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
>  			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
>  			  "m" (((struct lowcore *)0)->percpu_offset)		\
> -- 
> 2.53.0
> 
