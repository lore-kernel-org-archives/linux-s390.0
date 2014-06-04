Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: scsi: zfcp_aux.c:  Cleaning up missing null-terminate after strncpy call
Date: Wed,  4 Jun 2014 23:31:11 +0200
Message-Id: <1401917471-2869-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, linux390@de.ibm.com
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Added a guaranteed null-terminate after call to strncpy.

This was partly found using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/scsi/zfcp_aux.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 8004b07..138b84a 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -102,6 +102,7 @@ static void __init zfcp_init_device_setup(char *devstr)
 	if (!token || strlen(token) >= ZFCP_BUS_ID_SIZE)
 		goto err_out;
 	strncpy(busid, token, ZFCP_BUS_ID_SIZE);
+	busid[sizeof(busid) - 1] = '\0';
 
 	token = strsep(&str, ",");
 	if (!token || kstrtoull(token, 0, (unsigned long long *) &wwpn))
-- 
1.7.10.4
