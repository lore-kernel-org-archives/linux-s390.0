Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 20 May 2019 12:21:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 06/10] s390/cio: add basic protected virtualization
 support
Message-ID: <20190520122143.259ff8df.cohuck@redhat.com>
In-Reply-To: <20190518201100.0fd07d7f.pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-7-pasic@linux.ibm.com>
        <20190513114136.783c851c.cohuck@redhat.com>
        <20190515225158.301af387.pasic@linux.ibm.com>
        <20190516082928.1371696b.cohuck@redhat.com>
        <20190518201100.0fd07d7f.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 18 May 2019 20:11:00 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 16 May 2019 08:29:28 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 15 May 2019 22:51:58 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> Don't like the second sentence. How about "It handles neither QDIO
> in the common code, nor any device type specific stuff (like channel
> programs constructed by the DADS driver)."

Sounds good to me (with s/DADS/DASD/ :)

> > > A side note: making the subchannel device 'own' the DMA stuff of a
> > > ccw device (something that was discussed in the RFC thread) is tricky
> > > because the ccw device may outlive the subchannel (all that orphan
> > > stuff).  
> > 
> > Yes, that's... eww. Not really a problem for virtio-ccw devices (which
> > do not support the disconnected state), but can we make DMA and the
> > subchannel moving play nice with each other at all?
> >   
> 
> I don't quite understand the question. This series does not have any
> problems with that AFAIU. Can you please clarify?

Wait, weren't you saying that there actually is a problem?

We seem to have the following situation:
- the device per se is represented by the ccw device
- the subchannel is the means of communication, and dma is tied to the
  (I/O ?) subchannel
- the machine check handling code may move a ccw device to a different
  subchannel, or even to a fake subchannel (orphanage handling)

The moving won't happen with virtio-ccw devices (as they do not support
the disconnected state, which is a prereq for being moved around), but
at a glance, this looks like it is worth some more thought.

- Are all (I/O) subchannels using e.g. the same dma size? (TBH, that
  question sounds a bit silly: that should be a property belonging to
  the ccw device, shouldn't it?)
- What dma properties does the fake subchannel have? (Probably none, as
  its only purpose is to serve as a parent for otherwise parentless
  disconnected ccw devices, and is therefore not involved in any I/O.)
- There needs to be some kind of handling in the machine check code, I
  guess? We would probably need a different allocation if we end up at
  a different subchannel?

I think we can assume that the dma size is at most 31 bits (since that
is what the common I/O layer needs); but can we also assume that it
will always be at least 31 bits?

My take on this is that we should be sure that we're not digging
ourselves a hole that will be hard to get out of again should we want to
support non-virtio-ccw in the future, not that the current
implementation is necessarily broken.
