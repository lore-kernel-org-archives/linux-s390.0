From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Tue, 3 Nov 2015 10:45:12 -0800
Message-ID: <CALCETrXM96LKvy9ZsgPMOiMYD3ki2oju0e7OPzv-q9=Aq9dGcA@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
 <5631629B.2050505@de.ibm.com> <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
 <20151030092548.7abd51e1.cornelia.huck@de.ibm.com> <CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
 <20151102121658.11aa3375.cornelia.huck@de.ibm.com> <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
 <20151103185926.1442d0a8.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151103185926.1442d0a8.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 3, 2015 at 9:59 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> It's just failing very early in the setup phase. As it works for me
> with a kvm setup, I'm suspecting some error in qemu's emulation code,
> which is unfortunately not my turf.
>

That should be easy to rule out.  Can you try with -machine accel=tcg?
 I can't test with kvm for obvious reasons.

> Some more poke-around-in-the-dark ideas:
>
> - Do you get more debug out put when you switch back to s390-ccw-virtio
> (virtio-1), i.e. does cmd 83 work and is it followed by further
> commands?

I'll play with this stuff later today.

--Andy
