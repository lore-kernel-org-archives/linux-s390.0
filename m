From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio/s390: fix some races in virtio-ccw
Date: Tue, 25 Sep 2018 17:09:07 +0200
Message-ID: <20180925170907.60750f58.cohuck@redhat.com>
References: <20180925121309.58524-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180925121309.58524-1-pasic@linux.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018 14:13:07 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The trigger for the series is this bug report:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432
> 
> Changelog:
> v1 -> v2:
> * improve on commit messages, add cc:stable 
> RFC -> v1:
> * do mutual exclusion on a per device basis in ccw_io_helper() 
> 
> Halil Pasic (2):
>   virtio/s390: avoid race on vcdev->config
>   virtio/s390: fix race in ccw_io_helper()
> 
>  drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Thanks, queued.
