Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729424AbgGOKth (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 06:49:37 -0400
Subject: Re: [kvm-unit-tests PATCH v12 9/9] s390x: css: ssch/tsch with sense
 and interrupt
References: <1594725348-10034-1-git-send-email-pmorel@linux.ibm.com>
 <1594725348-10034-10-git-send-email-pmorel@linux.ibm.com>
 <20200715121523.1a4244fb.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <4363ac1a-d8a9-b6f7-785f-aa293c44215a@linux.ibm.com>
Date: Wed, 15 Jul 2020 12:49:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200715121523.1a4244fb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, drjones@redhat.com



On 2020-07-15 12:15, Cornelia Huck wrote:
> On Tue, 14 Jul 2020 13:15:48 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> After a channel is enabled we start a SENSE_ID command using
>> the SSCH instruction to recognize the control unit and device.
>>
>> This tests the success of SSCH, the I/O interruption and the TSCH
>> instructions.
>>
>> The SENSE_ID command response is tested to report 0xff inside
>> its reserved field and to report the same control unit type
>> as the cu_type kernel argument.
>>
>> Without the cu_type kernel argument, the test expects a device
>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/asm/arch_def.h |   1 +
>>   lib/s390x/css.h          |  35 ++++++++
>>   lib/s390x/css_lib.c      | 180 +++++++++++++++++++++++++++++++++++++++
>>   s390x/css.c              |  80 +++++++++++++++++
>>   4 files changed, 296 insertions(+)
> 
> Other than the padding issue, looks good to me now.
> 

Thanks, so one last respin. :)


-- 
Pierre Morel
IBM Lab Boeblingen
