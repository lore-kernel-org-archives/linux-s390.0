From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/5] KVM: s390: In-kernel handling of I/O instructions.
Date: Mon, 10 Dec 2012 11:14:41 +0100
Message-ID: <20121210111441.6161e0d6@BR9GNB5Z>
References: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354883425-38531-4-git-send-email-cornelia.huck@de.ibm.com>
	<C6462FA2-A67D-4BCE-992E-1075D462CB4B@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <C6462FA2-A67D-4BCE-992E-1075D462CB4B@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 10 Dec 2012 08:53:41 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 07.12.2012, at 13:30, Cornelia Huck wrote:
> 
> > Explicitely catch all channel I/O related instructions intercepts
> > in the kernel and set condition code 3 for them.
> > 
> > This paves the way for properly handling these instructions later
> > on.
> > 
> > Note: This is not architecture compliant (the previous code wasn't
> > either) since setting cc 3 is not the correct thing to do for some
> > of these instructions. For Linux guests, however, it still has the
> > intended effect of stopping css probing.
> > 
> > Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > arch/s390/kvm/intercept.c | 19 +++++++++++++---
> > arch/s390/kvm/kvm-s390.h  |  1 +
> > arch/s390/kvm/priv.c      | 56 +++++++++++++++++++++++++++++++++--------------
> > 3 files changed, 56 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> > index ec1177f..754dc9e 100644
> > --- a/arch/s390/kvm/intercept.c
> > +++ b/arch/s390/kvm/intercept.c
> > @@ -33,8 +33,6 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
> > 	int reg, rc;
> > 
> > 	vcpu->stat.instruction_lctlg++;
> > -	if ((vcpu->arch.sie_block->ipb & 0xff) != 0x2f)
> > -		return -EOPNOTSUPP;
> > 
> > 	useraddr = disp2;
> > 	if (base2)
> > @@ -104,6 +102,21 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
> > 	return 0;
> > }
> > 
> > +static intercept_handler_t eb_handlers[256] = {
> 
> const.
> 
> Reviewed-by: Alexander Graf <agraf@suse.de>

Thanks.

> 
> 
> Alex
> 
