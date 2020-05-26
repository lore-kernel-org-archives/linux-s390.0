Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgEZLkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:40:09 -0400
Subject: Re: [kvm-unit-tests PATCH v7 02/12] s390x: Use PSW bits definitions
 in cstart
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-3-git-send-email-pmorel@linux.ibm.com>
 <dfe3446e-1d57-fc2b-e467-29b3010cb936@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <e5995b01-f040-b09d-4ada-1ee9f65aa713@linux.ibm.com>
Date: Tue, 26 May 2020 13:40:02 +0200
MIME-Version: 1.0
In-Reply-To: <dfe3446e-1d57-fc2b-e467-29b3010cb936@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com



On 2020-05-26 12:17, Janosch Frank wrote:
> On 5/18/20 6:07 PM, Pierre Morel wrote:
>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>> for exceptions.
>>
>> Since some PSW mask definitions exist already in arch_def.h we add these
>> definitions there.
>> We move all PSW definitions together and protect assembler code against
>> C syntax.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> 
> Nice
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
