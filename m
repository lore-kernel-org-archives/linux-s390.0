Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: char: tape_class.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:32:22 +0200
Message-Id: <1406385142-3034-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/char/tape_class.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index 91c3c64..76ed29a 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -53,10 +53,10 @@ struct tape_class_device *register_tape_dev(
 	if (!tcd)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(tcd->device_name, device_name, TAPECLASS_NAME_LEN);
+	strlcpy(tcd->device_name, device_name, TAPECLASS_NAME_LEN);
 	for (s = strchr(tcd->device_name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
-	strncpy(tcd->mode_name, mode_name, TAPECLASS_NAME_LEN);
+	strlcpy(tcd->mode_name, mode_name, TAPECLASS_NAME_LEN);
 	for (s = strchr(tcd->mode_name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
 
-- 
1.7.10.4
