Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: scsi: zfcp_aux.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:36:58 +0200
Message-Id: <1406385418-3393-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, linux390@de.ibm.com
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/scsi/zfcp_aux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 8004b07..a23ba76 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -101,7 +101,7 @@ static void __init zfcp_init_device_setup(char *devstr)
 	token = strsep(&str, ",");
 	if (!token || strlen(token) >= ZFCP_BUS_ID_SIZE)
 		goto err_out;
-	strncpy(busid, token, ZFCP_BUS_ID_SIZE);
+	strlcpy(busid, token, ZFCP_BUS_ID_SIZE);
 
 	token = strsep(&str, ",");
 	if (!token || kstrtoull(token, 0, (unsigned long long *) &wwpn))
-- 
1.7.10.4
