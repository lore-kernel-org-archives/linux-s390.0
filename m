Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F83F870C;
	Wed,  5 Aug 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924721; cv=none; b=TiCY7PKKr0PUHx7vdWetrzkdsINiiboQXNLqr31HnEdZG+yuowEhmOxCMSCOPp+Hjecl8P8+DGW7ZrmsqAS8zkaDQdZbcpIUR5m/KJMsiOspCy4qvSXBaHu2KjABUKXDJKsie/ZKYonCl8Ols9DN35ynmxRcn/Mv04ZhaFwOnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924721; c=relaxed/simple;
	bh=rQ8K3VtjzPnY3N5ySgidfItt/I+QSJJaOPhbQEJGolQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfazY87o1pRKo8sNmBUebRnVgAz2Yqy9HufX+LyKgsz/Tv84u5vMuOn1xR3WPE2MB1De0DSOadoKYTFeV/7Yq1ysbkHLvCqXQRMo9L7FWXlnuta1rF2EHOP8JTfoqksEeJEek9mdGwFpjDzFNoXqMElgu7Ku12h5tBGbD7bpmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQkc17x7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQkc17x7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758mPvj3356162;
	Wed, 5 Aug 2026 10:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CWE05S
	HjpMvyioz1WLMUZ4krYQXzVCZ4qMe4SzHY6qo=; b=tQkc17x75JiHBMv1Rt+VvQ
	k0DjjzsU2xit0WdzJR0qq4eG1ks2x2OVlSMmLYtiCaDtUI7UzzcUwDyvwVKN2dY9
	B5j79XJTiPZjUDnwcj59RWCuKeUaMLHm57QNvgHimK0SfSMijevZpB2aM56PgCxs
	mvPcRuEmbKxwTESQz/ZrLUXmZJfiHqKC78+GKCdlw81kMhqGeOhctBQwkbpm7Euh
	G4LPF5WjhpOmkeixUXW+lW5l7FUpACcv1Y+Er4/stXQwGWfhB3/gmSd61Dx/6qak
	gUFTrF750yoNbesGOqHKP1xuYB52CzVN1W96fs2RGCd3k/E5u5+S3U8MUcPKAmOg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42gfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:11:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675ABH7f017374;
	Wed, 5 Aug 2026 10:11:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw65vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 10:11:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675ABdO442598792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 10:11:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969702004E;
	Wed,  5 Aug 2026 10:11:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36D902004D;
	Wed,  5 Aug 2026 10:11:39 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 10:11:39 +0000 (GMT)
Message-ID: <271a228d-5ce3-49e4-8ea6-a39edccf1e46@linux.ibm.com>
Date: Wed, 5 Aug 2026 12:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] s390: Implement arch_do_panic()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek
 <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Bradley Morgan <include@grrlz.net>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260805-arch_do_panic-v4-0-af4a36f99414@linux.ibm.com>
 <20260805-arch_do_panic-v4-2-af4a36f99414@linux.ibm.com>
 <20260805100642.76476B64-hca@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260805100642.76476B64-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a730c60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EgFNHiOLeo-lfLgDe_QA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GO3XmaC9pIShqD6ZcaUxlziCO0CB7jIk
X-Proofpoint-GUID: GO3XmaC9pIShqD6ZcaUxlziCO0CB7jIk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX32oNUyQuoBDf
 rqiQXTnZ8n9olrBoGBZ9RdFkYBt3RXAiQCDxIb8abcg4Df3Zc+SV5sKUi3HsLGTrO9oGTaKg0S0
 ilEnVdUxjTigAMqy4ztK3PKEOonAz2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX6Tzz4SSoQKXp
 EzRURYyY907xHlZ8FAHvuJ+kuPVbMqa/8v4OYFzxLMQc0y2g6GMTmwAcMMAZ9wdLMZi6MSuHxAk
 c0pzLARnObKUQwem6+HqOWsi1cye896NO2a214sowW7StpM3dbTOSN4CC/kS+gLNVFCCsovKxXX
 pXt5pcg5mIS1N/zVgivee0/MAAKaKHKW8eAaz4Seh4sxfBojHaCBIFAbZAQgHYiXgILmQ4oPcPc
 VlZVhuDcDliCHlxupt4u5fKES7bFyOxSMuiXkBXFxCUR+qnRW7bholeEvKwln7khArEX6vzrJjb
 B+kwfUlexdvQrxUO5akPI2F4Qn4FocSVK7SWsbVZo6aJj09nnXNrHj9FgN3jq6xKINqzxLBVyQb
 WPBeYPxrRGPLwSUk/3OvYZqByP6KoNxVHiGTyD8b3W/nl40JRAf2n6ylJRxloZgBHpoThtF8bTz
 0WPL/YvM5rXkh49v8xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050077

On 05/08/2026 12:06, Heiko Carstens wrote:
> On Wed, Aug 05, 2026 at 11:48:37AM +0200, Mete Durlu wrote:
>> Implement s390 specific arch_do_panic() instead of using s390 specific
>> ifdef sections in vpanic() code.
>> No functional changes.
>>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
>>   arch/s390/kernel/ipl.c | 6 ++++++
>>   kernel/panic.c         | 3 ---
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
>> index 3c346b02ceb9..31ff7c12c354 100644
>> --- a/arch/s390/kernel/ipl.c
>> +++ b/arch/s390/kernel/ipl.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>>   #include <linux/kstrtox.h>
>> +#include <linux/panic.h>
>>   #include <linux/panic_notifier.h>
>>   #include <linux/reboot.h>
>>   #include <linux/ctype.h>
>> @@ -2343,6 +2344,11 @@ static struct notifier_block on_panic_nb = {
>>   	.priority = INT_MIN,
>>   };
>>   
>> +void arch_do_panic(void)
>> +{
>> +	disabled_wait();
>> +}
>> +
> 
> Please move this to arch/s390/kernel/traps.c somewhere near
> kernel_stack_invalid() and monitor_event_exception().

Alright, will do in the next version.
Thank you for having a look!
