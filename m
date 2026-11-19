Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068460;
	b=mHDYze8j+mu7zFz116hQrYgj0SmrlltkM5ZYQUyOaKjX5GxEQchKLE2jbUtxUG+4BaRI
	 Ivq0kwo4hmmhf3W4tqk/Qoa2waUQ5RtVpm7TpZw6k3biaJeqM8rXjy90xmZUpScVBiQhV
	 avDMLEvMWQawqqbjYCrXwXY4qgAvkeA78AiDj2dDccHBJFjEvg5JeVtGf8M0xrgOKyIWM
	 CqCKDste+pmZd/bM1CfhVLr9R3n/xV7+9aACcx1Fsp250AEm1ESP0R5clctxIwwJZWfyH
	 V/cJFnM1D00AaWlzeovfk3jCFAGtf+OD4J/+Q/yDLbkBjgDsnmFSm7MKAtIBzewYbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RflKtLzANh50OVjZUvhyj5Uu+ZLP4MbVSiyqCQZ/TjM=;
	b=N/+j58v9oSKKUUY5JaActF7GA2kgUKS3AlsL5EzEDf4k5qiBg+CgeWlvCwrqa7yg8ZkO
	 73w9/v8FrvURX1AopAUree6fSFkf9TsU80mh1a8K8+8Nb7a4KBNTPvALauMiyCr7x8xpC
	 HrZmWvrBwwxG1cOf2EmqyzuDcMRk1e/72HE0E6EDrf7DUHZXm+IqO3gRfjoHR3tJSsFAC
	 IJ15Hov8KrsfFyPMHQJHTDr7XNoTtixLP4W93G2VeWbL8/mC44fvFtqbiI+r1p7C/5jPx
	 Yog1UcATo5nZpojkEzVgCpvk4O8YrYHtKb+8+tBkpbFbtidTXDzNFbsQLD6HXzoS24g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nS5XLY09;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85A606A320;
	Thu, 19 Nov 2026 06:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B85A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nS5XLY09
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4jHEI3324071;
	Thu, 19 Nov 2026 06:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RflKtL
	zANh50OVjZUvhyj5Uu+ZLP4MbVSiyqCQZ/TjM=; b=nS5XLY09cQJppraZF5/Ui6
	HzPXK0pxBcBYsO79/mnMn9NTE8lAPHxxIxKoIID85ZQBtXIEQwtEMvnz+ro5Cb42
	4j3afcBdy1/sDiFgSGnFn1GjHjHiP1kHKAvN6swcblTyumUZ4xIqz61/kS94brjz
	yH+C9oMfpYyyTWkflTbsiLlZ5Md36eAxD/rYIM6NwAu/kKVxHuHzpkY3990jgymU
	WodQGGsPNkO6hInudnpi4mOolqy9HENqYE2uPnlMv6LDjQOJgNxLJhYZHORjSTX5
	pmPCA2PVnVLN0+b22FWUp3zM8vpk0dNejPsFJiUGsYljqo59hEvg7RPR+hti7bSA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nevr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:07:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4XlFK2162899;
	Thu, 19 Nov 2026 06:06:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvnqmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:06:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ66tb450397622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 06:06:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 291D220040;
	Thu, 19 Nov 2026 06:06:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCD0E2004B;
	Thu, 19 Nov 2026 06:06:47 +0000 (GMT)
