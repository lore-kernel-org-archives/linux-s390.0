Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE528643A;
	Wed, 22 Apr 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861547; cv=none; b=Lm3uXGIjARtGNUL7i+WrSDj/WmZjhiRKLUvAeCs4+n/+grhcL7Gopdm8VQPC8oOGSWRmVdQDdDMjZUja+mKbF3w9Yud/7xO76jnL8mb3ABN1LlzpTSzU1zpsk0fBCYWzPaLmLBWo6ILijf4tzK/0QBE07pETo+hvcvNZLSJSpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861547; c=relaxed/simple;
	bh=thvAVlCvAes190lnDw+lOhex8Pa+v7SrF9M4FQ3yZ0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjriWg0+tDA0Dzy1BQNcLoIOz5bs6E7lvogIXr8J+4a8qrvm/sIFj2eNHQ2H6sICBluVpR1O6dkXBlY+HHwCQb9TrxrEiHjSXSMbDpTQDRvICJnZcv4Ey+7mlm7u9n30BnbNLxo5/aDcBd9APzGRcInQ18XZDrOremPCSjzm3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JrXdpL0A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JrXdpL0A"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LLmL7B1018638;
	Wed, 22 Apr 2026 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TjDVsC
	UPs8fh1Nd2MpH+1/UlUodhJ5NU+oyhQOx5anI=; b=JrXdpL0A11GblVRPlZEU5A
	MIiiovlWZUwn7Nisf8VdI8xjAy1g8bfOjgpeyjEKe/0cZqZm/z7mTfIc/4ubMPKL
	/xCJEbNcpYTApFswp5Xd+j72Tt3FxgJ0mGzELNS209GKwyiuSjljRbWrgePIKDmA
	1FQQZ1B8lN7FRBKEY1k/iTl3nKyxhA4Q3eh48o8Gmt0jRypUs/e3S2XzMahg5Pw8
	PpcOu+TqhYB2TuJky6kF1OQ0/50YcAzeLXPzwUMXoEWcEjtKBflJwKpjw5Yoa8QI
	7eNELZpfOufy00k6oH1s43MiCVeJ5y5tQ0xJl6LttaGiVhdtqXgB4ms0AxYejfcA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrav0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:38:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCZlWl009273;
	Wed, 22 Apr 2026 12:38:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky27q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:38:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MCcm2G29885056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 12:38:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6544420043;
	Wed, 22 Apr 2026 12:38:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D70020040;
	Wed, 22 Apr 2026 12:38:48 +0000 (GMT)
Received: from [9.111.42.51] (unknown [9.111.42.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 12:38:47 +0000 (GMT)
Message-ID: <6349a393-784e-4cf3-a9c1-902b2d292222@linux.ibm.com>
Date: Wed, 22 Apr 2026 14:38:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 5/6] s390x: sclp: Add detection of
 alternate STFLE facilities
To: Christoph Schlameuss <schlameuss@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
 <20260421-vsie-stfle-fac-v3-5-3cee84efefa3@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260421-vsie-stfle-fac-v3-5-3cee84efefa3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gxIXw6WApY2sdxx0JIbRZN6nziMSw5Ov
X-Proofpoint-ORIG-GUID: gxIXw6WApY2sdxx0JIbRZN6nziMSw5Ov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfX6gszI6l5cA9z
 cFCcuQi0jONdMQzB1Iiaia5lFkyCuLA1rqrei2PzEP0PAZfMKgXV8eWi5hCAbEO/V7aeyZ7CVYL
 6TgV0eFhVzGKboNMDYdtOOxprXKISnOV+5cIYDbmuemUpzw21sEQ51A4QF7dUH9G+UNG8AKk+pC
 9wqvYO0mV8CmsZjacnOxolE3a1P1rVyRPex9sBmx5RhtYNp59FA9sxoLGLXr32Qsw5Mc7NhkrBN
 hA1nonEeNxfWLgZzrzo36NS1ZAWmBh+rCmA0JTA25uPqPgixcvWeIPocXyUXZCrDEhqauNXpu2P
 RhHT3TjxQDd+fcxjQlKSaqa2ZRy3qYrDbORWxs+gWJQrZ2zNvSv/gw6wZ6xwlj427+vWbxXDqVX
 wMe9Jb5aDiynOKNikk6kHrpeRp70KU+XvVb1oCUKPMn+JNV4L6HrvWf0e20Ut9+NyWsR8rrkTOX
 XxugCrKIUNqU9Nfa7YQ==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e8c15d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=gR6WJP-61H6f6fgvF74A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118

On 4/21/26 13:31, Christoph Schlameuss wrote:
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> Detect availability of alternate STFLE interpretive execution facilities
> 1 and 2.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   lib/s390x/sclp.c | 5 +++++
>   lib/s390x/sclp.h | 4 ++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index ad2ba99ee1e1..d4e7eff66c31 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -181,12 +181,17 @@ void sclp_facilities_setup(void)
>   	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
>   	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
>   	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
> +	sclp_facilities.has_astfleie1 = sclp_feat_check(116, SCLP_FEAT_116_BIT_ASTFLEIE1);
>   	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
>   	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
>   
>   	if (read_info->offset_cpu <= 134)
>   		return;
>   	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
> +
> +	if (read_info->offset_cpu <= 139)
> +		return;
> +	sclp_facilities.has_astfleie2 = sclp_feat_check(139, SCLP_FEAT_139_BIT_ASTFLEIE2);
>   }
>   
>   /* Perform service call. Return 0 on success, non-zero otherwise. */
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 87af429b5798..eb574350d678 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -129,9 +129,11 @@ struct sclp_facilities {
>   	uint64_t has_cmma : 1;
>   	uint64_t has_64bscao : 1;
>   	uint64_t has_esca : 1;
> +	uint64_t has_astfleie1 : 1;

I don't think that we need to order this by appearance in read info.
The constants seem fine so we're only arguing about technicalities.
