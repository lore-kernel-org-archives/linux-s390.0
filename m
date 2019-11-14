Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfKNPZo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 10:25:44 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEFNgj9137034
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:25:43 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w99hbr4v1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 10:25:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 15:25:34 -0000
Subject: Re: [PATCH v1 2/4] s390x: Define the PSW bits
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-3-git-send-email-pmorel@linux.ibm.com>
 <5796f620-7ee6-6333-e4f4-5e904284a331@linux.ibm.com>
 <189f8129-86c5-8761-fdfe-d08c34fb1f18@linux.ibm.com>
 <e27023c2-5f9c-884d-e194-4420ec6e3023@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 16:25:29 +0100
MIME-Version: 1.0
In-Reply-To: <e27023c2-5f9c-884d-e194-4420ec6e3023@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <33163b34-247d-71b2-54a3-8a6b476b7157@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com


On 2019-11-14 09:53, Janosch Frank wrote:
> On 11/14/19 9:40 AM, Pierre Morel wrote:
>> On 2019-11-13 17:05, Janosch Frank wrote:
>>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>>> Instead of assigning obfuscated masks to the PSW dedicated to the
>>>> exceptions, let's define the masks explicitely, it will clarify the
>>> s/explicitely/explicitly/
>>> Try to break that up into sentences.
>> OK thx
...snip...
>>>> +
>>>> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
>>> That's not a bit anymore, shouldn't that be in arch_def.h?
>>> Also please add a comment, that this is 64 bit addressing.
>>
>> Don't we use the 64bit architecture only?
> architecture != addressing
> We can do 24 bit addressing on zArch...
> We mostly use ESAME (zArch), but old machines start up in the old mode
> and then we transition to zArch via a SIGP.


Yes, this is done during the first instructions of cstart.S:

- Setting the architecture to 64bit / ESAME using SIGP

- Set addressing mode to 64bit

After that AFAIK we never change the addressing mode.

The definitions in the file are intended for PSW flags which AFAIK are 
always 64bits.

I created arch_bits.h to avoid using arch_def.h which contains C 
structures and functions, so preventing to include it in assembler files.


Regards,

Pierre


>
>> Regards,
>>
>> Pierre
>>
>>
>
-- 
Pierre Morel
IBM Lab Boeblingen
