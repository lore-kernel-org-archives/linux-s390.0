Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: net: ctcm_main.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:33:54 +0200
Message-Id: <1406385234-3123-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/net/ctcm_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 03b6ad0..670fa7d 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -204,8 +204,8 @@ static void channel_remove(struct channel *ch)
 
 	if (ch == NULL)
 		return;
-	else
-		strncpy(chid, ch->id, CTCM_ID_SIZE);
+
+	strlcpy(chid, ch->id, CTCM_ID_SIZE);
 
 	channel_free(ch);
 	while (*c) {
-- 
1.7.10.4
