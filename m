Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730922AbgKEOPy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Nov 2020 09:15:54 -0500
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
 <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
 <20200928173147.750e7358.cohuck@redhat.com>
 <136e1860-ddbc-edc0-7e67-fdbd8112a01e@linux.ibm.com>
 <f2ff3ddd-c70e-b2cc-b58f-bbcb1e4684d6@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
Message-ID: <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
Date: Thu, 5 Nov 2020 15:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <f2ff3ddd-c70e-b2cc-b58f-bbcb1e4684d6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 11/5/20 1:16 PM, Pierre Morel wrote:
> 
> 
> On 9/29/20 9:19 AM, Janosch Frank wrote:
>> On 9/28/20 5:31 PM, Cornelia Huck wrote:
>>> On Mon, 28 Sep 2020 16:23:34 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>>> Some architectures need allocations to be done under a
>>>> specific address limit to allow DMA from I/O.
>>>>
>>>> We propose here a very simple page allocator to get
>>>> pages allocated under this specific limit.
>>>>
>>>> The DMA page allocator will only use part of the available memory
>>>> under the DMA address limit to let room for the standard allocator.
>>>>
> 
> ...snip...
> 
>>
>> Before we start any other discussion on this patch we should clear up if
>> this is still necessary after Claudio's alloc revamp.
>>
>> I think he added options to request special types of memory.
> 
> Isn't it possible to go on with this patch series.
> It can be adapted later to the changes that will be introduced by 
> Claudio when it is final.
> 
> 

Pierre, that's outside of my jurisdiction, you're adding code to the
common code library.

I've set Paolo CC, let's see if he finds this thread :)
