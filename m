Return-Path: <linux-kernel-owner+w=401wt.eu-S1759865AbXGWIxt@vger.kernel.org>
Message-Id: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/9] s390 update for 2.6.23-rc1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The shortlog speaks for itself:

Christian Borntraeger (1):
      [S390] add types.h include to s390_ext.h

Cornelia Huck (3):
      [S390] cio: css_sch_device_register() can be made static.
      [S390] cio: Remove remains of _ccw_device_get_device_number().
      [S390] cio: Remove deprecated rdc/rcd.

Heiko Carstens (4):
      [S390] Convert to smp_call_function_single.
      [S390] Improve __smp_call_function_map.
      [S390] sclp: kill unused SCLP config option.
      [S390] Get rid of new section mismatch warnings.

Martin Schwidefsky (1):
      [S390] Wire up sys_fallocate.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
