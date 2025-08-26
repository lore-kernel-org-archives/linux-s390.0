Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866D2248A4;
	Tue, 26 Aug 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196437; cv=none; b=ZLpfWx5UaWxsIdwD4TrUeaiyyiV9Jcd2SwRHT2oX458Ae27ETYTm08qXJfzbSYW5Fsw8nxMCl6yWZOAL6TaRe/XxWD3/hACGGupZXdd/QEtcBUiGBNdDclF+W1Gscpzzb7SYZiAIwL3jSqzHgA+e992B26ENTDuQnBbdgIFaHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196437; c=relaxed/simple;
	bh=esU0BJE6AEb+zv/ijPoESgZfSOIaYt6UKHknAJ0+OnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skEyY7VQWHWbAdL3JY6RsjXlfdxAR3Qy3rZdU4n5z1/osfIgeyXJC6Jm4vQqQ7YKqLd8EJvFYXEjpeQvpD5+1Oevxcsp6uHkhfMYKc0cit5Xw8GFbzB6218wVzyxG9uCqQNjmRPhSLIxhDYbj2+wtq8MXbuhC9XU547n7eWe23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cB0k63K4Cz9sSp;
	Tue, 26 Aug 2025 10:11:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiYLp3UY9uY7; Tue, 26 Aug 2025 10:11:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cB0k6241Nz9sSn;
	Tue, 26 Aug 2025 10:11:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A7BA8B764;
	Tue, 26 Aug 2025 10:11:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OvpXfkz87_WW; Tue, 26 Aug 2025 10:11:42 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B2258B763;
	Tue, 26 Aug 2025 10:11:40 +0200 (CEST)
Message-ID: <a506bb53-6e17-4a10-a870-50ce87a4ce06@csgroup.eu>
Date: Tue, 26 Aug 2025 10:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] sched/topology: Unify tl_smt_mask() across core
 and all arch
To: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 thomas.weissschuh@linutronix.de, Li Chen <chenl311@chinatelecom.cn>,
 Bibo Mao <maobibo@loongson.cn>, Mete Durlu <meted@linux.ibm.com>,
 Tobias Huschle <huschle@linux.ibm.com>,
 Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Brian Gerst <brgerst@gmail.com>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andrea Righi <arighi@nvidia.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-6-kprateek.nayak@amd.com>
 <20250826080123.GB3245006@noisy.programming.kicks-ass.net>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250826080123.GB3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2025 à 10:01, Peter Zijlstra a écrit :
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 602508130c8a..d75fbb7d9667 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -37,7 +37,13 @@ static inline int cpu_smt_flags(void)
>>   {
>>   	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
>>   }
>> -#endif
>> +
>> +static const __maybe_unused
>> +struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
>> +{
>> +	return cpu_smt_mask(cpu);
>> +}
>> +#endif /* CONFIG_SCHED_SMT */
> 
> Problem with that __maybe_unused is that you forgot inline.
> 
> static inline const
> struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> {
> 	return cpu_smt_mask(cpu);
> }
> 
> seems to make it happy.
> 

But the function is referenced by SDTL_INIT() macro so there is no real 
point in declaring it inline. Would be cleaner to have it defined in a C 
file.

Christophe
