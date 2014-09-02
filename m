From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 06:53:33 +1000
Message-ID: <1409691213.30640.37.camel@pasglop>
References: <cover.1409593066.git.luto@amacapital.net>
	<1409609814.30640.11.camel@pasglop>
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>
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

On Mon, 2014-09-01 at 22:55 -0700, Andy Lutomirski wrote:
> 
> On x86, at least, I doubt that we'll ever see a physically addressed
> PCI virtio device for which ACPI advertises an IOMMU, since any sane
> hypervisor will just not advertise an IOMMU for the virtio device.
> But are there arm64 or PPC guests that use virtio_pci, that have
> IOMMUs, and that will malfunction if the virtio_pci driver ends up
> using the IOMMU?  I certainly hope not, since these systems might be
> very hard-pressed to work right if someone plugged in a physical
> virtio-speaking PCI device.

It will definitely not work on ppc64. We always have IOMMUs on pseries,
all PCI busses do, and because it's a paravirtualized environment,
napping/unmapping pages means hypercalls -> expensive.

But our virtio implementation bypasses it in qemu, so if virtio-pci
starts using the DMA mapping API without changing the DMA ops under the
hood, it will break for us.

Cheers,
Ben.
