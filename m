Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 19:15:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390/virtio: mark headers as BSD licensed
Message-ID: <20171108191531.2d2f7210.cohuck@redhat.com>
In-Reply-To: <9c2debae-5c00-75ad-bc4d-13af9c4f431d@de.ibm.com>
References: <1510160307-13235-1-git-send-email-mst@redhat.com>
        <9c2debae-5c00-75ad-bc4d-13af9c4f431d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Nov 2017 19:12:25 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/08/2017 05:59 PM, Michael S. Tsirkin wrote:
> > Virtio UAPI headers aren't just for UAPI, it's for guests/hypervisors as
> > well.  The s390 ones need to be BSD as well.
> > 
> > Fixes: e2be04c7f995 ("License cleanup: add SPDX license identifier to uapi header files with a license")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > since v1:
> > 	drop an extra comment chunk, reported by Cornelia
> > 
> >  arch/s390/include/uapi/asm/kvm_virtio.h | 26 +++++++++++++++++++++++++-  
> 
> FWIW, this file will go away anyway. 
> Looks like the following commit in the s390 feature branch 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/drivers/s390/virtio/Makefile?h=features&id=7fb2b2d512448cf0e914c4647a1cf02b52263702
> missed this file.

Can we simply rip this out?

> 
> 
> Regarding the virtio-ccw.h headers it is probably something that happened by accident.
> Back then Rusty (as an IBMer) proposed to change all virtio headers to BSD licence.

ISTR that the relicensing already went through... is that not the case?
I thought this was just a fixup to align with reality?

> 
> >  arch/s390/include/uapi/asm/virtio-ccw.h | 26 +++++++++++++++++++++++++-
> >  2 files changed, 50 insertions(+), 2 deletions(-)
