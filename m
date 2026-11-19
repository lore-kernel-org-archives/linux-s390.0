Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068690;
	b=iiaZ/PBNZ9lcN+JSfw8f6rZp7fs8UVojr8rcJ80htOA5Ey59w8BDYFWOO2aCIdG/lrlJ
	 8YskHWa84lQigakTpXeRObyjCJurjqZ/uvaohf/Qo/9/yripBvYQq4rrL6CtJ7d54KNJC
	 imHT8mxZv4NOrmIIUjLDUruEzzxUFXi2G/Ic8aUoRD86uV6d4RaLMeWe3vd5t/nKtSm+Y
	 V23TmlTCZplgJJUID5efB8+Ke/MFElw5X5MbT5ukIPO1es9teOpv/SUksnr8yluESm82B
	 Fxqc9zMGvvu3CjIJ3VBQYDDiB6WUBkSi70OFLVZWE2BcViRZtfmuMvHfMjezagc0JwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K94uGD6ArahpJXM5c3d3DXsLlZxdyqhuThEbcDtddfw=;
	b=SiQ1q1iqyHThbMJ6Fho+VX8X2XKOUC9P7uO8VX3RhgGFxD16asdNQ87smVhsROB5Yo7v
	 anuCt+/DPp78U2Fo17oSasmEez2PSl8hmUWGkC1IPuMFokUE3LW5Xy7J8UpOzhQYsK2tM
	 MPD+ed6XxvlHLYzVxoAKoS5WHKdyJmsflT5gg0cQs5l7avW7f0CjiSXRAGmO2ljvzUTPg
	 /7fzO186bws7ghpvX10bxThWin32iE12Hc42svtytpaofFDtBNeksR8rTYghx9LnyuA1f
	 ly7OkrEvx13fxwldau8F+jQ3nrP1fZfWbugW/BhPvsaLTwW5x2JbN3Xhzn92VAse91A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JzCIRTuu;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76177606A320;
	Thu, 19 Nov 2026 06:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76177606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JzCIRTuu
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4ivSU1961553;
	Thu, 19 Nov 2026 06:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K94uGD
	6ArahpJXM5c3d3DXsLlZxdyqhuThEbcDtddfw=; b=JzCIRTuusu6s5iqO5eNnD0
	K8f6C4aYWrT9XxYj3yF/7eQS6XvhyqjEdD5tWjpcu7FoPow7bKRb9TDfeLTs86K9
	z7L+oHkSaDD7/IOtSOmi10AlKRYuMk0J7IFs3v3PNAiCfhahREyLczJgvBVmUQia
	IbEH6AxM9p8frtyu0WFu2QjmRzYPxOeaLJ2Ye3MkHRi9RAeWO29hE4zgLWr3UQs6
	Pp6EZAcbB087oobA79/cdfBloF8RWTSbEP0e72+Nx/kgo5K7Zgkju9Nkb+vllhPc
	RPa7BSS1AIcOyEmK4+iNK4Y90EpSQKgEjuzDFjvUYwgaYEz9w8Xdeqm6KlaFNwQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vxp53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:10:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4rvA7063193;
	Thu, 19 Nov 2026 06:10:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6tgwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:10:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ6AmNZ41877988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 06:10:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C41B620043;
	Thu, 19 Nov 2026 06:10:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E6620040;
	Thu, 19 Nov 2026 06:10:41 +0000 (GMT)
