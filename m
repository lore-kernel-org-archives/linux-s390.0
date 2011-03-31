Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 31 Mar 2011 18:55:52 +0200
From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] s390: oprofile: fix error checks in
 oprofile_hwsampler_init()
Message-ID: <20110331185552.5f633573@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <robert.richter@amd.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Checking 'oprofile_min_interval < 0' and
'oprofile_max_interval < 0' doesn't work because
'oprofile_min_interval' and 'oprofile_max_interval' are unsigned.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
Untested.

 arch/s390/oprofile/init.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/oprofile/init.c b/arch/s390/oprofile/init.c
index c63d7e5..09c3088 100644
--- a/arch/s390/oprofile/init.c
+++ b/arch/s390/oprofile/init.c
@@ -138,22 +138,26 @@ static int oprofile_create_hwsampling_files(struct super_block *sb,
 
 static int oprofile_hwsampler_init(struct oprofile_operations *ops)
 {
+	long retval;
+
 	if (hwsampler_setup())
 		return -ENODEV;
 
 	/*
 	 * create hwsampler files only if hwsampler_setup() succeeds.
 	 */
-	oprofile_min_interval = hwsampler_query_min_interval();
-	if (oprofile_min_interval < 0) {
+	retval = hwsampler_query_min_interval();
+	if (retval < 0) {
 		oprofile_min_interval = 0;
 		return -ENODEV;
 	}
-	oprofile_max_interval = hwsampler_query_max_interval();
-	if (oprofile_max_interval < 0) {
+	oprofile_min_interval = retval;
+	retval = hwsampler_query_max_interval();
+	if (retval < 0) {
 		oprofile_max_interval = 0;
 		return -ENODEV;
 	}
+	oprofile_max_interval = retval;
 
 	if (oprofile_timer_init(ops))
 		return -ENODEV;
-- 
1.7.3.4
