Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 15 May 2019 19:23:44 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 10/10] virtio/s390: make airq summary indicators DMA
In-Reply-To: <7c21b646-df27-88b6-6b06-3aab7887ff0a@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-11-pasic@linux.ibm.com>
        <74ff9a63-891a-7e24-0865-8cc91a95cada@linux.ibm.com>
        <7c21b646-df27-88b6-6b06-3aab7887ff0a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190515192344.5c57724c.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: pmorel@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 May 2019 15:33:02 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> >> @@ -273,8 +281,9 @@ static unsigned long get_airq_indicator(struct 
> >> virtqueue *vqs[], int nvqs,
> >>       unsigned long bit, flags;
> >>       for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
> >> +        /* TODO: this seems to be racy */  
> > 
> > yes, my opinions too, was already racy, in my opinion, we need another 
> > patch in another series to fix this.
> > 
> > However, not sure about the comment.  
> 
> I will drop this comment for v2 of this patch series.
> We shall fix the race with a separate patch.

Unless there is somebody eager to address this real soon, I would prefer
keeping the comment as a reminder.

Thanks for shouldering the v2!

Regards,
Halil
