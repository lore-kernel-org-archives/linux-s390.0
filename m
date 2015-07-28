From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 16:06:16 +0300
Message-ID: <20150728160358-mutt-send-email-mst@redhat.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55B7799C.3060908@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, xen-devel <Xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, jan.kiszka@siemens.com, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 28, 2015 at 02:46:20PM +0200, Paolo Bonzini wrote:
> 
> 
> On 28/07/2015 12:12, Benjamin Herrenschmidt wrote:
> >> > That is an experimental feature (it's x-iommu), so it can change.
> >> > 
> >> > The plan was:
> >> > 
> >> > - for PPC, virtio never honors IOMMU
> >> > 
> >> > - for non-PPC, either have virtio always honor IOMMU, or enforce that
> >> > virtio is not under IOMMU.
> >> > 
> > I dislike having PPC special cased.
> > 
> > In fact, today x86 guests also assume that virtio bypasses IOMMU I
> > believe. In fact *all* guests do.
> 
> This doesn't matter much, since the only guests that implement an IOMMU
> in QEMU are (afaik) PPC and x86, and x86 does not yet promise any kind
> of stability.

Hmm I think Jan (cc) said it was already used out there.


> > I would much prefer if the information as to whether it honors or not
> > gets passed to the guest somewhat. My preference goes for passing it via
> > the virtio config space but there were objections that it should be a
> > bus property (which is tricky to do with PCI and doesn't properly
> > reflect the fact that in qemu you can mix & match IOMMU-honoring devices
> > and bypassing-virtio on the same bus). 
> 
> Yes, for example on x86 it must be passed through the DMAR table.
> virtio-pci device must have a separate DRHD for them.  In QEMU, you
> could add an "under-iommu" property to PCI bridges, and walk the
> hierarchy of bridges to build the DRHDs.
> 
> Paolo

-- 
MST
