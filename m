From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 2/7] s390/kvm: Add support for machine
	checks.
Date: Wed, 5 Sep 2012 10:39:09 +0200
Message-ID: <20120905103909.736bb607@BR9GNB5Z>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771610-52423-3-git-send-email-cornelia.huck@de.ibm.com>
	<20120905072232.GA5852@osiris.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20120905072232.GA5852@osiris.de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 5 Sep 2012 09:22:32 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Tue, Sep 04, 2012 at 05:13:25PM +0200, Cornelia Huck wrote:
> 
> Just some quick comments:
> 
> [...]
> 
> >  int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
> >  {
> >  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
> > @@ -648,6 +747,12 @@ int kvm_s390_inject_vm(struct kvm *kvm,
> >  	case KVM_S390_INT_EMERGENCY:
> >  		kfree(inti);
> >  		return -EINVAL;
> > +	case KVM_S390_MCHK:
> > +		VM_EVENT(kvm, 5, "inject: machine check parm64:%llx",
> > +			 s390int->parm64);
> > +		inti->type = s390int->type;
> > +		inti->mchk.mcic = s390int->parm64;
> > +		break;
> 
> The kvm_s390_interrupt struct seems to be inappropriate to pass machine check
> data around.
> E.g. if you want to inject an uncorrectable storage error, because the host
> failed to swap in a page, you must also pass a failing storage address which
> doesn't fit into this structure.
> Just something you should consider. ;)

Sigh, it seems we might want a KVM_S390_INTERRUPT2 taking a larger and
more complex structure later on...

kvm_s390_interrupt should be fine for our current needs, though,
expecially as machine checks are currently only injected in-kernel.

> 
> > +static int handle_lpswe(struct kvm_vcpu *vcpu)
> > +{
> > +	int base2 = vcpu->arch.sie_block->ipb >> 28;
> > +	int disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16);
> 
> Sooner or later we need helper functions which extract the significant parts
> of an instruction.
> Maybay something like insn_[type]_get_base2(...) or simply structures like
> struct insn_[type], which allow to easily access parts of an instruction.

Agree on helper functions, not sure about the use of structures for
that. Let's see how it looks coded up.

> 
> > +	u64 addr;
> > +	u64 new_psw[2];
> 
> psw_t?
> 
> > +
> > +	addr = disp2;
> > +	if (base2)
> > +		addr += vcpu->run->s.regs.gprs[base2];
> > +	
> > +	if (addr & 7) {
> > +		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> > +		goto out;
> > +	}
> > +
> > +	if (copy_from_guest(vcpu, new_psw, addr, sizeof(*new_psw))) {
> 
> I assume that should be sizeof(new_psw). Did that ever work?!

No, because the code was never hit since the code for ICTL was
incorrect... The guest kernel just does a good job at keeping machine
checks open nearly all of the time :)

> 
> > +	if ((vcpu->arch.sie_block->gpsw.mask & 0xb80800fe7fffffff) ||
> > +	    (((vcpu->arch.sie_block->gpsw.mask & 0x0000000110000000) ==
> > +	      0x0000000010000000) &&
> > +	     (vcpu->arch.sie_block->gpsw.addr & 0xffffffff80000000)) ||
> > +	    (!(vcpu->arch.sie_block->gpsw.mask & 0x0000000180000000) &&
> > +	     (vcpu->arch.sie_block->gpsw.addr & 0xfffffffffff00000)) ||
> > +	    ((vcpu->arch.sie_block->gpsw.mask & 0x0000000110000000) ==
> > +	     0x0000000100000000)) {
> 
> This is not very readable...

It's straight from the PoP's discussion of invalid bits.

> 
> Please make use of the PSW defines in ptrace.h and add new ones if needed.
> Also please make use of (move) the PSW32 defines in compat.h.

I'll check these.
