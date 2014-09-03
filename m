From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 09:47:07 +0200
Message-ID: <5406C77B.1000809@redhat.com>
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
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 03/09/2014 02:25, Benjamin Herrenschmidt ha scritto:
> > But there aren't any ACPI systems with both virtio-pci and IOMMUs,
> > right?  So we could say that, henceforth, ACPI systems must declare
> > whether virtio-pci devices live behind IOMMUs without breaking
> > backward compatibility.
> 
> I don't know for sure whether that's the case and whether we can rely on
> that not happening, we'll need x86 folks opinion here.

IOMMU support for x86 is going to go in this week.

However, it is and likely will remain niche enough that I don't really
care about performance loss from IOMMU support.  If you enable it, you
want it.

So from the QEMU point of view we can simply add the direct-ram-access
property, and have the pseries machine turn it on by default (while
other machines can leave it off by default---they have no IOMMU and thus
no performance cost).

Paolo
