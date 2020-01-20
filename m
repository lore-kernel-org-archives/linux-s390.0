Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgATMII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 07:08:08 -0500
Subject: Re: [kvm-unit-tests PATCH v3 6/9] s390x: smp: Loop if secondary cpu
 returns into cpu setup again
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-7-frankja@linux.ibm.com>
 <20200120122743.68170875.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5d915473-f36e-0310-11a5-69eae79649a7@redhat.com>
Date: Mon, 20 Jan 2020 13:07:58 +0100
MIME-Version: 1.0
In-Reply-To: <20200120122743.68170875.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org

On 20.01.20 12:27, Cornelia Huck wrote:
> On Fri, 17 Jan 2020 05:46:37 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Up to now a secondary cpu could have returned from the function it was
>> executing and ending up somewhere in cstart64.S. This was mostly
>> circumvented by an endless loop in the function that it executed.
>>
>> Let's add a loop to the end of the cpu setup, so we don't have to rely
>> on added loops in the tests.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/cstart64.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 9af6bb3..5fd8d2f 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -162,6 +162,8 @@ smp_cpu_setup_state:
>>  	/* We should only go once through cpu setup and not for every restart */
>>  	stg	%r14, GEN_LC_RESTART_NEW_PSW + 8
>>  	br	%r14
>> +	/* If the function returns, just loop here */
>> +0:	j	0
> 
> Would it make sense to e.g. load a disabled wait psw instead? Or does
> that mess things up elsewhere?

I think we can keep it like that for now (simpler than loading a PSW).
Overall, I don't care about burning CPU cycles here :)


-- 
Thanks,

David / dhildenb
