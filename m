Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbfGKM2s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Jul 2019 08:28:48 -0400
Subject: Re: [RFC v2 4/5] vfio-ccw: Don't call cp_free if we are processing a
 channel program
References: <cover.1562616169.git.alifm@linux.ibm.com>
 <1405df8415d3bff446c22753d0e9b91ff246eb0f.1562616169.git.alifm@linux.ibm.com>
 <20190709121613.6a3554fa.cohuck@redhat.com>
 <45ad7230-3674-2601-af5b-d9beef9312be@linux.ibm.com>
 <20190709162142.789dd605.pasic@linux.ibm.com>
 <87f7a37f-cc34-36fb-3a33-309e33bbbdde@linux.ibm.com>
 <20190710154549.5c31cc0c.cohuck@redhat.com>
 <75e71cc4-7552-b9e5-5649-4de2cdd8f59a@linux.ibm.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <076c223c-d21c-634e-72d2-2de2fe082530@linux.ibm.com>
Date: Thu, 11 Jul 2019 08:28:28 -0400
MIME-Version: 1.0
In-Reply-To: <75e71cc4-7552-b9e5-5649-4de2cdd8f59a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 7/10/19 12:10 PM, Farhan Ali wrote:
> 
> 
> On 07/10/2019 09:45 AM, Cornelia Huck wrote:
>> On Tue, 9 Jul 2019 17:27:47 -0400
>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>
>>> On 07/09/2019 10:21 AM, Halil Pasic wrote:
>>>> Do we need to use atomic operations or external synchronization to
>>>> avoid
>>>> this being another gamble? Or am I missing something?
>>>
>>> I think we probably should think about atomic operations for
>>> synchronizing the state (and it could be a separate add on patch?).
>>
>> +1 to thinking about some atomicity changes later.

+1

>>
>>>
>>> But for preventing 2 threads from stomping on the cp the check should be
>>> enough, unless I am missing something?
>>
>> I think so. Plus, the patch is small enough that we can merge it right
>> away, and figure out a more generic change later.
> 
> I will send out a v3 soon if no one else has any other suggestions.
> 

I thumbed through them and think they look good with Conny's
suggestions.  Nothing else jumps to mind for me.
