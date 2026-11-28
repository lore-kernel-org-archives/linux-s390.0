Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795841003;
	b=Qwk3nc5rX54Fyj6I0S2QwINbr5S7ADvqAeZFxQf8xP/M37dGXf1dBJ2YdsXoN7SoUYgq
	 1nO+ym3LXDQmAYECJiZ7x2Jn41pdoMNL4y+PZbYl0yNWyOz+9iWwhSrFnpp9XZvx1nxGI
	 mcuUENILCcObIIHnf3XhpEraf38aKK3n74TLHCLmCToQoN130b+ZoA3oe1Da2l4bPlyTt
	 S2RwVUqoV34XmYfqc+9dNvPzCOQ+tQBt7TOm7/bOqU4JzbvDbCCQllNqb9Dm+38fnH85M
	 OB1GWj6M1QQ9cdc6Qtdb3xjR+0knQ29mCwO/U25Jksmtscy/N4ty1n3j2uB2xJEgDig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795841003;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jE30fb3/wdn9i0oP+c/2t9TrzWP1XvBD4vGbDC218Og=;
	b=nY3kY5rnxCjkveEY7E+4zeHvpK9SeED3eO98ATH8+XJBnMw4kZvwFFGBsIK/S/QzzNBp
	 uGwDKi7pPjNsecopF8qbvnDRRe2dae/v+9b1K530vaqsdgC4APErmEZGoyMQp106rdehx
	 +SulQwYLFwBEn8UpRsCR7lAP//eA5Dsd/rsH/+SlQFQKbSbE6rhwR0AM7G1x2PfG83hAf
	 fdxy5dUv/CsJdJ8jpwd7CMbaN/+qwoQ8VSSGQcvd2IjKOUJAgpXlutgXGwFUbMKu0LhYG
	 l1aT0W+i/c9Fk8VDsT3EkuuCEDeNOcXOg5YjEshQJigjF/CzvFq9BSKGxnbW1sWcyiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dlUSvQUs;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A606A31C;
	Sat, 28 Nov 2026 04:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E13A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dlUSvQUs
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS4Z1nl756982;
	Sat, 28 Nov 2026 04:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jE30fb
	3/wdn9i0oP+c/2t9TrzWP1XvBD4vGbDC218Og=; b=dlUSvQUsM72pfklqRjDsHO
	hDWRbBzxRatuTv+6Szm45bdoEyuYnbxxXA8FwLA7fZVi0OPwwkbsXPAdZRdyY8XW
	e888vTe6MkI8nIqJ0/aDricuUxUH9bzdKVqj0qHeZ+8lGhGQHoZKFr3CuztD4ILe
	0qkE3bRp7+KihOLNXWJRWbwa0SqJyJ1wMuPLHF05ksghv66446CrsDeEU8Ffpsyq
	jhsbCcFdP7aAjcCI7mQhHL28rEcUChIRfrpisfb3+nGfhnawBhfJJTKFlSKRMX8d
	4PiidLI7IqPjgB1LeB8JrZTnwTO4MPlT30zN4/sJBMGkBpUGZN+9clRA3sZVbUVw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7pp5g75c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 04:42:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS4JGJK609539;
	Sat, 28 Nov 2026 04:42:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6uccw78k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 04:42:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AS4gbOg22938120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 04:42:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2B2320043;
	Sat, 28 Nov 2026 04:42:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B62B20040;
	Sat, 28 Nov 2026 04:42:29 +0000 (GMT)
