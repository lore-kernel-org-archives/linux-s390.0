From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [GIT PULL 1/6] KVM: s390: Handle MVPG partial execution
 interception
Date: Wed, 30 Apr 2014 10:53:39 +0200
Message-ID: <20140430105339.08d19b18@oc7435384737.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
	<1398778608-3887-2-git-send-email-borntraeger@de.ibm.com>
	<20140430080709.GA7723@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140430080709.GA7723@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Apr 2014 10:07:09 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Tue, Apr 29, 2014 at 03:36:43PM +0200, Christian Borntraeger wrote:
> > +static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
> > +{
> > +	unsigned long hostaddr, srcaddr, dstaddr;
> > +	psw_t *psw = &vcpu->arch.sie_block->gpsw;
> > +	struct mm_struct *mm = current->mm;
> > +	int reg1, reg2, rc;
> > +
> > +	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
> > +	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
> > +	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
> > +
> > +	/* Make sure that the source is paged-in */
> > +	hostaddr = gmap_fault(srcaddr, vcpu->arch.gmap);
> > +	if (IS_ERR_VALUE(hostaddr))
> > +		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> 
> FWIW (and nothing that should keep this code from going upstream),
> this is not entirely correct, since gmap_fault() may return -ENOMEM.
> So a host out-of-memory situation will incorrectly result in a guest
> addressing exception, which is most likely not what we want.

Ah, ... good point, thanks for the hint! (BTW: That's why I personally
prefer some more comments in the source code - by just looking at
gmap_fault() and __gmap_fault(), this is quite hard to see unless you
step through these functions and called functions line by line).

Anyway, I'll assemble a follow-up patch that addresses this
problem with handle_mvpg_pei().

 Thomas
