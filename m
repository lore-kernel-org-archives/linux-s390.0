From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 20:46:57 -0800
Message-ID: <CALCETrWAVOATcCaUabunjYd+NYM1HRqJXG9K=DgrZCnBbWCexw@mail.gmail.com>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
	<1447151874.31884.82.camel@kernel.crashing.org>
	<CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
	<1447194427.31884.100.camel@kernel.crashing.org>
	<CALCETrWb9poeyxXhcbAbQkpcP-XYjWtz2w9iSPkKJH8rdzAj-A@mail.gmail.com>
	<1447202682.31884.123.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447202682.31884.123.camel@kernel.crashing.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Nov 10, 2015 4:44 PM, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2015-11-10 at 15:44 -0800, Andy Lutomirski wrote:
> >
> > > What about partition <-> partition virtio such as what we could do on
> > > PAPR systems. That would have the weak barrier bit.
> > >
> >
> > Is it partition <-> partition, bypassing IOMMU?
>
> No.
>
> > I think I'd settle for just something that doesn't regress
> > non-experimental setups that actually work today and that allow new
> > setups (x86 with fixed QEMU and maybe something more complicated on
> > powerpc and/or sparc) to work in all cases.
> >
> > We could certainly just make powerpc and sparc continue bypassing the
> > IOMMU until someone comes up with a way to fix it.  I'll send out some
> > patches that do that, and maybe that'll help this make progress.
>
> But we haven't found a solution that works. All we have come up with is
> a quirk that will force bypass on virtio always and will not allow us
> to operate non-bypassing devices on either of those architectures in
> the future.
>
> I'm not too happy about this.

Me neither.  At least it wouldn't be a regression, but it's still crappy.

I think that arm is fine, at least.  I was unable to find an arm QEMU
config that has any problems with my patches.

--Andy
