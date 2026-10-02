Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEC472543;
	Fri,  2 Oct 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932432; cv=none; b=Qidj5eaib/xRVerFSSXbiAjt+BWIJYZC2xMMd1YOszVPxrNIdMe9okFZz4uVLS1dlxxnLK4wvJ3SAUOYG5C0GlF5UexNJNG/Nl/Z6OwK+dtiDao1zaXBlpwu2lVdiYSz0ZYQiMrXGzfIN4BybUFnLF55MA6Hp/HUoWrP3aky+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932432; c=relaxed/simple;
	bh=MGk6FtfzjmFuuLRve8K+9rY1OcDSiDo6JA2VJMjw4Dw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dvsvAAksv3ZwQcLf+HHiqF8Pm/JoC3Eek9ysjenDN/WB/KcWz/zQxhk2MWVhlXvP7xDK9l537nleHg/lgG7V+UvmGZsRPfbq/4DMeDaRCqZzujE5OhplD5gmyeoo8WATUUYlLO5eNxbjMi0q/wpgDEsD1pxp1YmJ4Ej89hS299E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZeiaCCb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZeiaCCb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265Uap2682369;
	Fri, 2 Oct 2026 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0JbsvB
	Pi9kRKdXeDSaZfk/gefteQfVQjDHPBbH0otDQ=; b=gZeiaCCbdV2KofjoAjNiRt
	S2HrMIaPNlv1apWOC76+eGHuhQ62HIxiKFgksMdauOCTax8bk1WquI/AhIpBsYFU
	RjayysVmoYGuO77d4BZ8Yus+LBD+jyZaXrLJzXbfF+jVWcEHJFqmAgb6/Mu7kvaf
	be7pS+MqAV9wpjULA+N8Q2XSgfOGpHh7yZNAdBLDkcrcJY6XNjYDjdchoxHvNfYP
	1iqNnsaK0NQ5/0Gou2s1wkHRRSRxrZZaPTlt+QfunbGISYs8LGUB/MbRTfTtc+iq
	imb5Te2//1dY3q++T0icvqpXV7FWKK3nM48cPf1Z2DJCoqgtcs7kPhrOM529EbHA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4feq21h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 09:13:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925lVW32118894;
	Fri, 2 Oct 2026 09:13:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7y618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 09:13:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6929DlLT61014344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 09:13:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326445805A;
	Fri,  2 Oct 2026 09:13:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B5858051;
	Fri,  2 Oct 2026 09:13:44 +0000 (GMT)
Received: from [9.87.132.132] (unknown [9.87.132.132])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 09:13:44 +0000 (GMT)
Message-ID: <db924180c5ebe6d7237cb2cb9caf0dc0b6b8c74d.camel@linux.ibm.com>
Subject: Re: [PATCH 25/32] s390/pci: Convert inline assembly to
 EX_TABLE_INSN
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily
 Gorbik	 <gor@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan	
 <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Stefan Haberland	 <sth@linux.ibm.com>,
        Jan
 Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich	 <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda	
 <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20261001103247.1989111-26-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
	 <20261001103247.1989111-26-hca@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abf75cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=R3rtcIPnULuaThjcOJAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfX3XYRqozJjStZ
 SMFKk9vpYI9W3CoEQmT0rrhWigqnRHROiYlSdnN0qAlWs5jdQIwZau/pC0p+nQJyY/+kWiOP5vc
 lKeBmSTlaP84HGWt+7T8jcZogS5uLCA=
X-Proofpoint-ORIG-GUID: 9hg8TqHTrZRlnAr6mKK0Acb3u7dVvXDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNiBTYWx0ZWRfX2tx77CmmMAA7
 2ZCm7PSvwdizqL5TKVIzrUx2ICCBqNxs9no8qkU2yuKTH6S+QTzt+qyMVs3xvU+5Or+mn6SefFF
 i64NhwS7FDKDO8VgiSIAA9Bv/cPVQSFyziQrJS15uxyS3bdvvps2aSKB8CdoqMig/2Df0vN/PRC
 uzHAiMpdNZdJTWJ1btslQ3PT01Ee2moBUd7WNPOauQlgq4Z5G6Y6M4kTX9SE7JusRU/IunGvMh4
 0cROFKjXXC9UwPU/qONlB4grXq/Ga/8UqeAN+N7Ff4uVShT0XRPx9QV03C7cGBLiRteAHDOzFDt
 TErJZ2kdz5fjTM5OzE2htpMjE26JcPH62T3hWronr156J70gGxbr5JXPzN5VHAaR84rSOs9mdc7
 n5joPR9iY/hvgHzKPs9BASevz7x8bIxt3VkaizQ62qIMk7dXOyaM7N13Mg7Vm/4ykdaSEvN4xXR
 0wQUPZq48sGEBnLFNMA==
X-Proofpoint-GUID: 9hg8TqHTrZRlnAr6mKK0Acb3u7dVvXDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020036

