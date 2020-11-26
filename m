Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbgKZJnS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 04:43:18 -0500
Date: Thu, 26 Nov 2020 10:42:59 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
Message-ID: <20201126094259.GE8578@t480-pf1aa2c2>
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
 <20201125170658.GB8578@t480-pf1aa2c2>
 <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
 <20201126091353.50cf6ab6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126091353.50cf6ab6.cohuck@redhat.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On Thu, Nov 26, 2020 at 09:13:53AM +0100, Cornelia Huck wrote:
> On Thu, 26 Nov 2020 09:27:41 +0800
> Qinglang Miao <miaoqinglang@huawei.com> wrote:
> 
> > 在 2020/11/26 1:06, Benjamin Block 写道:
> > > On Fri, Nov 20, 2020 at 03:48:54PM +0800, Qinglang Miao wrote:  
> > >> kfree(port) is called in put_device(&port->dev) so that following
> > >> use would cause use-after-free bug.
> > >>
> > >> The former put_device is redundant for device_unregister contains
> > >> put_device already. So just remove it to fix this.
> > >>
> > >> Fixes: 86bdf218a717 ("[SCSI] zfcp: cleanup unit sysfs attribute usage")
> > >> Reported-by: Hulk Robot <hulkci@huawei.com>
> > >> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> > >> ---
> > >>   drivers/s390/scsi/zfcp_unit.c | 2 --
> > >>   1 file changed, 2 deletions(-)
> > >>
> > >> diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
> > >> index e67bf7388..664b77853 100644
> > >> --- a/drivers/s390/scsi/zfcp_unit.c
> > >> +++ b/drivers/s390/scsi/zfcp_unit.c
> > >> @@ -255,8 +255,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
> > >>   		scsi_device_put(sdev);
> > >>   	}
> > >>   
> > >> -	put_device(&unit->dev);
> > >> -
> > >>   	device_unregister(&unit->dev);  
> > >>  >>   	return 0;  
> > > 
> > > Same as in the other mail for `zfcp_sysfs_port_remove_store()`. We
> > > explicitly get a new ref in `_zfcp_unit_find()`, so we also need to put
> > > that away again.
> > >  
> > Sorry, Benjamin, I don't think so, because device_unregister calls 
> > put_device inside.
> > 
> > It seem's that another put_device before or after device_unregister is 
> > useless and even might cause an use-after-free.
> 
> The issue here (and in the other patches that I had commented on) is
> that the references have different origins. device_register() acquires
> a reference, and that reference is given up when you call
> device_unregister(). However, the code here grabs an extra reference,
> and it of course has to give it up again when it no longer needs it.
> 
> This is something that is not that easy to spot by an automated check,
> I guess?
> 

Indeed.

I do think the two patches for zfcp have merit, but not by simply
removing the put_device(), but by moving it.

For this patch in particular, I'd think the "proper logic" would be to
move the `put_device()` to after the `device_unregister()`:

    device_unregister(&unit->dev);
    put_device(&unit->dev);

    return 0;

As Cornelia pointed out, the extra `get_device()` we do in
`_zfcp_unit_find()` needs to be reversed, otherwise we have a dangling
reference and probably some sort of memory-/resource-leak.

Let's go by example. If we assume the reference count of `unit->dev` is
R, and the function starts with R = 1 (otherwise the deivce would've
been freed already), we get:

    int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
    {
    	struct zfcp_unit *unit;
    	struct scsi_device *sdev;
    
    	write_lock_irq(&port->unit_list_lock);
// unit->dev (R = 1)
    	unit = _zfcp_unit_find(port, fcp_lun);
// get_device(&unit->dev)
// unit->dev (R = 2)
    	if (unit)
    		list_del(&unit->list);
    	write_unlock_irq(&port->unit_list_lock);
    
    	if (!unit)
    		return -EINVAL;
    
    	sdev = zfcp_unit_sdev(unit);
    	if (sdev) {
    		scsi_remove_device(sdev);
    		scsi_device_put(sdev);
    	}
    
// unit->dev (R = 2)
    	put_device(&unit->dev);
// unit->dev (R = 1)
    	device_unregister(&unit->dev);
// unit->dev (R = 0)
    
    	return 0;
    }

If we now apply this patch, we'd end up with R = 1 after
`device_unregister()`, and the device would not be properly removed.

If you still think that's wrong, then you'll need to better explain why.


-- 
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Systems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/privacy
Vorsitz. AufsR.: Gregor Pillen         /        Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294
