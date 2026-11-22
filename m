Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362922;
	b=vtiWvwNsa1YN8UW7LZi/GIqQ8PlkxxzdGyV0IzDf+42tPJXQJD26XyP3yRxRJBJxYHBt
	 89xgkbwQ9B9A4+wnbz0JeZrhCwa2sfFWXHwhAmC4S3WzOX/4C0j6m7cDwe8pio/3fGzO9
	 RZUkH1QfiwHomoxaKJfVQzRmy3tkZ4m922QMigDi2EyXsI15JPOj1zCoRBS0TvsodjawQ
	 TW7HHkg91FrC3i9BDSaWpv/lnDzUghT/bdruOo7VboC2EWeUXdVQ7oR9R7XUKjqjw1GwN
	 c5BaJqNRQnFpx9xAiEzJHgOqHGS+jG2F/4IvW4Fr6pI9/+3p3FBmXeFTyOj9T2dh1bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362922;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/7MVC0aL+JKktBiQ05MuibISkezA5BtLH01mbRqMJvw=;
	b=GaNljMUkUnDyikO1YjTH0JNnUe5PtzUmNv/GcqkLAYRPyfttK/C33sidSwgddpW9lonG
	 GwbNtJ9OBPd+CLVuYlU1Zm8vK7HBbVEePfoUjSVP+/fHmgoaPO8+uKPEOPQqIabgUaNb3
	 C9mYl0NJIibvxmAzq9qEu6hytUuwRtiw2V8S0E59EBhM6kyASLiRBvDCuqrqjxoUl17kB
	 pns+EwakgECxXfnhvfWu+rc2RC/4R0u84RrGPFc/paynYg9pH0IqhdPhxywxcdT8D0oSJ
	 aSQ7T5TI/pJ9oB/lmLdybIUThyye2I77eaT3w3giK6XpkSdh5YnskbSVenkidN1+2zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DsfHgwm9;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CE606A333;
	Sun, 22 Nov 2026 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2CE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DsfHgwm9
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMFZJDm895705;
	Sun, 22 Nov 2026 15:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/7MVC0
	aL+JKktBiQ05MuibISkezA5BtLH01mbRqMJvw=; b=DsfHgwm9i/dIpsjZsQ8E8B
	K68V4cHolriVPWT86SsX4uzHcNqB4r6ewELoRhx4anP/7YytcHVxK16Hr9SBFq68
	i0AsTYgeQjI5gPsyUNwXxO4u+2trH4oBoV7UYw7IrJ5i7e27LOJBT0qFvzh0Ly//
	V7AeUw6k+gOjjQnFRvE9K6TVvXNiV6tdfsOcf85viOsmBOvHjdGUwEueRHusoeFt
	lTmI9YOG1aGfctSJq2vqeY4i5ineDHAYDAPqf4Bxrh7HZAU5xudDWVaKvu0DVlyC
	b8YCdHD6JdXHi/KuRX1gPIumLuZAoEpyd+O2nWf025J+1xLV+wQxRhk89hu7CaDA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34guy20w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 15:54:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMFYEkl457449;
	Sun, 22 Nov 2026 15:54:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqb4yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 15:54:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AMFsH3G49086764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 15:54:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A012004B;
	Sun, 22 Nov 2026 15:54:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C85320040;
	Sun, 22 Nov 2026 15:54:10 +0000 (GMT)
