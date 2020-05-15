Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbgEOG56 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 02:57:58 -0400
Subject: Re: [kvm-unit-tests PATCH v6 04/10] s390x: interrupt registration
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-5-git-send-email-pmorel@linux.ibm.com>
 <20200514135805.77a7ae82.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <7da200e9-4cbe-0c77-833e-b4430cc2b80e@linux.ibm.com>
Date: Fri, 15 May 2020 08:57:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200514135805.77a7ae82.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-05-14 13:58, Cornelia Huck wrote:
> On Fri, 24 Apr 2020 12:45:46 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> Let's make it possible to add and remove a custom io interrupt handler,
>> that can be used instead of the normal one.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>>   lib/s390x/interrupt.h |  8 ++++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/s390x/interrupt.h
> 
> As the "normal one" means "no handler, just abort", is there any reason
> not simply to always provide one? What is the use case for multiple I/O
> interrupt handlers?
> 

I can only agree, I proposed this initially.
David asked for a registration.

-- 
Pierre Morel
IBM Lab Boeblingen
