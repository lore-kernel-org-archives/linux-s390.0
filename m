From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Mon, 24 Oct 2016 16:39:39 +0200
Message-ID: <c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161019172403.GA9240@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019172403.GA9240@potion>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 19/10/2016 19:24, Radim Krčmář wrote:
>> > +	if (vcpu->arch.st.msr_val & KVM_MSR_ENABLED)
>> > +		if (kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
>> > +					&vcpu->arch.st.steal,
>> > +					sizeof(struct kvm_steal_time)) == 0) {
>> > +			vcpu->arch.st.steal.preempted = 1;
>> > +			kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
>> > +					&vcpu->arch.st.steal,
>> > +					sizeof(struct kvm_steal_time));
>> > +		}
> Please name this block of code.  Something like
>   kvm_steal_time_set_preempted(vcpu);

While at it:

1) the kvm_read_guest_cached is not necessary.  You can rig the call to
kvm_write_guest_cached so that it only writes vcpu->arch.st.steal.preempted.

2) split the patch in host and guest sides.

Paolo
