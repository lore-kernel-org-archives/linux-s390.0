Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069394;
	b=hFx+qqGQAeYBBTzjl/wF1yCD+1vqxAw3Zc3sQ74o9M/4I2FpYDz3ByNsNfYEwe5Xb5Ox
	 cBoDMnjh0IFVUUfJBcuo5XaWqMWK2nf2SNtaqb7w0XkScbB1BiLIGHxbdOAwBrleXNQFU
	 6kr4pShkPFIWwgrdA113EK2R4sAzf3YrG30uTrRIK5TlJ0GuY5ztlXB6h7VLCwhDxbaL3
	 cJ+ZHLPR57qKpbRLjFYt9Tip9VSHZqy7OSmlgyz4fAcAalGQGVhMDY544R7fJPE5r5UnI
	 yMDj/36DMCnKDiv1XcofRNS7i9ASs7c4K5Pwj+0puLOVM0iq71OlOaVNT9K7a6OBl4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069394;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=puzUkQ2hTfY+cHN+MMoEyRYAem8Ra1RSFNJumDklOsE=;
	b=BocpECWIOeMYxLLp6oOEoQ2GrwsGGGEYXyXWPalcABO7nuS2S0CTzouLuKIXmW++FsXv
	 Vb8Zfha9ajU5RIzHBoFz0LxLNYCAuIP1yBE/E5RM167wkOkUaEVkGDpFuVd7OFJLdzVmO
	 1ePDsmCgc1BAxszDX0nhxk8LywoQcHYKhwTJbOhMkqqH8x9TTn7i+WEmmBOp34lvktJir
	 VemyNehHu7iDZRbNhFuktykZW7MDiZA0UWkG3wzAxZFMRXFI0rRMs3p7Scgnlyjz95Bcp
	 rpiY9/RbAOEfvWzxy7YB1ZDZNU8Hjz+2Zv8uX1OIJENmtLmAZUs7E8Cqjq6EJb6HJow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MV8+4srj;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AC606A326;
	Thu, 19 Nov 2026 06:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F8AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MV8+4srj
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4jIDQ3160376;
	Thu, 19 Nov 2026 06:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=puzUkQ
	2hTfY+cHN+MMoEyRYAem8Ra1RSFNJumDklOsE=; b=MV8+4srjt30YwvEoIf2Dbh
	MlIAG7di+0408kgbHkdkdSBfghHrRs7xerJJR02Fvnc1fEbZGMqsvqB+bYFV6GGt
	Jed9lBlleM02zKUMeiO+vk0clNSU9d5OFd8zcLJ9Tf4FO9mVxVGSoZBLnxqmfjh+
	m34w//vFKSZgXMA6uYws3Y0Lznbwy0h79iAbzTt9JukV5r2AYuSQGkrLaKWGJoDn
	V+EZ+aI9bVG8vyrrtxrthzqnviR2HzRTSsUEUQ9x9SVFhvGLfMamcx56UI8GkZRH
	mVNRDmvw1RlWEJjxlJSwN5cMj6b96seRO1qJnwDF8yzmwHeIbjAUPy1+TcWoHIhw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t6ygb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:22:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4XlJv2162899;
	Thu, 19 Nov 2026 06:22:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvnsp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:22:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ6MSNg40370502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 06:22:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4260E2004B;
	Thu, 19 Nov 2026 06:22:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D671220040;
	Thu, 19 Nov 2026 06:22:20 +0000 (GMT)
