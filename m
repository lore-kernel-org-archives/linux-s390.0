Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727493AbfLBRDc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 12:03:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2Gvqi0118760
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 12:03:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wn3pch489-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 12:03:31 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 2 Dec 2019 17:03:29 -0000
Subject: Re: [kvm-unit-tests PATCH v2 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-5-git-send-email-pmorel@linux.ibm.com>
 <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
 <53c076ee-0b16-b990-b6d7-22903b8892b4@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 2 Dec 2019 18:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <53c076ee-0b16-b990-b6d7-22903b8892b4@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dba2fd94-1ce6-1397-da54-5841f86fdac6@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com



On 2019-12-02 12:13, Janosch Frank wrote:
> On 11/29/19 1:03 PM, David Hildenbrand wrote:
>> On 28.11.19 13:46, Pierre Morel wrote:
>>> To serve multiple times, the function get_clock_ms() is moved
>>> from intercept.c test to the new file asm/clock.h.
>>
>> I'd probably call this "tod.h" instead. Nevermind.
> 
> time.h / timing.h?
> I'm planning on adding cpu timer functions somewhen next year...

as long as you both agree, I take the name you want.

> 
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>>
> 
> 

-- 
Pierre Morel
IBM Lab Boeblingen
