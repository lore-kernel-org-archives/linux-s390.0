From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 18:48:04 +0100
Message-ID: <20171123174804.GB28855@cbox>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
 <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 23, 2017 at 06:12:41PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 18:06, Christoffer Dall wrote:
> > On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
> >> On 23/11/2017 17:05, Christoffer Dall wrote:
> >>> For example,
> >>> arm64 is about to do significant work in vcpu load/put when running a
> >>> vcpu, but not when doing things like KVM_SET_ONE_REG or
> >>> KVM_SET_MP_STATE.
> >>
> >> Out of curiosity, in what circumstances are these ioctls a hot path?
> >> Especially KVM_SET_MP_STATE.
> > 
> > Perhaps my commit message was misleading; we only want to do that for
> > KVM_RUN, and not for anything else.  We're already doing things like
> > potentially jumping to hyp mode and flushing VMIDs which really
> > shouldn't be done unless we actually plan on running a VCPU, and we're
> > going to do things like setting up the timer to handle timer interrupts
> > in an ISR, which doesn't make sense unless the VCPU is running.
> > 
> > Add to that, that loading an entire VM's state onto hardware, only to
> > read back a single register from hardware and returning it to user
> > space, doesn't really fall within optimization vs. non-optimization in
> > the critical path, but is just wrong, IMHO.
> 
> For GET/SET_ONE_REG it certainly makes sense.  For everything else, I'm
> wondering which ioctls (and how many calls to each of them) exactly you
> are seeing, and also on which userspace paths.
> 

Outside of migration, not many.  It's not about optimizing certain
ioctl's, but rather that I think it's wrong and potentially vulnerable
to do significant work on the system which is strictly unnecessary.

> > That doesn't solve my need as I want to *only* do the arch vcpu_load for
> > KVM_RUN, I should have been more clear in the commit message.
> 
> That's what you want to do, but it might not be what you need to do.
> 

Well, why would we want to do a lot of work when there's absolutely no
need to?

I see that this patch is invasive, and that's why I originally proposed
the other approach of recording the ioctl number.

While it may be possible to call kvm_arch_vcpu_load() for a number of
non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult to reason
about, especially after my optimization series, because a lot of things
can now happen, where we have to consider if we're really in the process
of running a vcpu or not.

Thanks,
-Christoffer
