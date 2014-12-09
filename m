Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Dec 2014 11:35:29 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 2/6] virtio_ccw: legacy: don't negotiate rev
 1/features
Message-ID: <20141209113529.675e8df3.cornelia.huck@de.ibm.com>
In-Reply-To: <1418042769-25539-3-git-send-email-mst@redhat.com>
References: <1418042769-25539-1-git-send-email-mst@redhat.com>
	<1418042769-25539-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, dahi@linux.vnet.ibm.com, rusty@rustcorp.com.au, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 8 Dec 2014 15:05:54 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Legacy balloon device doesn't pretend to support revision 1 or 64 bit
> features.
> 
> But just in case someone implements a broken one that does, let's not
> even try to drive legacy only devices using revision 1, and let's not
> give them a chance to say they support VIRTIO_F_VERSION_1 by not reading

s/reading/reading or writing/

> high feature bits.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Otherwise, looks good.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
