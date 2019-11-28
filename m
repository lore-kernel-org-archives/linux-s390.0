Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbfK1TQk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 14:16:40 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASJBx5R074179
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 14:16:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjgjdf8uu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2019 14:16:39 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 28 Nov 2019 19:16:37 -0000
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
 <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 28 Nov 2019 20:16:33 +0100
MIME-Version: 1.0
In-Reply-To: <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7abb4725-b814-8b43-8a4f-e0e2cf7a44f8@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com


On 2019-11-28 15:36, David Hildenbrand wrote:
> On 28.11.19 13:46, Pierre Morel wrote:
>> Let's define the PSW bits  explicitly, it will clarify their
>> usage.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>>   lib/s390x/asm/arch_def.h  |  6 ++----
> I'm sorry, but I don't really see a reason to move these 4/5 defines to
> a separate header. Can you just keep them in arch_def.h and extend?

no because arch_def.h contains C structures and inline.


>
> (none of your other patches touch arch_bits.h - and it is somewhat a
> weird name. Where to put something new: arch_def.h or arch_bits.h? I
> would have understood "psw.h", but even that, I don't consider necessary)
>
I can use a name like psw.h or let fall and keep the hexa.


-- 
Pierre Morel
IBM Lab Boeblingen
