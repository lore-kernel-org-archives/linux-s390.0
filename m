Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/5] s390/pci: Return directly after a failed parameter
 validation in clp_normal_command()
References: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <be482828-096c-889f-b916-1eb7ebe2368c@users.sourceforge.net>
Date: Sat, 21 Jan 2017 19:10:08 +0100
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
Date: Sat, 21 Jan 2017 17:49:00 +0100

Return directly after an inappropriate input parameter was detected.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/pci/pci_clp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 1c3332ac1957..4f5a1bf3b14b 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -514,9 +514,8 @@ static int clp_normal_command(struct clp_req *req)
 	void __user *uptr;
 	int rc;
 
-	rc = -EINVAL;
 	if (req->lps != 0 && req->lps != 2)
-		goto out;
+		return -EINVAL;
 
 	rc = -ENOMEM;
 	lpcb = clp_alloc_block(GFP_KERNEL);
-- 
2.11.0
