Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64655 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfJaH5r (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 03:57:47 -0400
Subject: Re: [PATCH V6 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
References: <20191030064444.21166-1-jasowang@redhat.com>
 <20191030064444.21166-7-jasowang@redhat.com>
 <20191030212312.GA4251@infradead.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <1592d723-a580-8614-3fb4-88560a06cdc1@intel.com>
Date: Thu, 31 Oct 2019 15:57:38 +0800
MIME-Version: 1.0
In-Reply-To: <20191030212312.GA4251@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 10/31/2019 5:23 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 02:44:44PM +0800, Jason Wang wrote:
>> This sample driver creates mdev device that simulate virtio net device
>> over virtio mdev transport. The device is implemented through vringh
>> and workqueue. A device specific dma ops is to make sure HVA is used
>> directly as the IOVA. This should be sufficient for kernel virtio
>> driver to work.
>>
>> Only 'virtio' type is supported right now. I plan to add 'vhost' type
>> on top which requires some virtual IOMMU implemented in this sample
>> driver.
> Can we please submit a real driver for it?  A more or less useless
> sample driver doesn't really qualify for our normal kernel requirements
> that infrastructure should have a real user.

Hello Christoph,

I am working on a real hardware driver for it, it's called IFC, I have 
posted RFC V1 and will post RFC V2 soon.

Thanks,
BR
Zhu Lingshan
