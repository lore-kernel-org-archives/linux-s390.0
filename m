Return-Path: <SRS0=crtG=TI=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 8 May 2019 22:12:58 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 01/10] virtio/s390: use vring_create_virtqueue
In-Reply-To: <ed6cbf63-f2ff-f259-ccb0-3b9ba60f2b35@de.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-2-pasic@linux.ibm.com>
        <20190503111724.70c6ec37.cohuck@redhat.com>
        <20190503160421-mutt-send-email-mst@kernel.org>
        <20190504160340.29f17b98.pasic@linux.ibm.com>
        <20190505131523.159bec7c.cohuck@redhat.com>
        <ed6cbf63-f2ff-f259-ccb0-3b9ba60f2b35@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190508221258.6db20c81.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 7 May 2019 15:58:12 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 05.05.19 13:15, Cornelia Huck wrote:
> > On Sat, 4 May 2019 16:03:40 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> >> On Fri, 3 May 2019 16:04:48 -0400
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>
> >>> On Fri, May 03, 2019 at 11:17:24AM +0200, Cornelia Huck wrote:  
> >>>> On Fri, 26 Apr 2019 20:32:36 +0200
> >>>> Halil Pasic <pasic@linux.ibm.com> wrote:
> >>>>   
> >>>>> The commit 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> >>>>> establishes a new way of allocating virtqueues (as a part of the effort
> >>>>> that taught DMA to virtio rings).
> >>>>>
> >>>>> In the future we will want virtio-ccw to use the DMA API as well.
> >>>>>
> >>>>> Let us switch from the legacy method of allocating virtqueues to
> >>>>> vring_create_virtqueue() as the first step into that direction.
> >>>>>
> >>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >>>>> ---
> >>>>>  drivers/s390/virtio/virtio_ccw.c | 30 +++++++++++-------------------
> >>>>>  1 file changed, 11 insertions(+), 19 deletions(-)  
> >>>>
> >>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >>>>
> >>>> I'd vote for merging this patch right away for 5.2.  
> >>>
> >>> So which tree is this going through? mine?
> >>>   
> >>
> >> Christian, what do you think? If the whole series is supposed to go in
> >> in one go (which I hope it is), via Martin's tree could be the simplest
> >> route IMHO.
> > 
> > 
> > The first three patches are virtio(-ccw) only and the those are the ones
> > that I think are ready to go.
> > 
> > I'm not feeling comfortable going forward with the remainder as it
> > stands now; waiting for some other folks to give feedback. (They are
> > touching/interacting with code parts I'm not so familiar with, and lack
> > of documentation, while not the developers' fault, does not make it
> > easier.)
> > 
> > Michael, would you like to pick up 1-3 for your tree directly? That
> > looks like the easiest way.
> 
> Agreed. Michael please pick 1-3.
> We will continue to review 4- first and then see which tree is best.

Thanks Christian!

Guys, I broke my right arm on last Thursday (2nd may). You may
have noticed that I was not as responsive as I'm supposed to be.
Unfortunately this less than responsiveness is about to persist for a
couple more weeks. Fortunate the guys from IBM, and chiefly Michael
Mueller is going to help me drive this -- thanks Michael! Due to this,
I would generally prefer doing as few changes to this series as
necessary, and deferring as many of the beautifying to patches on top
(possibly authored by somebody else) as possible.

Regards,
Halil
