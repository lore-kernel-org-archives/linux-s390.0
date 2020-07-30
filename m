Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55349 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgG3P7B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jul 2020 11:59:01 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
References: <20200727095415.494318-1-frankja@linux.ibm.com>
 <20200727095415.494318-4-frankja@linux.ibm.com>
 <20200730131617.7f7d5e5f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a407971-0b43-879e-0aac-65c7f9e29606@redhat.com>
Date: Thu, 30 Jul 2020 17:58:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200730131617.7f7d5e5f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

On 30/07/2020 13.16, Cornelia Huck wrote:
> On Mon, 27 Jul 2020 05:54:15 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>      * Query Ultravisor information
>>      * Set shared access
>>      * Remove shared access
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>>  s390x/Makefile      |   1 +
>>  s390x/unittests.cfg |   3 +
>>  s390x/uv-guest.c    | 159 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 231 insertions(+)
>>  create mode 100644 lib/s390x/asm/uv.h
>>  create mode 100644 s390x/uv-guest.c
>>
> 
> (...)
> 
>> +static inline int uv_call(unsigned long r1, unsigned long r2)
>> +{
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>> +		"		brc	3,0b\n"
>> +		"		ipm	%[cc]\n"
>> +		"		srl	%[cc],28\n"
>> +		: [cc] "=d" (cc)
>> +		: [r1] "a" (r1), [r2] "a" (r2)
>> +		: "memory", "cc");
>> +	return cc;
>> +}
> 
> This returns the condition code, but no caller seems to check it
> (instead, they look at header.rc, which is presumably only set if the
> instruction executed successfully in some way?)
> 
> Looking at the kernel, it retries for cc > 1 (presumably busy
> conditions), and cc != 0 seems to be considered a failure. Do we want
> to look at the cc here as well?

It's there - but here it's in the assembly code, the "brc 3,0b".

Patch looks ok to me (but I didn't do a full review):

Acked-by: Thomas Huth <thuth@redhat.com>
