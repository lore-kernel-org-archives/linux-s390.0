Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652702;
	b=L/FFSsFrMQaVvv8mBsdExf0oHjCMXOWhQw+HU1NyA/Y/KUTWYxu+K2qg+Egq2/hykpy8
	 +LzG/iUcEBMgstQtlQYp0qtMTr/r9rD9yc2TuWnXbQ9Srb4nEVEnhtDtEmccyBF74VgsJ
	 vin/FXtbhz3ShTOYfi7IcVBDA13NFKeZ1/GOD7W50BHLh633n+Aw06/CMdz9iM01rwm5l
	 Oun9ePvvoTqwQLol9RdkWyHLmAdLXRx6udkxMwIUTzX/ODtG58bZFE8WyPAqAgmKXDvVV
	 SyLqvSGlpebtuVyypaNCEcVRBgaCFJXuW7CewT82GHb5jFOjQhuYXD6x6t5LTTwcTog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652702;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=anUAPTBYwrZiVIEY/cGL5neP3W7YwBqhAi+Qzh8pD5o=;
	b=dvKv5f5M2xigGFN1yWfzgd0G0jztfMsnx/hR+xvo+FAXVZqvKP8vILMSZfyD6mZcUO2x
	 swZquae2R05tUpkwhx6Y7brG3jLgSPGFX+2Tv7SqAUmCQoWgCyiQoSVGR2VKlsSYY88eU
	 p43On+YfzzwE4XbrZsVspzXaA1pe8qF4gpTDdF56+swuNHANpsZjVc/YEQNbjpSqMQyQ7
	 qm6vVeEaneXxoskm+CcnXMeI+8C7Ent8JI1m784C9jVky8kzUV2lV3QvWrxMRneU73o0R
	 PvpIGZ9Mdgy77YTyB9AXmo02mGEffj+FktTK1bbVYaWQIgM59WAQHAFOvFVG/BLArpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3wjR9IR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CE606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425CE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3wjR9IR
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3ijYF3036375
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=anUAPT
	BYwrZiVIEY/cGL5neP3W7YwBqhAi+Qzh8pD5o=; b=o3wjR9IRSeRhJQczIB8EpB
	Xtabnu1tYNJadNGNXfNOOsXH0AxnV8bcJG1Nb4VttEpSpfrHY9vui8wxb5NSOZPo
	vpvXXVjU5tsL+TL61K8mQ0dkrLACgWoIqs0I58tz9VepNzB5tUUk9tflsJmlqFxU
	YKm9ofD2YOKrbe4p9W5C6kLb9Bcix97H6SN1b3XRx3HZaPa9hNmoZmr2f7axMaOT
	5yo82hanPywOT2gwV1DrGdXsn1Qx3ykS6BkEly7yfNgH08mzWcbn8RokKjLkj5y4
	C5z1ua3UDj1mH52/afjmj3fTxR1IHz8rnEwMUjLeEZum+0EnAwelAtjahnZrspCQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a57vh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:05:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69M74xSX140554
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:05:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqh3km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:05:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69M74ulN53018952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 07:04:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B18620043;
	Thu, 22 Oct 2026 07:04:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 675B920040;
	Thu, 22 Oct 2026 07:04:56 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 07:04:56 +0000 (GMT)
Message-ID: <eb11777b-5fd6-4bcf-9820-fbcc2f32d453@linux.ibm.com>
Date: Thu, 22 Oct 2026 09:04:56 +0200
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
Subject: Re: [PATCH 0/3] s390: Diag204 Rework
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAyNiBTYWx0ZWRfX0SzJm/DWbK3n
 JghTsARThJyciRvpTxm/s/LtW9lrW2Vt1WCvMBJP2rIm8omdUUVSQizOT84rUAAAWYFIpUe8eN5
 uikyJPcLZUmfqKT+YrcakkMGC6KaHefHkGotVky/uMqn9KhRwFcj60T4WI1LW2Zul3QOMmBbtp/
 WhinTfZ1wX4I3zjjgQ2uvWQkswfBbhaocGcjvgScbqtugvUy5hV+3MwZAoGV0OdMNxc7fr6kaFg
 dBRFlc9mi3kyfdoma6JNfjjaO8z2jkLqLz5ORLsUMtWauLK3UguBfrYW1PIvsUzPw/fpf6Ax61I
 l6txKQktdVw8qozQVJpY3JNRRqdgAvLcFjiTW6ONk+JklnWHlzjKFPu3/+Tsnh0EoMkRJDPCuru
 EDW+QVWyQSiwUm3rdnVK6TR9CIdwNsmm8+k94xhbiGih0JszL9is608thm5BpeLYmcFf9j7S0kP
 hAEZIsGDspfmyALj3Hg==
