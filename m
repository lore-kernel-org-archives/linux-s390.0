Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfIYL5d (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Sep 2019 07:57:33 -0400
Subject: Re: [PATCH 5/6] vringh: fix copy direction of vringh_iov_push_kern()
References: <20190923130331.29324-1-jasowang@redhat.com>
 <20190923130331.29324-6-jasowang@redhat.com>
 <20190923094559.765da494@x1.home>
 <20190923115930-mutt-send-email-mst@kernel.org>
 <20190924080413.0cc875c5@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2f145744-cbfb-5bc3-0e2c-e8c23c20b42d@redhat.com>
Date: Wed, 25 Sep 2019 19:56:33 +0800
MIME-Version: 1.0
In-Reply-To: <20190924080413.0cc875c5@x1.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com


On 2019/9/24 下午10:04, Alex Williamson wrote:
> On Mon, 23 Sep 2019 12:00:41 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
>> On Mon, Sep 23, 2019 at 09:45:59AM -0600, Alex Williamson wrote:
>>> On Mon, 23 Sep 2019 21:03:30 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>   
>>>> We want to copy from iov to buf, so the direction was wrong.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>  drivers/vhost/vringh.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)  
>>> Why is this included in the series?  Seems like an unrelated fix being
>>> held up within a proposal for a new feature.  Thanks,
>>>
>>> Alex  
>> It's better to have it as patch 1/6, but it's a dependency of the
>> example driver in the series. I can reorder when I apply.
> It's a fix, please submit it separately through virtio/vhost channels,
> then it will already be in the base kernel we use for the rest of the
> series.  The remainder of the series certainly suggests a workflow
> through the vfio tree rather than virtio/vhost.  Thanks,
>
> Alex


Ok.

Thanks
