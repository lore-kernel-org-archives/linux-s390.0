From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL 1/2] KVM: s390/facilities: allow TOD-CLOCK steering
 facility bit
Date: Thu, 2 Oct 2014 10:22:10 +0200
Message-ID: <20141002082210.GB4225@osiris>
References: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
 <1412172170-13472-2-git-send-email-borntraeger@de.ibm.com>
 <542C0CF4.9060401@suse.de>
 <542C479A.30108@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <542C479A.30108@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 01, 2014 at 08:27:38PM +0200, Christian Borntraeger wrote:
> On 10/01/2014 04:17 PM, Alexander Graf wrote:
> > 
> > 
> > On 01.10.14 16:02, Christian Borntraeger wrote:
> >> There is nothing to do for KVM to support TOD-CLOCK steering.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> >> ---
> >>  arch/s390/kvm/kvm-s390.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> >> index 56a411c..0d5aa88 100644
> >> --- a/arch/s390/kvm/kvm-s390.c
> >> +++ b/arch/s390/kvm/kvm-s390.c
> >> @@ -1786,7 +1786,7 @@ static int __init kvm_s390_init(void)
> >>  		return -ENOMEM;
> >>  	}
> >>  	memcpy(vfacilities, S390_lowcore.stfle_fac_list, 16);
> >> -	vfacilities[0] &= 0xff82fff3f4fc2000UL;
> >> +	vfacilities[0] &= 0xff82fffbf47c2000UL;
> > 
> > Can we please convert this into something readable soon? :)
> 
> It will be sooner when you send patches ;-)
> The facility numbers are documented in the POP (chapter 4 last page) in
> IBM notation (bit0 is the MSB)
> It probably makes sense to do this for the non-KVM part as well. When you grep
> for test_facility under arch/s390 there are lots of numerical value.

These numbers _are_ a wart and were the source of a couple of bugs e.g.
in our ALS code already.
However converting these bitfields to something readable doesn't seem
to be easy, since I'd like to have variable size array initializers which
set the bits depening on the symbolic name (e.g. set bits 19, 20 and 139
and automatically choose the correct size of the array):
..something like INIT_FACILITY_ARRAY(FAC19, FAC20, FAC139)

And of course this should work for asm code as well.

> Hmm, maybe we can find somebody that wants to increase the patch counter?

If you think this is trivial, please send a patch which does this.
