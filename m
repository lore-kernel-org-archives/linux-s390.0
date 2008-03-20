Return-Path: <linux-kernel-owner+w=401wt.eu-S1756694AbYCTQNl@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Thu, 20 Mar 2008 17:13:04 +0100
Message-Id: <1206029584.23671.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/lib/uaccess_pt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Heiko Carstens (1):
      [S390] futex: let futex_atomic_cmpxchg_pt survive early functional tests.

diff --git a/arch/s390/lib/uaccess_pt.c b/arch/s390/lib/uaccess_pt.c
index 7e8efaa..5efdfe9 100644
--- a/arch/s390/lib/uaccess_pt.c
+++ b/arch/s390/lib/uaccess_pt.c
@@ -406,6 +406,8 @@ int futex_atomic_cmpxchg_pt(int __user *uaddr, int oldval, int newval)
 {
 	int ret;
 
+	if (!current->mm)
+		return -EFAULT;
 	spin_lock(&current->mm->page_table_lock);
 	uaddr = (int __user *) __dat_user_addr((unsigned long) uaddr);
 	if (!uaddr) {
