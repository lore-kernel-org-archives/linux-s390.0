Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDD396D38;
	Mon,  8 Jun 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905323; cv=none; b=RSFH+pt2W3XbE4sxrFGMnWNaMzAK+XtBsVXNqqZ97+drldJ3qSYDRpHXi8v+t82KxwF6ziqVD2xVzG2RzPPz5p59eDekh4voycoPZ9wF8bid1muxMzQ1FzG1Hibkstx+cpcocPIiA+YItcGW43Ytfa3IFeBX0hhqcC1a7J6ZGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905323; c=relaxed/simple;
	bh=bPBhpL2ww2i1mIbB6xAl71JxxCHTPqnXaBxIo64kias=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHlIZQax8e9UpP/4/P9CslOdHq6V3iwBh15B4x9R0I3dWVKLpOkv15U629mVlTPW/OESAed3H7WJVtvv4qbwPrZv3xJk1IHAm07UrOHiRdkkKr2xWjHkXptbTIkb+Uz1Ym4FhIQDgasC5353oU92qxoLk8I5zDoZ3KwBoS7SrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cgKUVcbX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cgKUVcbX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657MBc8X3003996;
	Mon, 8 Jun 2026 07:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=k/6lN2p7B0PU1MgpRyc9jbM4qL5W6C
	N8vzJlLrVJmk0=; b=cgKUVcbXZAWWP+6+JDJ5KZvnqyIfesCvmUS+BRBasMl06u
	wqB165BAD9bRmEGxL+hKnx9HUr06WocRlMTj6JrNYF8rJa26xb0O2ysxccPd8dxJ
	T5IQuhJ2P3KTj+SLTIjHqh2VWYjP2zdrh/s3DR3MXs/PEdbbmdhsH6yBrZDbKpda
	eDAwEhZL8gIcPXx+CSMFQXeuJK6krmZsz3lDnxFYZH5Ua4kwouWMXOY9uA5STikX
	1bWUJeXBO0BHUqwpibkYBztMtq9p3UR7JWnZ+ijY9qS1EGNHUpejuN1culhTP49Y
	978vLgadfBc7fwJOQz9mj2x9HRvwqCiJlRFRrGLg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb9567uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 07:55:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6587nh34029242;
	Mon, 8 Jun 2026 07:55:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy44a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 07:55:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6587t2lI30474648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 07:55:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D610120040;
	Mon,  8 Jun 2026 07:55:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EF892004B;
	Mon,  8 Jun 2026 07:55:02 +0000 (GMT)
Received: from osiris (unknown [9.111.82.157])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 07:55:02 +0000 (GMT)
Date: Mon, 8 Jun 2026 09:55:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: Idle time accounting improvements
Message-ID: <20260608075500.34400A04-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513140129.4100822-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26755b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-PeJF6iH7ZEGWZFhlOYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: o3j_m6bzLaTVczNmcc6EOZTeYDZfzcX-
X-Proofpoint-GUID: o3j_m6bzLaTVczNmcc6EOZTeYDZfzcX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NCBTYWx0ZWRfX8jSHcppX3m5e
 +7Bv/W0oTviM6GsytjvnCm/Vbbb1J6zrHn9lXxJV7WvphQn5oezwmVmxvQxhxtetxFEAJfInI71
 GoVf9ALMuLP8SIzac6pILQKBy0PPqcdEfW0umvpB5k6RqlrZyk8pW43aOdd//S9kMDHHMeFOeVB
 /t95OLk/9UjZKSMTvWg/wlVig+yQgQZ5QSNnPujOypSmpdfqpxaTxm1SHEj6fs7YAs9wB1n8yEV
 ctbORI4f8H/yMWf+VDfH70dudl/sc9a9hXQsKZy5g1vkgy+9srDDGPsStX4ut5AmXaixx4wNEuY
 BRXveTt6v4c7BwTc0ckhEmH+9790wFPnSt9CHoPTNujIZfTz4/boBlu/eYTe9LhmQfxPaXqek5P
 kHDddnWRITf5jGG5aOAMm3zRYK0mxuZK+K7g4hffbA4Wlmi7wfCe1Z9/20ug2dSHP7nqOmUdqot
 1dImjjs5ysnbED+GnHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080064

On Wed, May 13, 2026 at 04:01:25PM +0200, Heiko Carstens wrote:
> This series is on top of Frederic Weisbecker's idle cpu time accounting
> refactor series [1][2].
> 
> This is supposed to improve s390 idle time accounting, and brings it
> back to the state it was before arch_cpu_idle_time() was removed from
> s390 [3].
> 
> In result all cpu time accounting is done by the s390 architecture backend
> again, instead of having a mix of architecure specific and common code
> accounting (common code: idle, s390 architecture: everything else).

Thomas, Peter, Frederic, any objections to this series? The third patch
touches common code, so I'd like to get an ACK for that.

If there is agreement, this could go either via tip tree's timers/nohz branch
(series applies cleanly), or via s390, after the nohz branch has been merged
upstream.

[Full quote below for reference]

> Changes since RFC [4]:
> 
> - Split into more patches
> 
> - Fix various build errors for !CONFIG_NO_HZ_COMMON
> 
> - Get rid of private seqcount implementation and access seqcount from
>   kernel_cpustat directly from assembler code, as suggested by Frederic
>   Weisbecker
> 
> [1] https://lore.kernel.org/all/20260508131647.43868-1-frederic@kernel.org/
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git timers/core-v4
> [3] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corresponding code")
> [4] https://lore.kernel.org/all/20260225145146.1031705-1-hca@linux.ibm.com/
> 
> Heiko Carstens (4):
>   s390/timex: Move union tod_clock type to separate header
>   s390/irq/idle: Use stcke instead of stckf for time stamps
>   s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
>   s390/idle: Remove idle time and count sysfs files
> 
>  arch/s390/include/asm/idle.h      |  14 ++--
>  arch/s390/include/asm/lowcore.h   |   4 +-
>  arch/s390/include/asm/timex.h     |  20 +----
>  arch/s390/include/asm/tod_types.h |  30 +++++++
>  arch/s390/include/asm/vtime.h     |   4 +-
>  arch/s390/kernel/asm-offsets.c    |   7 ++
>  arch/s390/kernel/entry.S          |  14 +++-
>  arch/s390/kernel/idle.c           | 129 +++++++++++++++++++++++-------
>  arch/s390/kernel/irq.c            |   7 +-
>  arch/s390/kernel/smp.c            |  33 +-------
>  arch/s390/kernel/vtime.c          |  55 +------------
>  drivers/s390/cio/qdio_main.c      |   2 +-
>  drivers/s390/cio/qdio_thinint.c   |   2 +-
>  include/linux/kernel_stat.h       |  27 +++++++
>  include/linux/vtime.h             |   6 ++
>  kernel/sched/cputime.c            |   4 +-
>  16 files changed, 203 insertions(+), 155 deletions(-)
>  create mode 100644 arch/s390/include/asm/tod_types.h
> 
> base-commit: e64ba052ce04e363ff76d3cb8bedc5f812188acb
> -- 
> 2.51.0
> 
> 
