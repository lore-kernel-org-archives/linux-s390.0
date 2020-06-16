Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgFPJj3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 05:39:29 -0400
Subject: Re: [kvm-unit-tests PATCH v9 01/12] s390x: Use PSW bits definitions
 in cstart
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-2-git-send-email-pmorel@linux.ibm.com>
 <accfc1b6-6ddb-2b04-7f8a-ea6fd83b8b2f@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <04f889dc-7706-5f4a-f568-760ea9337f65@linux.ibm.com>
Date: Tue, 16 Jun 2020 11:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <accfc1b6-6ddb-2b04-7f8a-ea6fd83b8b2f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 11:31, Thomas Huth wrote:
> On 15/06/2020 11.31, Pierre Morel wrote:
>> This patch defines the PSW bits EA/BA used to initialize the PSW masks
>> for exceptions.
>>
>> Since some PSW mask definitions exist already in arch_def.h we add these
>> definitions there.
>> We move all PSW definitions together and protect assembler code against
>> C syntax.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/asm/arch_def.h | 15 +++++++++++----
>>   s390x/cstart64.S         | 15 ++++++++-------
>>   2 files changed, 19 insertions(+), 11 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
