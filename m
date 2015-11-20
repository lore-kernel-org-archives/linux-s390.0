From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Fri, 20 Nov 2015 09:47:25 +0200
Message-ID: <20151120094616-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151119153821-mutt-send-email-mst@redhat.com>
	<CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
	<20151120083857-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151120083857-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 20, 2015 at 08:56:46AM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 19, 2015 at 01:59:05PM -0800, Andy Lutomirski wrote:
> > On Nov 19, 2015 5:45 AM, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 27, 2015 at 11:38:57PM -0700, Andy Lutomirski wrote:
> > > > This switches virtio to use the DMA API unconditionally.  I'm sure
> > > > it breaks things, but it seems to work on x86 using virtio-pci, with
> > > > and without Xen, and using both the modern 1.0 variant and the
> > > > legacy variant.
> > >
> > > So thinking hard about it, I don't see any real drawbacks to making this
> > > conditional on a new feature bit, that Xen can then set..
> > 
> > Can you elaborate?  If I run QEMU, hosting Xen, hosting Linux, and the
> > virtio device is provided by QEMU, then how does Xen set the bit?
> 
> You would run QEMU with the appropriate flag. E.g.
> -global virtio-pci,use_platform_dma=on

Or Xen code within QEMU can tweak this global internally
so users don't need to care.

> > Similarly, how would Xen set the bit for a real physical device?
> > 
> > 
> > --Andy
> 
> There's no need to set bits for physical devices I think: from security
> point of view, using them from a VM isn't very different from using them
> from host.
> 
> 
> 
> -- 
> MST
