Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726779AbfJaMNI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:13:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCCvJP076010
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:13:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vyvp0pd00-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:13:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Oct 2019 12:10:08 -0000
Reply-To: mimu@linux.ibm.com
Subject: Re: [RFC 13/37] KVM: s390: protvirt: Add interruption injection
 controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-14-frankja@linux.ibm.com>
 <c09046eb-380f-d930-8e99-42b9cc8a62ae@redhat.com>
 <26dfdefa-edbe-40e5-5b41-a4de86d47d15@linux.ibm.com>
 <5e8c5e1c-d08a-6ba4-da28-ee387522c257@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 31 Oct 2019 13:10:02 +0100
MIME-Version: 1.0
In-Reply-To: <5e8c5e1c-d08a-6ba4-da28-ee387522c257@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <63976ad0-745e-204b-f7c1-55f5a7465ca6@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 31.10.19 10:15, David Hildenbrand wrote:
> On 31.10.19 09:48, Michael Mueller wrote:
>>
>>
>> On 30.10.19 16:53, David Hildenbrand wrote:
>>>> @@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
>>>>        __u8    oai;            /* 0x00e2 */
>>>>        __u8    armid;            /* 0x00e3 */
>>>>        __u8    reservede4[4];        /* 0x00e4 */
>>>> -    __u64    tecmc;            /* 0x00e8 */
>>>> -    __u8    reservedf0[12];        /* 0x00f0 */
>>>> +    union {
>>>> +        __u64    tecmc;        /* 0x00e8 */
>>>> +        struct {
>>>> +            __u16    subchannel_id;    /* 0x00e8 */
>>>> +            __u16    subchannel_nr;    /* 0x00ea */
>>>> +            __u32    io_int_parm;    /* 0x00ec */
>>>> +            __u32    io_int_word;    /* 0x00f0 */
>>>> +        };
>>>
>>> I only wonder if we should give this member a fitting name, e.g.,
>>> "ioparams"
>>
>> Do you see a real gain for that? We have a lot of other unnamed structs
>> defined here as well.
> 
> I was wondering if we could just copy the whole struct when delivering
> the interrupt.
> 
> You could even reuse  "struct kvm_s390_io_info" here to make that more
> clear.

I want to keep it the way it is to have the fields in the SCB
declaration explicit.

Thanks,
Michael
