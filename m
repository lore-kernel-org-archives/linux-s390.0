From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 2 Sep 2014 17:32:49 -0700
Message-ID: <CALCETrX+NUGPrV1prWYcy-jGR9bdx__jiqDKsZzbOChiBiVYpw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409703942.30640.71.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 2, 2014 at 5:25 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> On Tue, 2014-09-02 at 16:42 -0700, Andy Lutomirski wrote:
>> So here's an ugly proposal:
>>
>> Step 1: Make virtio-pci use the DMA API only on x86.  This will at
>> least fix Xen and people experimenting with virtio hardware on x86,
>> and it won't break anything, since there are no emulated IOMMUs on
>> x86.
>
> I think we should make all virtio drivers use the DMA API and just have
> different set of dma_ops. We can make a simple ifdef powerpc if needed
> in virtio-pci that force the dma-ops of the device to some direct
> "bypass" ops at init time.
>
> That way no need to select whether to use the DMA API or not, just
> always use it, and add a tweak to replace the DMA ops with the direct
> ones on the archs/platforms that need that. That was my original
> proposal and I still think it's the best approach.

I agree *except* that implementing it will be a real PITA and (I
think) can't be done without changing code in arch/.  My patches plus
an ifdef powerpc will be functionally equivalent, just uglier.

>
> As I said, make it always use the DMA API, but add a quirk to replace
> the dma_ops with some NULL ops on platforms that need it.
>
> The only issue with that is the location of the dma ops is arch
> specific, so that one function will contain some ifdefs, but the rest of
> the code can just use the DMA API.

Bigger quirk: on a standard s390 virtio guest configuration,
dma_map_single etc will fail to link.  I tried this in v1 of these
patches.  So we can poke at the archdata all day, but we can't build a
kernel like that :(

So until the dma_ops pointer move into struct device and
CONFIG_HAS_DMA becomes mandatory (or mandatory enough that virtio can
depend on it), I don't think we can do it this way.

I'll send a v5 that is the same as v4 except with physical addressing
hardcoded in for powerpc.

--Andy