Received: from [9.124.217.144] (unknown [9.124.217.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 06:06:47 +0000 (GMT)
Message-ID: <37a30a91-bd86-4dbb-ad12-8cbb509f7c4c@linux.ibm.com>
Date: Thu, 19 Nov 2026 11:36:46 +0530
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
Subject: Re: [PATCH 6/7] virt: steal_governor: restart sampling immediately
 after CPU hotplug
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
 <20261113184257.621707-7-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261113184257.621707-7-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfXz3FkMuLeeVV5
 WUzbQqK3YwHV2gj69TBumNrDiz+4gYq0fiSGmx34KzREAEzefH8oJdqtAwSVZcy3aPOOBNeYGgC
 4YvQv+NPpQYJreJDMERt2PPjfhiOoYV0j5IFfZ88M8p5QAmQxINmhSc1K6i+RmBMJaITowpyZ9I
 gDwsuNcURIX8Cguau3gk/fl2BcpeNoLTZodgQBhsKRp7tDxVf3+s3frUBX2cLhvu5UiB34slUo3
 8wZ/05RGmF6RhjnlpRsB3/6EAMPCT2VDUa1axW7tHp+q4wPjH8Co+eoqc97VOMCWQ7WCP8Foaxq
 YqffDk30Wx7VXlQe9wzO/snrEYhqO3mm9RGA68su1NghmbKShNG/uBfW3FOli0MvKFOp3Q5gvGm
 XC5/sAWwWV2bgbzTuZhxgxB21EzBulPZ+mpXeu/Tc6BinBDiFYjmuyt1iyLO5hoZSysMYTFT72v
 GNFthaIyl3wljSmKbIg==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afe9205 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8
 a=0HZJD8Sdi3QcteILL10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hGB-_hglpyk7epm03uhVkOL4XuxGf6Ot
X-Proofpoint-ORIG-GUID: 5H73WGlaohj3_b7yzRgqsLltE59hArR0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfX5Q+rkoAKKTwf
 CjaHtE8KE7Yofa8LEijqts+UNxUoWM1P/XqQK6P4W2j23GRhykzKFm+wBOc+8aVI/dEAEGJ3e8A
 LHtQGyCDceK2utJ4pXtFAqwnujkUbnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190023

Hi Yury.

On 11/14/26 12:12 AM, Yury Norov wrote:
> CPU hotplug between samples can distort the calculated steal ratio because
> the governor divides accumulated steal time by the current active CPU
> count, even when that count changed during the sampling interval.
> 
> For example, assume a constant 3% steal rate on each CPU, with four active
> CPUs for 900ms followed by two active CPUs for 100ms. The accumulated
> steal time is:
> 
>      4 * 900ms * 3% + 2 * 100ms * 3% = 108ms + 6ms = 114ms


This example is not realistic. If you had 3% steal with 4 CPUs, and if they become 2,
your steal time will definitely increase. It will likely double. So
governor likely calculates 6%.

But yes, you can have realistic examples, where governor may calculate
the values which goes slightly above or below. But IMHO those examples are very
limited. Even in the above examples, the steal governor was supposed to trigger
high threshold since the steal time with 2 CPUs is 6%. So if not now, in the next
delta it would have triggered it anyways.

Some examples are really corner cases. Maybe like

60 CPUs 3% steal, and then 40 CPUs 5.1% steal = 4.55%
(Below threshold, but should have been high). One interval missed. But if you see
large duration was in low threshold, so it is agreeable to miss it.

> 
> The elapsed time is 1000ms. Using the final count of two active CPUs, the
> governor calculates:
> 
>      114ms / (2 * 1000ms) = 5.7%
> 
> This exceeds the default 5% high threshold, even though the actual steal
> rate stayed at 3%. Using the CPU counts over the whole interval gives:
> 
>      114ms / (4 * 900ms + 2 * 100ms) = 3%
> 
> Checking num_online_cpus() doesn't account for cases where CPUs go online
> and offline such that the total number of online CPUs doesn't change. So,
> implement the sampling restart on hotplug event.
> 

I am not sure if we really need to stress about hotplug cases. IIUC, when a user
does hotplug, systems are usually idle. (Atleast that is what we have observed in
real life use cases). And hotplug is really user driven, so user knows system is going
through some transitions and will be stable soon.

> Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/virt/steal_governor.c | 37 ++++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index c34d91267ec1..f71dbf27e4a9 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <linux/cleanup.h>
> +#include <linux/cpuhotplug.h>
>   #include <linux/cpuhplock.h>
>   #include <linux/cpumask.h>
>   #include <linux/init.h>
> @@ -42,6 +43,8 @@ struct steal_governor {
>   	unsigned long		delay;
>   	unsigned int		high_threshold;
>   	unsigned int		low_threshold;
> +	int			hp_state;
> +	bool			sample_invalidated;
>   	struct delayed_work	work;
>   };
>   
> @@ -217,6 +220,13 @@ static bool preferred_cpus_valid(void)
>   	return true;
>   }
>   
> +static int hotplug_callback(unsigned int cpu)
> +{
> +	sg_ctx.sample_invalidated = true;
> +	mod_delayed_work(system_wq, &sg_ctx.work, 0);
> +	return 0;
> +}
> +
>   static void steal_governor_loop(struct work_struct *work)
>   {
>   	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
> @@ -233,6 +243,11 @@ static void steal_governor_loop(struct work_struct *work)
>   	sg_ctx.steal = curr_steal;
>   	sg_ctx.time = now;
>   
> +	if (sg_ctx.sample_invalidated) {
> +		sg_ctx.sample_invalidated = false;
> +		goto requeue_work;
> +	}
> +
>   	/*
>   	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
>   	 * To avoid possible overflow, divide the denominator early.
> @@ -254,11 +269,14 @@ static void steal_governor_loop(struct work_struct *work)
>   		return;
>   	}
>   
> -	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> +requeue_work:
> +	mod_delayed_work(system_wq, &sg_ctx.work, sg_ctx.delay);
>   }
>   
>   static int __init steal_governor_init(void)
>   {
> +	int ret;
> +
>   #ifdef CONFIG_XEN
>   	if (xen_initial_domain()) {
>   		pr_err("Cannot load in Xen Dom0 (Host OS). Driver is for guests only.\n");
> @@ -273,8 +291,20 @@ static int __init steal_governor_init(void)
>   	}
>   
>   	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
> -	sg_ctx.steal = get_system_steal_time();
> -	sg_ctx.time = ktime_get();
> +	/* Lock to prevent unobserved hotplug event during setup. */
> +	scoped_guard(cpus_read_lock) {
> +		sg_ctx.steal = get_system_steal_time();
> +		sg_ctx.time = ktime_get();
> +		sg_ctx.sample_invalidated = false;
> +		ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN,
> +							 "virt/steal_governor:online",
> +							 hotplug_callback,
> +							 hotplug_callback);
> +	}
> +	if (ret < 0)
> +		return ret;
> +	sg_ctx.hp_state = ret;
> +
>   	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>   	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>   		jiffies_to_msecs(sg_ctx.delay), sg_ctx.high_threshold, sg_ctx.low_threshold);
> @@ -285,6 +315,7 @@ static int __init steal_governor_init(void)
>   static void __exit steal_governor_exit(void)
>   {
>   	disable_delayed_work_sync(&sg_ctx.work);
> +	cpuhp_remove_state_nocalls(sg_ctx.hp_state);
>   	guard(cpus_read_lock)();
>   	guard(mutex)(&cpu_preferred_mutex);
>   

