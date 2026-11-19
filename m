Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068878;
	b=Gw9YsKgtFIeQij6FNDn7v0kn+Q8qBAMLn68RtCwXkg45OtyXAbLgtY2sG2e60mWCkU5X
	 eW17kzH5Qdr0gJ81/hzxB2eeDxj/HEoo2SYbC96sbKOEecVpwdunh4xBC4Rr0tzbkfBNH
	 7iFjBCHtNHLbfjQqJl4KtUWqSWAm+eBGhOp+Dj8daeEHsKDC5tp7xpwmudomauPlOgz+s
	 3nklfzIAhSs8iNOJfGtG8oKpboXrFo12GkOWcQBVeZs+QNjjUmdvMaVzPpGX34OsFI2Po
	 UtzL+cGCR7XPm2LKNnbUVCamWU+1if3SHO2yR2ZzlA/IgKzFfHmSLH2uk4HzAf3yebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y1kzKgFzzLPrnnumisQ3dhJ6jcJ4V4YPruu8UrDGsfA=;
	b=A2ARg+vvm5Jn2xn2WE/6gkLHvqh1vzR3Pil1b5evuIZ1Py6oeH7wEaShKq+ZcJjLPV12
	 5lYJO9TfIdBXHVA2KAaTrBo+EE3+wUAgEp1ZPxPyE6Mq7EPB7lYSwyNdR5wpVElch7BrM
	 sUwq4e3cBx8Q+2N4tuKwJ33CEPxE+FITA14x5rkZ2d/0T1Lxl4tsAkCV9be1Sc3IwHqp4
	 SI+p6UBDWU/DNa4jcxmYpqgE9+fv8po6gdNyf1jVc/LJxwuGNTEbF4JYF+zYAfLqi5PDQ
	 34PMWumhThx+yP4OJHOygyfNqZS1iIf3yPF9WDk9iiu671VxUTtrAqzn1/Xk8TT+LVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UVBgA96S;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF0606A338;
	Thu, 19 Nov 2026 06:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FAF0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UVBgA96S
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4jFIT3192916;
	Thu, 19 Nov 2026 06:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y1kzKg
	FzzLPrnnumisQ3dhJ6jcJ4V4YPruu8UrDGsfA=; b=UVBgA96S4sKQaKoxJwknGH
	N2/BBKMNhPtaVm925B+E/MEYAe52UZBleCfytzIlX+KzcQyC4BOEzezia1q+mcPB
	+daCvDgGSqITWTf/1uOAnVG17RkQEIwjh9/EYdpSKQEwSWzEfrnMp7EGW84/VZ5I
	zd7dTG4/TuVUPoyioyLHWd4yqfkwz7VciWdf168kh4gk0RD0tUHN7TnTPTLJ7zyh
	1sbc7HorFmvZh472zL/+QcY4EwGPvALGHhDFMJ6+fS+FF1ND31VSb11czh7bBWFb
	fYxzh64G687RX6QFMlGIDF6H/Mnja34BuSE6WeS7NyG8EUImGyxutJruP+eQOPMw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vprq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:13:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4q2xW1755445;
	Thu, 19 Nov 2026 06:13:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nkhkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:13:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ6DnHq51511588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 06:13:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23AF82004E;
	Thu, 19 Nov 2026 06:13:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0265C20043;
	Thu, 19 Nov 2026 06:13:42 +0000 (GMT)
Received: from [9.124.217.144] (unknown [9.124.217.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 06:13:41 +0000 (GMT)
Message-ID: <1da4ec68-6432-4e2d-b435-0761dffb19a1@linux.ibm.com>
Date: Thu, 19 Nov 2026 11:43:40 +0530
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
Subject: Re: [PATCH 2/7] sched: restore preferred CPUs when hotplug removes
 the last one
To: Yury Norov <ynorov@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
        Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-3-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261113184257.621707-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 76W7tkljmXqdJPPPgl4R3chzrattvyNe
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afe93a2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VGkDIo3NPXgPuEZgp9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IOmWMU32yVQ8HiDH-kpQRQJ1zzU--GeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfX+9oKTM8Ex03j
 m7aoCyFppT0gJoGUJm0wZ7KCWwJ6/D9/tZDYx3or4JXA1XdrpXSOHwUBaW0JlJKjBJ1junL/aW9
 ExlgmYQ47t49Cear6xGLdOaaqVOLoS2ILNBoCovtL/IjAbxscUBMS0fh/PGS/Qj4PJFcbtguZXw
 AgjwX1ZE78pd9S34chCNLJjP7DLDD8qzdjrVN0w/h61eITWhBGJuU7GAr1DfcHpmv1crjPxT1LZ
 2qxlq7huTsWv6gues5m8ssViA1ulTXcFQ+YGKWCBkQkDyYLvr8xVYrE2GC0XweElIaLMd31irEP
 S+tmNdT57wQc+ppT+M0F9q1A3RzT8Tto/r6GRqduE7b2oIFIPjZeub7PqlXXZqYuUrGZIrb7XSW
 vx9Cc+xkXx52Mk1xk0Qlr1NvK2jpGchAiyFqptSh/qW/bLzcoFEGsTurtsoFwl0twvAb//U9Dg4
 8ZSuEbXb7rUthKh+Mhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfXyJPXA0HHk0VS
 k2RletfvY6VdVPzOScp1FAmghbj7bweub5WhFcjULLxFLdO5BOql20tKSoao9T0rb4G4tlCeHzj
 7dY8z0JdHisQxbVCXHdr0QiRU3DM9q0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190023

Hi Yury.

On 11/14/26 12:12 AM, Yury Norov wrote:
> Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
> fair load balancing stops, potentially leaving CPUs idle while having
> queued tasks.
> 
> Currently, steal governor is the only module that may modify the mask,
> so it takes care of it by resetting the mask to mirror the active cpumask.
> 
> The design allows alternative preferred cpumask managers; relying on
> loadable modules to maintain consistency of the core data structure
> is not worthwhile in general.
> 
> Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
> path, without relying on the steal governor to recover.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   kernel/sched/core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 175b52a7ea79..b5c158c4efad 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8723,6 +8723,14 @@ int sched_cpu_deactivate(unsigned int cpu)
>   
>   	set_cpu_active(cpu, false);
>   
> +#ifdef CONFIG_PREFERRED_CPU
> +	if (cpumask_empty(cpu_preferred_mask)) {
> +		pr_notice("sched: last preferred CPU%u offlined; make all active CPUs preferred\n",
> +			  cpu);

pr_warn instead?

> +		reset_preferred_cpumask();
> +	}
> +#endif
> +
>   	/*
>   	 * From this point forward, this CPU will refuse to run any task that
>   	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively

