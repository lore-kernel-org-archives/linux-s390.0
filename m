Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D432F8EAF;
	Fri, 19 Jun 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856137; cv=none; b=h5Fle30v4RMjsb7wCTz7rd3CSiQ8TLjro6XYfMGbfTVZow0Gz1k0WwYOgFOPcO9er48C+OqNtQ/jnnHqqG3KYDYXcIIASoE85fnbNjiA2lMgIjlMlV7AuZSOTwCvrgCNnHwWsce9shIHKaM6T7Q/V1yEAo2zXqT+NOHBkgauGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856137; c=relaxed/simple;
	bh=gM9kTcqCI/DCreNVOuEPjVZlcpEIAamCnr0PJ/oOrB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q28xefvYalhOZY+hVdt/6tdozB33/zrQTrb61tKTTpay2bF94aZwy9XfEUCJEkYNVfUzTHHxc5cCt/ad3Yd8dUevHgZxxEekC5dsmaahgny1k++ur28Ma23sY4ytHgRIAyPwj8AJe14vFSGBo6viCYX69G7ttSu2oa3pJeGhwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pc11KSgZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pc11KSgZ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mOW91840513;
	Fri, 19 Jun 2026 08:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=11PzirCd3j7xpyBLyAO9MsqyBbbMeG
	ogSD5YiY+Idw0=; b=Pc11KSgZ+OOUkI+gz5s9Ms+aUAusveGDO8h0zXhx6WUT/1
	sazKoTa9pe/XssBKYLgsB2MCOXTfhCwguajwQiJ507V9GHlPHStD7k80eRM4Y3qb
	RoBGfqvAmxdKfpswoRYjCp3VftEOBPiDXdOUdQlVVFU8xJ9oBuk2a9COPDU/wHEE
	qXp4agULIozqnfiOTxQbkJvDdBwXk77yMHfRZObXNs6lk98FZUXY7xhXUJo4Ubm1
	cIGi/Dj/MDSpIo5jG0qd9L53DEppwJacIHXKc5p10nNQG5SbTgMR/qK/vuS8er8z
	V9yHg2STWakhL2M5qeI/4BfGCZxJCxMKJQUmJRKw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcekr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:01:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7njIN032105;
	Fri, 19 Jun 2026 08:01:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172ftyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 08:01:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J81pca49086896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:01:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138B82004E;
	Fri, 19 Jun 2026 08:01:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF1320043;
	Fri, 19 Jun 2026 08:01:50 +0000 (GMT)
Received: from osiris (unknown [9.111.29.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 08:01:50 +0000 (GMT)
Date: Fri, 19 Jun 2026 10:01:48 +0200
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
Subject: Re: [PATCH v3 4/5] s390/idle: Introduce cpuidle for s390
Message-ID: <20260619080148.18590A1e-hca@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
 <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-idledriver-v3-4-684061eecbcb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfX6PUAKyzqKgEe
 mKSws+Jc3+46jpW7gCOTtWIfupSiXkva/yuX0W6U+LSoLmwvxSmtXwKiU+XpbBanhlNhhb61bh9
 HmObdXubQ8NRStfMztIECFM0NfRPl0A=
X-Proofpoint-ORIG-GUID: y3sJpWQQEcBiA35Rn6wh7yFfSWNaR1lC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3MSBTYWx0ZWRfX/nPIEOhsx435
 EgQ/GRts7aTuj5z3Ns5WZ3hxGUb3wK6FmcjZz4Jz9QyKL5a5QNaU0Pj+Vh1WTdnzcIvaFM3aJJj
 M10YjjlbNOP5Y6CnRgjiwhz+rvAbQpbPPxnhqm2RZlN45vGzW68oLZJPvGTKOTTLGNBj9kt6T6B
 NYwM5vI0yJQ1DfhXxfTzSrqJdeTC+sjcfsioAPj2WTy3Gd6uuRwvF0hM+gGCNYtrv7vKhrIZzRU
 caHWOScHPHIlvVLwvGDc0U6GKIRWHQVnTbYhUo1eMhvHUEuwga60IJAhbDNgaArgBwRbtjjgW6p
 JwivmuI3f68wWLFsAYMfdqe2+xUOhKOtPqRbYV7N7qxroCL/cpo1zqW2etRC62VcY9VQVDNqOoa
 ykd/PdB1eXCdetU77ry9aPKkxmZcNesik88n8xFKcZBI1sdcJ+jQnxvg3fv3+HXyof8DPIqQ1cd
 KOdbGI3u8TBdfafaXBA==
X-Proofpoint-GUID: y3sJpWQQEcBiA35Rn6wh7yFfSWNaR1lC
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a34f774 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=h9Z48_k1-030rbWLDsAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190071

On Thu, Jun 18, 2026 at 02:00:18PM +0200, Mete Durlu wrote:
> Introduce generic cpuidle driver on s390. Use a two stage approach to
> handle idle scenarios and use idle governor for idle stage selection.
> Two stages are, from shallow to deep, idle polling and enabled wait.
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  MAINTAINERS                    |   8 +++
>  arch/s390/Kconfig              |   5 ++
>  drivers/cpuidle/Kconfig        |   5 ++
>  drivers/cpuidle/Kconfig.s390   |  11 ++++
>  drivers/cpuidle/Makefile       |   4 ++
>  drivers/cpuidle/cpuidle-s390.c | 115 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 148 insertions(+)

...

> +static void __init s390_cpuidle_ew_tune(void)
> +{
> +	struct cpuidle_state *state = &s390_cpuidle_driver.states[1];
> +
> +	if (machine_is_lpar()) {
> +		state->target_residency = 5;
> +		state->exit_latency = 5;
> +	} else {
> +		state->target_residency = 1;
> +		state->exit_latency = 1;
> +	}
> +}

My Reviewed-by from the previous version still stands. However minor thing is
that this function should be renamed to something like s390_cpuidle_ew_init()
or s390_cpuidle_ew_setup().

But that's something Alexander can do when applying. Or it stays like it
is. Not too important.

Anyway:

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
