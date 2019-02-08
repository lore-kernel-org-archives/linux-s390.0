Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Allen <allen.lkml@gmail.com>
Subject: [PATCH] Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
Date: Fri,  8 Feb 2019 08:11:10 +0530
Message-Id: <20190208024110.8021-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

From: Allen Pais <allen.lkml@gmail.com>

This issue was detected with the help of Coccinelle.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/s390/tools/gen_opcode_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b29c81..468b70c85f62 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
 	strcpy(tmp, format);
 	base_format = tmp;
 	base_format = strsep(&base_format, "_");
-	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
 		ptr = insn_type_table[i].format;
 		while (*ptr) {
 			if (!strcmp(base_format, *ptr))
-- 
2.19.1
