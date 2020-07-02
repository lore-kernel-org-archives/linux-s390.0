Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 36/53] s390/debug: avoid kernel warning on too large number of pages
Date: Wed,  1 Jul 2020 21:21:45 -0400
Message-Id: <20200702012202.2700645-36-sashal@kernel.org>
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 827c4913923e0b441ba07ba4cc41e01181102303 ]

When specifying insanely large debug buffers a kernel warning is
printed. The debug code does handle the error gracefully, though.
Instead of duplicating the check let us silence the warning to
avoid crashes when panic_on_warn is used.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 6d321f5f101d6..7184d55d87aae 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -198,9 +198,10 @@ static debug_entry_t ***debug_areas_alloc(int pages_per_area, int nr_areas)
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
+		/* GFP_NOWARN to avoid user triggerable WARN, we handle fails */
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(debug_entry_t *),
-					 GFP_KERNEL);
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!areas[i])
 			goto fail_malloc_areas2;
 		for (j = 0; j < pages_per_area; j++) {
-- 
2.25.1
