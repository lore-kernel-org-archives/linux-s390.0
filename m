Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C62F069D;
	Thu, 13 Nov 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047732; cv=none; b=BNkR4djEFBsOoS0InYiOtYem8eSzOsPwsjEK3ysSuKzUva3xhLNeaDRk8t47VqoYXhDwecRU7oeGp6UpptZ2FsQZXnSk+hUjcugSWdcHPHv0CuikMrLSdfWK1A0bhx1JRP8/GJhzV+mXLvj4p62udqoWweDHnGlRDzTTItUQkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047732; c=relaxed/simple;
	bh=xl0Wj32ElFByT7POZlmtgHiowDCIQXU1fq2ns2atUCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NN1GikwMiR3HrNWfNzg7twark4ch6I90F4Zk45nF/OxfYiATmMNyYYwtJ2SOIrNf7XwbXn+744wdV8I8azTbaT9fe3tDVGgIu4Rt227sOoek1t+oacBRlsrPXdhHZXm+6MIs6G589/L6SRqxOPddy+LoXWQR+emsuVtP9zl+rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IsIq0zZk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IsIq0zZk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8rUoX028843;
	Thu, 13 Nov 2025 15:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QD37x+
	IqLLHJ5yViqZyM62WIGvkCbM8wiyyWiCARFiE=; b=IsIq0zZkMjcC8e05Aw0OD2
	kuU0cDIrwzNHe/rJZaIJp7VatN6T2pYbu6qIj//oMWE8d9RKuHpbjetWftX5JvKi
	/5XEsAOluGuOnbODfC7nnqb4C/wiqA7PFLPAWe2joNfQGeIFSXjczjtU6JLh/m6z
	tC06PI4I3ToE2gfJ8ii2cZywWTAnl0QwFLmO0JpDYbuyck+AbogpIwBkBFpM8ebz
	hp5kBkec0N4QNxrLpMHOzstthPnXs9sVYZQlwd99Gybmj97Ko6MVF9i36gX4IWaJ
	XefhDl4ph0C1ZoK8RXjepsU7SbCxEcnb7YLJfQyr7WdbXEq+JmPnS6XxCb6hHbYQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8gs1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:28:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCnglZ008190;
	Thu, 13 Nov 2025 15:28:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6n6gux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:28:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADFSNQh27525794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:28:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3352758059;
	Thu, 13 Nov 2025 15:28:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AFBD58043;
	Thu, 13 Nov 2025 15:28:22 +0000 (GMT)
Received: from [9.24.12.149] (unknown [9.24.12.149])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Nov 2025 15:28:22 +0000 (GMT)
Message-ID: <534cd250-1ebb-4c72-8c6a-49cef88568cf@linux.ibm.com>
Date: Thu, 13 Nov 2025 09:28:22 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] s390/ptrace: Rename psw_t32 to psw32_t
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel
 <krebbel@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20251113150731.2697279-1-hca@linux.ibm.com>
 <20251113150731.2697279-2-hca@linux.ibm.com>
Content-Language: en-US
From: Jimmy Brisson <jbrisson@linux.ibm.com>
In-Reply-To: <20251113150731.2697279-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX0BHUVGZbC1G1
 6Cnsb1v1kk6osbUvuy+ReJydwePPCGeSLoA0yC3bAyoPLHe3Z5cFOWugeevF6w96qkTlhoC8Ukd
 n3D45Zm5TEciemxmLBtqVR0Yifnjb0ShbbZ9Qb2f3w0tRskoM3hG/NhbRLoiD4bZrmQ/XWhPy3V
 YM8xj2X1WdbIkmxLBgYIrqVdFGa0K+4xogs5EKV4qCGm21s0+gjuN11+6RoQ3uEBMPtZofepLiv
 QopfraqKuylHWf41p2OAjaAQ4KEy5dKV0a+sXyBLdw5Erl4e17eu6l6+ZVMgRqaLG9FP1aXkwPq
 esWGL0Cep67W5rODIEz87bOZPl9WAmigDFnHyKL7ymrsWc+SVDb1xc0wzAaL6nryF3yqhmLEJSq
 7z86Z7mxVgrE/Hhb8mVu6wrAzQq/KQ==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6915f91a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=JAbWjcxYnC2GCM1842QA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 6dnRP_uNfKpyNovLviAXkGB_tUuIJYju
X-Proofpoint-GUID: 6dnRP_uNfKpyNovLviAXkGB_tUuIJYju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

On 11/13/25 9:07 AM, Heiko Carstens wrote:
> Use a standard "_t" suffix for psw_t32 and rename it to psw32_t.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/boot/ipl_data.c       | 2 +-
>   arch/s390/include/asm/ptrace.h  | 2 +-
>   arch/s390/kernel/compat_linux.h | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/ipl_data.c b/arch/s390/boot/ipl_data.c
> index c4130a80b058..7957cc6554e7 100644
> --- a/arch/s390/boot/ipl_data.c
> +++ b/arch/s390/boot/ipl_data.c
> @@ -12,7 +12,7 @@
>   #define PSW_MASK_DISABLED (PSW_MASK_WAIT | PSW_MASK_EA | PSW_MASK_BA)
>   
>   struct ipl_lowcore {
> -	psw_t32		ipl_psw;			/* 0x0000 */
> +	psw32_t		ipl_psw;			/* 0x0000 */
>   	struct ccw0	ccwpgm[2];			/* 0x0008 */
>   	u8		fill[56];			/* 0x0018 */
>   	struct ccw0	ccwpgmcc[20];			/* 0x0050 */
> diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
> index dfa770b15fad..f2ecc013a48a 100644
> --- a/arch/s390/include/asm/ptrace.h
> +++ b/arch/s390/include/asm/ptrace.h
> @@ -99,7 +99,7 @@ enum {
>   typedef struct {
>   	unsigned int mask;
>   	unsigned int addr;
> -} psw_t32 __aligned(8);
> +} psw32_t __aligned(8);
>   
>   #define PGM_INT_CODE_MASK	0x7f
>   #define PGM_INT_CODE_PER	0x80
> diff --git a/arch/s390/kernel/compat_linux.h b/arch/s390/kernel/compat_linux.h
> index ef23739b277c..133f22b5deeb 100644
> --- a/arch/s390/kernel/compat_linux.h
> +++ b/arch/s390/kernel/compat_linux.h
> @@ -33,7 +33,7 @@ typedef struct {
>   } _s390_fp_regs32;
>   
>   typedef struct {
> -	psw_t32		psw;
> +	psw32_t		psw;
>   	__u32		gprs[__NUM_GPRS];
>   	__u32		acrs[__NUM_ACRS];
>   } _s390_regs_common32;

Looks great

Reviewed-by: Jimmy Brisson <jbrisson@linux.ibm.com>

-Jimmy
