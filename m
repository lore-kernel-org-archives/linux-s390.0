Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42644 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbgGBM43 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Jul 2020 08:56:29 -0400
Subject: Re: [kvm-unit-tests PATCH v9 12/12] s390x: css: ssch/tsch with sense
 and interrupt
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-13-git-send-email-pmorel@linux.ibm.com>
 <20200617115442.036735c5.cohuck@redhat.com>
 <2383bdc0-caaf-9cb0-f4c4-ed57c1d3dfb1@linux.ibm.com>
 <20200619085718.25964a0a.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <fd2f7506-da62-1be5-4896-499c6ce7a682@linux.ibm.com>
Date: Thu, 2 Jul 2020 14:56:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200619085718.25964a0a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-06-19 08:57, Cornelia Huck wrote:
> On Wed, 17 Jun 2020 13:55:52 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 2020-06-17 11:54, Cornelia Huck wrote:
>>> On Mon, 15 Jun 2020 11:32:01 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> (...)
> 
>>>> +int start_subchannel(unsigned int sid, int code, void *data, int count,
>>>> +		     unsigned char flags)
>>>> +{
>>>> +	int cc;
>>>> +	struct ccw1 *ccw = &unique_ccw;
>>>
>>> Hm... it might better to call this function "start_single_ccw" or
>>> something like that.
>>
>> You are right.
>> I will rework this.
>> What about differentiating this badly named "start_subchannel()" into:
>>
>> ccw_setup_ccw(ccw, data, cnt, flgs);
>> ccw_setup_orb(orb, ccw, flgs)
>> ccw_start_request(schid, orb);
>>
>> would be much clearer I think.
> 
> Not sure about ccw_setup_ccw; might get a bit non-obvious if you're
> trying to build a chain.
> 
> Let's see how this turns out.
> 
> (...)
> 
>> I will rework this.
>>
>> - rework the start_subchannel()
>> - rework the read_len() if we ever need this
> 
> I think checking the count after the request concluded is actually a
> good idea. In the future, we could also add a check that it matches the
> requested length for a request where SLI was not specified.
> 
>>
>> Also thinking to put the irq_io routine inside the library, it will be
>> reused by other tests.
> 
> Yes, that probably makes sense as well.
> 

Thanks,
I respin soon.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
