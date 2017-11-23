From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 19:16:32 +0100
Message-ID: <acf7f751-d73d-8e16-fe9b-2f1f0e1f5e8d@redhat.com>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
 <20171123174804.GB28855@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171123174804.GB28855@cbox>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 23/11/2017 18:48, Christoffer Dall wrote:
>>> That doesn't solve my need as I want to *only* do the arch vcpu_load for
>>> KVM_RUN, I should have been more clear in the commit message.
>>
>> That's what you want to do, but it might not be what you need to do.
> 
> Well, why would we want to do a lot of work when there's absolutely no
> need to?
> 
> I see that this patch is invasive, and that's why I originally proposed
> the other approach of recording the ioctl number.

Because we need to balance performance and maintainability.  The
following observation is the important one:

> While it may be possible to call kvm_arch_vcpu_load() for a number of
> non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
> about, especially after my optimization series, because a lot of things
> can now happen, where we have to consider if we're really in the process
> of running a vcpu or not.

... because outside ARM I couldn't see any maintainability drawback.
Now I understand (or at least, I understand enough to believe you!).

The idea of this patch then is okay, but:

* x86 can use __vcpu_load/__vcpu_put, because the calls outside the lock
are all in the destruction path where no one can concurrently take the
lock.  So the lock+load and put+unlock variants are not necessary.

* Just make a huge series that, one ioctl at a time, pushes down the
load/put to the arch-specific functions.  No need to figure out where
it's actually needed, or at least you can leave it to the architecture
maintainers.

Thanks,

Paolo
