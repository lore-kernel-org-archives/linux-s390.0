From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Wed, 4 Nov 2015 15:29:23 +0100
Message-ID: <20151104152923.6b60ce4c.cornelia.huck@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
	<CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
	<5631629B.2050505@de.ibm.com>
	<CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
	<20151030092548.7abd51e1.cornelia.huck@de.ibm.com>
	<CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
	<20151102121658.11aa3375.cornelia.huck@de.ibm.com>
	<CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
	<20151103185926.1442d0a8.cornelia.huck@de.ibm.com>
	<CALCETrXM96LKvy9ZsgPMOiMYD3ki2oju0e7OPzv-q9=Aq9dGcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrXM96LKvy9ZsgPMOiMYD3ki2oju0e7OPzv-q9=Aq9dGcA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 3 Nov 2015 10:45:12 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Tue, Nov 3, 2015 at 9:59 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > It's just failing very early in the setup phase. As it works for me
> > with a kvm setup, I'm suspecting some error in qemu's emulation code,
> > which is unfortunately not my turf.
> >
> 
> That should be easy to rule out.  Can you try with -machine accel=tcg?
>  I can't test with kvm for obvious reasons.

Well, s390-on-s390 works (at least with
https://patchwork.ozlabs.org/patch/538882/ applied).

I'm currently suspecting some endianness issues, probably with the ecw
accesses, which is why I'd be interested in your trace information (as
I currently don't have a LE test setup at hand.)
