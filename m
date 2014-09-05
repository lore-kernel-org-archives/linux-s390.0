From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Fri, 05 Sep 2014 15:20:51 +1000
Message-ID: <1409894451.4246.116.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
	<1409691213.30640.37.camel@pasglop>
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>
	<874mwpkxxi.fsf@rustcorp.com.au>
	<CALCETrWMc6TQy02kLXLcLwMJbPkpY4yv7U-As6jv0Frx34nuww@mail.gmail.com>
	<87lhpykdbu.fsf@rustcorp.com.au>
	<CALCETrX7feY6f-iVEgdxp-YPNNPctRjQr=KyByyPRgiW1xKUdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrX7feY6f-iVEgdxp-YPNNPctRjQr=KyByyPRgiW1xKUdA@mail.gmail.com>
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
Cc: virtio-dev@lists.oasis-open.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2014-09-04 at 19:57 -0700, Andy Lutomirski wrote:

> There's a third option: try to make virtio-mmio work everywhere
> (except s390), at least in the long run.  This other benefits: it
> makes minimal hypervisors simpler, I think it'll get rid of the limits
> on the number of virtio devices in a system.  ARM is already going
> this direction, and I imagine that PPC support would be
> straightforward (it's already using devicetree).

PCI has advantages though. Management stacks know about PCI and nothing
else really. We already have all the infra to do hotplug with PCI,
etc...

> Does virtio-mmio have any reasonable way of doing hotplug?  It could
> also eventually make sense to have a standard for virtio on virtio.

That would be very platform specific.

Cheers,
Ben.
