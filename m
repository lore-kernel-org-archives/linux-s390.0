Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Nov 2017 10:09:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/2] s390/virtio: add BSD license to virtio-ccw
Message-ID: <20171124100954.5429a9a3.cohuck@redhat.com>
In-Reply-To: <1511500846-24696-2-git-send-email-mst@redhat.com>
References: <1511500846-24696-1-git-send-email-mst@redhat.com>
        <1511500846-24696-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 24 Nov 2017 07:21:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> The original intent of the virtio header relicensing
> from 2008 was to make sure anyone can implement compatible
> devices/drivers. The virtio-ccw was omitted by mistake.
> 
> We have an ack from the only contributor as well as the
> maintainer from IBM, so it's not too late to fix that.
> 
> Make it dual-licensed with GPLv2, as the whole kernel is GPL2.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/s390/include/uapi/asm/virtio-ccw.h | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)

As noted by Thomas, patch 1 is not needed anymore. Who will merge this
one?
