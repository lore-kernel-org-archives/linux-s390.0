Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40008 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726052AbgFPJlF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jun 2020 05:41:05 -0400
Subject: Re: [kvm-unit-tests PATCH v9 06/12] s390x: clock and delays
 caluculations
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
 <81557eed-ff8e-2076-44f7-2174befce7b5@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <64ec709d-08a4-2d82-141e-b86453d91896@linux.ibm.com>
Date: Tue, 16 Jun 2020 11:40:57 +0200
MIME-Version: 1.0
In-Reply-To: <81557eed-ff8e-2076-44f7-2174befce7b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-06-16 11:35, Thomas Huth wrote:
> On 15/06/2020 11.31, Pierre Morel wrote:
>> The hardware gives us a good definition of the microsecond,
>> let's keep this information and let the routine accessing
>> the hardware keep all the information and return microseconds.
>>
>> Calculate delays in microseconds and take care about wrapping
>> around zero.
>>
>> Define values with macros and use inlines to keep the
>> milliseconds interface.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/asm/time.h | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> In case you respin, there is a typo in the title ("caluculations") ...
> otherwise this can be fixed when the patch gets picked up.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Yes if I respin I modifify it :)

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
