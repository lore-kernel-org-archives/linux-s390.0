Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgAWN4f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 08:56:35 -0500
Subject: Re: [kvm-unit-tests PATCH v4 2/9] s390x: smp: Only use smp_cpu_setup
 once
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-3-frankja@linux.ibm.com>
 <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
 <e09c42a7-279a-7e8b-8241-26c69940cdd0@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9a17ce2d-bfce-0a1f-dfa7-3d798af4d5ab@redhat.com>
Date: Thu, 23 Jan 2020 14:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <e09c42a7-279a-7e8b-8241-26c69940cdd0@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 23.01.20 14:54, Janosch Frank wrote:
> On 1/23/20 2:45 PM, David Hildenbrand wrote:
>> On 21.01.20 14:42, Janosch Frank wrote:
>>> Let's stop and start instead of using setup to run a function on a
>>> cpu.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  s390x/smp.c | 21 ++++++++++++++-------
>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>> index e37eb56..3e8cf3e 100644
>>> --- a/s390x/smp.c
>>> +++ b/s390x/smp.c
>>> @@ -53,7 +53,7 @@ static void test_start(void)
>>>  	psw.addr = (unsigned long)test_func;
>>>  
>>>  	set_flag(0);
>>> -	smp_cpu_setup(1, psw);
>>> +	smp_cpu_start(1, psw);
>>>  	wait_for_flag();
>>>  	report(1, "start");
>>>  }
>>> @@ -109,6 +109,7 @@ static void test_store_status(void)
>>>  	report(1, "status written");
>>>  	free_pages(status, PAGE_SIZE * 2);
>>>  	report_prefix_pop();
>>> +	smp_cpu_stop(1);
>>>  
>>>  	report_prefix_pop();
>>>  }
>>> @@ -137,9 +138,8 @@ static void test_ecall(void)
>>>  
>>>  	report_prefix_push("ecall");
>>>  	set_flag(0);
>>> -	smp_cpu_destroy(1);
>>>  
>>> -	smp_cpu_setup(1, psw);
>>> +	smp_cpu_start(1, psw);
>>>  	wait_for_flag();
>>>  	set_flag(0);
>>>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>>> @@ -172,9 +172,8 @@ static void test_emcall(void)
>>>  
>>>  	report_prefix_push("emcall");
>>>  	set_flag(0);
>>> -	smp_cpu_destroy(1);
>>>  
>>> -	smp_cpu_setup(1, psw);
>>> +	smp_cpu_start(1, psw);
>>>  	wait_for_flag();
>>>  	set_flag(0);
>>>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>>> @@ -192,7 +191,7 @@ static void test_reset_initial(void)
>>>  	psw.addr = (unsigned long)test_func;
>>>  
>>>  	report_prefix_push("reset initial");
>>> -	smp_cpu_setup(1, psw);
>>> +	smp_cpu_start(1, psw);
>>>  
>>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>>> @@ -223,7 +222,7 @@ static void test_reset(void)
>>>  	psw.addr = (unsigned long)test_func;
>>>  
>>>  	report_prefix_push("cpu reset");
>>> -	smp_cpu_setup(1, psw);
>>> +	smp_cpu_start(1, psw);
>>>  
>>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>>  	report(smp_cpu_stopped(1), "cpu stopped");
>>> @@ -232,6 +231,7 @@ static void test_reset(void)
>>>  
>>>  int main(void)
>>>  {
>>> +	struct psw psw;
>>>  	report_prefix_push("smp");
>>>  
>>>  	if (smp_query_num_cpus() == 1) {
>>> @@ -239,6 +239,12 @@ int main(void)
>>>  		goto done;
>>>  	}
>>>  
>>> +	/* Setting up the cpu to give it a stack and lowcore */
>>> +	psw.mask = extract_psw_mask();
>>> +	psw.addr = (unsigned long)cpu_loop;
>>> +	smp_cpu_setup(1, psw);
>>> +	smp_cpu_stop(1);
>>> +
>>>  	test_start();
>>>  	test_stop();
>>>  	test_stop_store_status();
>>> @@ -247,6 +253,7 @@ int main(void)
>>>  	test_emcall();
>>>  	test_reset();
>>>  	test_reset_initial();
>>> +	smp_cpu_destroy(1);
>>>  
>>>  done:
>>>  	report_prefix_pop();
>>>
>>
>> With this patch, I get timeouts under TCG. Seems to loop forever.
>>
> The branch works on lpar and kvm without a problem.

Which could mean that either TCG is broken or your test is broken (e.g.,
a race condition that does not trigger under LPAR because it's faster,
or some undocumented/not guaranteed behavior).

-- 
Thanks,

David / dhildenb
