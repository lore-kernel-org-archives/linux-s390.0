Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1E432E7B;
	Thu, 30 Jul 2026 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417356; cv=none; b=AoWQn9uAklqTUohinjb57JtNvaV8qFW3gaM0qvnS3HyR/FMJcNoi90dFDFaHiqWQXpKhWPigNoHlnsD3y3Fon+m3QFhlWtDCsbDGtniEIFeJl4cdCPfWnXZOuBkwoJ/GGWa/ZDpSBRN9KKLYAHxIi8poU4KUXm310g5nYWn+JB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417356; c=relaxed/simple;
	bh=/H6eZJyvWtZM32zOe/9GdXsukjDjsl4AdlVAJMVulqA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d/OlXYNGifGLZPkcRWkRq8FjuaAd82EMiiEiG7TXZmJxeOYc0u3GJiwleddp2jEDpq66XkuosLXO0rOQq2URPX+8J2jSxB1CmjOnbsaI4nTOZ+vPKXfXET728mQ51f2kDUCyL9kNu5DZm/DGedYVv2Prh2+KYnWKscLw66unEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YW0B00W8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YW0B00W8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHp882637080;
	Thu, 30 Jul 2026 13:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=56kHSs
	JImCgC/ZuCiCdE1cm/QGvabCjN5Pd37LjTuYo=; b=YW0B00W8EUMa4kKhbBrt+w
	sHI48ebUS0mApLaVj2YtDauU36u3PVav3TW1aRzubCaXXRttoNpsvqVvEVyG1gRU
	ajJnGT6K4QY+7lEae5oPPsrRT+oPfpJcDp0T/DHnSSoDfUrjU4euptDVZNv7NXDO
	vhyPN0bFyC2AP2hf0ixow7ilS+EXtxdLtXz1D/vbcpvc76LMO2sp6/bxRB7OAXeP
	WHv/jyFRuFv9Wd4MkFsc5XYBvXYx1VIyQbuXIHeQHQaWJsyGiVllKMaDXhzUQ6dy
	ez6wrCmjcqysO6ZU4wTk53r5gs3yq4ZzS6KYuDBmm5ZcH7gAtOc3Vv4mW1C+p15g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjf01a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:15:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDFOni008492;
	Thu, 30 Jul 2026 13:15:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkbyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:15:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDFWos26083786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:15:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC9C20043;
	Thu, 30 Jul 2026 13:15:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E74DC20040;
	Thu, 30 Jul 2026 13:15:31 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:15:31 +0000 (GMT)
Message-ID: <f11500d0-4605-41c6-836a-510801ec6293@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:15:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] s390: Implement arch_do_panic
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
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com>
 <20260730-arch_do_panic-v3-2-d5401e683cdb@linux.ibm.com>
 <20260730115445.18059Aac-hca@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260730115445.18059Aac-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX10cbcel+91R+
 BTwe085EHtYqkpKMGUshSc3o0Fq0QGlK14lq157nCUGls3TdTyw+vitToFl6ALyJCum+g16Bfb7
 5sity7njariYVpObb7Zr/iDEMcb/A2A=
X-Proofpoint-GUID: 0TANLNtcWJOuZEOdli2ukSljFPFzv7s6
X-Proofpoint-ORIG-GUID: 0TANLNtcWJOuZEOdli2ukSljFPFzv7s6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5NiBTYWx0ZWRfX0HcDCo3PzWFW
 evdoTd8/DsDrJPc2HsY+XeY6qv+h6+zuU+DwcRJdlPZoEkfXOAOvV7ZqmcJCJIEvh7wi7DZRotx
 +qr6WmGXjLNprGQU48wzOLhgG0Sm6pQ0oJiv8Od0WL1yLhAOKcJ1j8LtflGNgUaeHy5/jMGLH0Z
 mmyD0jG4QGaO9L6xBT3pjRsfKnnaK6EjNhqMHy+xf5f8fGQaIdAEJc+mQhTrBRl1xoVnXrG0GlX
 jwoY8uV9cEz0ueBFkHCVDUDahezqX2eMQeqbAq8/XHSYX6YOud9QD7LMc7og7r2wf3PSuKSOcDL
 2W8MZij8HZPYmY0wGnviyZlhBpW/Q+dl1ayF55UJgS5e1vV6pQBQt122QUWFKvo5lWjbCOA73qC
 Zb+dSU9NvXYCCZshFxOfpKDRlIqgl8s/55H0psydvY2npDzZ5ATYh3I3L5PJG7+poOC8w3SwCeo
 LxGwLOeaX1NqUFdFPjg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b4e79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=KKsiVh0fwfR0d4kCrtgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300096

