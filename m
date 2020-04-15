Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
 <875ze2ywhy.fsf@vitty.brq.redhat.com>
 <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
 <87a73dxgk6.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e122372-249d-3d93-99ed-a670fff33936@redhat.com>
Date: Wed, 15 Apr 2020 16:53:28 +0200
MIME-Version: 1.0
In-Reply-To: <87a73dxgk6.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com

On 15/04/20 11:07, Vitaly Kuznetsov wrote:
> In case this is no longer needed I'd suggest we drop 'kvm_run' parameter
> and extract it from 'struct kvm_vcpu' when needed. This looks like a
> natural add-on to your cleanup patch.

I agree, though I think it should be _instead_ of Tianjia's patch rather
than on top.

Paolo
