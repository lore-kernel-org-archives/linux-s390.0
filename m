Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 2/4] KVM: selftests: Align memory region addresses to
 1M on s390x
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-3-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d9c383ef-6f4b-4f51-b627-7565a67005d3@redhat.com>
Date: Thu, 16 May 2019 13:30:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 16.05.19 13:12, Thomas Huth wrote:
> On s390x, there is a constraint that memory regions have to be aligned
> to 1M (or running the VM will fail). Introduce a new "alignment" variable
> in the vm_userspace_mem_region_add() function which now can be used for
> both, huge page and s390x alignment requirements.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8d63ccb93e10..64a0da6efe3d 100644
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

This corresponds to huge_page_size, maybe you can exploit this fact here.

Something like

alignment = 1;

/* On s390x, the host address must always be aligned to the THP size */
#ifndef __s390x__
if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
#endif
	alignment = huge_page_size;

Maybe in a nicer fashion. Not sure.

> +#else
> +	alignment = 1;
> +#endif
> +
>  	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -		region->mmap_size += huge_page_size;
> +		alignment = huge_page_size;
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
> 


-- 

Thanks,

David / dhildenb
