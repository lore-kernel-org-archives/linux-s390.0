Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728863AbgAMMsZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jan 2020 07:48:25 -0500
Subject: Re: [kvm-unit-tests PATCH v7 4/4] s390x: SCLP unit test
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
 <20200110184050.191506-5-imbrenda@linux.ibm.com>
 <8d7fb5c4-9e2c-e28a-16c0-658afcc8178d@redhat.com>
 <20200113133325.417bf657@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1b86b00a-261e-3d8c-fa52-c30e67463ad5@redhat.com>
Date: Mon, 13 Jan 2020 13:48:17 +0100
MIME-Version: 1.0
In-Reply-To: <20200113133325.417bf657@p-imbrenda>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 13.01.20 13:33, Claudio Imbrenda wrote:
> On Mon, 13 Jan 2020 12:00:00 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> +/**
>>> + * Test some bits in the instruction format that are specified to
>>> be ignored.
>>> + */
>>> +static void test_instbits(void)
>>> +{
>>> +	SCCBHeader *h = (SCCBHeader *)pagebuf;
>>> +	int cc;
>>> +
>>> +	expect_pgm_int();
>>> +	sclp_mark_busy();
>>> +	h->length = 8;
>>> +	sclp_setup_int();
>>> +
>>> +	asm volatile(
>>> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
>>> %1,%2 */
>>> +		"       ipm     %0\n"
>>> +		"       srl     %0,28"
>>> +		: "=&d" (cc) : "d" (valid_code), "a"
>>> (__pa(pagebuf))
>>> +		: "cc", "memory");
>>> +	if (lc->pgm_int_code) {
>>> +		sclp_handle_ext();
>>> +		cc = 1;
>>> +	} else if (!cc)
>>> +		  
>>
>> I wonder if something like the following would be possible:
>>
>> expect_pgm_int();
>> ...
>> asm volatiole();
>> ...
>> sclp_wait_busy();
>> check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> 
> we do not expect a specification exception, if that happens it's
> a bug and the test should rightfully fail.

Which one do we expect? (you're not checking for a specific one, should
you?)

> 
>> We would have to clear "sclp_busy" when we get a progam interrupt on a
>> servc instruction - shouldn't be too hard to add to the program
>> exception handler.
> 
> Sure that could be done, but is it worth it to rework the program
> interrupt handler only for one unit test?

Good point. I don't like this particular code, but I can live with it :)

-- 
Thanks,

David / dhildenb
