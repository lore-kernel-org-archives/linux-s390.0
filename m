Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4C5E9365.5030804@in.ibm.com>
Date: Sun, 08 Aug 2010 16:52:13 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: 2.6.35-git6: s390 build failure (drivers/s390/scsi/zfcp_qdio.c)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, christof.schmitt@de.ibm.com, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Latest 2.6.35 git - 2.6.35-git6 (cd816a0d8...) fails to build
on a s390 box with following error :

drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_thread':
drivers/s390/scsi/zfcp_erp.c:1337: warning: frame size of 'zfcp_erp_thread' is 280 bytes
drivers/s390/scsi/zfcp_qdio.c: In function 'zfcp_qdio_siosl':
drivers/s390/scsi/zfcp_qdio.c:467: error: implicit declaration of function 'ccw_device_siosl'
make[2]: *** [drivers/s390/scsi/zfcp_qdio.o] Error 1

This problem seem to have been introduced with git2 (3cfc2c42c1c...) via
commit 339f4f4eab80caa6cf0d39fb057ad6ddb84ba91e

[SCSI] zfcp: Trigger logging in the FCP channel on qdio error conditions

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
