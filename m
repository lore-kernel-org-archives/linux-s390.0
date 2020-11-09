Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726482AbgKIJOD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 04:14:03 -0500
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
 <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
 <20200928173147.750e7358.cohuck@redhat.com>
 <136e1860-ddbc-edc0-7e67-fdbd8112a01e@linux.ibm.com>
 <f2ff3ddd-c70e-b2cc-b58f-bbcb1e4684d6@linux.ibm.com>
 <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
 <fc553f1a-8ddd-59b0-9dec-8bdddfb5483d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <9dc9da3b-45de-7cb2-68ed-e5f7ada6c8b0@linux.ibm.com>
Date: Mon, 9 Nov 2020 10:13:56 +0100
MIME-Version: 1.0
In-Reply-To: <fc553f1a-8ddd-59b0-9dec-8bdddfb5483d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com



On 11/6/20 2:25 PM, Paolo Bonzini wrote:
> On 05/11/20 15:15, Janosch Frank wrote:
>>> Isn't it possible to go on with this patch series.
>>> It can be adapted later to the changes that will be introduced by
>>> Claudio when it is final.
>>>
>>>
>> Pierre, that's outside of my jurisdiction, you're adding code to the
>> common code library.
>>
>> I've set Paolo CC, let's see if he finds this thread:)
>>
> 
> I have queued Claudio's series already, so let's start from there.
> 
> Paolo
> 

OK, thanks

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
