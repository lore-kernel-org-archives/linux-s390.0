Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Dec 2014 20:15:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 3/3] virtio_ccw: rev 1 devices set VIRTIO_F_VERSION_1
Message-ID: <20141204181512.GA24307@redhat.com>
References: <1417713984-23771-1-git-send-email-mst@redhat.com>
 <1417713984-23771-3-git-send-email-mst@redhat.com>
 <20141204185914.4e989a7a.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141204185914.4e989a7a.cornelia.huck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, David Hildenbrand <dahi@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 04, 2014 at 06:59:14PM +0100, Cornelia Huck wrote:
> On Thu, 4 Dec 2014 19:26:50 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > What does it mean if rev 1 device does not set
> > VIRTIO_F_VERSION_1? E.g. is it native endian?
> > 
> > Let's not even try to drive such devices:
> > skip attempts to finalize features or set status.
> 
> Why not set status_failed?

It might be cleanest to just teach core that finalize_features
can fail.
I'll look into this.

> > virtio core will detect this and bail out.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/s390/kvm/virtio_ccw.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> 
> I'm not sure yet whether I like this approach. I'll think about it over
> the weekend.
