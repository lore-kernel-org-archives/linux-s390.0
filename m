Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Dec 2014 09:20:37 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 18/46] KVM: s390: virtio-ccw revision 1 SET_VQ
Message-ID: <20141201092037.4c560540@thinkpad-w530>
In-Reply-To: <1417359787-10138-19-git-send-email-mst@redhat.com>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
	<1417359787-10138-19-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, cornelia.huck@de.ibm.com, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, thuth@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> The CCW_CMD_SET_VQ command has a different format for revision 1+
> devices, allowing to specify a more complex virtqueue layout. For
> now, we stay however with the old layout and simply use the new
> command format for virtio-1 devices.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 54 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 12 deletions(-)

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
