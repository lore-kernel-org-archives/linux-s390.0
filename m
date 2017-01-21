Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/5] s390/pci: Return directly after a failed
 clp_alloc_block() in clp_normal_command()
References: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <c002c597-f52c-8fd5-e8d4-2f01a085ddd2@users.sourceforge.net>
Date: Sat, 21 Jan 2017 19:11:15 +0100
MIME-Version: 1.0
In-Reply-To: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Gerald_Sch=c3=a4fer?= <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 17:56:40 +0100

* Return directly after a call of the function "clp_alloc_block"
  failed here.

* Delete the jump label "out" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/pci/pci_clp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 4f5a1bf3b14b..28e13fa7a79c 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -517,10 +517,9 @@ static int clp_normal_command(struct clp_req *req)
 	if (req->lps != 0 && req->lps != 2)
 		return -EINVAL;
 
-	rc = -ENOMEM;
 	lpcb = clp_alloc_block(GFP_KERNEL);
 	if (!lpcb)
-		goto out;
+		return -ENOMEM;
 
 	rc = -EFAULT;
 	uptr = (void __force __user *)(unsigned long) req->data_p;
@@ -550,7 +549,6 @@ static int clp_normal_command(struct clp_req *req)
 
 out_free:
 	clp_free_block(lpcb);
-out:
 	return rc;
 }
 
-- 
2.11.0
