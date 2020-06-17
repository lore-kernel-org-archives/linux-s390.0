Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgFQLBx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:01:53 -0400
Subject: Re: [kvm-unit-tests PATCH v9 04/12] s390x: interrupt registration
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-5-git-send-email-pmorel@linux.ibm.com>
 <20200617102053.47c4a52c.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <884f0b99-69c8-ed7c-c0fd-14d1e76d5250@linux.ibm.com>
Date: Wed, 17 Jun 2020 13:01:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200617102053.47c4a52c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com



On 2020-06-17 10:20, Cornelia Huck wrote:
> On Mon, 15 Jun 2020 11:31:53 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> Subject: "s390: I/O interrupt registration" ?

yes, better.

> 
>> Let's make it possible to add and remove a custom io interrupt handler,
>> that can be used instead of the normal one.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

...snip...

>> +int unregister_io_int_func(void (*f)(void))
>> +{
>> +	if (io_int_func != f)
>> +		return -1;
> 
> Not sure if we really need these checks, but they don't hurt, either.

Not sure neither but I prefer to let it here to avoid more discussions 
since already reviewed-by...

> 
>> +	io_int_func = NULL;
>> +	return 0;
>> +}
>> +
>>   void handle_svc_int(void)
>>   {
>>   	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx",
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
