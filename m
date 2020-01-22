Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729016AbgAVKC5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jan 2020 05:02:57 -0500
Subject: Re: [kvm-unit-tests PATCH v8 0/6] s390x: SCLP Unit test
From: David Hildenbrand <david@redhat.com>
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <b47c3b26-398a-1791-802d-8f6f6abf3498@redhat.com>
Message-ID: <3919c77f-1b89-07b2-8bb9-67ba5289defc@redhat.com>
Date: Wed, 22 Jan 2020 11:02:48 +0100
MIME-Version: 1.0
In-Reply-To: <b47c3b26-398a-1791-802d-8f6f6abf3498@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22.01.20 10:55, David Hildenbrand wrote:
> On 20.01.20 19:42, Claudio Imbrenda wrote:
>> This patchset contains some minor cleanup, some preparatory work and
>> then the SCLP unit test itself.
>>
>> The unit test checks the following:
>>     
>>     * Correctly ignoring instruction bits that should be ignored
>>     * Privileged instruction check
>>     * Check for addressing exceptions
>>     * Specification exceptions:
>>       - SCCB size less than 8
>>       - SCCB unaligned
>>       - SCCB overlaps prefix or lowcore
>>       - SCCB address higher than 2GB
>>     * Return codes for
>>       - Invalid command
>>       - SCCB too short (but at least 8)
>>       - SCCB page boundary violation
>>
>> v7 -> v8
>> * fixed existing stfl asm wrapper
>> * now using stfl asm wrapper in intercept.c
>> * patched the program interrupt handler to clear the sclp_busy bit
>> * removed now unnecessary expect_pgm_int from the unit test
>> v6 -> v7
>> * renamed spx() and stpx() wrappers to set_prefix and get_prefix
>> * set_prefix now takes a value and get_prefix now returns a value
>> * put back some inline assembly for spx and stpx as a consequence
>> * used LC_SIZE instead of 2 * PAGE_SIZE everywhere in the unit test
>> v5 -> v6
>> * fixed a bug in test_addressing
>> * improved comments in test_sccb_prefix
>> * replaced all inline assembly usages of spx and stpx with the wrappers
>> * added one more wrapper for test_one_sccb for read-only tests
>> v4 -> v5
>> * updated usage of report()
>> * added SPX and STPX wrappers to the library
>> * improved readability
>> * addressed some more comments
>> v3 -> v4
>> * export sclp_setup_int instead of copying it
>> * add more comments
>> * rename some more variables to improve readability
>> * improve the prefix test
>> * improved the invalid address test
>> * addressed further comments received during review
>> v2 -> v3
>> * generally improved the naming of variables
>> * added and fixed comments
>> * renamed test_one_run to test_one_simple
>> * added some const where needed
>> * addresed many more small comments received during review
>> v1 -> v2
>> * fix many small issues that came up during the first round of reviews
>> * add comments to each function
>> * use a static buffer for the SCCP template when used
>>
>> Claudio Imbrenda (6):
>>   s390x: export sclp_setup_int
>>   s390x: sclp: add service call instruction wrapper
>>   s390x: lib: fix stfl wrapper asm
>>   s390x: lib: add SPX and STPX instruction wrapper
>>   s390x: lib: fix program interrupt handler if sclp_busy was set
>>   s390x: SCLP unit test
>>
>>  s390x/Makefile           |   1 +
>>  lib/s390x/asm/arch_def.h |  26 +++
>>  lib/s390x/asm/facility.h |   2 +-
>>  lib/s390x/sclp.h         |   1 +
>>  lib/s390x/interrupt.c    |   5 +-
>>  lib/s390x/sclp.c         |   9 +-
>>  s390x/intercept.c        |  24 +-
>>  s390x/sclp.c             | 474 +++++++++++++++++++++++++++++++++++++++
>>  s390x/unittests.cfg      |   8 +
>>  9 files changed, 526 insertions(+), 24 deletions(-)
>>  create mode 100644 s390x/sclp.c
>>
> 
> Queued to
> 
> https://github.com/davidhildenbrand/qemu.git s390-tcg-next

Lol, wrong shortcut (thanks Thomas :) )

Queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

-- 
Thanks,

David / dhildenb
