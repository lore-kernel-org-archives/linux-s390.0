Return-Path: <SRS0=LDNP=TN=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 13 May 2019 14:20:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 10/10] virtio/s390: make airq summary indicators DMA
Message-ID: <20190513142010.36c8478f.cohuck@redhat.com>
In-Reply-To: <20190426183245.37939-11-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-11-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 26 Apr 2019 20:32:45 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Hypervisor needs to interact with the summary indicators, so these
> need to be DMA memory as well (at least for protected virtualization
> guests).
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

(...)

> @@ -237,7 +243,8 @@ static void virtio_airq_handler(struct airq_struct *airq)
>  	read_unlock(&info->lock);
>  }
>  
> -static struct airq_info *new_airq_info(void)
> +/* call with airq_areas_lock held */

Hm, where is airq_areas_lock defined? If it was introduced in one of
the previous patches, I have missed it.

> +static struct airq_info *new_airq_info(int index)
>  {
>  	struct airq_info *info;
>  	int rc;
