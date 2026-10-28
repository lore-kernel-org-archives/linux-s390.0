Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184885;
	b=RXKWVlxrRBQU0IAma+2ZjaDvdDvb0KJSgpKRsW2+AdECAD4oCLv0hcFmcP3za69nc1Dr
	 nB1P6jdNqHI8cyvo1xczSCntT9eMVgO+LBbkpD0tY1DmHli0Tb2rHf1kMJhTD3m/Lxr58
	 z8lB2U2HkvlaKN9uk3qOZsg2D+3Ha6WrtIpDNTUVxfS1itfEl05tma3qyX+3rLW+lySXY
	 rjVi4KDzoKUFEYwUzaVamZahvm9+FH5W29dEzUCj0QO3KS/mL6p+75l8894HUrvoaSW9c
	 hWzuxu/8+P6WvvwizE3bOYwY6zyMa8lirvuCg0W9hObSbxokVMJMVI+XgZzDwzXjqgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184885;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2TPO4K+iBrOR0tr7c3kv/gXItbck8I042jWrXEyrrs8=;
	b=eo5hgGb7wd9/xOu/0v+15EZqofeq5nhfLJKGJ7S6RxpSsrGsTz4OSzue3LgA4Y3UShvN
	 EJYx+nVGlNlJNlrKPXQx0AJAgvw7Jb0V0RQPyYlt6NnbHJmThXxYdxfbQFHZiMQItPgTj
	 TWsVZkFawhw0CxfcvEGBsWG+Re22xhIK3R7td47tV+VeEGZVAx8AhGgj/QADzN8N95nyp
	 rDUG6zJLhaSmVYuk8gvwT9USGaGLQ4zGhHUo6uYzk20HjG1mmR/XgQ0tP6ckuWk8tgU3R
	 mAf4crSO4h5w49UgnrV4x7IoYkMtKkuFSvb/RJAFOTEQnWC6bFP4YY3nTZ0Wi/5pDEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BzneYWaz;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11D606A320;
	Wed, 28 Oct 2026 10:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD11D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BzneYWaz
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8i37U978954;
	Wed, 28 Oct 2026 10:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2TPO4K
	+iBrOR0tr7c3kv/gXItbck8I042jWrXEyrrs8=; b=BzneYWazy3VOj1e+wyY/ko
	3NKvmuKPGHwI6oJFAgEkLjnykb8UwW0e3Rhg/RUb9cRjnvZTQPuHCHWDTmTzf0q7
	E5rkITDQClmm16pRn/7U7UR09YzyQdklq/9v8Rof4fchhdP4tRf1f3THPvdYIP1k
	RwTfzEjbKsbdSsnI50lpcmEOoyZlmHnJgPnM2kyyCSqr/rp7O1AmRJ1PWyAZkcmC
	5iqLwnM7pTgQ38v29R8e1BFq771UFNBSdnvSX1Q3j5jZz/tDdYBIClaKNb7NHCto
	9c4coHqJDrJd1YsOYh791yEeRiBcqx/CC9X9Kj2phDSVV7xRT0jnhC7BWbGQi3kg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm644970-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:54:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8Jtk51274944;
	Wed, 28 Oct 2026 10:54:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7vuet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 10:54:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SAsdDc49283500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 10:54:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8350420049;
	Wed, 28 Oct 2026 10:54:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECFB20040;
	Wed, 28 Oct 2026 10:54:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.73.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 10:54:39 +0000 (GMT)
Message-ID: <22f1a455-fc80-4a0c-aa44-a347710bacaa@linux.ibm.com>
Date: Wed, 28 Oct 2026 11:54:38 +0100
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
Subject: Re: [PATCH v2 02/10] s390/ftrace: Serialize text patching with
 text_mutex
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-3-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfX9nSjiuhgBTnj
 RJJuVqhs6Xo6N2gfUZQrlU1esm6kjRbR3EdyApDGtXGxbOp0KcN6Vub+GavQLoYpI1AtEA7ZoCj
 TybrfGdPeqtRtyVhVGnXVTkEhxmHByw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXzhCnfIeyHmjw
 HrkWd202zoKPaj5vUXzKxqglJZFMeJvddn5WczNCpTYCId7TfPgANnWaqWYelWULOWF/saiVdVr
 EAvNNzOqdRGR/FXgWUezEBpKD5w6OAeIIjGH3imHxubTslsfgydKDbIbxCdyE2rD+AgrMB1JwkB
 nxUEKNBAFyqYr03TDX/R/MdU21spCzpJV6bqpK8UjMjFosgtE3eVrNbXlhvxmqcFievpATNA+2/
 KGjjoDKT4NeS1o35gvvUv6iwWpDCaGTQihnkwrJeBn1v54ufHvb46+hVxRmewXya3oPNOOaIIrd
 2BUgnFBUGc9oC9c/xd6/2RTp3QkmHeXZwtMVvbHqeE8fAdCJSY91yE8EPUykSL/S1emRVAVCgmk
 IJCX2BXp2A5cPnuOfn7yxVC+8+4TmwL5ENH0qAudBt70N+bN9rX6hGyP4ckwciwGibcDG/qK/Uv
 XP35uAKKtR39vsEqBmw==
X-Proofpoint-ORIG-GUID: GvLdZekchwy3P3mQvlWPG63oRmcYniXy
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae1d474 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=wXU5UHentgW_jQT7nqkA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: GvLdZekchwy3P3mQvlWPG63oRmcYniXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280042



On 10/27/26 15:30, Heiko Carstens wrote:
> Add ftrace_arch_code_modify_prepare() and extend
> ftrace_arch_code_modify_post_process() to acquire and release
> text_mutex when ftrace code is modified.
> 
> Also add locking to ftrace_init_nop(). This way s390 uses text_mutex
> like e.g. x86 and riscv.
> 
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/kernel/ftrace.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


