Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388435AbfGZNov (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:51 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 13/30] scsi: zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized
Date: Fri, 26 Jul 2019 09:44:15 -0400
Message-Id: <20190726134432.12993-13-sashal@kernel.org>
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Benjamin Block <bblock@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Benjamin Block <bblock@linux.ibm.com>

[ Upstream commit 484647088826f2f651acbda6bcf9536b8a466703 ]

GCC v9 emits this warning:
      CC      drivers/s390/scsi/zfcp_erp.o
    drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_action_enqueue':
    drivers/s390/scsi/zfcp_erp.c:217:26: warning: 'erp_action' may be used uninitialized in this function [-Wmaybe-uninitialized]
      217 |  struct zfcp_erp_action *erp_action;
          |                          ^~~~~~~~~~

This is a possible false positive case, as also documented in the GCC
documentations:
    https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized

The actual code-sequence is like this:
    Various callers can invoke the function below with the argument "want"
    being one of:
    ZFCP_ERP_ACTION_REOPEN_ADAPTER,
    ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
    ZFCP_ERP_ACTION_REOPEN_PORT, or
    ZFCP_ERP_ACTION_REOPEN_LUN.

    zfcp_erp_action_enqueue(want, ...)
        ...
        need = zfcp_erp_required_act(want, ...)
            need = want
            ...
            maybe: need = ZFCP_ERP_ACTION_REOPEN_PORT
            maybe: need = ZFCP_ERP_ACTION_REOPEN_ADAPTER
            ...
            return need
        ...
        zfcp_erp_setup_act(need, ...)
            struct zfcp_erp_action *erp_action; // <== line 217
            ...
            switch(need) {
            case ZFCP_ERP_ACTION_REOPEN_LUN:
                    ...
                    erp_action = &zfcp_sdev->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_PORT:
            case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
                    ...
                    erp_action = &port->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
                    ...
                    erp_action = &adapter->erp_action;
                    WARN_ON_ONCE(erp_action->port != NULL); // <== access
                    ...
                    break;
            }
            ...
            WARN_ON_ONCE(erp_action->adapter != adapter); // <== access

When zfcp_erp_setup_act() is called, 'need' will never be anything else
than one of the 4 possible enumeration-names that are used in the
switch-case, and 'erp_action' is initialized for every one of them, before
it is used. Thus the warning is a false positive, as documented.

We introduce the extra if{} in the beginning to create an extra code-flow,
so the compiler can be convinced that the switch-case will never see any
other value.

BUG_ON()/BUG() is intentionally not used to not crash anything, should
this ever happen anyway - right now it's impossible, as argued above; and
it doesn't introduce a 'default:' switch-case to retain warnings should
'enum zfcp_erp_act_type' ever be extended and no explicit case be
introduced. See also v5.0 commit 399b6c8bc9f7 ("scsi: zfcp: drop old
default switch case which might paper over missing case").

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/scsi/zfcp_erp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index abe460eac712..cc62d8cc8cfd 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/kthread.h>
+#include <linux/bug.h>
 #include "zfcp_ext.h"
 #include "zfcp_reqlist.h"
 
@@ -244,6 +245,12 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(int need, u32 act_status,
 	struct zfcp_erp_action *erp_action;
 	struct zfcp_scsi_dev *zfcp_sdev;
 
+	if (WARN_ON_ONCE(need != ZFCP_ERP_ACTION_REOPEN_LUN &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT_FORCED &&
+			 need != ZFCP_ERP_ACTION_REOPEN_ADAPTER))
+		return NULL;
+
 	switch (need) {
 	case ZFCP_ERP_ACTION_REOPEN_LUN:
 		zfcp_sdev = sdev_to_zfcp(sdev);
-- 
2.20.1
