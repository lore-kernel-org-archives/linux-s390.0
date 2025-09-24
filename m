Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D827FB25;
	Wed, 24 Sep 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701148; cv=none; b=kFPS6ncpkVaK2RHoKwEVBXCfHkPIXb+KcShsDayaB7Gy8CX4f/KkFdcDf5DcLJKDaXRATPI53vcAsr1r2tgg6jp6Hdi+XwcOMmKpETOIbfdGlcmU7/DYnos4BmRK/GHoOT24yTiaWLlIa+2rcMe5KVBmAJ2LQq0lcxXJs+ns1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701148; c=relaxed/simple;
	bh=zyx5Tv/zGehDroMiQn3Y9OOOythlM5P8kXKe/SaxVvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrMNUAZAk8C9BtCrDM0JQol3eortOhlE3M++USCFxEwifaUNkT6M56j+JZI8DjuV32TQJBt8SEH6DcakH9l3fDHs4dffb0KHw5++7anQsy1rXpk9LGWJk8kdchl4KzKPdQ2bCSVsn9wqWCsF4b94RI4JfwtXDBfdrC4yBmLARcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cemsv/kP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cemsv/kP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O1qQwH002933;
	Wed, 24 Sep 2025 08:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xslHDH
	+2SsplsxwmWxLLGdGGv6s2sKh7a5JKBCPlpyg=; b=cemsv/kPSQcP6jWmJhHG8U
	nBTMk2zH8e5KpHR9Or9/ty4/QJMjPjCeMELphDi1FAFizvLblj43jwr6+1i4eFOG
	aQWQAal+Spa28Uu9O7IZErC5gXNK5RKEvGYGDdQGNGMEMxBUXLGbX+FIhrFyVK6s
	6taPhNEi8RFQD/cUTp1lEBLADycLIiN06Chvpp2iXlPjXHPX2e1tYGeo53jJ7vx2
	k5YIXdWyLuqZHCAxOB5Hg8p3m+ByeCNsAp4zlxI0/rarqzG6tsWVDeDvNxuPGH0z
	FUq9bXVjfqpRBDGFw7+YGKLrHE0qT6E1NDlQYG131yn/flfDQsxyT6/aS3j8LhlA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky667mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 08:05:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58O7vxU6024436;
	Wed, 24 Sep 2025 08:05:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky667mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 08:05:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O6ILGJ030367;
	Wed, 24 Sep 2025 08:05:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a17aew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 08:05:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58O85Q2Z46203176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 08:05:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959AF20043;
	Wed, 24 Sep 2025 08:05:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B07820040;
	Wed, 24 Sep 2025 08:05:26 +0000 (GMT)
Received: from [9.152.212.43] (unknown [9.152.212.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 08:05:26 +0000 (GMT)
Message-ID: <72d10c3f-c036-4813-a256-9d7adba4bfec@linux.ibm.com>
Date: Wed, 24 Sep 2025 10:05:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] s390: replace use of system_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
 <20250917153859.363593-4-marco.crivellari@suse.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20250917153859.363593-4-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ITLPFSW78Qumnw3udS18HwrX1xwVkJhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX/OY4P5lRpSgT
 uUw8msrcQZz/HLmmdD5mEKQjkIE5rQSX661XeFrhXpUU6mI6ea1infehbfIB2hbP4xY64fgEi/k
 PclWrCEmwKoyZ9XdASSDfJwYFRlVKSAfIPcBDpMZ0GJy4Lq0Rzo/HvX2/nMzZa7eTLJIzXv1XbF
 +gCZTXK9Zf7m7R2BNngz2NuIu5hC2/WKH6et5GfWbQEHDPiA5o1SSmyqdebfipWz/fhjf59HitL
 RmUwYByInPR2DFK3MtFjFphUQS5UaldnNdkgmJX1MS588MexOguOChUcOPU86S2ZVnVDrvMLdI7
 /updH9HMCpErj/YurWv30HLoR4vIHVr5n9HNP9IqiKtaZ8gZOaqeH2tW8T4CVZumRSjVGzqwv4l
 Twy/Nl/A
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d3a64b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=VnNF1IyMAAAA:8 a=6K911Lx7mGFY9qHY268A:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: mz47SYCy-y6mUtn7dxpP9ukB5_NdZ52q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On 9/17/25 5:38 PM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> system_wq is a per-CPU worqueue (replaced by system_percpu_wq), but the
> current code does not benefit from it. Because of that, system_wq has been
> replaced by system_dfl_wq, the new unbound workqueue.

That sounds right. Thanks!

> The old wq will be kept for a few release cylces.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>   arch/s390/kernel/hiperdispatch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
> index e7b66d046e8d..2507bc3f7757 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
>   		return 0;
>   	if (hd_online_cores <= hd_entitled_cores)
>   		return 0;
> -	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
> +	mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
>   	hd_update_capacities();
>   	return 1;
>   }


Thank you for making the change from *_percpu_wq to *_dfl_wq.
I am not sure if its too late but you can have my r-b

Reviewed-by: Mete Durlu <meted@linux.ibm.com>
