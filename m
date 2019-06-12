Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407783AbfFLOYA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 10:24:00 -0400
Date: Wed, 12 Jun 2019 16:23:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 2/8] s390/cio: introduce DMA pools to cio
Message-ID: <20190612162348.0c43b806.cohuck@redhat.com>
In-Reply-To: <20190612111236.99538-3-pasic@linux.ibm.com>
References: <20190612111236.99538-1-pasic@linux.ibm.com>
        <20190612111236.99538-3-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>

On Wed, 12 Jun 2019 13:12:30 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> To support protected virtualization cio will need to make sure the
> memory used for communication with the hypervisor is DMA memory.
> 
> Let us introduce one global pool for cio.
> 
> Our DMA pools are implemented as a gen_pool backed with DMA pages. The
> idea is to avoid each allocation effectively wasting a page, as we
> typically allocate much less than PAGE_SIZE.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/cio.h |  11 +++
>  drivers/s390/cio/css.c      | 133 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 141 insertions(+), 4 deletions(-)

Changes look good to me.
