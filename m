Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 4/6] vfio-ccw: add capabilities chain
References: <20190301093902.27799-1-cohuck@redhat.com>
 <20190301093902.27799-5-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 15 Apr 2019 11:24:41 -0400
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <75256da4-2e3a-b3f1-d29b-1986b4bcdf79@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 03/01/2019 04:39 AM, Cornelia Huck wrote:
> Allow to extend the regions used by vfio-ccw. The first user will be
> handling of halt and clear subchannel.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   drivers/s390/cio/vfio_ccw_ops.c     | 186 ++++++++++++++++++++++++----
>   drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
>   include/uapi/linux/vfio.h           |   2 +
>   3 files changed, 200 insertions(+), 26 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
