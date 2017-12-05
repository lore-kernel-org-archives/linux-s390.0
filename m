From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 01/16] KVM: Take vcpu->mutex outside vcpu_load
Date: Tue, 5 Dec 2017 15:32:30 +0100
Message-ID: <241fe130-bc3f-533e-4bef-604b04b9818d@de.ibm.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-2-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-2-cdall@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


On 12/04/2017 09:35 PM, Christoffer Dall wrote:
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

Looks good to me.
