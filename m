Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Nov 2014 10:09:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 04/42] virtio: disable virtio 1.0 in transports
Message-ID: <20141126100954.3811e594.cornelia.huck@de.ibm.com>
In-Reply-To: <20141125212011.GA22343@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-5-git-send-email-mst@redhat.com>
	<20141125182942.3890fe7b.cornelia.huck@de.ibm.com>
	<20141125212011.GA22343@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, Ohad Ben-Cohen <ohad@wizery.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nikhil Rao <nikhil.rao@intel.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, lguest@lists.ozlabs.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Nov 2014 23:20:11 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 25, 2014 at 06:29:42PM +0100, Cornelia Huck wrote:
> > On Tue, 25 Nov 2014 18:41:35 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > disable virtio 1.0 in transports that don't
> > > support it yet.
> > 
> > I'd prefer if you disabled it for _every_ transport in this patch,
> > until the needed infrastructure is in place. Else this is a bit
> > confusing.
> 
> Well the only transports left are pci and rpoc, and these only
> read the low 32 bit of the features from the device -
> so there's nothing to clear.
> 
> E.g. the following would be even more confusing, would it not:
> 
> 	u32 features;
> 	....
> 	features &= ~BIT_ULL(VIRTIO_F_VERSION_1);
> 
> Agree?

Maybe you should tweak the patch description a bit and mention that you
only disable virtio 1.0 for transports where it is actually needed?

(...)

> > FWIW, as negotiating a revision >= 1 is a pre-req for virtio 1.0
> > support on ccw, virtio 1.0 is already implicitly disabled.
> 
> Ah, you mean device guarantees that VIRTIO_F_VERSION_1 isn't set
> if guest sets revision to 0?

Yes, the bit will not be offered if the revision is 0 or has not been
set at all.

> In that case it's probably best to drop this from both ccw
> devices.

There's only one ccw transport :)

The old s390 virtio transport in kvm_virtio.c is not part of virtio 1.0.
