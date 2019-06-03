Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 17:40:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 5/8] virtio/s390: use cacheline aligned airq bit
 vectors
Message-ID: <20190603174032.58dd0532.cohuck@redhat.com>
In-Reply-To: <20190529122657.166148-6-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-6-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 29 May 2019 14:26:54 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The flag AIRQ_IV_CACHELINE was recently added to airq_iv_create(). Let
> us use it! We actually wanted the vector to span a cacheline all along.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
