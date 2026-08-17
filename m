Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC646C4B4
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988247; cv=none; b=Jmc78dfUVsmzEIzWWBG9P1mdwxcbFnOOYkBwmIBM73LaSGyDEbBBe6gSgYGzNUwOUOGRqGQU3ge+s1kWsWVE1nY7MKnfPORLqR1Fo0RFJK8lOaiMQkjlui9iPgETmlJOhPxyAS5VrJX/NoEkrv5GY45VuenGWOMYetFufdCjkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988247; c=relaxed/simple;
	bh=KZex0Q79Tnha1lugF2nwJREa0EQmsUmSA+GbuXdIuXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA8mIAOeqSura0DUHLN5CNhUeB9tlVx28EyCoSqlS8N+9EtNSseoXXdCY9oTAjrkScLBGxNMSmGAzVsLzT+9aJW0bxjVfpAf5fNIa4MVV8jIoID32lWe7ZHtREkTpwvUnaU1z860W9+UALuDqnYoDla8ce8o9LSsrymgRe2A/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JBh67Zop; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JBh67Zop"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFfWf44133352
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+PvGTjIho67rfRcE+AnjDbqYgzkmMI
	Yux+CsQympSm8=; b=JBh67ZopbPKJV/grLtMXkWKCMJ7raP78oDwbsRIIvmcOwk
	L/anI5E4medBiUlSzKBiF68lyggmvO3Y/coBU/D7M27QLMSSPlqjpQ/UJEd5rOqQ
	2bd8+uB9VBbWX24bVDCzgbskLh0PJExUr1LAyvTzP6jNEEPBN5B6XlJVAzhEf3Tk
	UkJogPPRINIqE1YeBF0wZoR0R7ian9HMqYPXKwdHJggoa1VtJxeZTpiPUtO+/PiB
	PsJ3Dg+21bHCwNAlm/5BYpn4Y3pqxD3dIGxCVVNWI4vH96EHSAFyNWU3KNSPOXUb
	yGkgbyfJ4RtpLCT3lNibynbSrUJjvD59qGs1Zc7Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqkja8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:37:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HHQI9Y005766
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:37:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgy10t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 17:37:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HHbIDb52756892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 17:37:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2524320043;
	Mon, 17 Aug 2026 17:37:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24D020040;
	Mon, 17 Aug 2026 17:37:17 +0000 (GMT)
Received: from localhost (unknown [9.111.2.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Aug 2026 17:37:17 +0000 (GMT)
Date: Mon, 17 Aug 2026 19:37:16 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/ipl: Fix missing re-IPL parm blocks handling in
 dump paths
Message-ID: <ttjxcy4@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-02.ttjpfvt@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzNCBTYWx0ZWRfX0UGvbD3cYID6
 cmoALKUM/wBUcGPStLYIDcRdCEn8yajkF9W5tLVeeicFrKLjUMBmD80vV7CkvL79WNM4UKq1RMz
 2Mlys38cbI+S7JeXoy/hKJjnZoHerBhjqfjkq81CJ6uOS9ghkioLj5rim7XzTBLt9Meot4ivOs+
 WAeC2NP34qkl8I2S0mtnGnrUSSjsrJOXw7xEZlfv81RwcSvRDicTH9g8LBjVOKJeAH0AutnD8po
 jYK4Vr6inwFjzlBmNZQi0L0DhZBeRXT1wtXPt0D4/yMGzhDMeNNt9LoOfBIBUC9OMaqKcWJBwXx
 DgbMURM7cKr1aufJz4HaItmKE9zI5qfeeOItzP8ps6WpRHZ3QSwtmFTtw2guZZvrBul8Nu9VSwv
 cvcBLCOxjXkZRYr0TV8hSZocWoPPOGobRz5i71ZDEUNSBbQFVLviIrfqtdnBuFMCHKMevWjTleU
 zgleko9j85NUHgp2nhg==
X-Proofpoint-ORIG-GUID: 7o4uLmbnMKmBtJbhlW5rXCoSfR2QDDLK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzNCBTYWx0ZWRfX0LqRQ11BGYtE
 Lnps7PrZDjHCAHULJ5GJOztkx38wXVufuwVH3KB/BiosRaNc20te4h2/ELI2MCWjJFlRt1AHHkF
 cw7dp0U5dOFd09/Y3E7DuLlS7xJHbdE=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a8346d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=_wmGLrF05a6c7XaiEVkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7o4uLmbnMKmBtJbhlW5rXCoSfR2QDDLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170134

On Thu, Aug 13, 2026 at 01:06:52PM +0200, Vasily Gorbik wrote:
> HMC FTP boot and QEMU direct kernel boot do not provide an IPL parameter
> block. This can lead to NULL pointer dereferences during kdump and
> stand-alone dump processing.
> 
> Fix the kdump and stand-alone dump paths separately. kdump continues
> without a re-IPL parameter block, while the stand-alone dumper completes
> the dump and halts.
> 
> Vasily Gorbik (2):
>   s390/ipl: Fix NULL deref in kdump without re-IPL parm block
>   s390/ipl: Fix NULL deref in dump_reipl without re-IPL parm block
> 
>  arch/s390/kernel/ipl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied
