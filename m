Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33286 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgFPNnK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 09:43:10 -0400
Subject: Re: [kvm-unit-tests PATCH v9 08/12] s390x: retrieve decimal and
 hexadecimal kernel parameters
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-9-git-send-email-pmorel@linux.ibm.com>
 <a25fa4b1-da51-4dba-48c7-5d7154073d68@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <5407a74d-2e4d-c1df-8060-a824177156f1@linux.ibm.com>
Date: Tue, 16 Jun 2020 15:43:03 +0200
MIME-Version: 1.0
In-Reply-To: <a25fa4b1-da51-4dba-48c7-5d7154073d68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 11:47, Thomas Huth wrote:
> On 15/06/2020 11.31, Pierre Morel wrote:
>> We often need to retrieve hexadecimal kernel parameters.
>> Let's implement a shared utility to do it.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/kernel-args.c | 60 +++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/kernel-args.h | 18 +++++++++++++
>>   s390x/Makefile          |  1 +
>>   3 files changed, 79 insertions(+)
>>   create mode 100644 lib/s390x/kernel-args.c
>>   create mode 100644 lib/s390x/kernel-args.h
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
