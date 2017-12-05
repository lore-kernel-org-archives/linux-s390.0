From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 03/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_run
Date: Tue, 5 Dec 2017 15:39:19 +0100
Message-ID: <fd7436c1-2c88-5056-a822-b630f1e4ae94@de.ibm.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-4-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-4-cdall@kernel.org>
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
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_run().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com> # s390 parts

> ---
