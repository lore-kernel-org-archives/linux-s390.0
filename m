From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Thu, 17 Aug 2017 09:29:51 +0200
Message-ID: <db11c343-d5f7-97cd-47df-ed801bad5947@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816194037.9460-1-rkrcmar@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On 16.08.2017 21:40, Radim Krčmář wrote:
> The goal is to increase KVM_MAX_VCPUS without worrying about memory
> impact of many small guests.
> 
> This is a second out of three major "dynamic" options:
>  1) size vcpu array at VM creation time
>  2) resize vcpu array when new VCPUs are created
>  3) use a lockless list/tree for VCPUs
> 
> The disadvantage of (1) is its requirement on userspace changes and
> limited flexibility because userspace must provide the maximal count on
> start.  The main advantage is that kvm->vcpus will work like it does
> now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
> allow dynamic kvm->vcpus array",
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html
> 
> The main problem of (2), this series, is that we cannot extend the array
> in place and therefore require some kind of protection when moving it.
> RCU seems best, but it makes the code slower and harder to deal with.
> The main advantage is that we do not need userspace changes.
> 
> The third option wasn't explored yet.  It would solve the ugly
> kvm_for_each_vcpu() of (2), but kvm_get_vcpu() would become linear.
> (We could mitigate it by having list of vcpu arrays and A lockless
>  sequentially growing "tree" would be logarithmic and not that much more
>  complicated to implement.)

That sounds interesting but also too complicated.

> 
> Which option do you think is the best?

I actually think the RCU variant doesn't look bad at all. Execution time
should be ok.

As Alex said, doubling the size every time we run out of space could be
done.

I clearly favor a solution that doesn't require user space changes.

-- 

Thanks,

David
