Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbgBSPJd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Feb 2020 10:09:33 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JF90kU038770
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 10:09:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubngsu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 19 Feb 2020 10:09:31 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Wed, 19 Feb 2020 15:09:30 -0000
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH] zfcp: fix wrong data and display format of SFP+ temperature
Date: Wed, 19 Feb 2020 16:09:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <d6e3be5428da5c9490cfff4df7cae868bc9f1a7e.1582039501.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org

When implementing support for retrieval of local diagnostic data from
the FCP channel, the wrong data format was assumed for the temperature
of the local SFP+ connector. The Fibre Channel Link Services (FC-LS-3)
specification is not clear on the format of the stored integer, and only
after consulting the SNIA specification SFF-8472 did we realize it is
stored as two's complement. Thus, the used data and display format is
wrong, and highly misleading for users when the temperature should drop
below 0°C (however unlikely that may be).

To fix this, change the data format in `struct fsf_qtcb_bottom_port`
from unsigned to signed, and change the printf format string used to
generate `zfcp_sysfs_adapter_diag_sfp_temperature_show()` from `%hu` to
`%hd`.

Fixes: a10a61e807b0 ("scsi: zfcp: support retrieval of SFP Data via Exchange Port Data")
Fixes: 6028f7c4cd87 ("scsi: zfcp: introduce sysfs interface for diagnostics of local SFP transceiver")
Cc: <stable@vger.kernel.org> # 5.5+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---

Hello James, Martin,

please consider this patch to be included in scsi-fixes, I also tagged
it for stable. It fixes a bug I found with the exposed hardware
diagnostics we introduced with 5.5.

Tests have been done by injecting negative temperatures in the used data
structures, in the same format specified in SNIA's SFF-8472 (Table
9-2).

    crash vmlinux /proc/kcore
    p ((struct zfcp_adapter *)((struct ccw_device *)0x00000001be250800)->dev.driver_data)->diagnostics->port_data.data.temperature
    $8 = 0xffff
    crash> ^Z
    [1]+  Stopped                 crash vmlinux /proc/kcore
    ~ # cat /sys/bus/ccw/drivers/zfcp/0.0.1900/diagnostics/temperature
    -1

    crash vmlinux /proc/kcore
    p ((struct zfcp_adapter *)((struct ccw_device *)0x00000001be250800)->dev.driver_data)->diagnostics->port_data.data.temperature
    $9 = 0xff00
    crash> ^Z
    [1]+  Stopped                 crash vmlinux /proc/kcore
    ~ # cat /sys/bus/ccw/drivers/zfcp/0.0.1900/diagnostics/temperature
    -256

Reviews and comments are welcome :-).


 drivers/s390/scsi/zfcp_fsf.h   | 2 +-
 drivers/s390/scsi/zfcp_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 2b1e4da1944f..4bfb79f20588 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -410,7 +410,7 @@ struct fsf_qtcb_bottom_port {
 	u8 cb_util;
 	u8 a_util;
 	u8 res2;
-	u16 temperature;
+	s16 temperature;
 	u16 vcc;
 	u16 tx_bias;
 	u16 tx_power;
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index 494b9fe9cc94..a711a0d15100 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -800,7 +800,7 @@ static ZFCP_DEV_ATTR(adapter_diag, b2b_credit, 0400,
 	static ZFCP_DEV_ATTR(adapter_diag_sfp, _name, 0400,		       \
 			     zfcp_sysfs_adapter_diag_sfp_##_name##_show, NULL)
 
-ZFCP_DEFINE_DIAG_SFP_ATTR(temperature, temperature, 5, "%hu");
+ZFCP_DEFINE_DIAG_SFP_ATTR(temperature, temperature, 6, "%hd");
 ZFCP_DEFINE_DIAG_SFP_ATTR(vcc, vcc, 5, "%hu");
 ZFCP_DEFINE_DIAG_SFP_ATTR(tx_bias, tx_bias, 5, "%hu");
 ZFCP_DEFINE_DIAG_SFP_ATTR(tx_power, tx_power, 5, "%hu");
-- 
2.24.1
