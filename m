Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbfLMPYY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 10:24:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDFN9xa032269
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 10:24:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsduu10-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 13 Dec 2019 10:24:23 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 13 Dec 2019 15:24:21 -0000
Subject: Re: [kvm-unit-tests PATCH v4 8/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-9-git-send-email-pmorel@linux.ibm.com>
 <20191212132634.3a16a389.cohuck@redhat.com>
 <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
 <96034dbc-489a-7f76-0402-d5c0c42d20b3@linux.ibm.com>
 <20191213104350.6ebe4aa6.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 13 Dec 2019 16:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <20191213104350.6ebe4aa6.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ea7707f9-bba2-e9f4-77ad-7f2e9fdef21d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2019-12-13 10:43, Cornelia Huck wrote:
> On Thu, 12 Dec 2019 19:20:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2019-12-12 15:10, Pierre Morel wrote:
>>>
>>>
>>> On 2019-12-12 13:26, Cornelia Huck wrote:
>>>> On Wed, 11 Dec 2019 16:46:09 +0100
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>>> +
>>>>> +    senseid.cu_type = buffer[2] | (buffer[1] << 8);
>>>>
>>>> This still looks odd; why not have the ccw fill out the senseid
>>>> structure directly?
>>>
>>> Oh sorry, you already said and I forgot to modify this.
>>> thanks
>>
>> hum, sorry, I forgot, the sense structure is not padded so I need this.
> 
> Very confused; I see padding in the senseid structure? (And what does
> padding have to do with it?)

Sorry my fault:
I wanted to say packed and... I forgot to pack the senseid structure.
So I change this.

> 
> Also, you only copy the cu type... it would really be much better if
> you looked at the whole structure you got back from the hypervisor;
> that would also allow you to do some more sanity checks etc. If you
> really can't pass in a senseid structure directly, just copy everything
> you got?
> 

No I can, just need to work properly ;)

I will only check on the cu_type but report_info() on all fields.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
