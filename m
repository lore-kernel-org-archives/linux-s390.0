Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20251 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgEFOFa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 10:05:30 -0400
Subject: Re: [kvm-unit-tests RFC] s390x: Add Protected VM support
References: <20200506124636.21876-1-mhartmay@linux.ibm.com>
 <ad0d5c9d-bde2-2143-0440-d47d6e28bb29@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d13ba18-fede-20fc-7b04-b6b0933971d1@redhat.com>
Date: Wed, 6 May 2020 16:05:13 +0200
MIME-Version: 1.0
In-Reply-To: <ad0d5c9d-bde2-2143-0440-d47d6e28bb29@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>, kvm@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On 06.05.20 16:03, Janosch Frank wrote:
> On 5/6/20 2:46 PM, Marc Hartmayer wrote:
>> Add support for Protected Virtual Machine (PVM) tests. For starting a
>> PVM guest we must be able to generate a PVM image by using the
>> `genprotimg` tool from the s390-tools collection. This requires the
>> ability to pass a machine-specific host-key document, so the option
>> `--host-key-document` is added to the configure script.
>>
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  .gitignore          |  1 +
>>  configure           |  8 ++++++++
>>  s390x/Makefile      | 16 +++++++++++++---
>>  s390x/unittests.cfg | 20 ++++++++++++++++++++
>>  scripts/common.bash | 30 +++++++++++++++++++++++++++++-
>>  5 files changed, 71 insertions(+), 4 deletions(-)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 784cb2ddbcb8..1fa5c0c0ea76 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -4,6 +4,7 @@
>>  *.o
>>  *.flat
>>  *.elf
>> +*.img
>>  .pc
>>  patches
>>  .stgit-*
>> diff --git a/configure b/configure
>> index 5d2cd90cd180..29191f4b0994 100755
>> --- a/configure
>> +++ b/configure
>> @@ -18,6 +18,7 @@ u32_long=
>>  vmm="qemu"
>>  errata_force=0
>>  erratatxt="errata.txt"
>> +host_key_document=
>>  
>>  usage() {
>>      cat <<-EOF
>> @@ -40,6 +41,8 @@ usage() {
>>  	                           no environ is provided by the user (enabled by default)
>>  	    --erratatxt=FILE       specify a file to use instead of errata.txt. Use
>>  	                           '--erratatxt=' to ensure no file is used.
>> +	    --host-key-document=HOST_KEY_DOCUMENT
>> +	                           host-key-document to use (s390x only)
>>  EOF
>>      exit 1
>>  }
>> @@ -91,6 +94,9 @@ while [[ "$1" = -* ]]; do
>>  	--erratatxt)
>>  	    erratatxt="$arg"
>>  	    ;;
>> +	--host-key-document)
>> +	    host_key_document="$arg"
>> +	    ;;
>>  	--help)
>>  	    usage
>>  	    ;;
>> @@ -207,6 +213,8 @@ PRETTY_PRINT_STACKS=$pretty_print_stacks
>>  ENVIRON_DEFAULT=$environ_default
>>  ERRATATXT=$erratatxt
>>  U32_LONG_FMT=$u32_long
>> +GENPROTIMG=genprotimg
>> +HOST_KEY_DOCUMENT=$host_key_document
>>  EOF
>>  
>>  cat <<EOF > lib/config.h
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index ddb4b48ecbf9..a57655dcce10 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -17,12 +17,19 @@ tests += $(TEST_DIR)/stsi.elf
>>  tests += $(TEST_DIR)/skrf.elf
>>  tests += $(TEST_DIR)/smp.elf
>>  tests += $(TEST_DIR)/sclp.elf
>> -tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>  
>> -all: directories test_cases test_cases_binary
>> +tests_binary = $(patsubst %.elf,%.bin,$(tests))
>> +ifneq ($(HOST_KEY_DOCUMENT),)
>> +tests_pv_img = $(patsubst %.elf,%.pv.img,$(tests))
>> +else
>> +tests_pv_img =
>> +endif
>> +
>> +all: directories test_cases test_cases_binary test_cases_pv
>>  
>>  test_cases: $(tests)
>>  test_cases_binary: $(tests_binary)
>> +test_cases_pv: $(tests_pv_img)
>>  
>>  CFLAGS += -std=gnu99
>>  CFLAGS += -ffreestanding
>> @@ -68,8 +75,11 @@ FLATLIBS = $(libcflat)
>>  %.bin: %.elf
>>  	$(OBJCOPY) -O binary  $< $@
>>  
>> +%.pv.img: %.bin $(HOST_KEY_DOCUMENT)
>> +	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --image $< -o $@
>> +
>>  arch_clean: asm_offsets_clean
>> -	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
>> +	$(RM) $(TEST_DIR)/*.{o,elf,bin,img} $(TEST_DIR)/.*.d lib/s390x/.*.d
>>  
>>  generated-files = $(asm-offsets)
>>  $(tests:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index b307329354f6..6beaca45fb20 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -16,6 +16,8 @@
>>  #			 # a test. The check line can contain multiple files
>>  #			 # to check separated by a space but each check
>>  #			 # parameter needs to be of the form <path>=<value>
>> +# pv_support = 0|1       # Optionally specify whether a test supports the
>> +#                        # execution as a PV guest.
>>  ##############################################################################
>>  
>>  [selftest-setup]
>> @@ -25,62 +27,80 @@ extra_params = -append 'test 123'
>>  
>>  [intercept]
>>  file = intercept.elf
>> +pv_support = 1
> 
> So, let's do this discussion once more:
> Why would we need a opt-in for something which works on all our current
> tests? I'd much rather have a opt-out or just a bail-out when running
> the test like I already implemented for the storage key related tests...
> 
> I don't see any benefit for this right now other than forcing me to add
> another line to this file that was not needed before..
> 

Exactly my thought. I would assume that most tests that properly test
for feature availability should just work?

-- 
Thanks,

David / dhildenb
