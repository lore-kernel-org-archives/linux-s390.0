From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 01/16] KVM: Take vcpu->mutex outside vcpu_load
Date: Mon, 11 Dec 2017 12:51:01 +0100
Message-ID: <20171211125101.662dc8b1.cohuck@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-2-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-2-cdall@kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>
Cc: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  4 Dec 2017 21:35:23 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> As we're about to call vcpu_load() from architecture-specific
> implementations of the KVM vcpu ioctls, but yet we access data
> structures protected by the vcpu->mutex in the generic code, factor
> this logic out from vcpu_load().
> 
> x86 is the only architecture which calls vcpu_load() outside of the main
> vcpu ioctl function, and these calls will no longer take the vcpu mutex
> following this patch.  However, with the exception of
> kvm_arch_vcpu_postcreate (see below), the callers are either in the
> creation or destruction path of the VCPU, which means there cannot be
> any concurrent access to the data structure, because the file descriptor
> is not yet accessible, or is already gone.
> 
> kvm_arch_vcpu_postcreate makes the newly created vcpu potentially
> accessible by other in-kernel threads through the kvm->vcpus array, and
> we therefore take the vcpu mutex in this case directly.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/x86/kvm/vmx.c       |  4 +---
>  arch/x86/kvm/x86.c       | 20 +++++++-------------
>  include/linux/kvm_host.h |  2 +-
>  virt/kvm/kvm_main.c      | 17 ++++++-----------
>  4 files changed, 15 insertions(+), 28 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
