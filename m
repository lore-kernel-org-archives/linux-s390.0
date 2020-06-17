Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbgFQLIi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:08:38 -0400
Subject: Re: [kvm-unit-tests PATCH v9 09/12] s390x: Library resources for CSS
 tests
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-10-git-send-email-pmorel@linux.ibm.com>
 <c424e6fe-a2f1-65fe-7ed1-2f26bc58587c@redhat.com>
 <20200617104255.607b670a.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <b9a30e60-db70-5780-3352-2c1186295af7@linux.ibm.com>
Date: Wed, 17 Jun 2020 13:08:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200617104255.607b670a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com



On 2020-06-17 10:42, Cornelia Huck wrote:
> On Tue, 16 Jun 2020 12:31:40 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 15/06/2020 11.31, Pierre Morel wrote:
>>> Provide some definitions and library routines that can be used by
>>> tests targeting the channel subsystem.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   lib/s390x/css.h      | 256 +++++++++++++++++++++++++++++++++++++++++++
>>>   lib/s390x/css_dump.c | 153 ++++++++++++++++++++++++++
>>>   s390x/Makefile       |   1 +
>>>   3 files changed, 410 insertions(+)
>>>   create mode 100644 lib/s390x/css.h
>>>   create mode 100644 lib/s390x/css_dump.c
>>
>> I can't say much about the gory IO details, but at least the inline
>> assembly looks fine to me now.
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>
> 
> I've looked at the gory I/O details, and they seem fine to me.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
