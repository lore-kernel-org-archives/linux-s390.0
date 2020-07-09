Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgGINiK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jul 2020 09:38:10 -0400
Subject: Re: [kvm-unit-tests PATCH v11 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1594282068-11054-1-git-send-email-pmorel@linux.ibm.com>
 <1594282068-11054-10-git-send-email-pmorel@linux.ibm.com>
 <20200709141348.6ae5ff18.cohuck@redhat.com>
 <9aba6196-edd4-4eb0-1e1c-e6410291863b@linux.ibm.com>
 <20200709153318.2931430d.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ff6623ca-eb52-5169-ca31-0ca2790a176f@linux.ibm.com>
Date: Thu, 9 Jul 2020 15:38:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200709153318.2931430d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com



On 2020-07-09 15:33, Cornelia Huck wrote:
> On Thu, 9 Jul 2020 15:18:25 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-07-09 14:13, Cornelia Huck wrote:
>>> On Thu,  9 Jul 2020 10:07:48 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>> +	if (irb.scsw.sch_stat & !(SCSW_SCHS_PCI | SCSW_SCHS_IL)) {
>>>
>>> Did you mean ~(SCSW_SCHS_PCI | SCSW_SCHS_IL)?
>>
>> grrr... yes, thanks.
>>
>>>
>>> If yes, why do think a PCI may show up?
>>
>> Should not in the current implementation.
>> I thought I can add it as a general test.
> 
> Yeah, maybe in the future. But for now, I think it is a bit confusing.
> 

OK then I just remove it.


-- 
Pierre Morel
IBM Lab Boeblingen
