From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Wed, 03 Sep 2014 09:43:59 +0200
Message-ID: <5406C6BF.8040908@redhat.com>
References: <cover.1409593066.git.luto@amacapital.net>	
	<1409609814.30640.11.camel@pasglop>	
	<CALCETrVHSjaCe5TN6+Gr9W9uT8XEZC97ne_dZUazMDyLr0Wetw@mail.gmail.com>	
	<1409691213.30640.37.camel@pasglop>	
	<CALCETrWNqksZWjotVXfWVWOaJ-tN=uBuMaRe+JmmPjacb6KDOg@mail.gmail.com>	
	<1409695810.30640.57.camel@pasglop>	
	<CALCETrXA0Po5mhLWDn41_sT+zBwbo7Rzm5Nqxdmao-MbtfKvmQ@mail.gmail.com>
	<1409700010.30640.67.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409700010.30640.67.camel@pasglop>
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

Il 03/09/2014 01:20, Benjamin Herrenschmidt ha scritto:
> I wouldn't be so certain, as I said, the way virtio is implemented in
> qemu bypass the DMA layer which is where IOMMUs sit. The fact that
> currently x86 doesn't put an IOMMU there is not even garanteed, is it ?
> What happens if you try to mix and match virtio and other emulated
> devices that require the iommu on the same bus ?

As far as QEMU is concerned, it's trivial to add a property like
"direct-ram-access" that selects whether to bypass the IOMMU or not.
And it would have zero performance cost if direct RAM access is enabled,
compared to the current code.

If possible, I would quirk it in the PPC code.

Paolo
