From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
Date: Mon, 11 Dec 2017 13:15:55 +0100
Message-ID: <20171211131555.7eae512e.cohuck@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-8-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-8-cdall@kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>
Cc: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  4 Dec 2017 21:35:29 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_sregs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/powerpc/kvm/book3s.c |  8 +++++++-
>  arch/powerpc/kvm/booke.c  | 15 +++++++++++----
>  arch/s390/kvm/kvm-s390.c  |  4 ++++
>  arch/x86/kvm/x86.c        | 13 ++++++++++---
>  virt/kvm/kvm_main.c       |  2 --
>  5 files changed, 32 insertions(+), 10 deletions(-)

With David's suggestions included:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
