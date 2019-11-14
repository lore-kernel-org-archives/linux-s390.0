Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57172 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbfKNRv1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 12:51:27 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEHm6NS082023
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:51:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92jm98f4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 12:51:24 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 17:51:03 -0000
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
 <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
 <75b72389-eec5-200f-01af-512d1294f137@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <75b72389-eec5-200f-01af-512d1294f137@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <4f6763fa-a97b-94eb-ac84-9416a653f009@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com


On 2019-11-14 17:51, Thomas Huth wrote:
> On 14/11/2019 17.38, Pierre Morel wrote:
> [...]
>>>> +static char buffer[4096];
>>>> +
>>>> +static void delay(int d)
>>>> +{
>>>> +    int i, j;
>>>> +
>>>> +    while (d--)
>>>> +        for (i = 1000000; i; i--)
>>>> +            for (j = 1000000; j; j--)
>>>> +                ;
>>>> +}
>>> You could set a timer.
>> Hum, do we really want to do this?
> I'm pretty sure that the compiler optimizes empty loops away. Maybe have
> a look at the disassembly of your delay function...
>
> Anyway, it's likely better to use STCK and friends to get a proper
> timing. You could move get_clock_ms() from s390x/intercept.c to the
> lib/s390x folder and then use that function here.


Yes, I can, thanks.

Pierre



>
>   Thomas
>
-- 
Pierre Morel
IBM Lab Boeblingen
