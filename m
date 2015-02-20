From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 20:29:19 +0100
Message-ID: <20150220202919.29cc7b32@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73EB2.6050700@suse.de>
	<20150220163209.4e082e0b@bee>
	<54E76823.9000106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E76823.9000106@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 18:00:19 +0100
Alexander Graf <agraf@suse.de> wrote:

> > So above s390_set/get_processor_props() the code is accelerator independent.  
> 
> Any particular reason you can't do it like PPC?

That seems to be a short question... and when I started one year ago, I oriented myself on
the PPC version and I'm also willing to revisit it but I can't give you a quick answer different
from no currently to that.

There are no PVRs for s390x CPUs and thus I came up with "pseudo PVRs":

/*
 * bits 0-7   : CMOS generation
 * bits 8-9   : reserved
 * bits 10-11 : machine class 0=unknown 1=EC 2=BC
 * bits 12-15 : GA
 * bits 16-31 : machine type
 *
 * note: bits are named according to s390
 *       architecture specific endienness
 */
enum {
    CPU_S390_2064_GA1 = 0x07112064,
    CPU_S390_2064_GA2 = 0x07122064,
    CPU_S390_2064_GA3 = 0x07132064,
    CPU_S390_2066_GA1 = 0x07212066,
    CPU_S390_2084_GA1 = 0x08112084,
    CPU_S390_2084_GA2 = 0x08122084,
    CPU_S390_2084_GA3 = 0x08132084,
    CPU_S390_2084_GA4 = 0x08142084,
    CPU_S390_2084_GA5 = 0x08152084,
    CPU_S390_2086_GA1 = 0x08212086,
    CPU_S390_2086_GA2 = 0x08222086,
    CPU_S390_2086_GA3 = 0x08232086,
    CPU_S390_2094_GA1 = 0x09112094,
    CPU_S390_2094_GA2 = 0x09122094,
    CPU_S390_2094_GA3 = 0x09132094,
    CPU_S390_2096_GA1 = 0x09212096,
    CPU_S390_2096_GA2 = 0x09222096,
    CPU_S390_2097_GA1 = 0x0a112097,
    CPU_S390_2097_GA2 = 0x0a122097,
    CPU_S390_2097_GA3 = 0x0a132097,
    CPU_S390_2098_GA1 = 0x0a212098,
    CPU_S390_2098_GA2 = 0x0a222098,
    CPU_S390_2817_GA1 = 0x0b112817,
    CPU_S390_2817_GA2 = 0x0b122817,
    CPU_S390_2818_GA1 = 0x0b212818,
    CPU_S390_2827_GA1 = 0x0c112827,
    CPU_S390_2827_GA2 = 0x0c122827,
    CPU_S390_2828_GA1 = 0x0c212828,
    CPU_S390_2964_GA1 = 0x0d112964,
};

And initially I had a version that was limiting the accelerator to be able to implement just them
with all their properties encapsulated in the a accelerator as well. After identifying the real
processor related attributes defining the model, I changed the interface such that KVM or
other accelerators give hints what it is able to support in dependency of the current code
version and the hosting machine and let QEMU decide how to set these attributes
(cpuid,ibc,fac_list). Thus I think the implementation is now quite open and easily adoptable also
for TCG and possibly others as well. Eventually the integration and also some trigger points of
my code are to adjust. So coming back to your question, the answer is still no for the whole item
but eventually yes if you have limited it to the s390_set/get_processor_props() triggers. But I
have to look into it first again. I will do that when I'm back on Tuesday morning.

Thanks and have a nice WE
Michael
