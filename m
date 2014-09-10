From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 10 Sep 2014 09:15:10 -0700
Message-ID: <CALCETrV=w_-heYpzxMDpNW8MtB-R2HB98bOsyyk5ojRoc7zgBQ@mail.gmail.com>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au>
	<CALCETrWMc6TQy02kLXLcLwMJbPkpY4yv7U-As6jv0Frx34nuww@mail.gmail.com>
	<87lhpykdbu.fsf@rustcorp.com.au>
	<CALCETrX7feY6f-iVEgdxp-YPNNPctRjQr=KyByyPRgiW1xKUdA@mail.gmail.com>
	<54107013.2030701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54107013.2030701@codeaurora.org>
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
To: Christopher Covington <cov@codeaurora.org>
Cc: virtio-dev@lists.oasis-open.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 10, 2014 at 8:36 AM, Christopher Covington
<cov@codeaurora.org> wrote:
> On 09/04/2014 10:57 PM, Andy Lutomirski wrote:
>> There's a third option: try to make virtio-mmio work everywhere
>> (except s390), at least in the long run.  This other benefits: it
>> makes minimal hypervisors simpler, I think it'll get rid of the limits
>> on the number of virtio devices in a system.  ARM is already going
>> this direction, and I imagine that PPC support would be
>> straightforward (it's already using devicetree).
>
> In my opinion, a uniform "virt" machine for every instruction set would be
> very beneficial. I would guess that MMIO is more universally available than
> PCI, and as you point out, simpler to implement.

Except for x86 :(  That's presumably fixable, though.

>
>> Does virtio-mmio have any reasonable way of doing hotplug?  It could
>> also eventually make sense to have a standard for virtio on virtio.
>
> I don't think so, but it seems possible. My bystander understanding is that
> QEMU allocates some fixed number of VirtIO-MMIO devices, maybe a dozen, in the
> device tree. The ones that don't actually get hooked up to something real like
> a block device or network interface are populated with a dummy device. One
> naive approach might be to allow the dummy devices to tell the kernel that
> they are now changing to a real device.

My thought (which I completely failed to articulate) was to have a
spec for a virtio device that exposes a complete virtio bus along with
hotplug and per-cpu interrupts (a la MSI-X).  This might be a bit
complicated, but it would work everywhere without any firmware or
platform issues.

--Andy
