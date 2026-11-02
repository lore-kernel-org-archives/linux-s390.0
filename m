Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619349;
	b=z8ZCPvxt+82Wnb1PErmzDInf+lgnCxtinN+MRWyNGH8S3JkSyrV8vJYi4oqAIjsxsLyR
	 nfy740dtrLLkfAo28tvT799YMVsHvHq4z1YBeUWJmPRrB3+FVbl08mN3Wr+T6VWtzSHiM
	 gPTyQWOdbtKew1Lu5a5FKy8rkTkTl6BbfdDR1p/luGv9+6kiAcvdxedeNqoKaSwETBfSi
	 X240YEUWTLo12OCczLyK934QaMVUU4UpsYLOlaRf//ktnhttpJWUnLGHObzk9T7Xs5jlu
	 /LmVy+yM4Z83k2v/rUMO0bP/ni/wZ3ipEVztxMpqV47T6enZ1+1GlUygQ1jCuPqSZcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619349;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TfXq70VRw0+EWLo4hGrFvfTZk90eytaHGZHylY3mlwY=;
	b=bn9YZjbj/n55j19xoFSiuJO138CW66Whkp6s5MG+wHZq71PKyxArEx+6/Y89w7BGsqAd
	 v9+vaGnlFJgDoH35VmhOHQS5K8lFisZQ0u+RwXcjj7Y37BQp0ZsqhSV69Or0GnCsKY32w
	 jwZldqDZn/uJm/8pBWzXO56f8uBZY8CRCHs2aBN+zrT9GwP/TeO0pQL61mkVi/R5DWji7
	 lliKAFk7XZGaZef5HwbUPuO4KavUew5j/72n41/tkKRkuyJx+9ezJgjpn4qJGka7bNn4I
	 ZXd8AVKrR/k5lgW5xfS3LFgjLW1oAm/QW2EZAJ8IAdCcsQkiUbrfPNwSlqumszC4RRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="PJUrk7/s";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40099606A326;
	Mon,  2 Nov 2026 11:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40099606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PJUrk7/s
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29E8Me2719556;
	Mon, 2 Nov 2026 11:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TfXq70
	VRw0+EWLo4hGrFvfTZk90eytaHGZHylY3mlwY=; b=PJUrk7/sHaYVEd2TuGFtfR
	w+Uc0DWCtWbfg5P0mqK8Gk9ZbrG1E2hiLz6/Ot4Sps19vpEPm4MCVmxamgvPcZ6x
	vTcM7/6Gn9fzzoWat0MUY0iesHtnS5TKUmbXkIRUvBsQFC43KqJgFBh7BFkmU7Rb
	AU8idQUOXK2UvK0U0ONyxVVckGddFW5oamiUF6De0cbVDLnsImWDzSTJWQClnfI5
	KBhA73mx0pmyc7XqRohoh/sVujE1MovOObPNAN1HeIlVT78mbguv7bCloLObOfAX
	xBiUZwwr0zqChRBHzWgUUq2MCCo3vimjH0+8b5sLYBcGTgH7KTBZBCL0FnF9pTjw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u386su-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 11:35:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Jt2P703033;
	Mon, 2 Nov 2026 11:35:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnpwq1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 11:35:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2BYv4X31588636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 11:34:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CE8520043;
	Mon,  2 Nov 2026 11:34:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F17720040;
	Mon,  2 Nov 2026 11:34:56 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.80.131])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 11:34:56 +0000 (GMT)
Message-ID: <9273846b-d815-4c40-a7a0-960281515878@linux.ibm.com>
Date: Mon, 2 Nov 2026 12:34:56 +0100
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
Subject: Re: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in
 Kconfig.preempt
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yury Norov <ynorov@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi
 <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
        Mete Durlu <meted@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-2-ynorov@nvidia.com>
 <388636ac-4521-4523-bb5b-b6bc71591ff6@linux.ibm.com>
 <20261102110026.GG1813469@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261102110026.GG1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae87566 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=I1v3tsrwUu51H011r8EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: we72V2jneRZhoR5xmwFuL_ybqRSX3oIk
