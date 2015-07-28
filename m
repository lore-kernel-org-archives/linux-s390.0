From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] virtio: Clean up scatterlists and use the DMA API
Date: Tue, 28 Jul 2015 19:15:27 +0200
Message-ID: <55B7B8AF.5060603@redhat.com>
References: <CALCETrU2o27udqjvREDFyoNtKtaKvuHTyYRaK+Qt_1Q3tPWYDQ@mail.gmail.com>
	<55B73A49.9050206@redhat.com>
	<1438078345.7562.133.camel@kernel.crashing.org>
	<55B7799C.3060908@redhat.com>
	<20150728160358-mutt-send-email-mst@redhat.com>
	<55B77F8C.7010804@siemens.com> <55B7AF99.2080209@redhat.com>
	<55B7B105.50200@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55B7B105.50200@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, xen-devel <Xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>



On 28/07/2015 18:42, Jan Kiszka wrote:
> > On the other hand interrupt remapping is absolutely necessary for
> > production use, hence my point that x86 does not promise API stability.
> 
> Well, we currently implement the features that the Q35 used to expose.
> Adding interrupt remapping will require a new chipset and/or a hack
> switch to ignore compatibility.

Isn't the VT-d register space separate from other Q35 features and
backwards-compatible?  You could even add it to PIIX in theory just by
adding a DMAR.

It's not like for example SMRAM, where the registers are in the
northbridge configuration space and move around in every chipset generation.

> > ("Any kind of stability" actually didn't include crashes; those are not
> > expected :))
> > 
> > The Google patches for userspace PIC and IOAPIC are proceeding well, so
> > hopefully we can have interrupt remapping soon.
> 
> If the day had 48 hours... I'd love to look into this, first adding QEMU
> support for the new irqchip architecture.

I hope I can squeeze in some time for that...  Google also had an intern
that was looking at it.

Paolo
