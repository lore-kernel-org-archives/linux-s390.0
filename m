Return-Path: <SRS0=rkwH=SM=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:16:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 05/12] s390/cio: add protected virtualization
 support to cio
Message-ID: <20190410181612.70734815.cohuck@redhat.com>
In-Reply-To: <20190410150225.61b86cd9@oc2783563651>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-6-pasic@linux.ibm.com>
        <20190409195548.6dea6e40.cohuck@redhat.com>
        <20190410021044.4da3e847@oc2783563651>
        <20190410102557.1ba89d96.cohuck@redhat.com>
        <20190410150225.61b86cd9@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 10 Apr 2019 15:02:25 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 10 Apr 2019 10:25:57 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:

> > So, what is a high-level summary of areas that need the treatment?
> > What I get from looking at the patches so far, it's:
> > - stuff that is written by the hypervisor's interrupt injection code:
> >   IRB, indicators, etc.  
> 
> In interrupt context IRB behaves like a control block. We don't have
> to make it shared.
> 
> I moved IRB because of snse:
> 
> 
> @@ -329,9 +329,9 @@ ccw_device_do_sense(struct ccw_device *cdev, struct
> irb *irb) /*
>          * We have ending status but no sense information. Do a basic
> sense. */
> -       sense_ccw = &to_io_private(sch)->sense_ccw;
> +       sense_ccw = &to_io_private(sch)->dma_area->sense_ccw;
>         sense_ccw->cmd_code = CCW_CMD_BASIC_SENSE;
> -       sense_ccw->cda = (__u32) __pa(cdev->private->irb.ecw);
> +       sense_ccw->cda = (__u32) __pa(cdev->private->dma_area->irb.ecw);
> 
> as the irb.ecw is used as channel program data. And that needs to be
> shared.

Ah, I see. So it's more "guest points to some memory where the
hypervisor needs to write data"?

> 
> > - buffers that are filled by a channel program: sense, sense id, etc.
> > - ccws themselves (because of translation?)
> >   
> 
> Right. The idea is: smallish, basically fixed size a readily available
> control blocks (specified as a ) are copied back and forth by the

As a what? :)

> ultravisor (via SIE SD).

Ok. It's really hard to be sure from the outside what falls into which
category :(
