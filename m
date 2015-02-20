From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/15] cpu-model/s390: Introduce
 S390 CPU models
Date: Fri, 20 Feb 2015 20:43:03 +0100
Message-ID: <20150220204303.4f20f54e@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-5-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73C8F.7000202@suse.de>
	<20150220160046.4743acc8@bee>
	<89E3550E-9E2B-4D95-A809-B7C64EBCD7C5@suse.de>
	<20150220164944.4eb4eeb3@bee>
	<54E76790.1030700@suse.de>
	<20150220183748.45b32e11@bee>
	<2049D8E0-FE03-4E84-94D0-E23B695BC865@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2049D8E0-FE03-4E84-94D0-E23B695BC865@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 18:50:20 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> 
> 
> > Am 20.02.2015 um 18:37 schrieb Michael Mueller <mimu@linux.vnet.ibm.com>:
> > 
> > On Fri, 20 Feb 2015 17:57:52 +0100
> > Alexander Graf <agraf@suse.de> wrote:
> > 
> >> Because all CPUs we have in our list only expose 128 bits?
> > 
> > Here a STFLE result on a EC12 GA2, already more than 128 bits... Is that model on the list?
> 
> If that model has 3 elements, yes, the array should span 3.
> 
> I hope it's in the list. Every model wecare about should be, no?
> 

On my list? Yes!

> > 
> > [mimu@p57lp59 s390xfac]$ ./s390xfac -b
> > fac[0] = 0xfbfffffbfcfff840
> > fac[1] = 0xffde000000000000
> > fac[2] = 0x1800000000000000
> >> 
> >>> I want to have this independent from a future machine of the z/Arch. The kernel stores the
> >>> full facility set, KVM does and there is no good reason for QEMU not to do. If other
> >>> accelerators decide to just implement 64 or 128 bits of facilities that's ok...  
> >> 
> >> So you want to support CPUs that are not part of the list?
> > 
> > The architecture at least defines more than 2 or 3. Do you want me to limit it to an arbitrary
> > size?. Only in QEMU or also in the KVM interface?
> 
> Only internally in QEMU. The kvm interface should definitely be as big as the spec allows!

Right, now we're on the same page again. That can be taken in consideration. ... Although it's
just and optimization. :-)

Michael

> 
> Alex
> 
> > 
> > Thanks
> > Michael
> > 
> 
