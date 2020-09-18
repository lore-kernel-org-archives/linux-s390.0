Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgIRCJH (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Sep 2020 22:09:07 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 054/206] s390/cpum_sf: Use kzalloc and minor changes
Date: Thu, 17 Sep 2020 22:05:30 -0400
Message-Id: <20200918020802.2065198-54-sashal@kernel.org>
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 32dab6828c42f087439d3e2617dc7283546bd8f7 ]

Use kzalloc() to allocate auxiliary buffer structure initialized
with all zeroes to avoid random value in trace output.

Avoid double access to SBD hardware flags.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 74a296cea21cc..0e6d01225a670 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1377,8 +1377,8 @@ static int aux_output_begin(struct perf_output_handle *handle,
 		idx = aux->empty_mark + 1;
 		for (i = 0; i < range_scan; i++, idx++) {
 			te = aux_sdb_trailer(aux, idx);
-			te->flags = te->flags & ~SDB_TE_BUFFER_FULL_MASK;
-			te->flags = te->flags & ~SDB_TE_ALERT_REQ_MASK;
+			te->flags &= ~(SDB_TE_BUFFER_FULL_MASK |
+				       SDB_TE_ALERT_REQ_MASK);
 			te->overflow = 0;
 		}
 		/* Save the position of empty SDBs */
@@ -1425,8 +1425,7 @@ static bool aux_set_alert(struct aux_buffer *aux, unsigned long alert_index,
 	te = aux_sdb_trailer(aux, alert_index);
 	do {
 		orig_flags = te->flags;
-		orig_overflow = te->overflow;
-		*overflow = orig_overflow;
+		*overflow = orig_overflow = te->overflow;
 		if (orig_flags & SDB_TE_BUFFER_FULL_MASK) {
 			/*
 			 * SDB is already set by hardware.
@@ -1660,7 +1659,7 @@ static void *aux_buffer_setup(struct perf_event *event, void **pages,
 	}
 
 	/* Allocate aux_buffer struct for the event */
-	aux = kmalloc(sizeof(struct aux_buffer), GFP_KERNEL);
+	aux = kzalloc(sizeof(struct aux_buffer), GFP_KERNEL);
 	if (!aux)
 		goto no_aux;
 	sfb = &aux->sfb;
-- 
2.25.1
