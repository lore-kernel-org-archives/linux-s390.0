Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 10/52] s390/dasd: fix using offset into zero size array error
Date: Mon, 11 Mar 2019 15:54:34 -0400
Message-Id: <20190311195516.137772-10-sashal@kernel.org>
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 4a8ef6999bce998fa5813023a9a6b56eea329dba ]

Dan Carpenter reported the following:

The patch 52898025cf7d: "[S390] dasd: security and PSF update patch
for EMC CKD ioctl" from Mar 8, 2010, leads to the following static
checker warning:

	drivers/s390/block/dasd_eckd.c:4486 dasd_symm_io()
	error: using offset into zero size array 'psf_data[]'

drivers/s390/block/dasd_eckd.c
  4458          /* Copy parms from caller */
  4459          rc = -EFAULT;
  4460          if (copy_from_user(&usrparm, argp, sizeof(usrparm)))
                                    ^^^^^^^
The user can specify any "usrparm.psf_data_len".  They choose zero by
mistake.

  4461                  goto out;
  4462          if (is_compat_task()) {
  4463                  /* Make sure pointers are sane even on 31 bit. */
  4464                  rc = -EINVAL;
  4465                  if ((usrparm.psf_data >> 32) != 0)
  4466                          goto out;
  4467                  if ((usrparm.rssd_result >> 32) != 0)
  4468                          goto out;
  4469                  usrparm.psf_data &= 0x7fffffffULL;
  4470                  usrparm.rssd_result &= 0x7fffffffULL;
  4471          }
  4472          /* alloc I/O data area */
  4473          psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL
  			   				 | GFP_DMA);
  4474          rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL
							       | GFP_DMA);
  4475          if (!psf_data || !rssd_result) {

kzalloc() returns a ZERO_SIZE_PTR (0x16).

  4476                  rc = -ENOMEM;
  4477                  goto out_free;
  4478          }
  4479
  4480          /* get syscall header from user space */
  4481          rc = -EFAULT;
  4482          if (copy_from_user(psf_data,
  4483                             (void __user *)(unsigned long)
  				   	 		 usrparm.psf_data,
  4484                             usrparm.psf_data_len))

That all works great.

  4485                  goto out_free;
  4486          psf0 = psf_data[0];
  4487          psf1 = psf_data[1];

But now we're assuming that "->psf_data_len" was at least 2 bytes.

Fix this by checking the user specified length psf_data_len.

Fixes: 52898025cf7d ("[S390] dasd: security and PSF update patch for EMC CKD ioctl")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 4e7b55a14b1a..6e294b4d3635 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4469,6 +4469,14 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 		usrparm.psf_data &= 0x7fffffffULL;
 		usrparm.rssd_result &= 0x7fffffffULL;
 	}
+	/* at least 2 bytes are accessed and should be allocated */
+	if (usrparm.psf_data_len < 2) {
+		DBF_DEV_EVENT(DBF_WARNING, device,
+			      "Symmetrix ioctl invalid data length %d",
+			      usrparm.psf_data_len);
+		rc = -EINVAL;
+		goto out;
+	}
 	/* alloc I/O data area */
 	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
 	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
-- 
2.19.1
