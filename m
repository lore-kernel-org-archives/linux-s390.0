From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 10:00:03 +0000
Subject: Re: [kvm-unit-tests PATCH v5 09/11] s390x: Add binary generation to makefile
Message-Id: <7324b362-9a41-000b-8c01-2caf8200d43c@redhat.com>
In-Reply-To: <20190110154151.24233-10-frankja@linux.ibm.com>
References: <20190110154151.24233-10-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-10 16:41, Janosch Frank wrote:
> make bin will now generate binaries that can be booted from disk or as
> a non ELF kernel boot.

s/make bin/make test_cases_binary/ ?

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  s390x/Makefile | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ede2961..dbef7a0 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -10,10 +10,12 @@ tests += $(TEST_DIR)/cmm.elf
>  tests += $(TEST_DIR)/vector.elf
>  tests += $(TEST_DIR)/gs.elf
>  tests += $(TEST_DIR)/iep.elf
> +tests_binary = $(patsubst %.elf,%.bin,$(tests))
>  
> -all: directories test_cases
> +all: directories test_cases test_cases_binary
>  
>  test_cases: $(tests)
> +test_cases_binary: $(tests_binary)
>  
>  CFLAGS += -std=gnu99
>  CFLAGS += -ffreestanding
> @@ -55,8 +57,11 @@ FLATLIBS = $(libcflat)
>  	$(RM) $(@:.elf=.aux.o)
>  	@chmod a-x $@
>  
> +%.bin: %.elf
> +	$(OBJCOPY) -O binary  $< $@
> +
>  arch_clean: asm_offsets_clean
> -	$(RM) $(TEST_DIR)/*.{o,elf} $(TEST_DIR)/.*.d lib/s390x/.*.d
> +	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
>  
>  generated-files = $(asm-offsets)
>  $(tests:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
