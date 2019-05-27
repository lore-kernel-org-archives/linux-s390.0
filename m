Return-Path: <SRS0=9P2n=T3=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v2 2/8] s390/cio: introduce DMA pools to cio
References: <20190523162209.9543-1-mimu@linux.ibm.com>
 <20190523162209.9543-3-mimu@linux.ibm.com>
 <alpine.LFD.2.21.1905251115590.3359@schleppi>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 27 May 2019 13:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1905251115590.3359@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a42a0d7d-fd0b-b1bf-d4d9-3d64a8ff31f1@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 25.05.19 11:22, Sebastian Ott wrote:
> 
> On Thu, 23 May 2019, Michael Mueller wrote:
>> +static void __init cio_dma_pool_init(void)
>> +{
>> +	/* No need to free up the resources: compiled in */
>> +	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1);
> 
> This can return NULL.

css_bus_init() will fail with -ENOMEM in v3

> 
>> +/**
>> + * Allocate dma memory from the css global pool. Intended for memory not
>> + * specific to any single device within the css. The allocated memory
>> + * is not guaranteed to be 31-bit addressable.
>> + *
>> + * Caution: Not suitable for early stuff like console.
>> + *
>> + */
> 
> drivers/s390/cio/css.c:1121: warning: Function parameter or member 'size' not described in 'cio_dma_zalloc'

will complete param description in v3

> 
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>

Thanks!

> 

Michael
