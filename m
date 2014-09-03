From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 10:43:10 +1000
Message-ID: <1409704990.30640.76.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<1409695810.30640.57.camel@pasglop>
	<CALCETrXA0Po5mhLWDn41_sT+zBwbo7Rzm5Nqxdmao-MbtfKvmQ@mail.gmail.com>
	<1409700010.30640.67.camel@pasglop>
	<CALCETrWTwoBLj6onvNWOrwvY_n3-rWx0KifR0xP7091Vd-xHbg@mail.gmail.com>
	<1409703942.30640.71.camel@pasglop>
	<CALCETrX+NUGPrV1prWYcy-jGR9bdx__jiqDKsZzbOChiBiVYpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrX+NUGPrV1prWYcy-jGR9bdx__jiqDKsZzbOChiBiVYpw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2014-09-02 at 17:32 -0700, Andy Lutomirski wrote:
> 
> I agree *except* that implementing it will be a real PITA and (I
> think) can't be done without changing code in arch/.  My patches plus
> an ifdef powerpc will be functionally equivalent, just uglier.

So for powerpc, it's a 2 liner inside virtio-pci, but yes, it might be
more of a problem for s390, I'm not too sure what they do in that area.

> Bigger quirk: on a standard s390 virtio guest configuration,
> dma_map_single etc will fail to link. 

Yuck

>  I tried this in v1 of these
> patches.  So we can poke at the archdata all day, but we can't build a
> kernel like that :(

I would like the s390 people to chime in here, it still looks like the
best way to go if they can fix things on their side :-)

> So until the dma_ops pointer move into struct device and
> CONFIG_HAS_DMA becomes mandatory (or mandatory enough that virtio can
> depend on it), I don't think we can do it this way.

I see, it's a bummer because it would be a lot cleaner.

> I'll send a v5 that is the same as v4 except with physical addressing
> hardcoded in for powerpc.

Thanks. That will do for now, but ideally we want to make it a function
of some flag from the implementation, so let's see what Rusty has to
say.

Cheers,
Ben.