X-Proofpoint-ORIG-GUID: Y0w1jNCm_P52vTZtmG9LYU31c85JtYXO
X-Proofpoint-GUID: Y0w1jNCm_P52vTZtmG9LYU31c85JtYXO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAyNiBTYWx0ZWRfX6+9AS0HcGl15
 WrZOtI6BdH9khyscd63r0OdoIW4bM/5O7GSp8pP7uCoUt2otzmRzG6bUWY5k5YfWE+jkx44oGQE
 ub0GVjB4IaAvOe1+8a1vCpRIfxEOaVM=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad9b59c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=lZLN9AOQTtpZeFcYnPkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220026

On 21/10/2026 12:28, Mete Durlu wrote:

[...snip...]

> Considerations
> ========================================================================
> * At the moment diag204 size request returns a page count requirement of
>    423. That is the maximum amount of space needed currently for a CEC to
>    service diag204.
>    With this series at times there will be ~6Mb (1.6Mb for each; cache,
>    temp, user buffer...) memory allocated for diag204 data per lpar.
> 
> * With the new IOCTL interface, userspace is defaulted to the
>    largest diag204 data request subcode available(from subcodes 4, 6 and
>    7 always the largest available is used as it returns more data).
>    While this aligns with the existing behavior, question is, would
>    there be any value in allowing users to specify which subcode to use?
>    Although this also means more complicated implementation.
> 
> * A new addition with the IOCTL interface are the allow_busy and
>    allow_busy_wait toggles. For sure there is benefit in allowing diag204
>    to return BUSY instead of waiting for longer durations when it is not
>    ready at the moment. allow_busy_wait adds an interruptable polling
>    loop around that, with that mechanism diag204 users from userspace can
>    wait for diag204 to return from its BUSY state within the same system
>    call. Obviously using only a single system call is better but diag204
>    users are not performance critical atm and the same polling can be
>    implemented from userspace side. This can help reduce some complexity
>    on the kernel code.
> 
> Changes from the earlier series;
> * Address mutex lockdep issues (Sumanth Korikkar)
> * Add permission check for IOCTL (Sumanth Korikkar)
> * Pass buffers set to 0 when calling diag (Sumanth Korikkar)
> 
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> 
> Mete Durlu (3):
>        s390/diag204: Introduce diag204 rework
>        s390/diag204: Replace diag204 users with new implementation
>        s390/diag: Add diag204 IOCTL to diag misc device
> 
>   arch/s390/hypfs/hypfs_diag.c       | 140 ++------------
>   arch/s390/hypfs/hypfs_diag.h       |   4 +-
>   arch/s390/hypfs/hypfs_diag_fs.c    |   9 +-
>   arch/s390/include/asm/diag.h       |   8 +-
>   arch/s390/include/uapi/asm/diag.h  |   8 +
>   arch/s390/kernel/diag/Makefile     |   2 +-
>   arch/s390/kernel/diag/diag204.c    | 382 +++++++++++++++++++++++++++++++++++++
>   arch/s390/kernel/diag/diag_ioctl.h |   3 +
>   arch/s390/kernel/diag/diag_misc.c  |  10 +
>   arch/s390/kernel/sthyi.c           |  28 +--
>   10 files changed, 437 insertions(+), 157 deletions(-)

I will submit a new version soon with Sashiko findings addressed.
I kindly ask to hold any comments until then.

Thank you!
