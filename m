Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 5/5] s390/pci: Move two assignments for the variable "ret" in
 get_pfn()
References: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <99fa9b19-143b-1d11-755a-a1de606b6953@users.sourceforge.net>
Date: Sat, 21 Jan 2017 19:14:37 +0100
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
Date: Sat, 21 Jan 2017 18:48:45 +0100

A local variable was set to an error code in two cases before a concrete
error situation was detected. Thus move the corresponding assignments into
if branches to indicate a software failure there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/s390/pci/pci_mmio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index f125858a77e9..400af13ef275 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -18,13 +18,15 @@ static long get_pfn(unsigned long user_addr, unsigned long access,
 	long ret;
 
 	down_read(&current->mm->mmap_sem);
-	ret = -EINVAL;
 	vma = find_vma(current->mm, user_addr);
-	if (!vma)
+	if (!vma) {
+		ret = -EINVAL;
 		goto out;
-	ret = -EACCES;
-	if (!(vma->vm_flags & access))
+	}
+	if (!(vma->vm_flags & access)) {
+		ret = -EACCES;
 		goto out;
+	}
 	ret = follow_pfn(vma, user_addr, pfn);
 out:
 	up_read(&current->mm->mmap_sem);
-- 
2.11.0
