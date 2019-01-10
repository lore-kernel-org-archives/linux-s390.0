From: David Hildenbrand <david@redhat.com>
Date: Thu, 10 Jan 2019 12:13:53 +0000
Subject: Re: [kvm-unit-tests PATCH v4 09/13] s390x: Add binary generation to makefile
Message-Id: <63633355-278a-022c-f7a0-a5782ab86888@redhat.com>
In-Reply-To: <78583bcd-ce90-89be-2328-524c8cdf75d3@linux.ibm.com>
References: <78583bcd-ce90-89be-2328-524c8cdf75d3@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03.01.19 14:12, Thomas Huth wrote:
> On 2019-01-03 11:08, Janosch Frank wrote:
>> make bin will now generate binaries that can be booted from disk or as
>> a non ELF kernel boot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index ede2961..82c4f15 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -10,10 +10,12 @@ tests += $(TEST_DIR)/cmm.elf
>>  tests += $(TEST_DIR)/vector.elf
>>  tests += $(TEST_DIR)/gs.elf
>>  tests += $(TEST_DIR)/iep.elf
>> +tests_binary = $(patsubst %.elf,%.bin,$(tests))
>>  
>> -all: directories test_cases
>> +all: directories test_cases test_cases_binary
>>  
>>  test_cases: $(tests)
>> +test_cases_binary: $(tests_binary)
>>  
>>  CFLAGS += -std=gnu99
>>  CFLAGS += -ffreestanding
>> @@ -55,8 +57,11 @@ FLATLIBS = $(libcflat)
>>  	$(RM) $(@:.elf=.aux.o)
>>  	@chmod a-x $@
>>  
>> +%.bin: %.elf
>> +	objcopy -O binary  $< $@
> 
> Please use $(OBJCOPY) instead, otherwise this won't work when
> cross-compiling.
> 
>  Thomas
> 

With that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
