Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Dec 2014 08:52:22 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 06/46] virtio_ccw: add support for 64 bit features.
Message-ID: <20141201085222.0715e878@thinkpad-w530>
In-Reply-To: <1417359787-10138-7-git-send-email-mst@redhat.com>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
	<1417359787-10138-7-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, cornelia.huck@de.ibm.com, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> Negotiate full 64 bit features.
> Change u32 to u64, make sure to use 1ULL everywhere.
> 
> Note: devices guarantee that VERSION_1 is clear unless
> revision 1 is negotiated.
> 
> Note: We don't need to re-setup the ccw, but we do it
> for clarity.
> 
> Based on patches by Rusty, Thomas Huth and Cornelia.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Hildebrand <dahi@linux.vnet.ibm.com>
