From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Thu, 25 Sep 2014 08:04:57 +1000
Message-ID: <1411596297.4184.50.camel@pasglop>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrULv=zj_+rA2sRgf0Pxw3P6RDBzmM5C40=OHWwpYtEuJQ@mail.gmail.com>
	<1411162406.30672.64.camel@pasglop>
	<CALCETrUSRXv9wPoNF54GuXT+kKnLAdJmRPEsOjeFNfSE4QueoA@mail.gmail.com>
	<1411275788.30672.79.camel@pasglop> <1411275943.30672.81.camel@pasglop>
	<CALCETrUDMxsdPsZjRZj-T-Tc4OH697mGH1r4Vj6hPu8tjvmfew@mail.gmail.com>
	<1411595404.4184.48.camel@pasglop>
	<CALCETrWRfrLs5Se+mbiGhEbt=WM8fGd2bt6XWskPEYOq2tq-qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWRfrLs5Se+mbiGhEbt=WM8fGd2bt6XWskPEYOq2tq-qg@mail.gmail.com>
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
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2014-09-24 at 14:59 -0700, Andy Lutomirski wrote:

> Scratch that idea, then.
> 
> The best that I can currently come up with is to say that pre-1.0
> devices on PPC bypass the IOMMU and that 1.0 devices on PPC and all
> devices on all other architectures do not bypass the IOMMU.

Well, the thing is, we *want* them to bypass the IOMMU for performance
reasons in the long run. Today we have no ways to tell our guests that
a PCI bus doesn't have an IOMMU, they always do !

Also qemu can mix and match devices on a given PCI bus so making this a
bus property wouldn't work either.

> I agree that this is far from ideal.  Any ideas?  Is there any other
> channel that QEMU can use to signal to a PPC guest that a specific PCI
> virtio device isn't really behind an IOMMU?  

Any reason why this can't be a virtio capability ?

> From my POV, the main
> consideration is that existing QEMU versions hosting Xen hypervisors
> should work, which is not the case in current kernels, but which is
> the case with my patches without any known regressions.
> 
> Is there some evil trick that a PPC guest could use to detect whether
> the IOMMU is honored?  As an example that I don't like at all, the
> guest could program the IOMMU so that the ring's physical address maps
> to a second copy of the ring and then see which one works.

Cheers,
Ben.
