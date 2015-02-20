From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 10/15] cpu-model/s390: Add cpu class
 initialization routines
Date: Fri, 20 Feb 2015 17:12:49 +0100
Message-ID: <20150220171249.210a0236@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
	<54E75AA2.9070503@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <54E75AA2.9070503@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: linux-s390@vger.kernel.org, frank.blaschka@de.ibm.com, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 08:02:42 -0800
Richard Henderson <rth@twiddle.net> wrote:

> > +/**
> > + * s390_test_facility - test if given facility bit is set facility list
> > + *                      of given cpu class
> > + * @class: address of cpu class to test
> > + * @nr: bit number to test
> > + *
> > + * Returns: true in case it is set
> > + *          false in case it is not set
> > + */
> > +bool s390_test_facility(S390CPUClass *cc, unsigned long nr)
> > +{
> > +    if (cc) {
> > +        return test_facility(nr, cc->fac_list) ? true : false;
> > +    }
> > +    return false;
> > +}  
> 
> Where do you see this being used?

Good spot, it's not being used yet. It's planned to be used with a patch that implements zPCI
related instructions on QEMU side. Maybe you have seen the discussion from Frank Blaschka in this
e-mail list in regard to that.

Michael
