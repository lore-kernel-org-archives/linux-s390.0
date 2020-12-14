Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436572AbgLNKgz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 05:36:55 -0500
Subject: Re: [kvm-unit-tests PATCH v3 4/8] s390x: Split assembly and move to
 s390x/asm/
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-5-frankja@linux.ibm.com>
 <5f1e9f51-86d9-4bb1-1dcf-09ec687419f4@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <34bf37fd-ba78-7cd4-7d46-dce1f27b8f62@linux.ibm.com>
Date: Mon, 14 Dec 2020 11:34:52 +0100
MIME-Version: 1.0
In-Reply-To: <5f1e9f51-86d9-4bb1-1dcf-09ec687419f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/11/20 1:18 PM, Thomas Huth wrote:
> On 11/12/2020 11.00, Janosch Frank wrote:
>> I've added too much to cstart64.S which is not start related
>> already. Now that I want to add even more code it's time to split
>> cstart64.S. lib.S has functions that are used in tests. macros.S
>> contains macros which are used in cstart64.S and lib.S
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile             |   8 +--
>>  s390x/{ => asm}/cstart64.S | 119 ++-----------------------------------
>>  s390x/asm/lib.S            |  65 ++++++++++++++++++++
>>  s390x/asm/macros.S         |  77 ++++++++++++++++++++++++
>>  4 files changed, 150 insertions(+), 119 deletions(-)
>>  rename s390x/{ => asm}/cstart64.S (50%)
>>  create mode 100644 s390x/asm/lib.S
>>  create mode 100644 s390x/asm/macros.S
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index b079a26..fb62e87 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -66,10 +66,10 @@ cflatobjs += lib/s390x/css_lib.o
>>  
>>  OBJDIRS += lib/s390x
>>  
>> -cstart.o = $(TEST_DIR)/cstart64.o
>> +asmlib = $(TEST_DIR)/asm/cstart64.o $(TEST_DIR)/asm/lib.o
>>  
>>  FLATLIBS = $(libcflat)
>> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(cstart.o)
>> +%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>>  	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
>>  		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
>>  	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
>> @@ -87,7 +87,7 @@ FLATLIBS = $(libcflat)
>>  	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --image $< -o $@
>>  
>>  arch_clean: asm_offsets_clean
>> -	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
>> +	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d $(TEST_DIR)/asm/*.{o,elf,bin} $(TEST_DIR)/asm/.*.d
>>  
>>  generated-files = $(asm-offsets)
>> -$(tests:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
>> +$(tests:.elf=.o) $(asmlib) $(cflatobjs): $(generated-files)
> 
> Did you check this with both, in-tree and out-of-tree builds?
> (I wonder whether that new asm directory needs some special handling for
> out-of-tree builds?)

I'm not a big fan of out-of-tree builds, so I didn't check.
To get those builds working we would need to create the asm directory in
the $testdir

> 
>> diff --git a/s390x/asm/lib.S b/s390x/asm/lib.S
>> new file mode 100644
>> index 0000000..4d78ec6
>> --- /dev/null
>> +++ b/s390x/asm/lib.S
>> @@ -0,0 +1,65 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * s390x assembly library
>> + *
>> + * Copyright (c) 2019 IBM Corp.
>> + *
>> + * Authors:
>> + *    Janosch Frank <frankja@linux.ibm.com>
>> + */
>> +#include <asm/asm-offsets.h>
>> +#include <asm/sigp.h>
>> +
>> +#include "macros.S"
>> +
>> +/*
>> + * load_reset calling convention:
>> + * %r2 subcode (0 or 1)
>> + */
>> +.globl diag308_load_reset
>> +diag308_load_reset:
> 
> Thinking about this twice ... this function is only used by s390x/diag308.c,
> so it's not really a library function, but rather part of a single test ...
> I think it would be cleaner to put it into a separate file instead, what do
> you think?

I don't really want to split this any further.
Moving the asm files into an own directory already improves readability
a lot for me and I don't need more files if they aren't absolutely
necessary.

> 
>  Thomas
> 
> 
