Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3D3B7B8B
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910671; cv=none; b=kHxrjrJusKGu7aKSPKoJQm9Jvl5CmdFtrRP1HK3NXRAn5rwwPc/L5boclO8etZOSqigsaTd0tGAhXNp4Pef0HIipcmQbfbwezNZkFvhQ4vhH4lGJVseqktKINQ6a4XlGPbQhecz1jnNkLsbtsLjTdY8O0ncYD6PoSO+sOba4CgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910671; c=relaxed/simple;
	bh=GLy4XrWst8Su4zrE2RbunPNNn4tber8MYmve0zx3Uio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwGfpV7qjfx9stmHp4XgpnMvumLYN8BOsATZkhG1YQxxuMvw7RgzkfJ/8B33La/ZZ0tpIhSz15zpDgbFK9PP5NPWMTh/0Lf68AXSEAO1KEOvKjeMGQD1rOSJvLeAPgON3F0rZ6wqJfWnNZvSBS5ilpUntvjbJIE8fdCcor5T+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmsdaHMq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmsdaHMq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588UelN1477263
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RGUn+gFuDiROihfLLRNgByF4u95ESS
	70aM32JcOJwgg=; b=jmsdaHMq1Hl9CCUpiqs6ULyIU+IiSylwP3Bj7jF2zOTngm
	bdTuIB94uQrq2mb+s4MXLCdqE/j2S9Z4UOBKVgU25SU7doWDIrz2A9uN8x8Aac8m
	BAetb8DmoPmQHvGUHA6HQNKqz8pyG1yJo/U2I0BeCK5/kvkHJCbQwfeDBtRSWy5C
	b8wL0tDiqX4AAoyATrEOYWbbElUz38Qu/PP1NQh+4JL6QAKPbQYCm6R9L5UG2wEf
	AMqcMDs5Eclp7oGEBegH1/ocGxM7rbEM0rVEu0VDbOLlX1GoFs+7ZaMqrRTfLGlH
	KonkuiEF7ExPicGYxHk1s1fsgyKEt20NELP9R79Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qehp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:24:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589Jh07030644
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:24:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpvtn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:24:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6589OPuA46793012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 09:24:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CBEA2004F;
	Mon,  8 Jun 2026 09:24:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7532004B;
	Mon,  8 Jun 2026 09:24:24 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.139.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 09:24:24 +0000 (GMT)
Date: Mon, 8 Jun 2026 11:24:23 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/8]
Message-ID: <ecdecc38-ede2-4811-a8f1-e6eb4a9057b4-jchrist@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a268a4d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=4FvDrmaL7glVqQ80eM0A:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: uOdul6_2kCm3X4kqTvoWAJXC5pqQlebN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXxF1PqgNSRRP0
 ldVnCCkAZktPY+1fECo7tpO4r/i9PKT9q+iK68V21UBwZMWCgsAvUGjN7k5wC1Q6oFRmjrLTL88
 Qkqk/QFkia23oo2/KvcuVsMSGdxd/NVJGrJLmuO+qDVk1T9oH1uuAtihid9C9C798JZJgqy8QUU
 7T5W6+s1e4p6mOA1AzBB87djB4AA7jQSehOHjO8nZ8gwYb3leHejrCInP3rm3IxO2nFJmXXULi3
 6OeFzE2ksQwYJUCKibmanhN64qUJArg82qMoRBFa7Xeyf8WK7wdhOLkA1b2eyEeRirJBstBsvFI
 1yzt7CSbYBfAPzfnPgvvJDsl1s+el4Ty99J7a4HqEdwHID2srx+foJHNCQrVHPvhJqR1h/TFzy/
 In4Q+Yj/7NCJk7laP/vw5fJTggNSeuipyypvDpNKBCRJe4WkE9sEx7g8vuJzjQlUrgzEHkQZbp+
 z5vRRq6DjNYtqyL9JZg==
X-Proofpoint-ORIG-GUID: uOdul6_2kCm3X4kqTvoWAJXC5pqQlebN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084

> v2:
> Address various Shashiko findings [2]:
> 
> - Off by one comparison bug, which leads to slow path for memmove()
> - Incorrect ifdef around __memset()
> - Incorrect commit description for memmove() conversion
> - Missing noinstr for tishift functions
> - Missing header guard for tishift header file
> 
> v1:
> While working on something else I stumbled again across the various mem*()
> helper functions, which were implemented in assembler to avoid recursive
> calls [1], when using the compiler's builtin functions.
> 
> Convert the functions back to C using inline assemblies, which makes them
> hopefully a bit more readable and maintainable. Also improve the memmove()
> implementation by using the mvcrl instruction for the backward copy case.
> 
> Thanks,
> Heiko
> 
> [1] commit 535c611ddd3e ("s390/string: provide asm lib functions for memcpy and memcmp")
> [2] https://sashiko.dev/#/patchset/20260607162937.2927356-1-hca%40linux.ibm.com
> 
> Heiko Carstens (8):
>   s390/purgatory: Enforce z10 minimum architecture level
>   s390: Add .noinstr.text to boot and purgatory linker scripts
>   s390/string: Convert memmove() to C
>   s390/string: Convert memset() to C
>   s390/string: Convert memcpy() to C
>   s390/string: Convert memset(16|32|64)() to C
>   s390/memmove: Optimize backward copy case
>   s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C
> 
>  arch/s390/boot/Makefile                |   2 +-
>  arch/s390/boot/mem.S                   |   2 -
>  arch/s390/boot/string.c                |   6 +-
>  arch/s390/boot/vmlinux.lds.S           |   1 +
>  arch/s390/include/asm/asm-prototypes.h |   4 -
>  arch/s390/lib/Makefile                 |   1 -
>  arch/s390/lib/mem.S                    | 192 ----------------------
>  arch/s390/lib/string.c                 | 210 +++++++++++++++++++++++++
>  arch/s390/lib/tishift.S                |  63 --------
>  arch/s390/lib/tishift.c                |  64 ++++++++
>  arch/s390/lib/tishift.h                |   9 ++
>  arch/s390/purgatory/Makefile           |   9 +-
>  arch/s390/purgatory/purgatory.lds.S    |   1 +
>  13 files changed, 291 insertions(+), 273 deletions(-)
>  delete mode 100644 arch/s390/boot/mem.S
>  delete mode 100644 arch/s390/lib/mem.S
>  delete mode 100644 arch/s390/lib/tishift.S
>  create mode 100644 arch/s390/lib/tishift.c
>  create mode 100644 arch/s390/lib/tishift.h
> 
> -- 
> 2.53.0
> 

Silly me forgot for the whole series:

Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