Received: from [9.124.223.55] (unknown [9.124.223.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 15:54:10 +0000 (GMT)
Message-ID: <4061adb8-0f62-4630-87bf-dc7598ac18e0@linux.ibm.com>
Date: Sun, 22 Nov 2026 21:24:09 +0530
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
To: Yury Norov <ynorov@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi
 <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
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
 <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com> <av8oy9v9eLTL0dw8@yury>
 <38f8999a-f3e1-486f-870b-25710462308e@linux.ibm.com> <awBopXdhgUatAU9d@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <awBopXdhgUatAU9d@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b03102f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=kkHrh7IN9Q2Nb_kOQYwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA2MiBTYWx0ZWRfX5SRrjpBFrS83
 tWLkOfdOdVt2dGegO6xkgD4vMKyf7239B0f6rcvHE66WzazIrteP0zum9wfRjLv7nvoTJDoOZ6c
 /I6hkBKrPXqhfFOJAhO9irJcG1z6jiA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA2MiBTYWx0ZWRfX6t7WpMUP2ZBv
 DzNpZghlcjJyJ49zrw4WyJeKZr/MazUfFczB3ibscKvY8C00GMr1uJ8tWCFPdWlfuZILITRZr+f
 dFEZZAMxvCF8hcc9x8aGSlPop5+KySmkEWKnqN2zIMe6raoAZWmJtPnz/KKJugxy3LzI6FXJ4jO
 PAbtItG0D5b/w1SjzkPFI1vY6fO5XGFjxMWYycEHNo4OJzGdCvy3d4YnvLAayziPALHHS9/ivEn
 733rRdvAIqkuTM2KzJ4Bz9FasR6LHlHZIoTkt9jQySbes5Z9ZlaIShAvFpmLh+K85F6r18X47nj
 HHWPWNHvZq2LRz24nObtcaorOHf2NUBWhbw7C9PvuhHxs0QgmqtDXUDyRanbeEWshvNNL8KZU2w
 VebNnDZ2FI2MCc575+nZicTjVxPSVGJfnyOu0ejfXkijtTZ+RE0dKTMjOCV/YMGbO/BQTsfHgtU
 A506SuNM0zd5OiGE47Q==
X-Proofpoint-ORIG-GUID: j5BX4CE2aga9eSZZqrXIMb4hC4i1TJd7
X-Proofpoint-GUID: 9Qs7XKaSwJ4XIaAT-MRFiGkahS3Q8OzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_03,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220062

Hi Yury,

On 11/20/26 9:05 PM, Yury Norov wrote:
> On Fri, Nov 20, 2026 at 02:08:59PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 11/19/26 10:20 PM, Yury Norov wrote:
>>> On Thu, Nov 19, 2026 at 11:52:19AM +0530, Shrikanth Hegde wrote:
>>>>
>>>>
>>>> On 11/14/26 12:12 AM, Yury Norov wrote:
>>>>> Steal governor is not safe against a concurrent CPU hotplug operation
>>>>> because it can change active and preferred cpumasks during the governor
>>>>> sampling.
>>>>>
>>>>> To address the race, the governor would take the cpus_write_lock(). But
>>>>> that may be impractical for the loadable module.
>>>>>
>>>>> Instead, implement the following locking policy:
>>>>>
>>>>>     - if the code takes cpus_write_lock(), it's enough to write-access
>>>>>       the preferred cpumask;
>>>>>     - if the code takes cpus_read_lock(), it must also take
>>>>>       cpu_preferred_mutex in order to modify the preferred mask.
>>>>>
>>>>> The core scheduler and hotplug paths already modify the preferred cpumask
>>>>> under the cpus_write_lock(), so no change in core logic is required.
>>>>>
>>>>> This provides a common update protocol for multiple policy drivers
>>>>> without requiring writers to take the broader CPU hotplug write lock.
>>>>>
>>>>
>>>> This is also necessary if there are multiple writers outside of core hotplug No?
>>>> So should it go with the write interface series?
>>>
>>> The race is real, and it's already there, so this is the fix for an
>>> existing functionality.
>>
>> At current, if there is hotplug, core takes cpus_write_lock to modify
>> active/preferred which makes governor to wait.
>>
>> If the governor is modifying the preferred mask it is taking the read lock
>> which makes the hotplug core to wait before modifying active/preferred masks.
>>
>> And there are no other infra modifying the preferred mask.
>> Could you please explain where is race currently?
> 
> Initially, both masks contain CPUs {0,1}. No cpus_read_lock() held.
> Steal ratio is within thresholds, so neither update helper runs.
> 
> Governor worker                         CPU hotplug
> ---------------                         -----------
> preferred_cpus_valid():
>    cpumask_empty(cpu_preferred_mask)
>      -> false
> 
>    cpumask_subset(cpu_preferred_mask,
>                   cpu_active_mask):
>      load preferred word -> {0,1}
> 
>                                          cpus_write_lock()
>                                          sched_cpu_deactivate(1):
>                                            set_cpu_preferred(1, false)
>                                            /* preferred={0} */
>                                            set_cpu_active(1, false)
>                                            /* active={0} */
>                                          cpus_write_unlock()
> 
>      load active word -> {0}
>      /* {0,1} is not a subset of {0} */
>      return false
> 
> /* Useless and misleading */
> restore_preferred_to_active();
> 
> /* Skips schedule_delayed_work(). */
> return

To address this, then we need only this right?

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 81e5089ba824..6a49ca55fc57 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -202,6 +202,7 @@ static void increase_preferred_cpus(void)
  
  static bool preferred_cpus_valid(void)
  {
+       guard(cpus_read_lock)();
         if (cpumask_empty(cpu_preferred_mask)) {
                 pr_err("empty preferred mask. stopping\n");
                 return false;
