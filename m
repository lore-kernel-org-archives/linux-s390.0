From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Fri, 18 Aug 2017 16:10:31 +0200
Message-ID: <20170818141028.GG2566@flask>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
 <20170817145411.GE2566@flask>
 <edb9403f-3a94-605d-5f06-9bc81ca4d2c3@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <edb9403f-3a94-605d-5f06-9bc81ca4d2c3@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Christoffer Dall <cdall@linaro.org>, Paul Mackerras <paulus@ozlabs.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

2017-08-17 21:17+0200, Alexander Graf:
> On 17.08.17 16:54, Radim Krčmář wrote:
> > 2017-08-17 09:04+0200, Alexander Graf:
> > > What if we just sent a "vcpu move" request to all vcpus with the new pointer
> > > after it moved? That way the vcpu thread itself would be responsible for the
> > > migration to the new memory region. Only if all vcpus successfully moved,
> > > keep rolling (and allow foreign get_vcpu again).
> > 
> > I'm not sure if I understood this.  You propose to cache kvm->vcpus in
> > vcpu->vcpus and do an extensions of this,
> > 
> >    int vcpu_create(...) {
> >      if (resize_needed(kvm->vcpus)) {
> >        old_vcpus = kvm->vcpus
> >        kvm->vcpus = make_bigger(kvm->vcpus)
> 
> if (kvm->vcpus != old_vcpus) :)
> 
> >        kvm_make_all_cpus_request(kvm, KVM_REQ_UPDATE_VCPUS)
> 
> IIRC you'd need some manual bookkeeping to ensure that all users have
> switched to the new array. Or set the KVM_REQUEST_WAIT flag :).

Absolutely.  I was thinking about synchronous execution, which might
need extra work to expedite halted VCPUs.  Letting the last user free it
is plausible and would need more protection against races.

> >        free(old_vcpus)
> >      }
> >      vcpu->vcpus = kvm->vcpus
> >    }
> > 
> > with added extra locking, (S)RCU, on accesses that do not come from
> > VCPUs (irqfd and VM ioctl)?
> 
> Well, in an ideal world we wouldn't have any users to vcpu structs outside
> of the vcpus obviously. Every time we do, we should either reconsider
> whether the design is smart and if we think it is, protect them accordingly.

And there would be no linear access to all VCPUs. :)

The main user of kvm->vcpus is kvm_for_each_vcpu(), which is well suited
for a list, so we can change the design of kvm_for_each_vcpu() to use a
list head in struct kvm_vcpu with head/tail in struct kvm.
(The list is trivial to make lockless as we only append.)

This would allow more flexibility with the remaining uses.

> Maybe even hard code separate request mechanisms for the few cases where
> it's reasonable?

All non-kvm_for_each_vcpu() seem to need accesss outside of VCPU scope.

We have few awkward accesses that can be handled keeping track of kvm
state and all remaining uses need some kind of "int -> struct kvm_vcpu"
mapping, where the integer is arbitrary.

All users of kvm_get_vcpu_by_id() need a vcpu_id mapping, but hijack
kvm->vcpus for O(1) access if lucky, with fallback to
kvm_for_each_vcpu().  Adding a vcpu_id mapping seems reasonable.

s390 __floating_irq_kick() and x86 kvm_irq_delivery_to_apic() are
keeping a bitmap for kvm->vcpus indices.  They want compact indices,
which cannot be provided by vcpu_id mapping.

I think that MIPS and ARM use the index in kvm->vcpus for userspace
communication, which looks dangerous as userspace shouldn't know the
position.  Not much we can do because of that.

> > > That way we should be basically lock-less and scale well. For additional
> > > icing, feel free to increase the vcpu array x2 every time it grows to not
> > > run into the slow path too often.
> > 
> > Yeah, I skipped the growing as it was not necessary for the
> > illustration.
> 
> Sure.
> 
> I'm also not fully advocating my solution here, but wanted to make sure we
> have it on the radar. I *think* this option has the least runtime overhead
> and best readability score, as it sticks to the same frameworks we already
> have and use throughout the code base ;).
> 
> That said, I'd love to get proven wrong.

Unless I missed some uses, the linked list for kvm_for_each_vcpu() and a
use-case specific protection for the rest looks better ... kvm->vcpus is
terribly overloaded.
