Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH] checkpatch: HLIST_HEAD is also declaration
Date: Wed, 14 Jun 2017 12:16:26 +0200
Message-Id: <20170614101626.81494-1-maier@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Fixes the following false warning:

    WARNING: Missing a blank line after declarations
    #71: FILE: drivers/s390/scsi/zfcp_fsf.c:422:
    +	struct hlist_node *tmp;
    +	HLIST_HEAD(remove_queue);

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baa3c7be04ad..a539fb2561bc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -714,7 +714,7 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
-	(?:$Storage\s+)?LIST_HEAD\s*\(|
+	(?:$Storage\s+)?H?LIST_HEAD\s*\(|
 	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(
 )};
 
-- 
2.11.2
