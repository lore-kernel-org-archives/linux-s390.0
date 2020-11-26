Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389316AbgKZPNH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 10:13:07 -0500
Date: Thu, 26 Nov 2020 16:12:42 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
Message-ID: <20201126151242.GI8578@t480-pf1aa2c2>
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
 <20201125170658.GB8578@t480-pf1aa2c2>
 <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
 <20201126091353.50cf6ab6.cohuck@redhat.com>
 <20201126094259.GE8578@t480-pf1aa2c2>
 <9ba663ad-97fe-6c2a-e15a-45f2de1f0af0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba663ad-97fe-6c2a-e15a-45f2de1f0af0@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On Thu, Nov 26, 2020 at 08:07:32PM +0800, Qinglang Miao wrote:
> 在 2020/11/26 17:42, Benjamin Block 写道:
> > On Thu, Nov 26, 2020 at 09:13:53AM +0100, Cornelia Huck wrote:
> > > On Thu, 26 Nov 2020 09:27:41 +0800
> > > Qinglang Miao <miaoqinglang@huawei.com> wrote:
> > > > 在 2020/11/26 1:06, Benjamin Block 写道:
> > > > > On Fri, Nov 20, 2020 at 03:48:54PM +0800, Qinglang Miao wrote:
....
> > Let's go by example. If we assume the reference count of `unit->dev` is
> > R, and the function starts with R = 1 (otherwise the deivce would've
> > been freed already), we get:
> > 
> >      int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
> >      {
> >      	struct zfcp_unit *unit;
> >      	struct scsi_device *sdev;
> >      	write_lock_irq(&port->unit_list_lock);
> > // unit->dev (R = 1)
> >      	unit = _zfcp_unit_find(port, fcp_lun);
> > // get_device(&unit->dev)
> > // unit->dev (R = 2)
> >      	if (unit)
> >      		list_del(&unit->list);
> >      	write_unlock_irq(&port->unit_list_lock);
> >      	if (!unit)
> >      		return -EINVAL;
> >      	sdev = zfcp_unit_sdev(unit);
> >      	if (sdev) {
> >      		scsi_remove_device(sdev);
> >      		scsi_device_put(sdev);
> >      	}
> > // unit->dev (R = 2)
> >      	put_device(&unit->dev);
> > // unit->dev (R = 1)
> >      	device_unregister(&unit->dev);
> > // unit->dev (R = 0)
> >      	return 0;
> >      }
> > 
> > If we now apply this patch, we'd end up with R = 1 after
> > `device_unregister()`, and the device would not be properly removed.
> > 
> > If you still think that's wrong, then you'll need to better explain why.
> > 
> Hi Banjamin and Cornelia,
> 
> Your replies make me reliaze that I've been holding a mistake understanding
> of put_device() as well as reference count.
> 
> Thanks for you two's patient explanation !!
> 
> BTW, should I send a v2 on these two patches to move the position of
> put_device()?

Feel free to do so.

I think having the `put_device()` call after `device_unregister()` in
both `zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` is more
natural, because it ought to be the last time we touch the object in
both functions.


-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /        Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
