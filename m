From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
Date: Tue, 12 Dec 2017 17:47:21 +0100
Message-ID: <0a6052a0-29d3-5a5e-b0c2-1d99804bcba4@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-15-cdall@kernel.org>
 <20171211141241.2129a84c.cohuck@redhat.com> <20171211152226.GJ910@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171211152226.GJ910@cbox>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <christoffer.dall@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Christoffer Dall <cdall@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/12/2017 16:22, Christoffer Dall wrote:
> I find the special casing with the immediate return a bit ugly. Maybe
> introduce a helper async_vcpu_ioctl() or so that sets -ENOIOCTLCMD in
> its default case and return here if ret != -ENOIOCTLCMD? Christian,
> what do you think?

I'll post my attempt at it shortly.

Thanks,

Paolo
