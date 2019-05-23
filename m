Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 23 May 2019 19:40:28 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 5/9] KVM: selftests: Align memory region addresses to 1M
 on s390x
Message-ID: <20190523174028.3giefzff3l5eclki@kamzik.brq.redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523164309.13345-6-thuth@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 23, 2019 at 06:43:05PM +0200, Thomas Huth wrote:
> On s390x, there is a constraint that memory regions have to be aligned
> to 1M (or running the VM will fail). Introduce a new "alignment" variable
> in the vm_userspace_mem_region_add() function which now can be used for
> both, huge page and s390x alignment requirements.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 08edb8436c47..656df9d5cd4d 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -559,6 +559,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  	unsigned long pmem_size = 0;
>  	struct userspace_mem_region *region;
>  	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
> +	size_t alignment;
>  
>  	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
>  		"address not on a page boundary.\n"
> @@ -608,9 +609,20 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  	TEST_ASSERT(region != NULL, "Insufficient Memory");
>  	region->mmap_size = npages * vm->page_size;
>  
> -	/* Enough memory to align up to a huge page. */
> +#ifdef __s390x__
> +	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
> +	alignment = 0x100000;
> +#else
> +	alignment = 1;
> +#endif
> +
>  	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -		region->mmap_size += huge_page_size;
> +		alignment = huge_page_size;

I guess s390x won't ever support VM_MEM_SRC_ANONYMOUS_THP? If it does,
then we need 'alignment = max(huge_page_size, alignment)'. Actually
that might be a nice way to write this anyway for future-proofing.

> +
> +	/* Add enough memory to align up if necessary */
> +	if (alignment > 1)
> +		region->mmap_size += alignment;
> +
>  	region->mmap_start = mmap(NULL, region->mmap_size,
>  				  PROT_READ | PROT_WRITE,
>  				  MAP_PRIVATE | MAP_ANONYMOUS
> @@ -620,9 +632,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  		    "test_malloc failed, mmap_start: %p errno: %i",
>  		    region->mmap_start, errno);
>  
> -	/* Align THP allocation up to start of a huge page. */
> -	region->host_mem = align(region->mmap_start,
> -				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
> +	/* Align host address */
> +	region->host_mem = align(region->mmap_start, alignment);
>  
>  	/* As needed perform madvise */
>  	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> -- 
> 2.21.0
> 
