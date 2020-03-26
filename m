Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727994AbgCZLyX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 07:54:23 -0400
Subject: Re: [RFC PATCH v2 2/9] vfio-ccw: Register a chp_event callback for
 vfio-ccw
References: <20200206213825.11444-1-farman@linux.ibm.com>
 <20200206213825.11444-3-farman@linux.ibm.com>
 <20200214131147.0a98dd7d.cohuck@redhat.com>
 <459a60d1-699d-2f16-bb59-23f11b817b81@linux.ibm.com>
 <20200324165854.3d862d5b.cohuck@redhat.com>
 <302a0650-99b0-22ef-b95d-cecdeb0f9f04@linux.ibm.com>
 <20200326074759.5808c945.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <7dd0d142-dad2-c5d9-fb84-237f99bd9e7b@linux.ibm.com>
Date: Thu, 26 Mar 2020 07:54:19 -0400
MIME-Version: 1.0
In-Reply-To: <20200326074759.5808c945.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 3/26/20 2:47 AM, Cornelia Huck wrote:
> On Wed, 25 Mar 2020 22:09:40 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 3/24/20 11:58 AM, Cornelia Huck wrote:
>>> On Fri, 14 Feb 2020 11:35:21 -0500
>>> Eric Farman <farman@linux.ibm.com> wrote:
>>>   
>>>> On 2/14/20 7:11 AM, Cornelia Huck wrote:  
>>>>> On Thu,  6 Feb 2020 22:38:18 +0100
>>>>> Eric Farman <farman@linux.ibm.com> wrote:  
> 
>>>>>> +	case CHP_ONLINE:
>>>>>> +		/* Path became available */
>>>>>> +		sch->lpm |= mask & sch->opm;    
>>>>>
>>>>> If I'm not mistaken, this patch introduces the first usage of sch->opm
>>>>> in the vfio-ccw code.     
>>>>
>>>> Correct.
>>>>  
>>>>> Are we missing something?    
>>>>
>>>> Maybe?  :)
>>>>  
>>>>> Or am I missing
>>>>> something? :)
>>>>>     
>>>>
>>>> Since it's only used in this code, for acting as a step between
>>>> vary/config off/on, maybe this only needs to be dealing with the lpm
>>>> field itself?  
>>>
>>> Ok, I went over this again and also looked at what the standard I/O
>>> subchannel driver does, and I think this is fine, as the lpm basically
>>> factors in the opm already. (Will need to keep this in mind for the
>>> following patches.)  
>>
>> Just to make sure I don't misunderstand, when you say "I think this is
>> fine" ... Do you mean keeping the opm field within vfio-ccw, as this
>> patch does?  Or removing it, and only adjusting the lpm within vfio-ccw,
>> as I suggested in my response just above?
> 
> I meant the code change done in this patch: We update the lpm whenever
> the opm is changed, and use the lpm. I'd like to keep the opm separate,
> just so that we are clear where each value comes from.
> 

Great.  Thanks for that clarification.
