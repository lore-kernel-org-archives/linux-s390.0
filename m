Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C88438495;
	Fri, 11 Sep 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122435; cv=none; b=gsBksy5GHIloTMBfCZAqRa1f3gDyrEFnKH2dsERP3kJYH4X7JpO3scCVWmV/Tl6uHu+CV9v7qse7wVI/n9aZ5cyDxVSEsKIAxxdjinZGIio/qRLJutRt089Q7VLNMN4/cF2IdOv5G6QEC7//ZWjaqEdrD7AElA0DUMkXz+X41Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122435; c=relaxed/simple;
	bh=SsUTa8NQTgjrpOBLY3hNBkZ0ptivfq1GukvYd8ouSx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTe823kJxD1mFSkNnlfVtI2wAHXVbdcVHpvbMHhf6CGADcwJq1gAVPtpwdRy7trecLAHoagX1coPQnXpUgtnYfhzPS6b/xmtV17d/e3oRtb637v1TVN/xmWe63o4wA9PAGHtSRcn06DNNV/uM0+4KsXFplsMJZ/xZJ1TVczcm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L1CJyhpG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L1CJyhpG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81Z7M1218133;
	Fri, 11 Sep 2026 10:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mZ+us9
	UTBtiXnTcwW1jkW5kQmZKKPaNjZS3V20zhm90=; b=L1CJyhpGcQR0Ulav/1UlFY
	q55MwjBNy6XqHT35Rug3OMcyabQ2YMlhIfi3DozyemtERaF6+RCK7mDPrWPF7VvG
	od1tOOwbMsrHdP59l8NaQUVPjpsJ96f8EXUEgrrtxW0FRGGh8YkeyjrFONUQijxH
	MEff/GDG6LJJbn1Y25yESRil3vR5M4JW/vKUFvx1Kevsc0XcnQb/d0/OLOb0YRW3
	0X9OCyaVnqJZz+Uv6COId7tQo9t6+WTdRteY+bMGk/QgUJ3I+6+AUlR83COiOxg/
	7aZPTRDhpRf4ZlG6/LXniCnYfkxrnLRNM+aNEwpbfTFwM+YEk0qtW+gtX5CEQPBw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8ptusv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:27:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o4SB1301389;
	Fri, 11 Sep 2026 10:26:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk5qmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:26:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BAQtIM40567150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 10:26:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3330C20040;
	Fri, 11 Sep 2026 10:26:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2B02004D;
	Fri, 11 Sep 2026 10:26:52 +0000 (GMT)
Received: from [9.123.3.144] (unknown [9.123.3.144])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 10:26:52 +0000 (GMT)
Message-ID: <0df7dbac-725b-436e-bd8a-bb637ed828f4@linux.ibm.com>
Date: Fri, 11 Sep 2026 15:56:51 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] s390/ctcm: Fix use-after-free in channel_remove()
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
        aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        sashiko-bot@kernel.org
References: <20260907144511.3810194-3-nagamani@linux.ibm.com>
 <178900839280.219967.3546163075460076479@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <178900839280.219967.3546163075460076479@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa3d774 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=RMRYEIFC2vSlcnFUtB4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ilmhbMDp7acPMiQh_YDXMYd3SEhkDrPY
X-Proofpoint-GUID: gwjbm_JwqzrfUyGVL9mJ5AtS8SM6ve8y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfX5/uYdv4vIR2F
 BoYr1fLPjLNFzEjYoWBV2u7pFJZ8LfbDV6eVANkuNPatH5DRLpBv1N4h0+9bsTmTQyExDRpFQzT
 6qmhPUyGxR2/NTFNSRaWfjXWKFgfdZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfX6YeQNVOvKQrP
 alPtobdgwI6zvxYN1Wl8yIsmKZGwUA253N7u0w8Zu6YvuOi3ZpRjMvKhMRmK766c9ju5kE0HqPC
 j2LNLq9A+lNoLP1jKKpIWembP0kr6NF812oLKhHB4Kk9bqXEyCo+aiP95XQmfUEcYxjVW81pByU
 XMdY6wbxaoUBTH+cIJglABCGNrKXaYpPn52OVyrCf0YfHIUADclqugNeSnyRCwNyZ8m3zJ36vUe
 wtsQq0U9Z1HszKHEGcsNkUKJLZO+cdpl4Ss1v8sljmrAbNHhnA2Rv0octviwUC1lHFziXoALYuz
 YbrtXx7VoB64IkZ7VrCjc0QE8f8YkDdTxtIOxbHeWyXTeOnHW+UjEwN0Wvk/A1/sM/k6K3tG6BI
 zPXDIuq9OXTeZeRrkH8GhsaL1IB4F5Qk0qeojAuhU3VGmvmCgsgZUBQt+Iq9pbrSqIxD4plqdQs
 m/jxippnvuUAloqTS/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110140



On 10/09/26 8:16 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 (3) · Medium: 0 · Low: 1
> 
> - [High] channel_remove() (drivers/s390/net/ctcm_main.c:214/216) uses
>   timer_delete_sync() instead of timer_shutdown_sync().
> - [Low] The patch fixes a real use-after-free reachable during device
>   teardown but carries no `Fixes:` tag, so stable maintainers cannot…
> 
> Pre-existing issues:
> - [High] The same fsm_timer/kfree_fsm() UAF pattern that this patch fixes
>   for ch->timer/ch->sweep_timer remains completely unfixed for the…
> - [High] The synchronous cancel was added in channel_remove(), but
>   ctcm_shutdown_device() frees the objects that timer-driven FSM actions…
> - [High] The MPC channel tasklets are killed only after the resources
>   they dereference have been freed.
> 
> --
> 
> [Severity: Low]
> There is no Fixes: tag on this patch. git blame on the two replaced
> fsm_deltimer() calls and the following kfree_fsm(ch->fsm) points at:
> 
>   293d984f0e3604 ("ctcm: infrastructure for replaced ctc driver")
> 
> Could that be added as a Fixes: tag so stable can work out the affected
> range?
> 

Will add in v2:
  Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
  Cc: stable@vger.kernel.org
 > [Severity: High]
> Does that hold for the MPC case?  timer_delete_sync() leaves
> timer->function intact, so a later fsm_addtimer() simply re-queues the
> timer:
> For ch == priv->channel[CTCM_WRITE], can a sweep callback that has already
> been dispatched on another CPU execute the fsm_addtimer(&wch->timer, ...)
> above after timer_delete_sync(&ch->timer.tl) has returned?  

Pre-existing issue not introduced by this patch.

> 
> [Severity: High]
> This is a pre-existing ordering problem and not something the patch
> introduces, but kfree_fsm(ch->fsm) here runs before the MPC tasklets
> are stopped later in the same function.

Pre-existing issue not introduced by this patch.

> [Severity: High]
> This is a pre-existing gap rather than a regression from this patch, but
> the driver has two more fsm_timer instances with the same kfree_fsm()
> pattern, and neither is cancelled at all in the teardown path.

Pre-existing issue not introduced by this patch.

> 
> [Severity: High]
> Also pre-existing, but related to where the new synchronous cancel sits in
> the overall shutdown ordering.  In ctcm_shutdown_device() the objects the
> channel timer callbacks dereference are freed before channel_remove() runs:
> 

Pre-existing issue not introduced by this patch.

Nagamani