On 30/07/2026 13:54, Heiko Carstens wrote:
> On Thu, Jul 30, 2026 at 11:23:28AM +0200, Mete Durlu wrote:
>> s390 has a custom panic handler which carries out user specified actions
>> during a panic scenario. This handler is invoked via the panic_notifier
>> call chain and executed before panic_timeout value is evaluated in
>> common code.
>>
>> Use arch_do_panic() hook to invoke arch specific panic handling instead
>> of using panic_notifier call chain. By reordering s390's panic handler
>> allow more information to be printed during a panic.
>> The execution order of panic handlers now allows for user specified
>> panic_timeout value to be taken into account. This fixes the broken
>> "panic" kernel parameter for s390, earlier it was just ignored
>> inexplicibly.
>>
>> This now means that the panic_timeout value takes precedence over user
>> defined on_panic behavior defined via "chshut" or writing to
>> /sys/firmware/shutdown_actions/on_panic.
>>
>> Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")
>> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
>>   arch/s390/kernel/ipl.c | 19 +++++--------------
>>   kernel/panic.c         |  3 ---
>>   2 files changed, 5 insertions(+), 17 deletions(-)
> 
> So, finally I took a closer look :)
> 
> Question: why is it desirable that panic_timeout takes precedence? The result
> of this change is quite surprising: if anybody (e.g. a distribution) sets
> CONFIG_PANIC_TIMEOUT to a non-zero value this completely breaks "on_panic"
> behaviour on s390.

panic timeout can be set during boot or compile time as you said, so it
can be used to determine what will happen to a system if it panics
during boot along with after boot. Since panic timeout covers a larger
area I thought it should get precedence.
Being able to choose what will happen on panic before boot is a super
power IMO and would help immensely if one would like to boot an untested
kernel via kexec for example.

> I could understand if this change would result in a larger timeout and
> additional information being printed, but not that it breaks existing and
> actually designed and desired behaviour.

For that to happen users have to "misconfigure" the system and try to
use both panic_timeout and a custom "on_panic" action. The same goes for
kdump, when kdump is configured "on_panic" actions are ignored silently
and system always dumps on panic.

> This change also makes it more likely that the system deadlocks on console
> messages, before the actual arch_do_panic() is called, if I'm not mistaken.
> Which would also be a regression.

This I wasn't aware of, I don't understand how it can deadlock on
console messages. I will look this up.

> What I like about this patch set is that it removes architecture dependent
> ifdefs from common code. But the side effects are very questionable.
> 
> The "obvious" cleanup would be to move only the existing ifdef'ed code
> into arch_do_panic(), and only then provide semantical changes, which
> wouldn't need to be part of such a cleanup series.

ifdef'ed code for s390 is unreachable as the code called by panic
notifiers aka "on_panic_trigger" do the same regardless of the
action it is configured to and stops with disabled_wait().

If that should be the way, I can remove the ifdef s390 chunk
from vpanic and propose the panic_timeout changes in a separate
patch.

>> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
>> index 3c346b02ceb9..6a5fa9213450 100644
>> --- a/arch/s390/kernel/ipl.c
>> +++ b/arch/s390/kernel/ipl.c
>> @@ -2111,11 +2111,15 @@ static ssize_t on_panic_store(struct kobject *kobj,
>>   			      struct kobj_attribute *attr,
>>   			      const char *buf, size_t len)
>>   {
>> +	if (panic_timeout) {
>> +		pr_warn("on_panic action will be ignored in favor of panic timeout (panic=%d)",
>> +			panic_timeout);
>> +	}
>>   	return set_trigger(buf, &on_panic_trigger, len);
>>   }
> 
> I'm wondering why AI doesn't complain about this user trigger-able warning
> message. This is not good. *If* we go this way, writing to this attribute
> should simply fail, instead of giving the user the impression that something
> has been configured, which would actually do something.

My thought process was to put some marker to dmesg for users
to figure out what happened and why their system didn't respect
to their "on_panic" action. I know this is subobtimal but
simply failing the write to "on_panic" doesn't provide a good
solution IMO as users can first write to "on_panic" and then
set a value to panic_timeout from sysctl.

Regardless, I think I can remove semantic changes for s390
from this patchset and submit them from a different patch series
like you suggested.

Thank you for your input Heiko!
