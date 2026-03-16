Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B2221D3E2
	for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653751; cv=none; b=WPUAlh6u2zhyX/f9z2uWH0pHcDfM+qzlMuwKKbcfc61rM1fe4PDsNnJkijX6/m8o7p+/qfahAyGyLOLWW/bUkMFhlA7fKtFtLkopWgkRo6d/JXqDiULhsNQ88dgHlto/4I/hOWwRT6D3OYEv/E2Jhdbbw6HrK7kQZFdtoMl3HjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653751; c=relaxed/simple;
	bh=qOy6wdMUf+znl64IB8F/UMEyhBD/RMNcCo1Dt75B7Xg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tPn8PHXiHAEkt/RiT1hlzrUTR/KkN90n8UDyARMAfsdkfy1Sla/A+LPLfHBe8p563eJWuTeTsDJS4S4CfxRP5+9NR3EYmTTSPMaZ3yJLPxXOq+HH0xtkvGUetDh82CIRTkeHcXCqBqPiRCyNPgsErNdHVmH1rU8lYUsvX8A0dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeDfskHn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EeDfskHn"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMj11e956130;
	Mon, 16 Mar 2026 09:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=+sf9EvW5VDTft28g3mY2yX2D9Q/sezfc0fm6Oit32/s=; b=EeDfskHndBCm
	a76H/xKYtTBzcApVMnyj/sKOdFn1zD4O6GH/fVbIEPIGTBP1BvaM4dkDe9ocWAG+
	oI5kApeS53O7wGfW9SddhQJpvV4Oxq2L5eXinaRA3H9c1K/SzaSfppgyNeNHP/hh
	FKRg643cTtAF1DEwKhXXkFzrHb+E6QcEFSsIVUQiRLEdm1k10dzO9K6NpC1bmIDP
	FjzUO6t5stQZOhqVLH9qKoQUrY/ffe6tBIl9NS8GskQ/tB87bsSK7hGs4oN6D0qP
	wUOGnS8VKrGu8XGpeTbQqHcfMGB8Us4LIgrsWXNxk+Sl+PiKwbWG7Ti4JwjOQHKD
	cpfgSJbRRw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hq1df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:35:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G58OBo015644;
	Mon, 16 Mar 2026 09:35:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n480j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 09:35:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62G9Zhrd33227372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 09:35:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C812458052;
	Mon, 16 Mar 2026 09:35:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D59758056;
	Mon, 16 Mar 2026 09:35:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 09:35:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 10:35:43 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pkey: Remove synchronize_rcu from
 pkey_handler_register
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260313052312.2389-1-lirongqing@baidu.com>
References: <20260313052312.2389-1-lirongqing@baidu.com>
Message-ID: <09877680c056890694067390894f2e01@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rc9LKEmmahRnOglA88wzpDvtu373QlKk
X-Proofpoint-ORIG-GUID: rc9LKEmmahRnOglA88wzpDvtu373QlKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MCBTYWx0ZWRfX4V7acdQ0rhyX
 wXWh45a3VO+wDTzFQXlg5GuVmKUChlw277E3C2Q4thWxb296gOlGv2pT7miGMNJsEWxF6sqLGQU
 j/8DFNtv3zagkqqfAsoI8aT827fuB4W8GdeJ+UBvw1ydHd+nnTiY0WIe5Qu4wUX6xSZRYwQSH55
 TD8pqrIJR6V8wWTYC3R1JSj8qr4yNtVewKG4A8Pqt2FKTQ9tPTE3zrRQAjZknSg1sQHGwBmptks
 07AbSfvT88ZY7b4IHK5tIzXVfntJmTaYIESKjIhjdIaVd71ejk50SvMnuMGbnqEcB9EsOgl3EY9
 +u9wLZkHycjQfSfSf41NDu+5Xu1Q4KkDIRukAUgBdnUvIZFp+SaKfZdQXxhrvTvGYtOnhUUwsO3
 LEsF58bxN7PvpJJ94m+mnak6bI/EP8nrKvrpTuu2MlmWbvlMRAnh+AZoGEsLBv1zkVyK3oTc60O
 oLAlhDtyvYW9/bfuM2Q==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b7cef1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zuLzuavZAAAA:8
 a=lFT4GuY0HqRxgGrVVpkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160070

On 2026-03-13 06:23, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The synchronize_rcu() call after adding a handler to the handler_list
> is redundant because RCU readers will either see the old list or the
> new list. Removing this synchronization point reduces the blocking
> time during handler registration.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/s390/crypto/pkey_base.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/pkey_base.c 
> b/drivers/s390/crypto/pkey_base.c
> index d60cd98..c2e29d6 100644
> --- a/drivers/s390/crypto/pkey_base.c
> +++ b/drivers/s390/crypto/pkey_base.c
> @@ -60,7 +60,6 @@ int pkey_handler_register(struct pkey_handler 
> *handler)
> 
>  	list_add_rcu(&handler->list, &handler_list);
>  	spin_unlock(&handler_list_write_lock);
> -	synchronize_rcu();
> 
>  	module_put(handler->module);

After some deep dive into RCU, and some code review with Holger we
decided to leave this statement in the code: This is the fast path to
push the info about the updated list to the other cpus. If removed, the
other cpus may get the updated list when the RCU context is synched. As
this code is in general not performance critical and the list update
more or less only occurs at the early time in system startup the focus
is on concurrency versus performance. Maybe I'll add a comment onto
this code line...

Thanks Li RongQing for your patch and suggestions.

Harald Freudenberger
