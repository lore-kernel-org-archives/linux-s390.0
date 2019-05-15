Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 15 May 2019 15:50:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 10/10] virtio/s390: make airq summary indicators DMA
Message-ID: <20190515155017.0d3e2543.cohuck@redhat.com>
In-Reply-To: <3a8353e2-97e3-778e-ab2e-ef285ac7027d@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-11-pasic@linux.ibm.com>
        <20190513142010.36c8478f.cohuck@redhat.com>
        <3a8353e2-97e3-778e-ab2e-ef285ac7027d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 May 2019 15:43:23 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> On 13.05.19 14:20, Cornelia Huck wrote:
> > On Fri, 26 Apr 2019 20:32:45 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> Hypervisor needs to interact with the summary indicators, so these
> >> need to be DMA memory as well (at least for protected virtualization
> >> guests).
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> ---
> >>   drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++-------
> >>   1 file changed, 17 insertions(+), 7 deletions(-)  
> > 
> > (...)
> >   
> >> @@ -237,7 +243,8 @@ static void virtio_airq_handler(struct airq_struct *airq)
> >>   	read_unlock(&info->lock);
> >>   }
> >>   
> >> -static struct airq_info *new_airq_info(void)
> >> +/* call with drivers/s390/virtio/virtio_ccw.cheld */  
> > 
> > Hm, where is airq_areas_lock defined? If it was introduced in one of
> > the previous patches, I have missed it.  
> 
> There is no airq_areas_lock defined currently. My assumption is that
> this will be used in context with the likely race condition this
> part of the patch is talking about.
> 
> @@ -273,8 +281,9 @@ static unsigned long get_airq_indicator(struct 
> virtqueue *vqs[], int nvqs,
>   	unsigned long bit, flags;
> 
>   	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
> +		/* TODO: this seems to be racy */
>   		if (!airq_areas[i])
> -			airq_areas[i] = new_airq_info();
> +			airq_areas[i] = new_airq_info(i);
> 
> 
> As this shall be handled by a separate patch I will drop the comment
> in regard to airq_areas_lock from this patch as well for v2.

Ok, that makes sense.
