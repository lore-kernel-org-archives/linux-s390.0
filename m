Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1370080336.29224.23.camel@localhost.localdomain>
Subject: [PATCH] s390/dasd: Cocci spatch "ptr_ret.spatch"
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 01 Jun 2013 11:52:16 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2968,7 +2968,7 @@ static int prepare_itcw(struct itcw *itc
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
 		     &pfxdata, sizeof(pfxdata), total_data_size);
-	return IS_ERR(dcw) ? PTR_ERR(dcw) : 0;
+	return PTR_RET(dcw);
 }
 
 static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
