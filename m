From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 03 Aug 2016 12:40:54 +0000
Subject: [bug report] [S390] z/VM unit record device driver
Message-Id: <20160803124054.GA8279@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Frank Munzert,

The patch 810cb5b32ded: "[S390] z/VM unit record device driver" from
Jul 17, 2007, leads to the following static checker warning:

	drivers/s390/char/vmur.c:320 ur_int_handler()
	warn: 'irb' isn't an ERR_PTR

drivers/s390/char/vmur.c
   304  static void ur_int_handler(struct ccw_device *cdev, unsigned long intparm,
   305                             struct irb *irb)
   306  {
   307          struct urdev *urd;
   308  
   309          TRACE("ur_int_handler: intparm=0x%lx cstat=%02x dstat=%02x res=%u\n",
   310                intparm, irb->scsw.cmd.cstat, irb->scsw.cmd.dstat,
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   311                irb->scsw.cmd.count);
                      ^^^^^^^^^^^^^^^^^^^
We already dereferenced irb several times.

   312  
   313          if (!intparm) {
   314                  TRACE("ur_int_handler: unsolicited interrupt\n");
   315                  return;
   316          }
   317          urd = dev_get_drvdata(&cdev->dev);
   318          BUG_ON(!urd);
   319          /* On special conditions irb is an error pointer */
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is possibly true.  The static checker is assuming x86_64 rules.

   320          if (IS_ERR(irb))
                    ^^^^^^^^^^
   321                  urd->io_request_rc = PTR_ERR(irb);
   322          else if (irb->scsw.cmd.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
   323                  urd->io_request_rc = 0;
   324          else
   325                  urd->io_request_rc = -EIO;
   326  
   327          complete(urd->io_done);
   328  }

regards,
dan carpenter
