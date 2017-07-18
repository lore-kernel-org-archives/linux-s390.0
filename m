From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/2] vfio-ccw bugfixs
Date: Tue, 18 Jul 2017 11:26:19 +0200
Message-ID: <20170718112619.6f455bc2@gondolin>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Jul 2017 03:49:24 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Dear Conny,
> 
> Here we got two bugfix patches for vfio-ccw:
> - fix commit 7da624e2 which missed to initialize a new introduced
>   pointer for the vfio-ccw case
> - fix a memory allocation that used a wrong size for an irq info
>   variable
> 
> Dong Jia Shi (1):
>   vfio/ccw: fix initialization of the Object DeviceState pointer in the
>     common base-device
> 
> Jing Zhang (1):
>   vfio/ccw: allocate irq info with the right size
> 
>  hw/vfio/ccw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks, queued to my s390-next branch.

As these are bugfixes, I'll send a pullreq next week.