Received: from [9.124.217.219] (unknown [9.124.217.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 06:22:20 +0000 (GMT)
Message-ID: <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com>
Date: Thu, 19 Nov 2026 11:52:19 +0530
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
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU
 hotplug
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
 <20261113184257.621707-5-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261113184257.621707-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afe95aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8
 a=RNFODHZklxBg7YJVFhcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5QmSlD6ZkKM8ZZj26W2boOBVbTdbFjBl
X-Proofpoint-GUID: Zn19TAfC3VfxQS4eNZ_abzonEMfRlKhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfXxRyPjTB6Zucd
 ThUELYVhwn4c0txy/NjqHCVch4178BCM2xRwK7z7LyLo1QRglafWr5iHc9vKojj0d40UOgSxSUq
 Zei+Huxe/wrbNMVNdkBQbMmhZHHrkY7ZIl7yGdBVE8BS3JWyFqEjlJa7TmfW7qCJ+nX00Rl5GUh
 sNY1esuYlJyISPTcivJhC5tLSE+QxGk385SDSXx34DQzsVudBhVNIhvwv5bwdhkzWm24f13UrbK
 79wXi8nM12es9Gin6knihba7Ge/jX4OZg3qfVjZ9MzOxLRP3opvX5n4SYBEu6pafrnDcwQEiMKN
 CG2wNSmMjjicd+eWPw51x2Lgb2J6tcsfVqXViS9Ox7CbVfZh+txhSFr7FkVwtCsIiV2VFgrwUAl
 TdIYseZt4EhJb3tRs3fTKkrlte2E6RwPTMsPjkfip43b8iC58mZ2e/E4byM1QJCLHJhWcabVPkP
 3sb4Zj074pbtZrVYsxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfX73l9/gEQ8ZA+
 3FE0bRIuLnFI1uWGEF3N9VSQ5ywNck5Bt5tDYbijkmjzyofLkoWXhcEPwqa0f8mkUtfidvKZjJA
 lkpiC/Zq7XGRpEhhh6XnnCUdHfyJkSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190023



On 11/14/26 12:12 AM, Yury Norov wrote:
> Steal governor is not safe against a concurrent CPU hotplug operation
> because it can change active and preferred cpumasks during the governor
> sampling.
> 
> To address the race, the governor would take the cpus_write_lock(). But
> that may be impractical for the loadable module.
> 
> Instead, implement the following locking policy:
> 
>   - if the code takes cpus_write_lock(), it's enough to write-access
>     the preferred cpumask;
>   - if the code takes cpus_read_lock(), it must also take
>     cpu_preferred_mutex in order to modify the preferred mask.
> 
> The core scheduler and hotplug paths already modify the preferred cpumask
> under the cpus_write_lock(), so no change in core logic is required.
> 
> This provides a common update protocol for multiple policy drivers
> without requiring writers to take the broader CPU hotplug write lock.
> 

This is also necessary if there are multiple writers outside of core hotplug No?
So should it go with the write interface series?

> Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/virt/steal_governor.c | 17 +++++++++++++----
>   include/linux/cpumask.h       | 11 ++++++++++-
>   lib/cpumask.c                 |  5 +++++
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index 26b6bcca27ed..8cd5c0f3e3ef 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -23,6 +23,7 @@
>   #include <linux/ktime.h>
>   #include <linux/math64.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/sched/isolation.h>
>   #include <linux/topology.h>
>   #include <linux/types.h>
> @@ -139,7 +140,8 @@ static void decrease_preferred_cpus(void)
>   	int target_cpu = nr_cpu_ids;
>   	int cpu;
>   
> -	guard(cpus_read_lock)();
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&cpu_preferred_mutex);
>   	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>   				cpu_preferred_mask);
>   	if (cpu >= nr_cpu_ids)
> @@ -179,7 +181,8 @@ static void increase_preferred_cpus(void)
>   {
>   	int first_cpu, cpu;
>   
> -	guard(cpus_read_lock)();
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&cpu_preferred_mutex);
>   	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
>   
>   	/* All CPUs are preferred. Nothing to increase further */
> @@ -193,6 +196,9 @@ static void increase_preferred_cpus(void)
>   
>   static bool preferred_cpus_valid(void)
>   {
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&cpu_preferred_mutex);
> +
>   	if (cpumask_empty(cpu_preferred_mask)) {
>   		pr_err("empty preferred mask. stopping\n");
>   		return false;
> @@ -213,6 +219,9 @@ static void steal_governor_loop(struct work_struct *work)
>   	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
>   	ktime_t now;
>   
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
>   	now = ktime_get();
>   	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
>   
> @@ -238,8 +247,6 @@ static void steal_governor_loop(struct work_struct *work)
>   	 * module restores to active if CPU hotplug breaks those assumptions.
>   	 */
>   	if (!preferred_cpus_valid()) {
> -		guard(cpus_read_lock)();
> -
>   		reset_preferred_cpumask();
>   		return;
>   	}
> @@ -276,6 +283,8 @@ static void __exit steal_governor_exit(void)
>   {
>   	disable_delayed_work_sync(&sg_ctx.work);
>   	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
>   	reset_preferred_cpumask();
>   	pr_info("disabled\n");
>   }
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index b13d099474bc..3716213d0730 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -124,6 +124,14 @@ extern struct cpumask __cpu_dying_mask;
>   
>   #ifdef CONFIG_PREFERRED_CPU
>   extern struct cpumask __cpu_preferred_mask;
> +
> +/*
> + * Drivers must take cpus_read_lock(), then cpu_preferred_mutex and
> + * hold both across mask validation and updates. If cpus_write_lock()
> + * is held, it guarantees the exclusive access to the mask, thus
> + * holding cpu_preferred_mutex isn't necessary.
> + */
> +extern struct mutex cpu_preferred_mutex;
>   #else
>   #define __cpu_preferred_mask __cpu_active_mask
>   #endif
> @@ -1199,7 +1207,8 @@ void init_cpu_possible(const struct cpumask *src);
>    * reset_preferred_cpumask - reset preferred CPUs to the active mask.
>    *
>    * Callers must serialize against CPU hotplug and other preferred cpumask
> - * writers.
> + * writers. Requires cpus_read_lock() and cpu_preferred_mutex; or
> + * cpus_write_lock().
>    */
>   static inline void reset_preferred_cpumask(void)
>   {
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 5adb9874fbd0..2e16e19a2bdb 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -166,3 +166,8 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp)
>   	return next;
>   }
>   EXPORT_SYMBOL(cpumask_any_distribute);
> +
> +#ifdef CONFIG_PREFERRED_CPU
> +DEFINE_MUTEX(cpu_preferred_mutex);
> +EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
> +#endif