Received: from [9.39.18.53] (unknown [9.39.18.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 04:42:28 +0000 (GMT)
Message-ID: <75748781-c20c-4b1b-acc9-ba8e6e06cf60@linux.ibm.com>
Date: Sat, 28 Nov 2026 10:12:27 +0530
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
Subject: Re: [PATCH 5/7] virt: steal_governor: warn on unexpected preferred
 mask states
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
 <20261113184257.621707-6-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261113184257.621707-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: MJcPJuBtAEqFLc5Jw9N_CJSw4nFus0s3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDAxOCBTYWx0ZWRfXxtTIwP3qvK1Y
 T+Q1emVYYFw7N0yMORS0l2KI4v9IZMQ4oyjytY6+K46FA6IdouZ35YQH1jBbEz4gSGPVV06P/aC
 yHByN1isFyc2NoEIrb5phwDzsZiZGXE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDAxOCBTYWx0ZWRfX9IA7cKbQiBOL
 J/fCYFSasuUKGblpfNuMHe6rLzfZ4RQGFUnOKvh+xLS/B0s7MFVALO5lAyUvvU9xwNhs2mD4B95
 PRQ3oJnM3Z3seeV2lDppBKSHqpmEowm4WVPvmu+LuAX7eDdizueyOyMpyxRZb5uwUvFor+S55EC
 mML22z5lWscvLuAmGwB6TmMbU5oacZHS2+esQy75M8gYgV5/1IoSM4oTzgjf1ZIrS9pQU9GVG/8
 NUJ1KE7sRKq4OQEdznZvZ+nHXIPKk8LMfw0v/JPfV4vrd56dt5qrhhrR8brAlAIAxKgaznPC6oy
 bQ6ruYOLJ5UGZWFn1zfu4Mh8WLfgP4JH6KR7NSmS4/muOqIC3aNVWsVgVoW51oPQQNFDXRw6gUw
 1fTcovxNUOowVP2dfAOdl+Ssv9d3ddUj7a+CRKtbgZPmVtkRgI75N0ktPQsaC5dovgtwiMqOAko
 VWyXPaUr7lBYwYPoAGw==
X-Authority-Analysis: v=2.4 cv=Ae8kjHXG c=1 sm=1 tr=0 ts=6b0a5bc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8
 a=GoBj-LaQcTnmE09wTXwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qQowAyHxu2TmLdxn6Wavq18tyUQajkPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611280018

Hi Yury.

On 11/14/26 12:12 AM, Yury Norov wrote:
> Now that preferred cpumask access is properly serialized, and CPU
> hotplug restores all remaining active CPUs as preferred when the
> last preferred CPU gets offlined, the corresponding logic in the
> driver is redundant.
> 
> Instead of removing it completely, add WARN_ON()s in the corresponding
> paths to harden the preferred CPUs mask management and highlight that
> this condition is not expected during normal operation.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/virt/steal_governor.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index 8cd5c0f3e3ef..c34d91267ec1 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -142,6 +142,11 @@ static void decrease_preferred_cpus(void)
>   
>   	lockdep_assert_cpus_held();
>   	lockdep_assert_held(&cpu_preferred_mutex);
> +
> +	/* We can't end up with no preferred CPUs under normal conditions. */
> +	if (WARN_ON(cpumask_empty(cpu_preferred_mask)))
> +		return;
> +

With this, we will end up with 2 WARN's for the same thing.
Once here and once again in preferred_cpus_valid.

What we have in preferred_cpus_valid covers this already. Why again here?

>   	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>   				cpu_preferred_mask);
>   	if (cpu >= nr_cpu_ids)
> @@ -150,8 +155,6 @@ static void decrease_preferred_cpus(void)
>   	/* Always leave first housekeeping core as preferred. */
>   	first_hk_core = topology_sibling_cpumask(cpu);
>   	cpu = cpumask_last(cpu_preferred_mask);
> -	if (cpu >= nr_cpu_ids)
> -		return;
>   
>   	/* Find the last CPU which doesn't belong to that first hk_core. */
>   	if (!cpumask_test_cpu(cpu, first_hk_core)) {
> @@ -246,7 +249,7 @@ static void steal_governor_loop(struct work_struct *work)
>   	 * else: steal ratio is within bounds. Still do design checks so that
>   	 * module restores to active if CPU hotplug breaks those assumptions.
>   	 */
> -	if (!preferred_cpus_valid()) {
> +	if (WARN_ON(!preferred_cpus_valid())) {
>   		reset_preferred_cpumask();
>   		return;
>   	}

Regarding this series, IMHO we should split the patches into

1.ones which are actually about fixing the hotplug race (PATCH 3 and 6)
2.ones which are needed only when the another write interface comes in (PATCH 1,2,4,5,7).
