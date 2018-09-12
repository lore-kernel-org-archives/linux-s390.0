From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 12 Sep 2018 14:04:27 +0000
Subject: Re: [RFC PATCH 0/2] virtio/s390: fix some races in virtio-ccw
Message-Id: <abdfff3e-3b63-17f0-5124-618799b7a1f1@linux.ibm.com>
In-Reply-To: <20180912140202.12292-1-pasic@linux.ibm.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 09/12/2018 04:02 PM, Halil Pasic wrote:
> Came up with these while investigating
> https://bugzilla.linux.ibm.com/show_bug.cgi?id=170918

Sorry bad reference, this is the correct one
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432

> 
> It's RFC because I don't really understand the original design, and I'm
> not sure this is the best way to fix the problems. Thus took I took
> minimal intrusive approach.
> 
> Halil Pasic (2):
>    virtio/s390: avoid race on vcdev->config
>    virtio/s390: fix race in ccw_io_helper()
> 
>   drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
