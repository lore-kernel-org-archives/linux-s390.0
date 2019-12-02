Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbfLBKll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 05:41:41 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/9] s390x: irq: make IRQ handler weak
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-4-git-send-email-pmorel@linux.ibm.com>
 <33be2bbd-ea3b-4a93-3ce3-9dee36a531d1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1fdc2864-ce65-1af1-272b-0769d903dd3f@redhat.com>
Date: Mon, 2 Dec 2019 11:41:29 +0100
MIME-Version: 1.0
In-Reply-To: <33be2bbd-ea3b-4a93-3ce3-9dee36a531d1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, cohuck@redhat.com

On 29/11/2019 13.01, David Hildenbrand wrote:
> On 28.11.19 13:46, Pierre Morel wrote:
>> Having a weak function allows the tests programm to declare its own
>> IRQ handler.
>> This is helpfull for I/O tests to have the I/O IRQ handler having
>> its special work to do.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  lib/s390x/interrupt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 3e07867..d70fde3 100644
>> --- a/lib/s390x/interrupt.c
>> +++ b/lib/s390x/interrupt.c
>> @@ -140,7 +140,7 @@ void handle_mcck_int(void)
>>  		     lc->mcck_old_psw.addr);
>>  }
>>  
>> -void handle_io_int(void)
>> +__attribute__((weak)) void handle_io_int(void)
>>  {
>>  	report_abort("Unexpected io interrupt: at %#lx",
>>  		     lc->io_old_psw.addr);
>>
> 
> The clear alternative would be a way to register a callback function.
> That way you can modify the callback during the tests. As long as not
> registered, wrong I/Os can be caught easily here. @Thomas?

I don't mind too much, but I think I'd also slightly prefer a registered
callback function here instead.

 Thomas
