From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Wed, 4 Nov 2015 10:14:11 -0800
Message-ID: <CALCETrVGcLLtJwTxXk3pFcO_8Ocu3_xUsWjbV1Gm5WWtBLVJUA@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
 <5631629B.2050505@de.ibm.com> <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
 <20151030092548.7abd51e1.cornelia.huck@de.ibm.com> <CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
 <20151102121658.11aa3375.cornelia.huck@de.ibm.com> <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
 <20151103185926.1442d0a8.cornelia.huck@de.ibm.com> <CALCETrXM96LKvy9ZsgPMOiMYD3ki2oju0e7OPzv-q9=Aq9dGcA@mail.gmail.com>
 <20151104152923.6b60ce4c.cornelia.huck@de.ibm.com> <20151104185252.199973af.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151104185252.199973af.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 4, 2015 at 9:52 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Wed, 4 Nov 2015 15:29:23 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>
>> I'm currently suspecting some endianness issues, probably with the ecw
>> accesses, which is why I'd be interested in your trace information (as
>> I currently don't have a LE test setup at hand.)
>
> I think I've got it. We have sense_data as a byte array, which
> implicitly makes it BE already. When we copy to the ecws while building
> the irb, the data ends up in 32 bit values. The conversion from host
> endianness to BE now treats them as LE on your system...
>
> Could you please give the following qemu patch a try?

Tested-by: Andy Lutomirski <luto@kernel.org>

Now my test script panics for the right reason (init isn't actually an
s390 binary).  Thanks!

I'll update my branch with the latest s390 DMA stuff, and now I can
give it at least basic regression testing.  Of course, I have to find
a root filesystem, too. :)

--Andy
