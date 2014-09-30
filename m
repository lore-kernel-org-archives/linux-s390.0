From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Tue, 30 Sep 2014 09:19:58 -0700
Message-ID: <CALCETrUuy57DOGPghBiJJ3Q-rX3_eG=JX7bD_vZCbc4PSD1ptw@mail.gmail.com>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
	<1410955351.30672.27.camel@pasglop> <20140917141639.GA13684@redhat.com>
	<CALCETrW1mD5EuPbJDhnQPDSJwy9L=dh6rSSTj_wEOmFJNHBeUQ@mail.gmail.com>
	<1412023777.4285.93.camel@pasglop>
	<CALCETrXPEepB2jcY+1GF_pM2L_xf9Et58YHud3N0Aff3uj39cg@mail.gmail.com>
	<20140930153821.GA4456@redhat.com>
	<CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVBmTPg1J6nt8EXAmtvazh_uXRzYRSvvA4-Pdrj8t=VpQ@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 30, 2014 at 8:48 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Sep 30, 2014 at 8:38 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> Maybe we should disable the IOMMU in 2.2, this is worth considering.
>>
>
> Please do.
>
> Also, try booting this 2.2 QEMU candidate with nested virtualization
> on.  Then bind vfio to a virtio-pci device and watch the guest get
> corrupted.  QEMU will blame Linux for incorrectly programming the
> hardware, and Linux will blame QEMU for its blatant violation of the
> ACPI spec.  Given that this is presumably most of the point of adding
> IOMMU support, it seems like a terrible idea to let code like that
> into the wild.
>
> If this happens, Linux may also end up needing a quirk to prevent vfio
> from binding to QEMU 2.2's virtio-pci devices.

I just confirmed that a guest with my patches blows up if I run it
like this against QEMU master from today:

PATH=.:$PATH virtme-run --kimg
~/apps/linux-devel/arch/x86/boot/bzImage -a intel_iommu=on --qemu-opts
-machine q35,iommu=on

IOW, QEMU master is indeed presenting an IOMMU that blows up the guest
if the guest tries to use it as specified.

--Andy
