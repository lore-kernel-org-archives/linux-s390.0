Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731446AbgEZLjb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:39:31 -0400
Subject: Re: [kvm-unit-tests PATCH v7 01/12] s390x: saving regs for interrupts
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-2-git-send-email-pmorel@linux.ibm.com>
 <e06ed054-6038-3a7e-3eda-0d37ee382919@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ec90a237-0edb-121e-6c16-f1dc96a3a169@linux.ibm.com>
Date: Tue, 26 May 2020 13:39:25 +0200
MIME-Version: 1.0
In-Reply-To: <e06ed054-6038-3a7e-3eda-0d37ee382919@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-05-26 12:30, Janosch Frank wrote:
> On 5/18/20 6:07 PM, Pierre Morel wrote:
>> If we use multiple source of interrupts, for example, using SCLP
>> console to print information while using I/O interrupts, we need
>> to have a re-entrant register saving interruption handling.
>>
>> Instead of saving at a static memory address, let's save the base
>> registers, the floating point registers and the floating point
>> control register on the stack in case of I/O interrupts
>>
>> Note that we keep the static register saving to recover from the
>> RESET tests.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Some nits below
> 
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> 
> 

Thanks, I will modify the nits as you proposed.

regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
