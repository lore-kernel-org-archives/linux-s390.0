From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Thu, 17 Aug 2017 16:54:12 +0200
Message-ID: <20170817145411.GE2566@flask>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b77b151f-e51d-3657-66e9-6fbc83887b18@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Christoffer Dall <cdall@linaro.org>, Paul Mackerras <paulus@ozlabs.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

2017-08-17 09:04+0200, Alexander Graf:
> On 16.08.17 21:40, Radim Krčmář  wrote:
> > The goal is to increase KVM_MAX_VCPUS without worrying about memory
> > impact of many small guests.
> > 
> > This is a second out of three major "dynamic" options:
> >   1) size vcpu array at VM creation time
> >   2) resize vcpu array when new VCPUs are created
> >   3) use a lockless list/tree for VCPUs
> > 
> > The disadvantage of (1) is its requirement on userspace changes and
> > limited flexibility because userspace must provide the maximal count on
> > start.  The main advantage is that kvm->vcpus will work like it does
> > now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
> > allow dynamic kvm->vcpus array",
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html
> > 
> > The main problem of (2), this series, is that we cannot extend the array
> > in place and therefore require some kind of protection when moving it.
> > RCU seems best, but it makes the code slower and harder to deal with.
> > The main advantage is that we do not need userspace changes.
> 
> Creating/Destroying vcpus is not something I consider a fast path, so why
> should we optimize for it? The case that needs to be fast is execution.

Right, the creation is not important.  I was concerned about the use of
lock() and unlock() needed for every access -- both in performance and
code, because the common case where hotplug doesn't happen and all VCPUs
are created upfront doesn't even need any runtime protection.

> What if we just sent a "vcpu move" request to all vcpus with the new pointer
> after it moved? That way the vcpu thread itself would be responsible for the
> migration to the new memory region. Only if all vcpus successfully moved,
> keep rolling (and allow foreign get_vcpu again).

I'm not sure if I understood this.  You propose to cache kvm->vcpus in
vcpu->vcpus and do an extensions of this,

  int vcpu_create(...) {
    if (resize_needed(kvm->vcpus)) {
      old_vcpus = kvm->vcpus
      kvm->vcpus = make_bigger(kvm->vcpus)
      kvm_make_all_cpus_request(kvm, KVM_REQ_UPDATE_VCPUS)
      free(old_vcpus)
    }
    vcpu->vcpus = kvm->vcpus
  }

with added extra locking, (S)RCU, on accesses that do not come from
VCPUs (irqfd and VM ioctl)?

> That way we should be basically lock-less and scale well. For additional
> icing, feel free to increase the vcpu array x2 every time it grows to not
> run into the slow path too often.

Yeah, I skipped the growing as it was not necessary for the
illustration.
