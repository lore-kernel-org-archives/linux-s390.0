Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbgE0Kod (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 06:44:33 -0400
Subject: Re: [PATCH] vfio-ccw: document possible errors
References: <20200407111605.1795-1-cohuck@redhat.com>
 <55932365-3d36-1629-5d65-06c71e8231f9@linux.ibm.com>
 <20200508125541.72adc626.cohuck@redhat.com>
 <ed9b7c9b-3dc7-e573-55a8-d52f28877da9@linux.ibm.com>
 <20200527081934.2dceda89.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <b9fe4698-c889-3480-9720-013c8af79c16@linux.ibm.com>
Date: Wed, 27 May 2020 06:44:29 -0400
MIME-Version: 1.0
In-Reply-To: <20200527081934.2dceda89.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 5/27/20 2:19 AM, Cornelia Huck wrote:
> On Tue, 26 May 2020 15:39:22 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 5/8/20 6:55 AM, Cornelia Huck wrote:
>>> On Fri, 17 Apr 2020 12:33:18 -0400
>>> Eric Farman <farman@linux.ibm.com> wrote:
>>>   
>>>> On 4/7/20 7:16 AM, Cornelia Huck wrote:  
>>>>> Interacting with the I/O and the async regions can yield a number
>>>>> of errors, which had been undocumented so far. These are part of
>>>>> the api, so remedy that.    
>>>>
>>>> (Makes a note to myself, to do the same for the schib/crw regions we're
>>>> adding for channel path handling.)  
>>>
>>> Yes, please :) I plan to merge this today, so you can add a patch on
>>> top.  
>>
>> I finally picked this up and realized that the io and async regions both
>> document the return codes that would be stored in a field within their
>> respective regions. The schib/crw regions don't have any such field, so
>> the only values to be documented are the ones that the .read callback
>> itself returns. What obvious thing am I missing?
> 
> The fact that you are right :)
> 
> No need to do anything, I might have spread my own confusion here ;)
> 

Oh, good. I was worried vacation was too long/short. :)

Thanks for confirming; will get back to the other things on the list
instead.
