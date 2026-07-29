Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11D4457A7;
	Wed, 29 Jul 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322143; cv=none; b=t3CCXUMDP/3+aqPU7UOEQC1fQqtQEY/4dNJevYiIRSheXjhc8O+e3/HoaPK3fEB+i1cJw7m6Rccdgbw1Wy8zZgoiIfJJG0/SOcWI35GcMkJaw+4Vjorm8tz3QwSCNTIMv/EweoKA8jbkmyfoI5Oo/i6fWkO7PwcBHnsyfMSJ8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322143; c=relaxed/simple;
	bh=9xwdwb3P6pjRfGx+SSB89DN8lArwnd1ksiJfx9C98gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlxp2FaafPzBjVDZUXkm96wur4PK4GCKrgVIlDqPNSfcXhOSHsuS1DbWRVshNP5m3x1OZg3Oe5ppEmhF4trTPZqYF90BpPhYz7SivVhRIwKMYjZ9lexuqSV84jp9JyrwQ2+xIX5I7Zybx1HKKCtr0grI0FgZqMVkmc8sJ6g0zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tv82NYR8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tv82NYR8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7ltHP3633970;
	Wed, 29 Jul 2026 10:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S2u00x
	s0Pjiojp1GHh+LZZ0iy+1ots8b6JcBGk3Zb9g=; b=Tv82NYR8a1E3mAdc9FZeeK
	/V547KPs6VR1+ruDllbIgBcYob8J3VY7gZhEh0bpN7/v+MDszVZZiEhpatvUSWcL
	IEizOB5m/9cNPEhBmux9q+eXA60VaJ8OfFTECCiufzkgJFQbFtk33lYDCqd7RvPu
	3UV2gHt1eTlalRc/Og07/lP7IFBr2lvebGWD8npwtgLU1kwvKtUnUAC/rUlm3bJw
	1ie2bYXBhS6b9zbcuau/haFMsuIhXHbGbnUQoLwyXGW/x4PsQI7tf74Nm+NtBOC5
	w9kDx8qvqehzOF5iikMCJLoDfZQQAwCdzGhjPIbibp30BbSoUB1YpmAj9UIhplIw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd1fh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:48:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TAfHbX015046;
	Wed, 29 Jul 2026 10:48:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhe7my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:48:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TAmooN29295096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:48:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5B812004D;
	Wed, 29 Jul 2026 10:48:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44FA520040;
	Wed, 29 Jul 2026 10:48:50 +0000 (GMT)
Received: from [9.111.25.199] (unknown [9.111.25.199])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 10:48:50 +0000 (GMT)
Message-ID: <6213badb-436d-4e2f-a537-7171bde074f3@linux.ibm.com>
Date: Wed, 29 Jul 2026 12:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Introduce arch_do_panic
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek
 <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
 <20260729085655.17504C1f-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260729085655.17504C1f-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fa1AOBC5V-efn3FZglUEzwu4rXqbvh4-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfX3SRPWXVwe6ZU
 rhZ8jVMzt04yFtxw5IAbaLZ3d+g3j7TUdM+NHAmLu8V6LzEM06AcMZE6gq4a5GCR1UmosGYGsqL
 P4IeYKzzhl36DnCsyIGcDRva0/X/DL0=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69da97 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ypr9IfWEbVWsyizBetwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfX1Nmkz5oCiiUI
 AkXRvY8f6R1YTbKbNlc2yj+qQNnrUFKACYm8hpzR5sHzTO/OvyMiSrCRMULPF9tZDlTFKDQUVYC
 g7Kf+InE3uJ7et98xpfib2/+JE8Zo2azL1sxoXwDDF2YXOzFWA6Qqv+xoZ47covp2qQ7/6vTCYh
 a4lCRe/PbIxYz9ZDFrYbUZHP2yfuCiDuMr5Leh1QnqP84JaCHq9rsRVND1Wv5I9PvHQ2EBlSvu5
 dB/50ue2LXgK8XvPhDAy7LnFpNEmrKKwexjY1qADdMFwJj+4/1zfOdRtg/MvQTW0ayoIsT6leLE
 /ZGBzbqTYMI1FqXZFMdO84dpyyic2Rnd5eXn9kxcSeuFWKojdLPEKGrBr3lzHI4Mcm53enR3zFQ
 BBRysitwbZZPzZ6mgib2t2N+7HnXc4TMxDxtypqQEJ98RO6uPb6cTnXWcdvO5laIkmo8XOzam2M
 7cmZikyUp02CpKUMC1g==
X-Proofpoint-GUID: fa1AOBC5V-efn3FZglUEzwu4rXqbvh4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290089

On 29/07/2026 10:56, Heiko Carstens wrote:
> On Mon, Jul 27, 2026 at 12:36:19PM +0200, Mete Durlu wrote:
>> Changes in v2 - Address Sashiko findings;
>> - Patch 2: Remove unused leftover code
>> - Patch 2: Mention panic_timeout and shutdown_actions relationship for
>>    s390 in commit message
>> - Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
>>    implementation of sparc
>>
>> Replace architecture-specific ifdef sections in vpanic() with a clean
>> arch_do_panic() hook. Currently s390 and sparc embed their panic
>> handlers directly in vpanic() using preprocessor conditionals, making
>> the common code path harder to maintain.
>>
>> Introduce arch_do_panic() as an architecture extension point called at
>> the end of vpanic(). Architectures can use this hook to implement their
>> specific panic handling without polluting the generic panic code.
>>
>> Move s390 panic handling from the panic_notifier chain to
>> arch_do_panic(). This corrects the execution order so that the
>> panic_timeout is properly evaluated before architecture-specific
>> actions. The previous notifier-based approach executed too early in the
>> panic sequence.
>>
>> Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
>> the preprocessor conditionals from vpanic() and place the Stop-A
>> enablement code in architecture-specific files where it belongs.
>>
>> The cleanup reduces vpanic() complexity and establishes a pattern for other
>> architectures needing custom panic behavior.
>>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
>> Mete Durlu (3):
>>        panic: Introduce arch_do_panic
>>        s390: Implement arch_do_panic
>>        sparc: Implement arch_do_panic
>>
>>   arch/s390/include/asm/setup.h  |  3 +++
>>   arch/s390/kernel/ipl.c         | 15 +--------------
>>   arch/sparc/include/asm/bug.h   |  3 +++
>>   arch/sparc/include/asm/setup.h |  1 -
>>   arch/sparc/kernel/setup.c      |  8 ++++++++
>>   kernel/panic.c                 | 18 ++++++------------
>>   6 files changed, 21 insertions(+), 27 deletions(-)
> 
> Putting the define in a different header file per architecture doesn't
> seem to be a good idea. There is no guarantee that this will work. So
> either you find a common header file, where it is known that is (and
> will be) included in panic.c, or you go with a weak function.

I went over the headers included to panic.c, either they are really
irrelevant or not present on other archs. To me the best candidate
header seems like "asm/bug.h"

$ find ./arch/ -name "bug.h" | grep include/asm | wc -l
16

$ ls ./arch | wc -l
22 # actually 21 as we shouldn't count Kconfig file

The architectures missing bug.h in their include/asm/ directory are
hexagon, microblaze, nios2, um and xtensa

I believe 16/21 is a good ratio but if this is still not good
enough, I'd like to fallback to __weak implementation.

What do you think Heiko?


