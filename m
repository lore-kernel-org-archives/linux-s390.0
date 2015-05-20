From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 00/11] KVM: multiple address spaces (for SMM)
Date: Wed, 20 May 2015 10:31:58 +0200
Message-ID: <555C467E.5060106@de.ibm.com>
References: <1431956923-35602-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431956923-35602-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>, rkrcmar@redhat.com, bdas@redhat.com, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 18.05.2015 um 15:48 schrieb Paolo Bonzini:
> This implements Avi's suggestion of having two separate kvm_memslots for
> regular and SMM operation, corresponding to different address spaces.
> 
> All in all, the surgery is limited even though there are a few preparatory
> patches that touch all architectures.
> 
> The amount of added code for the vcpu-specific versions of kvm_read_guest
> and kvm_write_guest is smaller, and duplication is limited to a couple of
> functions.  Even the rmap parts, which scared me a lot when the first
> version OOPSed on me, :) are actually very easy.
> 
> Patches 1-6 are preparatory cleanups that can be applied separately,
> while the others will be posted in v2 of the SMM patches.
> 
> Patches 7-8 add the new functions (this time in virt/kvm/kvm_main.c).
> Architectures can then define a function kvm_arch_vcpu_memslots_id that
> returns the active address space id for a given VCPU.  The address space
> ID must be passed to KVM_SET_USER_MEMORY_REGION and KVM_GET_DIRTY_LOG,
> using the high 16 bits of the slot id.
> 
> Patch 9 then does VCPU-specific accesses in x86, and patch 10 loops
> over the SMM slots as well on memslot iterations.
> 
> Patch 11 then introduces the SMRAM address space, which is very simple
> after all the legwork.
> 
> Thanks for the reviews,


So in essence this allows to have each vcpu in separate address space if
necessary. These address space might overlap or be identical and allow
permutations by having different memslots for each address space.
And we can have several address spaces per vcpu. Correct?

This might be useful for kvm on s390 (e.g. we did the ucontrol thing that
also has one guest address space per vcpu). I need to have a look at that.

Christian
