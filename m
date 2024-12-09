Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0921505A;
	Mon,  9 Dec 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732381; cv=none; b=GLTvEoEJKBXuwiTRY0jj40SjQ8ekqaTWFTpJ0fULmMN2OMrW1cAHUH+Cot8dEYmkgzoy5F1sDov6WqBaqm31HiuLhJUGkh+gsFwwomeVCumo0xGotlqEwQ1jnPffeoaC/CyiOIZcT+y2C6JkuZQyVNnLUeAqaPA+W5xTGJte8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732381; c=relaxed/simple;
	bh=WbkvEoIaiG470FCd71mVg9lmDgRgpp+ASXlAcAPU40E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D+XkkQK8SnB9MVChMd7t0JTpi2THneF5fBZf4Xy/S7mS2FXPS0zZQHYE1vGtQA1coYZkj8P+7bbncW7TkGW2Kxq6fzv/D79Z36w0duIG+ZPGMY4ya8ZIAaUC6tq5ETsJ6vqURmz37+UL9mP7Ey+oo0ZyxTlkianpZOq/xb1s4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5sIhcDm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5sIhcDm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NOkvp000529;
	Mon, 9 Dec 2024 08:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y9uud5
	ruM6O8JA3vLeQfAAwPVqwN8jw+GdGTqPpU5WM=; b=M5sIhcDm/3G/epDf6wT9aq
	tGk8dGfw4IOXZl02YhiMQtsX+oPNEjDZgf/pLL8lJMWJ2xylzERcKcY7tEK6SZ4+
	GfrtygejRQB5aTRR2Eh0vdcy/BWp086JYTeJfIQjomAEzNv5Rqo9A0c4au+z/L6a
	UTdv8PpSBVs2Pfb8OoojMyZG7wD6QjjjL6PnxYMyJy0ab1uDJaOcWuk8YJ1IvQaC
	QOe15gA8hXTgITfV/GeMWJsOx5rqJ1kw7XuAg6b6/wOGt1JmEwgFB/6LQQ0l5+ko
	OevbkDt0+1qOcyQtoQoZUtJPN4YK9Fet92OHpRy/K9PfOAWOsYmNpIs6BxA0s1Rg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8g5nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:18:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B98IpFs016096;
	Mon, 9 Dec 2024 08:18:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8g5na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:18:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B957Cju032734;
	Mon, 9 Dec 2024 08:18:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps5wgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 08:18:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B98Imqk65733056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 08:18:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9D62004D;
	Mon,  9 Dec 2024 08:18:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED04720043;
	Mon,  9 Dec 2024 08:18:47 +0000 (GMT)
Received: from [9.171.77.252] (unknown [9.171.77.252])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Dec 2024 08:18:47 +0000 (GMT)
Message-ID: <5e3c0502-1a28-483c-a831-6d1f814501da@linux.ibm.com>
Date: Mon, 9 Dec 2024 09:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tobias Huschle <huschle@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] s390/topology: Add initial implementation for
 selection of parked CPUs
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20241204112149.25872-1-huschle@linux.ibm.com>
 <20241204112149.25872-3-huschle@linux.ibm.com>
 <1f7ad21c-372f-4d7d-b3dc-9a2fb194b704@linux.ibm.com>
In-Reply-To: <1f7ad21c-372f-4d7d-b3dc-9a2fb194b704@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G6Dqr1a2rHeB_Qv23cJ9bs_o2oSpnxIl
X-Proofpoint-ORIG-GUID: aL5EcZ04MHp423ywKXRbgg7LWNalNb6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090061



On 05/12/2024 19:12, Shrikanth Hegde wrote:
> 
> 
> On 12/4/24 16:51, Tobias Huschle wrote:
>> In this simplified example, vertical low CPUs are parked generally.
>> This will later be adjusted by making the parked state dependent
>> on the overall utilization on the underlying hypervisor.
>>
>> Vertical lows are always bound to the highest CPU IDs. This implies that
>> the three types of vertically polarized CPUs are always clustered by ID.
>> This has the following implications:
>> - There can be scheduler domains consisting of only vertical highs
>> - There can be scheduler domains consisting of only vertical lows
>>
> 
> A sched domain can have combination of these two as well. Is that not 
> possible on s390?

A combination is possible. It depends on the algorithm of the hypervisor 
how many of those mixed groups might be possible.

> 
>> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/topology.h | 3 +++
>>   arch/s390/kernel/topology.c      | 5 +++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/ 
>> topology.h
>> index cef06bffad80..e86afeccde35 100644
>> --- a/arch/s390/include/asm/topology.h
>> +++ b/arch/s390/include/asm/topology.h
>> @@ -99,6 +99,9 @@ static inline int numa_node_id(void)
>>   #endif /* CONFIG_NUMA */
>> +#define arch_cpu_parked cpu_parked
>> +int cpu_parked(int cpu);
>> +
>>   #include <asm-generic/topology.h>
>>   #endif /* _ASM_S390_TOPOLOGY_H */
>> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
>> index 4f9c301a705b..1032b65da574 100644
>> --- a/arch/s390/kernel/topology.c
>> +++ b/arch/s390/kernel/topology.c
>> @@ -299,6 +299,11 @@ void store_topology(struct sysinfo_15_1_x *info)
>>       stsi(info, 15, 1, topology_mnest_limit());
>>   }
>> +int cpu_parked(int cpu)
>> +{
>> +    return smp_cpu_get_polarization(cpu) == POLARIZATION_VL;
>> +}
> 
> Curious to know how this smp_cpu_get_polarization gets updated at 
> runtime? is it done by add_cpus_to_mask?

The polarization itself can get updated by the underlying hypervisor, 
which passes that information on to the Linux kernel.

A future implementation will not rely on the polarization as the main 
criterion but take more data points into account to allow a correct 
adaption to the load of the system.

Only using polarization would deny us the opportunity to overconsume on 
our entitlement if the machine has enough spare capacity. This patch 
just wants to be a tiny example on how this could be used.

> 
>> +
>>   static void __arch_update_dedicated_flag(void *arg)
>>   {
>>       if (topology_cpu_dedicated(smp_processor_id()))

