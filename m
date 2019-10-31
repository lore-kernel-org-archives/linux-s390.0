Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727012AbfJaIsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 04:48:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V8m7XW038428
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 04:48:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vysd3wf48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 04:48:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 31 Oct 2019 08:48:27 -0000
Reply-To: mimu@linux.ibm.com
Subject: Re: [RFC 13/37] KVM: s390: protvirt: Add interruption injection
 controls
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-14-frankja@linux.ibm.com>
 <c09046eb-380f-d930-8e99-42b9cc8a62ae@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 31 Oct 2019 09:48:21 +0100
MIME-Version: 1.0
In-Reply-To: <c09046eb-380f-d930-8e99-42b9cc8a62ae@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <26dfdefa-edbe-40e5-5b41-a4de86d47d15@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 30.10.19 16:53, David Hildenbrand wrote:
>> @@ -268,8 +277,16 @@ struct kvm_s390_sie_block {
>>       __u8    oai;            /* 0x00e2 */
>>       __u8    armid;            /* 0x00e3 */
>>       __u8    reservede4[4];        /* 0x00e4 */
>> -    __u64    tecmc;            /* 0x00e8 */
>> -    __u8    reservedf0[12];        /* 0x00f0 */
>> +    union {
>> +        __u64    tecmc;        /* 0x00e8 */
>> +        struct {
>> +            __u16    subchannel_id;    /* 0x00e8 */
>> +            __u16    subchannel_nr;    /* 0x00ea */
>> +            __u32    io_int_parm;    /* 0x00ec */
>> +            __u32    io_int_word;    /* 0x00f0 */
>> +        };
> 
> I only wonder if we should give this member a fitting name, e.g., 
> "ioparams"

Do you see a real gain for that? We have a lot of other unnamed structs
defined here as well.


> 
>> +    } __packed;
>> +    __u8    reservedf4[8];        /* 0x00f4 */
>>   #define CRYCB_FORMAT_MASK 0x00000003
>>   #define CRYCB_FORMAT0 0x00000000
>>   #define CRYCB_FORMAT1 0x00000001
>>

Thanks,
Michael