Received: from [9.124.217.144] (unknown [9.124.217.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 06:10:41 +0000 (GMT)
Message-ID: <8a61dd54-3602-4823-b5b5-54f25c40f8e8@linux.ibm.com>
Date: Thu, 19 Nov 2026 11:40:40 +0530
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
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
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
 <20261113184257.621707-8-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261113184257.621707-8-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vHcnMrHdG8xsxPhX4i7HZDwEriYUFoxD
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afe92ee cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=JfrnYn6hAAAA:8
 a=Ikd4Dj_1AAAA:8 a=lFpQOZMjgk80ak9VIzcA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: ZJfZmJmeD5y3cLlk5IdTGNjp44sbM-W0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfX3jcybAWDsu+h
 qQxcok/NkgVeXrZRP6vJU+qPrxyHFQ5SKv/t7okkhntM1MAOzIsS7+/v+/Fz3sTkkdgbWXK2jh2
 Wi+IXwVroZBdAcNsViROyNXMoBL8ZE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMyBTYWx0ZWRfX4ZuGjLzOJm1u
 l3fSjDdIagoD1LE4m7LWPB2I+xw23v7O+gFf9TXZF7RqztRbyBHnxsFMOL/w+FZfI/uUDB4BP0e
 hpPVewJQeTHwWeCyqIH3cKJGEBvE34v4K8F8McH72feYp+cBl2YNGGUZph8TG9nBkIwaMic64Jp
 f8mvG81YZejZF9UuVnSwdsutZQKnY1Vjsgx121u05DFmCXRaxpmNYVim4p38cd9wmzwmh/AlMtz
 aBOand4uYF687b+/pE5aJc1OQOnlKyTbX06yBj9xANWRE2v8tZZi9RqDYJ0NQvMEGByP0Qg4VjS
 CRC6uGeZWipuUEkkL/NIWiOqTBSxiBBDoPQKAGVmyTUD82a9PozftX2CYkTgnc9zF3api2sEWDD
 9ydpf5ttC9sKuhsr2hn1M4VBwrd3akF8aCLayz6KI5GCVpnnyttSYhcYnHAGCNZmegIXHGSblJM
 hRQdklL6hNE+Ly6ob9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190023

Hi Yury.

On 11/14/26 12:12 AM, Yury Norov wrote:
> Serializing preferred mask updates still lets competing policy drivers
> repeatedly override each other's selections.
> 
> Disallow multiple policy drivers running at the same time with the
> exclusive ownership rule.
> 

This patch should go with the write interface patch series IMHO.
There are no new writers/governors with this series.

> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   Documentation/scheduler/sched-paravirt.rst |  2 +-
>   drivers/virt/steal_governor.c              | 13 +++--
>   include/linux/cpumask.h                    |  8 +++
>   lib/cpumask.c                              | 62 ++++++++++++++++++++++
>   4 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-paravirt.rst b/Documentation/scheduler/sched-paravirt.rst
> index 311cdbf2722b..d8f446c3ab6e 100644
> --- a/Documentation/scheduler/sched-paravirt.rst
> +++ b/Documentation/scheduler/sched-paravirt.rst
> @@ -48,7 +48,7 @@ Notes:
>      makes decisions should enable it. For example, steal_governor driver
>      (``CONFIG_STEAL_GOVERNOR``). On enabling the driver, CPU preferred state
>      can change based on steal time. Without the driver, preferred CPUs is
> -   same as active CPUs.
> +   same as active CPUs. Only one governor may be enabled at a time.
>   
>   2. This feature works for the FAIR class only.
>   
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index f71dbf27e4a9..b456b03714e4 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -291,6 +291,10 @@ static int __init steal_governor_init(void)
>   	}
>   
>   	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
> +	ret = claim_preferred_cpumask(&sg_ctx);
> +	if (ret)
> +		return ret;
> +
>   	/* Lock to prevent unobserved hotplug event during setup. */
>   	scoped_guard(cpus_read_lock) {
>   		sg_ctx.steal = get_system_steal_time();
> @@ -301,8 +305,10 @@ static int __init steal_governor_init(void)
>   							 hotplug_callback,
>   							 hotplug_callback);
>   	}
> -	if (ret < 0)
> +	if (ret < 0) {
> +		release_preferred_cpumask(&sg_ctx);
>   		return ret;
> +	}
>   	sg_ctx.hp_state = ret;
>   
>   	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> @@ -316,10 +322,7 @@ static void __exit steal_governor_exit(void)
>   {
>   	disable_delayed_work_sync(&sg_ctx.work);
>   	cpuhp_remove_state_nocalls(sg_ctx.hp_state);
> -	guard(cpus_read_lock)();
> -	guard(mutex)(&cpu_preferred_mutex);
> -
> -	reset_preferred_cpumask();
> +	release_preferred_cpumask(&sg_ctx);
>   	pr_info("disabled\n");
>   }
>   
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 3716213d0730..1f4d93adb917 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -132,6 +132,14 @@ extern struct cpumask __cpu_preferred_mask;
>    * holding cpu_preferred_mutex isn't necessary.
>    */
>   extern struct mutex cpu_preferred_mutex;
> +
> +/*
> + * Drivers must claim exclusive ownership of cpu_preferred_mask
> + * for the whole period of operation.
> + */
> +int claim_preferred_cpumask(const void *owner);
> +void release_preferred_cpumask(const void *owner);
> +bool preferred_cpumask_owned_by(const void *owner);
>   #else
>   #define __cpu_preferred_mask __cpu_active_mask
>   #endif
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 2e16e19a2bdb..ee710c3c8920 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -3,8 +3,10 @@
>   #include <linux/kernel.h>
>   #include <linux/bitops.h>
>   #include <linux/cpumask.h>
> +#include <linux/cpuhplock.h>
>   #include <linux/export.h>
>   #include <linux/memblock.h>
> +#include <linux/mutex.h>
>   #include <linux/numa.h>
>   
>   /* These are not inline because of header tangles. */
> @@ -170,4 +172,64 @@ EXPORT_SYMBOL(cpumask_any_distribute);
>   #ifdef CONFIG_PREFERRED_CPU
>   DEFINE_MUTEX(cpu_preferred_mutex);
>   EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
> +
> +static const void *preferred_cpumask_owner;
> +
> +/**
> + * preferred_cpumask_owned_by - test preferred CPU policy ownership
> + * @owner: policy identity
> + *
> + * Return: true if @owner holds the policy, false otherwise.
> + */
> +bool preferred_cpumask_owned_by(const void *owner)
> +{
> +	lockdep_assert_held(&cpu_preferred_mutex);
> +
> +	return preferred_cpumask_owner == owner;
> +}
> +EXPORT_SYMBOL_GPL(preferred_cpumask_owned_by);
> +
> +/**
> + * claim_preferred_cpumask - acquire exclusive preferred CPU policy ownership
> + * @owner: non-NULL identity that remains valid until ownership is released
> + *
> + * Call before starting policy work, normally on module init.
> + *
> + * Return: 0 on success, -EBUSY if claimed, or -EINVAL for a NULL identity.
> + */
> +int claim_preferred_cpumask(const void *owner)
> +{
> +	if (!owner)
> +		return -EINVAL;
> +
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
> +	if (preferred_cpumask_owner)
> +		return -EBUSY;
> +
> +	preferred_cpumask_owner = owner;
> +	reset_preferred_cpumask();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(claim_preferred_cpumask);
> +
> +/**
> + * release_preferred_cpumask - release exclusive preferred CPU policy ownership
> + * @owner: identity used to claim ownership
> + *
> + * Call after stopping policy work, normally on module exit.
> + */
> +void release_preferred_cpumask(const void *owner)
> +{
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
> +	if (WARN_ON_ONCE(!owner || !preferred_cpumask_owned_by(owner)))
> +		return;
> +
> +	reset_preferred_cpumask();
> +	preferred_cpumask_owner = NULL;
> +}
> +EXPORT_SYMBOL_GPL(release_preferred_cpumask);
>   #endif

