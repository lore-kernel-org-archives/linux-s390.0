Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502603EE1E2;
	Thu,  7 May 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159830; cv=none; b=XJnaj2LrAX1SsZzF8sZ+HRWBYC1/Ja+iNeIx2XpiWjItFnjtNujEvTkKf6SituNz8A5yBMxKNTuGcZo1f7FOUd0vO+ZIO6hlQEJqcu7QyYUHm0Y4eyNNbz+kwONHaI3xydk62PCscZ3OLJSRVzGdfHmbogaLul+OU5oUKhC4AME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159830; c=relaxed/simple;
	bh=SjI9KuWqB5eEq+gAvFPh2e+4xxGMjYd2K6HtviapvSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0Rc/bLAt+1fASTyq8O/SbMCAr22585Ipa0vJs0Y+VCWYuoFWSAjEAQHp38AlOh+7FjUNgOxkjHIDgbDwwAiDg42/l6MdIrxQS6qhFuuSnZzt8FW5SkRukoxYkq1dNy/RogdtvUMxgaZuWYTOLD0+J1vTS96aVw2MvtBVMObT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OPdJI0s8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPdJI0s8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647AFdY53182093;
	Thu, 7 May 2026 13:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5bKUpg
	4eYDkMsYvkWVpAoYUUA9XPdC+uIztaXeOhwmA=; b=OPdJI0s84Ke96hw2lkq9fp
	ZIG2mc2Xx3fr9lHOho8EauXEHRXkeVaceeahPcT/lcOFJTqTcYRTIXTyTFy4E9Xl
	diGjL5MNOjTnQxts9VdA2DTKVVTZsICeny086LNBcmEhma0pfO1sisygs6Gccle+
	fPcACQktY811gHq7ZOmr85rFl4fQLDsSnxWiPBhialldtHa205MEC8atwjV2FpJl
	wjtxOG869DUS9Cdp94C276yWjA89Rz453/Apt/CWfM8hjrwFsowAwgVjdaKqstDJ
	mUEkuQv7o1ECmX1NMTFbaD0w4edpXA0bdZBCKrYWdSdSaf3v8pMmI7tNpdCQ+lTw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxwn85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:17:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647D9a2d007652;
	Thu, 7 May 2026 13:17:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgkg5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 13:17:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647DH2OM10551996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 13:17:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8F35805E;
	Thu,  7 May 2026 13:17:02 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D2435805C;
	Thu,  7 May 2026 13:17:01 +0000 (GMT)
Received: from [9.61.162.242] (unknown [9.61.162.242])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 13:17:01 +0000 (GMT)
Message-ID: <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
Date: Thu, 7 May 2026 09:17:00 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
To: Heiko Carstens <hca@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
 <20260507095630.10395Aa0-hca@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260507095630.10395Aa0-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMSBTYWx0ZWRfX4bNS1ejhA2K8
 47xshJwH3AXA9BKpBXKG+0FQpn8vEmWun5a5VkZIBsohgI/jCrO3XcGH+GOoocE2ndSfBwJJDez
 oxCbLypMOj0TBBys7GqKbOKpvJCUbzq3BlHd5/Ee36pvNNojiD5Gt/83ZUCfUEBDjVrilEvunsX
 CsYpbVGhJ42S9CVM9siLHlPZCDS0f946wEmBPPHxT4rZObCEQVZeMMAXL2m+VMTyos50Pmco0ke
 cW2pelnT8lDswKzzhbIITeQT+DfFwIhTLBUoXRrImXZfaNfCEg+tLa4Uo6MR/uDE2ubdAMSJF/b
 C9F3Zh/H79hMPW3yEUQiUETJsUawNaSHBE4GSiAR6r1moLg+5w6o5eD0x7Dme8mgzEphCQmP42f
 9fIPet6ZD4aemg7/u0oheYIYaTWYE1tA7lzlNcMInPNnHXM0ds5ZuPQzeacefJHzYsnYdzUb9bI
 ZbjSdnOsufvxxPa3uCg==
X-Proofpoint-ORIG-GUID: _Tq8n_NGK6fFzdUoicVZqqSaw77eAGL0
X-Proofpoint-GUID: _Tq8n_NGK6fFzdUoicVZqqSaw77eAGL0
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fc90d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=DbsqzBMTFuslpglZLXsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070131

On 5/7/26 5:56 AM, Heiko Carstens wrote:
> On Wed, May 06, 2026 at 10:50:52AM -0400, Douglas Freimuth wrote:
>> On 5/6/26 12:57 AM, Heiko Carstens wrote:
>>> On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
>>>> s390 needs to maintain support for an RT kernel. This requires the
>>>> floating interrupt lock, fi->lock to be changed to a raw spin lock
>>>> since the fi->lock maybe called with interrupts disabled in __inject_io.
>>>>
>>>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>>>> ---
>>>>   arch/s390/include/asm/kvm_host.h |  2 +-
>>>>   arch/s390/kvm/intercept.c        |  4 +-
>>>>   arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
>>>>   arch/s390/kvm/kvm-s390.c         |  2 +-
>>>>   4 files changed, 38 insertions(+), 38 deletions(-)
>>>
>>> s390 does not support RT, but I guess you are referring to a lockdep splat
>>> which you would see without doing this change, similar like we have seen at
>>> other places.
>>>
>>> Can you include the relevant parts of the splat for reference, please?
>>
>> Heiko, thank you for you response. I dont recall trapping it with lockdep
>> (while it was on) but discussion on the mailing list in an earlier version
>> made us look closer (and we saw it across the AI models that reviewed the
>> patch.) It appears that while RT isn't supported it can still be compiled in
>> to the kernel so we wanted to mitigate the issues we would add to if someone
>> does that while not impacting non-RT environments, the main use case.
> 
> RT support cannot be compiled in for s390, because of the missing
> "select ARCH_SUPPORTS_RT", however you can still enable lockdep checks
> for raw_spinlock vs spinlock nesting, which this seems to appear about?
> 
> See PROVE_RAW_LOCK_NESTING config option for a more detailed description.
> 
> Therefore my question about a lockdep splat. However I don't see why
> using spin_lock() instead of raw_spin_lock() alone in irq disabled
> context could be problematic. On the other hand this patch does

Hi Heiko,

AFAIU it is only problematic if we (s390) should ever want to support RT
in the future.

As the name implies, the point of kvm_arch_set_irq_inatomic() is to
inject the interrupt without the possibility of sleeping, or
alternatively recognizing the need to sleep and fall back to a queued
"slow path" that can safely sleep while delivering it.

My original thinking was 'well, it won't hurt to use the raw spinlocks
in the new code' so I set Doug down this road with my review comments --
I did not consider that there would be a need for additional fallout
like this patch, which means increased chance of regressions (see below)
to accomodate a feature that we don't support today.

If you are saying it's OK to simply not care about RT for s390 now, then
AFAICT it should be fine to just use s/raw_spin_)lock/spin_lock/ for
this whole series, drop this patch and then ignore the subsequent
Sashiko complaints about RT.

What do you think?

> introduce a
> 
>       raw_spin_lock();
>       spin_lock();
>       spin_unlock();
>       raw_spin_unlock();
> 
> sequence in __deliver_machine_check() which seems to be incorrect and
> indeed should generate a lockdep splat iff PROVE_RAW_LOCK_NESTING is
> enabled.

+1
Doug, I know you've run with lockdep enabled before on this series --
please make sure to test with lockdep for next version

Thanks,
Matt



