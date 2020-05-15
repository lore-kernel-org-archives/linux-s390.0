Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44408 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgEOHOm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 03:14:42 -0400
Subject: Re: [kvm-unit-tests PATCH v6 05/10] s390x: Library resources for CSS
 tests
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-6-git-send-email-pmorel@linux.ibm.com>
 <20200514140315.6077046b.cohuck@redhat.com>
 <42beb241-8cc1-51a1-b374-3fb89968df36@linux.ibm.com>
 <20200515091127.3cd629d7.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <4b55b2ec-6e68-1edd-2263-ef0bbe949fc2@linux.ibm.com>
Date: Fri, 15 May 2020 09:14:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200515091127.3cd629d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-05-15 09:11, Cornelia Huck wrote:
> On Fri, 15 May 2020 09:02:37 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-05-14 14:03, Cornelia Huck wrote:
>>> On Fri, 24 Apr 2020 12:45:47 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> + * - IRB  : Interuption response Block, describes the result of an operation
>>>
>>> s/operation/operation;/
>>
>> ? I do not understand, do you want a ";" at the end of "operation"
> 
> Yes, I think that makes the description read more like a proper
> sentence (describe what its purpose is; describe its contents).
> 

You are right, thanks.

Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
