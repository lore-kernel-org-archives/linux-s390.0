From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] KVM: Only register preempt notifiers and load arch
 cpu state as needed
Date: Thu, 23 Nov 2017 18:12:41 +0100
Message-ID: <62ae4eb1-fd57-c525-cd73-e3f646d340e1@redhat.com>
References: <20171123160521.27260-1-christoffer.dall@linaro.org>
 <72357599-798d-14d0-336a-69a083f17863@redhat.com>
 <20171123170642.GA28855@cbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171123170642.GA28855@cbox>
Content-Language: en-US
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@linaro.org>
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, Alexander Graf <agraf@suse.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

On 23/11/2017 18:06, Christoffer Dall wrote:
> On Thu, Nov 23, 2017 at 05:17:00PM +0100, Paolo Bonzini wrote:
>> On 23/11/2017 17:05, Christoffer Dall wrote:
>>> For example,
>>> arm64 is about to do significant work in vcpu load/put when running a
>>> vcpu, but not when doing things like KVM_SET_ONE_REG or
>>> KVM_SET_MP_STATE.
>>
>> Out of curiosity, in what circumstances are these ioctls a hot path?
>> Especially KVM_SET_MP_STATE.
> 
> Perhaps my commit message was misleading; we only want to do that for
> KVM_RUN, and not for anything else.  We're already doing things like
> potentially jumping to hyp mode and flushing VMIDs which really
> shouldn't be done unless we actually plan on running a VCPU, and we're
> going to do things like setting up the timer to handle timer interrupts
> in an ISR, which doesn't make sense unless the VCPU is running.
> 
> Add to that, that loading an entire VM's state onto hardware, only to
> read back a single register from hardware and returning it to user
> space, doesn't really fall within optimization vs. non-optimization in
> the critical path, but is just wrong, IMHO.

For GET/SET_ONE_REG it certainly makes sense.  For everything else, I'm
wondering which ioctls (and how many calls to each of them) exactly you
are seeing, and also on which userspace paths.

> That doesn't solve my need as I want to *only* do the arch vcpu_load for
> KVM_RUN, I should have been more clear in the commit message.

That's what you want to do, but it might not be what you need to do.

Paolo
