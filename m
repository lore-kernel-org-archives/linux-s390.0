Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727014AbfKSDER (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 22:04:17 -0500
Subject: Re: [PATCH V13 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-7-jasowang@redhat.com>
 <20191118151706.GA371978@kroah.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4fed1e7e-9d27-d441-f0a1-0eb6f15e90b1@redhat.com>
Date: Tue, 19 Nov 2019 11:03:39 +0800
MIME-Version: 1.0
In-Reply-To: <20191118151706.GA371978@kroah.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jgg@mellanox.com, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com


On 2019/11/18 =E4=B8=8B=E5=8D=8811:17, Greg KH wrote:
> On Mon, Nov 18, 2019 at 06:59:23PM +0800, Jason Wang wrote:
>> +static void mvnet_device_release(struct device *dev)
>> +{
>> +=09dev_dbg(dev, "mvnet: released\n");
>> +}
> We used to have documentation in the kernel source tree that said that
> whenever anyone did this, I got to make fun of them.  Unfortunately that
> has been removed.
>
> Think about what you did right here.  You silenced a kernel runtime
> warning that said something like "ERROR! NO RELEASE FUNCTION FOUND!" by
> doing the above because "I am smarter than the kernel, I will silence it
> by putting an empty release function in there."
>
> {sigh}
>
> Did you ever think _why_ we took the time and effort to add that warning
> there?  It wasn't just so that people can circumvent it, it is to
> PREVENT A MAJOR BUG IN YOUR DESIGN!  We are trying to be nice here and
> give people a _chance_ to get things right instead of having you just
> live with a silent memory leak.
>
> After 13 versions of this series, basic things like this are still here?
> Who is reviewing this thing?


Apologize that static structure is used here, will fix them with dynamic=20
one. I just borrow the codes from other vfio-mdev samples without too=20
much thought here ...


>
> {ugh}
>
> Also, see the other conversations we are having about a "virtual" bus
> and devices.  I do not want to have two different ways of doing the same
> thing in the kernel at the same time please.  Please work together with
> the Intel developers to solve this in a unified way, as you both
> need/want the same thing here.


Sure, some functions looks similar, but the "virtual" bus does not=20
contain a management interface and it's not clear that how it can be=20
used by userspace driver. For this series, sysfs/GUID based management=20
interface is reused and we had a concrete example of how it would be=20
used by userspace driver[1] and a real hardware driver implementation[2].

[1] https://lkml.org/lkml/2019/11/7/62
[2] https://lkml.org/lkml/2019/11/12/215


>
> Neither this, nor the other proposal can be accepted until you all agree
> on the design and implementation.


Yes.

Thanks


>
> /me goes off to find a nice fruity drink with an umbrella.
>
> greg k-h
>