On Thu, 2026-10-01 at 12:32 +0200, Heiko Carstens wrote:
> Convert all pci exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/pci/pci_clp.c  | 12 ++++++------
>  arch/s390/pci/pci_insn.c | 36 ++++++++++++++++++------------------
>  arch/s390/pci/pci_mmio.c | 28 +++++++++++++++-------------
>  3 files changed, 39 insertions(+), 37 deletions(-)
--- snip ---
> diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
> index f3f79ba78410..8b49175b0031 100644
> --- a/arch/s390/pci/pci_mmio.c
> +++ b/arch/s390/pci/pci_mmio.c
> @@ -39,10 +39,10 @@ static inline int __pcistb_mio_inuser(
>  	asm_inline volatile (
>  		"	sacf	256\n"
>  		"0:	.insn	rsy,0xeb00000000d4,%[len],%[ioaddr],%[src]\n"
> -		"1:	lhi	%[exc],0\n"
> -		"2:	sacf	768\n"
> +		"	lhi	%[exc],0\n"
> +		"1:	sacf	768\n"
>  		CC_IPM(cc)
> -		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
> +		EX_TABLE_INSN(0b, 1b)
>  		: CC_OUT(cc, cc), [len] "+d" (len), [exc] "+d" (exception)
>  		: [ioaddr] "a" (ioaddr), [src] "Q" (*((u8 __force *)src))
>  		: CC_CLOBBER_LIST("memory"));
> @@ -72,15 +72,16 @@ static inline int __pcistg_mio_inuser(
>  	asm_inline volatile (
>  		"	sacf	256\n"
>  		"0:	llgc	%[tmp],0(%[src])\n"
> -		"4:	sllg	%[val],%[val],8\n"
> +		"	sllg	%[val],%[val],8\n"
>  		"	aghi	%[src],1\n"
>  		"	ogr	%[val],%[tmp]\n"
>  		"	brctg	%[cnt],0b\n"
>  		"1:	.insn	rre,0xb9d40000,%[val],%[ioaddr_len]\n"
> -		"2:	lhi	%[exc],0\n"
> -		"3:	sacf	768\n"
> +		"	lhi	%[exc],0\n"
> +		"2:	sacf	768\n"
>  		CC_IPM(cc)
> -		EX_TABLE(0b, 3b) EX_TABLE(4b, 3b) EX_TABLE(1b, 3b) EX_TABLE(2b, 3b)
> +		EX_TABLE_INSN(0b, 2b)
> +		EX_TABLE_INSN(1b, 2b)

:) this and the one in __pcilg_mio_inuser() must be one of the best
examples why the new approach is cleaner and easier to read. Well done!

>  		: [src] "+a" (src), [cnt] "+d" (cnt),
>  		  [val] "+d" (val), [tmp] "=3Dd" (tmp), [exc] "+d" (exception),
>  		  CC_OUT(cc, cc), [ioaddr_len] "+&d" (ioaddr_len.pair)
> @@ -227,13 +228,13 @@ static inline int __pcilg_mio_inuser(
>  	asm_inline volatile (
>  		"	sacf	256\n"
>  		"0:	.insn	rre,0xb9d60000,%[val],%[ioaddr_len]\n"
> -		"1:	lhi	%[exc],0\n"
> +		"	lhi	%[exc],0\n"
>  		"	jne	4f\n"
> -		"2:	ahi	%[shift],-8\n"
> +		"1:	ahi	%[shift],-8\n"
>  		"	srlg	%[tmp],%[val],0(%[shift])\n"
> -		"3:	stc	%[tmp],0(%[dst])\n"
> -		"5:	aghi	%[dst],1\n"
> -		"	brctg	%[cnt],2b\n"
> +		"2:	stc	%[tmp],0(%[dst])\n"
> +		"	aghi	%[dst],1\n"
> +		"	brctg	%[cnt],1b\n"
>  		/*
>  		 * Use xr to clear exc and set condition code to zero
>  		 * to ensure flag output is correct for this branch.
> @@ -241,7 +242,8 @@ static inline int __pcilg_mio_inuser(
>  		"	xr	%[exc],%[exc]\n"
>  		"4:	sacf	768\n"
>  		CC_IPM(cc)
> -		EX_TABLE(0b, 4b) EX_TABLE(1b, 4b) EX_TABLE(3b, 4b) EX_TABLE(5b, 4b)
> +		EX_TABLE_INSN(0b, 4b)
> +		EX_TABLE_INSN(2b, 4b)
>  		: [ioaddr_len] "+&d" (ioaddr_len.pair), [exc] "+d" (exception),
>  		  CC_OUT(cc, cc), [val] "=3Dd" (val),
>  		  [dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=3Dd" (tmp),

I went through the adjustments and they all look correct under the
explanations you gave in the cover letter and prerequisite patches.

So feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
