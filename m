From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Wed, 24 Sep 2014 15:49:53 -0700
Message-ID: <CALCETrUwCzxD=25W_nS+JqU8sNMxQCjPmXhFrKURx-QKO3u=3w@mail.gmail.com>
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
	<1411596297.4184.50.camel@pasglop>
	<CALCETrUGRCNT-bhfeYoVuFA1TAwjtadCEOLMbAQ_xN6A0GVPaQ@mail.gmail.com>
	<1411598299.4184.53.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411598299.4184.53.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux390@de.ibm.com" <linux390@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 24, 2014 at 3:38 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-09-24 at 15:15 -0700, Andy Lutomirski wrote:
>> On Wed, Sep 24, 2014 at 3:04 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Wed, 2014-09-24 at 14:59 -0700, Andy Lutomirski wrote:
>> >
>> >> Scratch that idea, then.
>> >>
>> >> The best that I can currently come up with is to say that pre-1.0
>> >> devices on PPC bypass the IOMMU and that 1.0 devices on PPC and all
>> >> devices on all other architectures do not bypass the IOMMU.
>> >
>> > Well, the thing is, we *want* them to bypass the IOMMU for performance
>> > reasons in the long run. Today we have no ways to tell our guests that
>> > a PCI bus doesn't have an IOMMU, they always do !
>>
>> Alternatively, the IOMMU could be extended to allow an efficient
>> identity map of the entire physical address space.
>
> We have that option, but I'm a bit reluctant to rely on it, it has its
> issues, but it's something we can look into.
>
>> > Also qemu can mix and match devices on a given PCI bus so making this a
>> > bus property wouldn't work either.
>> >
>> >> I agree that this is far from ideal.  Any ideas?  Is there any other
>> >> channel that QEMU can use to signal to a PPC guest that a specific PCI
>> >> virtio device isn't really behind an IOMMU?
>> >
>> > Any reason why this can't be a virtio capability ?
>> >
>>
>> For Xen.
>
> And ? I don't see the problem... When running Xen, you don't put the
> capability in. They are negociated... Why can't qemu set the capability
> accordingly based on whether it's using KVM or Xen ? It's not like we
> care about backward compat of ppc on Xen anyway...
>

QEMU doesn't know that Xen is running.  I can do qemu-system-x86_64
-kernel /path/to/xen (virtme-run --xen does this) or
qemu-system-x86_64 -hda disk_with_xen.img and Xen will run.

>
>  .../...
>
>> a) IOMMU should be used.
>> b) Device is trusted but the IOMMU still works.  The guest may want to
>> set up an identity map.
>> c) (PPC only) Device bypasses the IOMMU.  There's no security issue
>> here: a malicious device wouldn't be able to bypass the IOMMU, so it
>> would be unable to do DMA at all.
>
> I wouldn't make it "ppc only" at this point but yes. Also keep in mind
> that we do have ppc cases where we will want to use the iommu (in which
> case the capability would be enforced by the other half).

The only reason I say "PPC only" is because I don't think that other
architectures would want to choose c.

We could plausibly use paravirt tricks for this, but that gets messy,
since e.g. the KVM kernel code might not even know what QEMU wants to
do.

--Andy
