Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgAWNrm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 08:47:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NDl82i024573
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:47:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp963w92c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:47:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Jan 2020 13:47:39 -0000
Subject: Re: [kvm-unit-tests PATCH v4 6/9] s390x: smp: Loop if secondary cpu
 returns into cpu setup again
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-7-frankja@linux.ibm.com>
 <73f8c5f6-327a-8ff5-c4e7-b1db46e3490f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 23 Jan 2020 14:47:35 +0100
MIME-Version: 1.0
In-Reply-To: <73f8c5f6-327a-8ff5-c4e7-b1db46e3490f@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c44d4347-1603-3f98-1ca1-1fbd6ae29ac0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 1/23/20 2:32 PM, David Hildenbrand wrote:
> On 21.01.20 14:42, Janosch Frank wrote:
>> Up to now a secondary cpu could have returned from the function it was
>> executing and ending up somewhere in cstart64.S. This was mostly
>> circumvented by an endless loop in the function that it executed.
>>
>> Let's add a loop to the end of the cpu setup, so we don't have to rely
>> on added loops in the tests.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/cstart64.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 9af6bb3..5fd8d2f 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -162,6 +162,8 @@ smp_cpu_setup_state:
>>  	/* We should only go once through cpu setup and not for every restart */
>>  	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
>>  	br	%r14
>> +	/* If the function returns, just loop here */
>> +0:	j	0
>>  
>>  pgm_int:
>>  	SAVE_REGS
>>
> 
> This patch collides with a patch I have still queued
> 
> Author: Janosch Frank <frankja@linux.ibm.com>
> Date:   Wed Dec 11 06:59:22 2019 -0500
> 
>     s390x: smp: Use full PSW to bringup new cpu
>     
>     Up to now we ignored the psw mask and only used the psw address when
>     bringing up a new cpu. For DAT we need to also load the mask, so let's
>     do that.
>     
>     Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>     Reviewed-by: David Hildenbrand <david@redhat.com>
>     Message-Id: <20191211115923.9191-2-frankja@linux.ibm.com>
>     Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> 
> In that patch we use a lpswe to jump to the target code, not a br. So the
> return address will no longer be stored in %14 and this code here would stop working
> AFAIKS.
> 
> Shall I drop that patch for now?

Please drop "s390x: smp: Use full PSW to bringup new cpu"
I will send out a fixed version of that patch soonish. It will load a
label for lpswe into r14 before doing the lpswe.