X-Proofpoint-GUID: 5evHCYDIK3Zr41_QeZIheuYxwC9baE2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfXxaptEFt9Wq7Y
 YsLWgdI4NtRzlPpH7XpzpXLQU4dbQX1MbTUTbtUrvie8cqjbED3Tf5zyGcm44I5DV2xpwJuRgh3
 z7Kj2uImG+RHwITIoXw3xgZdk6OYP2eX2h8mfe1EIb/1KA+XLdDkookz+W5Mrz05uOu5R+hqoFT
 sZYjS6z6OJom7qg41WvepQhE/MTLFd00p+0eZh5yIOgZX9TxdMTBmrGtUrRj3OG3p24TRVF0S+W
 dAg4sNlbiF558AhyX7t8y8ZagGqw/zwuI5F96FODOT+75lPQOFf/5qR5EvbUzxtxeS9y3UHrKyD
 3IuEGSc+z0GVdePBPBQlJ+BUl7wfjedPdmFh/5krR4fHeWQtxSydQW4XE84qJLT8V0p1PsG+0h8
 00xXrPdzUYRFmsmte6xiyo5mpXQu+xtvTbbGkML6KlAkuiGO7tbXLHhFvemfshcu9WXT3f3M956
 yFPH2sQJpdfkZaLlBfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NCBTYWx0ZWRfXz1mH42xp8ibK
 a+jDfdF/+xjaItdtLNeX2pYORs9I2F+HJOfg3G3TihWlTcsEQEblkugE4I04PcLqsDinlRez0Jj
 I5kqIATiGDtQMh0VB6OwVYWewbx34ZQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020044



On 11/2/26 12:00, Peter Zijlstra wrote:
> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>
>>
>> On 11/1/26 20:21, Yury Norov wrote:
>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>> is enabled.
>>>
>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
>>> and requires it to minimize the configuration space and runtime overhead,
>>> with the lack of non-paravirt user. Now that s390 wants to adopt preferred
>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>
>>> Make PREFERRED_CPU a user-configurable option, even if paravirtualization
>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>
>>> Keep the default module selection conditional on PARAVIRT so other SMP
>>> configurations can opt in without enabling the governor by default.
>>>
>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com/
>>> CC: Mete Durlu <meted@linux.ibm.com>
>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>> ---
>>> Can be applied independently from the rest of the series.
>>>
>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> This is really useful to us, since even though s390 is nominally
>> paravirtualized, it does not technically benefit from defining
>> CONFIG_PARAVIRT.
> 
> And therefore removing PARAVIRT is the only possible solution?
> 
>> Specifically, steal time accounting happens by
>> computing a difference between wall time and CPU time, and not by
>> explicitly querying the hypervisor.
> 
> Nobody explicitly asks the hypervisor, that would be horrendously slow.
> 
> Something trivial like this should do.
> 
> ---
>   arch/Kconfig                           | 9 +++++++++
>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>   arch/s390/Kconfig                      | 1 +
>   drivers/virt/Kconfig                   | 2 +-
>   4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1163736de1f9..8980054beb52 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>   config HAVE_PV_STEAL_CLOCK_GEN
>   	bool
>   
> +#
> +#  Archs that can account CPUTIME_STEAL; normal route is through PARAVIRT which
> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and PPC-LPAR
> +#  which have their own thing and don't go through generic cputime accounting.
> +#
> +config HAVE_CPUTIME_STEAL
> +	bool
> +	default y if HAVE_PV_STEAL_CLOCK_GEN
> +
>   config HAVE_MOVE_PUD
>   	bool
>   	help
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 7d125e288f6e..3c49baf606d7 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -41,6 +41,7 @@ config PPC_SPLPAR
>   	depends on PPC_PSERIES
>   	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
>   	select PARAVIRT_TIME_ACCOUNTING if VIRT_CPU_ACCOUNTING_GEN
> +	select HAVE_CPUTIME_STEAL
>   	default y
>   	help
>   	  Enabling this option will make the kernel run more efficiently
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 7138d923d86f..03a884355218 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -291,6 +291,7 @@ config S390
>   	select USER_STACKTRACE_SUPPORT
>   	select VDSO_GETRANDOM
>   	select VIRT_CPU_ACCOUNTING
> +	select HAVE_CPUTIME_STEAL
>   	select VMAP_STACK
>   	select ZONE_DMA
>   	# Note: keep the above list sorted alphabetically
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index eeb84e578ddf..a3721d34a55c 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -43,7 +43,7 @@ config FSL_HV_MANAGER
>   
>   config STEAL_GOVERNOR
>   	tristate "Dynamic vCPU management based on steal time"
> -	depends on PARAVIRT && SMP
> +	depends on SMP && HAVE_CPUTIME_STEAL
>   	select PREFERRED_CPU
>   	default m
>   	help

I can't comment on the PPC part, but for s390 this works fine with the
following addition:

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -197,4 +197,4 @@ config SCHED_CLASS_EXT

  config PREFERRED_CPU
         bool
-       depends on SMP && PARAVIRT
+       depends on SMP && HAVE_CPUTIME_STEAL
