Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0B31986C;
	Tue,  9 Jun 2026 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014302; cv=none; b=IWI/rYtkuq5AxvjiOejrs8nA0bE5fMapxyTzMxsMbMUsV5wLq3fTs4V0oa0Dl/65s06iDrzhDal1k3WnmohQpzHtngrfdBhUELI3w77ggXA4Rkbtdi8uYoUDiGgwQm45FSkIgUTtlIiPWFALnOAyHpx47prNyqdvzThvVS/9C7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014302; c=relaxed/simple;
	bh=8h5yT93e2dlD2MIOvzgVKpndjqsGDKzs+AolZYJc+VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd/2jem7FDFfy8fTFTeGjnFzmZQTVPrwSZ3vzgcQSfMRyoScH7yxWpVb6fltHMJKZRiSZWzfJIuxweTJAOKOYXpGODs0XTqM2UGSxahOHkuntFKXn9bpAx/RFnORIkkxs3qbDWOBcOpPgTVtrQEyJWu3Rji2MsVr9ZzqHllevhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QH5j3hf1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QH5j3hf1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6598B2ol1266651;
	Tue, 9 Jun 2026 14:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F9riTq8/qJjTUby5Le27Usq6dpwIUG
	01u9LcRHaLfPQ=; b=QH5j3hf1utjBMfHoFbfYBOD19VqyhSVNRiuGoa75KbIcRB
	GiptnOQpx2QjAbZLuYlaB+SfeNk52yJ2b329QIhiiqbHwRjeN96iTymLXWlceLoK
	dSGve8saKLOaWag+EpCN5lqJtW/jm2MH28dtYD+koHAzAWEkNBIN6KnCuo17TUkr
	Mx9z3+3sAMOktibAYaahJ7YyCvdosS77gw9wZRC1Xr0LWqqaR1RmIOo4ImEkscS0
	uFe/91sXqwK3kY77n6s5YaoJti5401I13QU097QZ7siamFetmwpypNw4I/cKBsYG
	Nn33y16XUhlSX+a9aUxX42ymFk44Lg8uKoffoKqw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye4cfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:11:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659E4oAN032222;
	Tue, 9 Jun 2026 14:11:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w2e0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 14:11:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659EBTbr43057602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 14:11:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA80F20043;
	Tue,  9 Jun 2026 14:11:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C62D20040;
	Tue,  9 Jun 2026 14:11:28 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 14:11:28 +0000 (GMT)
Date: Tue, 9 Jun 2026 16:11:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] s390/idle: CPU idle driver
Message-ID: <20260609141126.9217Gf8-hca@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzNCBTYWx0ZWRfX7cOHGb4yYmQU
 UWBzo6rm/eMBefjPYW/OZYlCV3uku6HiU0m3iCkf5bNfBUMwT0/rU5EYO2WuAJmAeHy3MqqIkTN
 4wkhRxnvn+QinS7ROEZd4dcSXXwop0F+mkVw5E08aGwTC3tWcTVvv3YwD1IJIZ2ag+zTzz9JRyA
 cqUZHusl0iPNq9HbOThxK2bJPOVrRjpsEy5Gmxs70GK2skZtVAPE8vcXlq+VjLkERM43ar59eyf
 zw9cwA8/Pv21jYnHW3ZA4oWIfsF23ljgiXxa43R9Lgtj3Mr8e+RXrN8LvUoINfOpMKCdwr8T0NB
 r7NWSXbr85VwXd3r0oOlVHAYhIN1nNlX/8ACgiACBiGQHTAqpnVJ8KsYydOOZZargb3D1/DbCye
 v6GSc/HeXPlisChYGsfKpfj8wWLA4A+/9Rqshf52QctirfoudDtSGoDThuivMojnaJCAcX0FfD5
 ET3TcfIc18IkWn5duPg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a281f15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=7TjuNBi8Wp6cLl_tVUMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: N8el8hY51p8ujlNCOLrQiRgqMUm5Rzox
X-Proofpoint-ORIG-GUID: N8el8hY51p8ujlNCOLrQiRgqMUm5Rzox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090134

On Tue, Jun 09, 2026 at 03:24:20PM +0200, Mete Durlu wrote:
> v1 -> v2:
> 
> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>   (Christian Loehle)
> 
> This patch series introduces a CPU idle driver for s390
> architecture that leverages the existing cpu idle infrastructure and
> TEO (Timer Events Oriented) governor to optimize idle state selection
> based on timer events and interrupt patterns.
...

> Mete Durlu (5):
>       s390/tick: Remove CIF_NOHZ_DELAY flag
>       tick: Remove arch_needs_cpu
>       s390: Enable TIF_POLLING_NRFLAG
>       s390/idle: Introduce cpuidle for s390
>       s390/configs: Enable cpuidle driver on s390
> 
>  MAINTAINERS                         |   8 +++
>  arch/s390/Kconfig                   |   5 ++
>  arch/s390/configs/debug_defconfig   |   2 +
>  arch/s390/configs/defconfig         |   2 +
>  arch/s390/include/asm/processor.h   |   4 --
>  arch/s390/include/asm/thread_info.h |   1 +
>  arch/s390/kernel/idle.c             |   1 -
>  arch/s390/kernel/irq.c              |   4 --
>  arch/s390/kernel/smp.c              |   1 -
>  drivers/cpuidle/Kconfig             |   5 ++
>  drivers/cpuidle/Kconfig.s390        |  11 ++++
>  drivers/cpuidle/Makefile            |   4 ++
>  drivers/cpuidle/cpuidle-s390.c      | 104 ++++++++++++++++++++++++++++++++++++
>  include/linux/tick.h                |   3 --
>  kernel/time/tick-sched.c            |   7 ++-
>  15 files changed, 145 insertions(+), 17 deletions(-)

Looks all good to me.
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
