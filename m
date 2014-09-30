From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Tue, 30 Sep 2014 17:53:37 +0200
Message-ID: <542AD201.7080808@redhat.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop>
	<20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140930153821.GA4456@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@amacapital.net>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 30/09/2014 17:38, Michael S. Tsirkin ha scritto:
> I think that is true but it seems that this will be true for x86 for
> QEMU 2.2 unless we make some changes there.
> Which we might not have the time for since 2.2 is feature frozen
> from tomorrow.
> Maybe we should disable the IOMMU in 2.2, this is worth considering.

It is disabled by default, no?  And only supported by Q35 which does not
yet have migration compatibility (though we are versioning it, not sure
why that is the case).

Paolo
