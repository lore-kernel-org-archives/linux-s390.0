From: Christoffer Dall <cdall@linaro.org>
Subject: Re: [PATCH 01/15] KVM: Prepare for moving vcpu_load/vcpu_put into
 arch specific code
Date: Mon, 27 Nov 2017 20:58:30 +0100
Message-ID: <20171127195830.GB16941@cbox>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
 <20171125205718.7731-2-christoffer.dall@linaro.org>
 <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <838db374-6040-c805-82f3-187a2cdfc40d@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 27, 2017 at 05:53:01PM +0100, Paolo Bonzini wrote:
> On 25/11/2017 21:57, Christoffer Dall wrote:
> > In preparation for moving calls to vcpu_load() and vcpu_put() into the
> > architecture specific implementations of the KVM vcpu ioctls, move the
> > calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> > of the ioctl select statement.  This allows us to move the vcpu_load()
> > and vcpu_put() calls into architecture specific implementations of vcpu
> > ioctls, one by one.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  virt/kvm/kvm_main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 48 insertions(+), 5 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 9deb5a245b83..fafafcc38b5a 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2528,16 +2528,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >  		return kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> >  #endif
> >  
> > -
> > -	r = vcpu_load(vcpu);
> > -	if (r)
> > -		return r;
> >  	switch (ioctl) {
> >  	case KVM_RUN: {
> >  		struct pid *oldpid;
> >  		r = -EINVAL;
> >  		if (arg)
> >  			goto out;
> > +		r = vcpu_load(vcpu);
> > +		if (r)
> > +			goto out;
> >  		oldpid = rcu_access_pointer(vcpu->pid);
> 
> If it is not a problem for ARM, maybe it would actually be best to leave
> the locking in kvm_vcpu_ioctl (with the already existing exception of
> KVM_INTERRUPT).  This would make vcpu_load void, and would also let you
> keep the PID adjustment in common code.  This would be more similar to
> the previous version, but without introducing __vcpu_load/__vcpu_put.

Yes, that's not a problem for ARM, and it was actually what I started
out with, and you can see the result here (rebased on v4.15-rc1):

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put-keeplock

I got a bit into getting rid of the (IMHO) ugly ifdef-shortcut
dispatcher code, and thus reworked it to the submitted version.

Going back and looking, it's nicer to avoid the pid adjustment call, and
having vcpu_load be void is also convenient, but we're stuck with the
ifdef.  I guess I lean towards your suggestion as well, given that my
problem with the ifdef is not a technical one, but an aesthetic one.

> 
> Looks good apart from this doubt!  Thanks,
> 
Let me know if you want to have a quick glance at the branch above and
prefer that I send that as v2.

Thanks,
-Christoffer
