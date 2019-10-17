Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389585AbfJQI2M (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Oct 2019 04:28:12 -0400
Subject: Re: [PATCH V3 1/7] mdev: class id support
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191011081557.28302-2-jasowang@redhat.com>
 <AM0PR05MB4866481AEE614FDF766C6A25D1920@AM0PR05MB4866.eurprd05.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67b645a6-1b70-094d-6a12-fc6591e07a13@redhat.com>
Date: Thu, 17 Oct 2019 16:27:41 +0800
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB4866481AEE614FDF766C6A25D1920@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Parav Pandit <parav@mellanox.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>, "freude@linux.ibm.com" <freude@linux.ibm.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, Ido Shamay <idos@mellanox.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>


On 2019/10/16 下午12:57, Parav Pandit wrote:
>> +static struct mdev_class_id id_table[] = {
> static const
>
>> +	{ MDEV_ID_VFIO },
> I guess you don't need extra braces for each entry.
> Since this enum represents MDEV class id, it better to name it as MDEV_CLASS_ID_VFIO.
> (Similar to  PCI_VENDOR_ID, PCI_DEVICE_ID)..
>

Gcc start to complain like:

warning: missing braces around initializer [-Wmissing-braces]
  static const struct mdev_class_id id_table[] = {
                                                 ^
   MDEV_ID_VFIO, 0,
   {           } {
  };
  }

So I will keep this part untouched.

Thanks


>> +	{ 0 },
>> +};
