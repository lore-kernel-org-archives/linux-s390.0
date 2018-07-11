From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 11 Jul 2018 08:14:46 +0000
Subject: Re: [PATCH v5 0/2] KVM: s390: fix storage attributes migration
Message-Id: <bf9b0c21-737e-4f9d-3d2a-66a527b680ed@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Thanks, both Tested and applied.

On 04/30/2018 06:33 PM, Claudio Imbrenda wrote:
> This patchset fixes the migration of storage attributes.
> 
> Each memory slot has a bitmap, with 2 bits per page, used to keep track
> of dirty pages during migration. We only use one bit, the other would be
> wasted. With this patch, the second bit is now used to keep track of
> dirty storage attributes. This means that we do not need anymore to
> allocate and manage the additional bitmap, and no extra work is needed
> to keep track of memory slots. The code does get a little bit more
> complicated when accounting for the memory slots, but overall it should
> be more robust.
> 
> The first patch simply introduces two auxiliary functions, while the
> second patch does the actual job.
> 
> v4 -> v5
> * rebased on v4.17-rc3
> 
> v3 -> v4 
> * move gfn_to_memslot_approx to the second patch
> * rename kvm_shadow_dirty_bitmap to kvm_second_dirty_bitmap
> * removed useless (un)likely()
> * fixed and improved some comments
> * replaced break with return in kvm_s390_get_cmma
> * pass *slots instead of *kvm in a few functions
> 
> v2 -> v3
> * rebased on master
> * fix comment for gfn_to_memslot_approx
> * cmma_bitmap renamed to kvm_shadow_dirty_bitmap and easier to read
> * kvm->arch.migration_mode is not atomic any longer
> * renamed some local variables for more consistency
> 
> v1 -> v2
> * renamed _cmma_bitmap to cmma_bitmap and moved it to kvm-s390.h
> * renamed and/or removed some variables to improve readability
> * added some comments inline
> * simplified the code flow to improve readability
> 
> Claudio Imbrenda (2):
>   KVM: s390: a utility function for migration
>   KVM: s390: Fix storage attributes migration with memory slots
> 
>  arch/s390/include/asm/kvm_host.h |   9 +-
>  arch/s390/kvm/kvm-s390.c         | 293 +++++++++++++++++++++++----------------
>  arch/s390/kvm/priv.c             |  28 ++--
>  include/linux/kvm_host.h         |   7 +
>  virt/kvm/kvm_main.c              |   2 +-
>  5 files changed, 203 insertions(+), 136 deletions(-)
> 
