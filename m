Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732224AbhAUN0M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 08:26:12 -0500
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: css: pv: css test adaptation
 for PV
References: <1611220392-22628-1-git-send-email-pmorel@linux.ibm.com>
 <1611220392-22628-4-git-send-email-pmorel@linux.ibm.com>
 <20210121134824.041100f3.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <d9f78616-a6a2-1aa9-35bb-92fdf2462866@linux.ibm.com>
Date: Thu, 21 Jan 2021 14:25:07 +0100
MIME-Version: 1.0
In-Reply-To: <20210121134824.041100f3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com, drjones@redhat.com, pbonzini@redhat.com



On 1/21/21 1:48 PM, Cornelia Huck wrote:
> On Thu, 21 Jan 2021 10:13:12 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We want the tests to automatically work with or without protected
>> virtualisation.
>> To do this we need to share the I/O memory with the host.
>>
>> Let's replace all static allocations with dynamic allocations
>> to clearly separate shared and private memory.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     |  3 +--
>>   lib/s390x/css_lib.c | 28 ++++++++--------------------
>>   s390x/css.c         | 43 +++++++++++++++++++++++++++++++------------
>>   3 files changed, 40 insertions(+), 34 deletions(-)
>>
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
