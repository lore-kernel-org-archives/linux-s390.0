Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 21:50:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] s390/virtio: mark headers as BSD licensed
Message-ID: <20171108214928-mutt-send-email-mst@kernel.org>
References: <1510159613-12930-1-git-send-email-mst@redhat.com>
 <20171108172844.GA9893@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108172844.GA9893@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 08, 2017 at 06:28:44PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 08, 2017 at 06:47:18PM +0200, Michael S. Tsirkin wrote:
> > Virtio UAPI headers aren't just for UAPI, it's for guests/hypervisors as
> > well.  The s390 ones need to be BSD as well.
> > 
> > Fixes: e2be04c7f995 ("License cleanup: add SPDX license identifier to uapi header files with a license")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Christian, I would appreciate your ack if you agree.
> 
> You are changing the license on this file, you can't just slap a BSD one
> on the top, and have GPL below it without saying something about both
> covering the file, right?
> 
> 
> 
> > 
> >  arch/s390/include/uapi/asm/kvm_virtio.h | 26 ++++++++++++++++++++++-
> >  arch/s390/include/uapi/asm/virtio-ccw.h | 37 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 61 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/include/uapi/asm/kvm_virtio.h b/arch/s390/include/uapi/asm/kvm_virtio.h
> > index 7328367..1773693 100644
> > --- a/arch/s390/include/uapi/asm/kvm_virtio.h
> > +++ b/arch/s390/include/uapi/asm/kvm_virtio.h
> > @@ -1,4 +1,28 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> There is a dual-license SPDX identifier you can use, please use that, if
> you agree to relicense this file.
> 
> thanks,
> 
> greg k-h


Will do, thanks.

-- 
MST
