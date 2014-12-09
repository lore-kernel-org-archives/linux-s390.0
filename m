Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 9 Dec 2014 18:25:40 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/2] virtio_ccw: future-proof finalize_features
Message-ID: <20141209182540.25009892.cornelia.huck@de.ibm.com>
In-Reply-To: <1418133187-12436-2-git-send-email-mst@redhat.com>
References: <1418133187-12436-1-git-send-email-mst@redhat.com>
	<1418133187-12436-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Dec 2014 15:53:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We never negotiate revision > 1, but just to
> make this code more likely to work when we do,
> require VERSION_1 with any revision >= 1.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
