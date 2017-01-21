Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/5] s390/pci: Move three assignments for the variable "rc" in
 clp_normal_command()
References: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <d8178ea8-8a46-b922-c486-d741dd916565@users.sourceforge.net>
Date: Sat, 21 Jan 2017 19:12:27 +0100
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
Date: Sat, 21 Jan 2017 18:10:57 +0100

A local variable was set to an error code before a concrete error situation
was detected. Thus move the corresponding assignments into if branches
to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/pci/pci_clp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 28e13fa7a79c..bde0291cc724 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -521,14 +521,16 @@ static int clp_normal_command(struct clp_req *req)
 	if (!lpcb)
 		return -ENOMEM;
 
-	rc = -EFAULT;
 	uptr = (void __force __user *)(unsigned long) req->data_p;
-	if (copy_from_user(lpcb, uptr, PAGE_SIZE) != 0)
+	if (copy_from_user(lpcb, uptr, PAGE_SIZE) != 0) {
+		rc = -EFAULT;
 		goto out_free;
+	}
 
-	rc = -EINVAL;
-	if (lpcb->fmt != 0 || lpcb->reserved1 != 0 || lpcb->reserved2 != 0)
+	if (lpcb->fmt != 0 || lpcb->reserved1 != 0 || lpcb->reserved2 != 0) {
+		rc = -EINVAL;
 		goto out_free;
+	}
 
 	switch (req->lps) {
 	case 0:
@@ -541,9 +543,8 @@ static int clp_normal_command(struct clp_req *req)
 	if (rc)
 		goto out_free;
 
-	rc = -EFAULT;
 	if (copy_to_user(uptr, lpcb, PAGE_SIZE) != 0)
-		goto out_free;
+		rc = -EFAULT;
 
 	rc = 0;
 
-- 
2.11.0
