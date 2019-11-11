Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfKKHRk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 02:17:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB7HPID000929
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 02:17:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w717pbsa4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 02:17:37 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Mon, 11 Nov 2019 07:17:36 -0000
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
References: <20191108120025.GM4787@sasha-vm>
 <4d8f1938-af6e-7e0e-4085-2f7c53390b2d@linux.ibm.com>
 <20191108123416.GA732985@kroah.com>
 <20191108.113527.2242883926552730503.davem@davemloft.net>
From: Julian Wiedmann <jwi@linux.ibm.com>
Date: Mon, 11 Nov 2019 08:17:31 +0100
MIME-Version: 1.0
In-Reply-To: <20191108.113527.2242883926552730503.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <29d7a908-10af-a83a-df2f-05cf1facf82c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-s390@vger.kernel.org

On 08.11.19 20:35, David Miller wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> Date: Fri, 8 Nov 2019 13:34:16 +0100
> 
>> On Fri, Nov 08, 2019 at 01:16:26PM +0100, Julian Wiedmann wrote:
>>> On 08.11.19 13:00, Sasha Levin wrote:
>>>> On Fri, Nov 08, 2019 at 12:50:24PM +0100, Julian Wiedmann wrote:
>>>>> On 08.11.19 12:37, Sasha Levin wrote:
>>>>>> From: Julian Wiedmann <jwi@linux.ibm.com>
>>>>>>
>>>>>> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
>>>>>>
>>>>>> Combined L3+L4 csum offload is only required for some L3 HW. So for
>>>>>> L2 devices, don't offload the IP header csum calculation.
>>>>>>
>>>>>
>>>>> NACK, this has no relevance for stable.
>>>>
>>>> Sure, I'll drop it.
>>>>
>>>> Do you have an idea why the centos and ubuntu folks might have
>>>> backported this commit into their kernels?
>>>>
>>>
>>> No clue, I trust they have their own reasons.
>>>
>>
>> I cant see centos backporting anything unless they were asked to do so.
>> And this really looks like a "bugfix" to me, why isn't this relevant for
>> any older kernel versions?
> 
> Yeah seriously, this looks entirely legit.
> 

I can assure you this doesn't fix any actual bug, and there's zero user
impact from _not_ having this patch.
