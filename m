Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfJOD1z (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 23:27:55 -0400
Subject: Re: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191011081557.28302-6-jasowang@redhat.com>
 <20191014172301.GA5359@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <97d93729-9bc2-4cb5-5e4f-678285044c7f@redhat.com>
Date: Tue, 15 Oct 2019 11:27:32 +0800
MIME-Version: 1.0
In-Reply-To: <20191014172301.GA5359@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com


On 2019/10/15 上午1:23, Stefan Hajnoczi wrote:
> On Fri, Oct 11, 2019 at 04:15:55PM +0800, Jason Wang wrote:
>> + * @set_vq_cb:			Set the interrut calback function for
> s/interrut/interrupt/
>
> s/calback/callback/


Fixed.

Thanks
