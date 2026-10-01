Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A1327C08;
	Thu,  1 Oct 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841992; cv=none; b=Bn3r0FBYalWRTv9XRNMCyxDtVBFJEsyNXaCXw3OpnaylQlId5yNjho5jKAP/ZdMDfQaLIzVCeBMOJzhi4qcFFuY9975X/7F2imWbRT7QMmiQPYHf8f0QbvpGtSKpP7s1oqGd+Kch6FQIjGo+BjIL4R03QEHaM+e4i0nf7T++bsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841992; c=relaxed/simple;
	bh=FbcwJTHY0e4prfQK9e51s23CbDVnvKyJff3VHTaqr80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/9mQxxsci0PW7hJufoDunCDerC5O64QMA7mpk8C4PgxxUMr/WAAsK52pYUvYiLSPRke3OTevv02JfA7DgTl3xDftbW7+N2e8gFPnqXtN4/duGyh0U9UqE/XOdE2UBvPEVF8e0BYJxPW8Rk5S18xHg45CNeum56YNHLyhXqSsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qdXCR37X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qdXCR37X"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175XFu907358;
	Thu, 1 Oct 2026 08:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Thg/qz
	Yqeu1lpk1hqfrCpFCMVZeUO2HAEDQm5a2yUIc=; b=qdXCR37XlpuObnciG312dF
	5aeNG+IAHNfFIKisaVnmb1AKgyJFSbIGKV7b+vmykl99A+VrhMmP2OvUXYwl7GaW
	6trDJ/AEX83Pgyxl0UrTaElCfXM3FHQ6SPAsz0UZbE/yD4zBKAB4qVT5zI+2c3q8
	PHBUnpbValwoogXobcwFGCLzpUPhHWl8Ct9VQQT+vdo5UC60OJxiL1OqOOrx1E/X
	eGZUGDcMNFwXaaQT2tRbqE7TwC4Fa8Q5Fszy/8Ja7j6Rv812FIx0yJ8CLRDvJtSf
	tbSYvhwUGOfog8bsrm6qFXCKAOJrTPCCeDNwHZkYxKJ7slDaIL+6z04HIgA1oSiQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkh5sv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:06:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Vjt520696;
	Thu, 1 Oct 2026 08:06:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpfsqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:06:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69186GO053084474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 08:06:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF112004B;
	Thu,  1 Oct 2026 08:06:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1177A20040;
	Thu,  1 Oct 2026 08:06:14 +0000 (GMT)
Received: from [9.123.15.93] (unknown [9.123.15.93])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 08:06:13 +0000 (GMT)
Message-ID: <8737cb76-a399-4443-9ef6-f251cd23670a@linux.ibm.com>
Date: Thu, 1 Oct 2026 13:36:13 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 0/2] s390/ctcm: Fix timer corruption and
 use-after-free
To: netdev-bot+sinfo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
        aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <179075218956.31693.13833464260090345125@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <179075218956.31693.13833464260090345125@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: UCx0HP0mPee-m2TZdjQ3p96uYK-3scYW
X-Proofpoint-GUID: 8yD2cODHGK2AWanJUQoQny89lpsPs3AS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMiBTYWx0ZWRfX1A5gPl8KV5qG
 zuO5y4vjPygMIw9uINTLpTVCus6XFoLn8mHH3ENgO64DsFcFujRtRMWLmuViAFlX578Op7d0iox
 qm+Ye3n3+tDBFx2uMRAWJv88L3diln8=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe147d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=xiR1IYxcKOTdaxYgfMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMiBTYWx0ZWRfX8jHF6RKZ/h/o
 bvaB1+AgAkeWWxSFVPTGNwNn6ikfkWzuo9oBBhQXg2Q8HIk50lS6PcdGFia6C1YFuXnRAiHFGsL
 Hre6uNgAmbpZWfVryDniKFb1/IuXuYtURdYuQIZ8RruKu9s5Q/i0zMBl3FDcuHZVbZewLyHJIdk
 NU2+72ED9LygZpW4JcqLdejAEEj8ygUcfA5ffKlpfJd8yfCrW8Qq0ibo9VDcw3Lo0Ej6fMDX+bf
 4pdHZB1eLlf0lSDXBVxnj9zFrAQMeRQlCK8zF1ukSYWkMpdZgnUzKHUVLu0kvXeQotyjq6yN4av
 Jw+hfyhVqvGpZgAHdPEpQ19z7zSJtzWVMXggSAsw7e9ygdaY/Ye0ZnV6orZzWlu3B+C6lqBjx7c
 nBNSz3UMI6XmGjmk7ms9UaaRHySHTwmLKFHmEd5uwXYAyI5EFI7LjFt97GTDtdVs5n8T0FgOcMz
 APJHFQqaDY74+xZROjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010032



On 30/09/26 12:39 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Both issues were identified through static code inspection / automated
analysis (Sashiko code review) and confirmed by manual code review.
They have not been triggered in production with an observed stack trace.

Nagamani
