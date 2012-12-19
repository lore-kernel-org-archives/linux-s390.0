From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/5] KVM: s390: Add support for machine checks.
Date: Wed, 19 Dec 2012 14:07:57 +0100
Message-ID: <20121219130757.GA5240@osiris.de.ibm.com>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com>
 <1354883425-38531-3-git-send-email-cornelia.huck@de.ibm.com>
 <20121219094414.GA4996@osiris.de.ibm.com>
 <50D194E2.8050102@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50D194E2.8050102@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 19, 2012 at 11:20:18AM +0100, Christian Borntraeger wrote:
> On 19/12/12 10:44, Heiko Carstens wrote:
> > On Fri, Dec 07, 2012 at 01:30:22PM +0100, Cornelia Huck wrote:
> >> +		rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
> >> +		if (rc == -EFAULT)
> >> +			exception = 1;
> >> +
> >> +		rc = copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
> >> +				   &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> >> +		if (rc == -EFAULT)
> >> +			exception = 1;
> > 
> > Please don't add more explicit -EFAULT checks on guest access paths. Just
> > make this like normal user space accesses. That is return code != 0 means
> > an error occured:
> > 
> > 	rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
> > 	if (rc)
> > 		exception = 1;
> > 
> > In fact, with the current kvm gaccess code it's even broken, since on error
> > the guest access functions may return also -ENOMEM instead of -EFAULT, which
> > would be ignored by your code.
> > I addressed that with a patch when trying to clean up the guest access
> > functions. Maybe the patch below should be merged anyway. Christian?
> 
> The whole guest memory access of KVM needs to be reworked to work properly
> in those corner cases. I have this on my todo list as one of things for next
> year with lots of open questions that I dont want to answer before xmas.
> what about in kernel intercepts? (shall we then return EFAULT for the KVM_RUN
> ioctl, shall we kill the guest?.....)
> 
> We actually need to test the address for validity via the memslots (and not
> via return value of copy_from/to_user) all across the s390 code.
> 
> I really want to avoid mixing this effort with the virtio-ccw patches.
> So my proposal is to apply your patch below and keep Conny's patch as is.
> Ok?

Sure. :)
