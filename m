Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfHNCRP (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Aug 2019 22:17:15 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 50/68] s390: put _stext and _etext into .text section
Date: Tue, 13 Aug 2019 22:15:28 -0400
Message-Id: <20190814021548.16001-50-sashal@kernel.org>
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, Andreas Krebbel <krebbel@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 24350fdadbdec780406a1ef988e6cd3875e374a8 ]

Perf relies on _etext and _stext symbols being one of 't', 'T', 'v' or
'V'. Put them into .text section to guarantee that.

Also moves padding to page boundary inside .text which has an effect that
.text section is now padded with nops rather than 0's, which apparently
has been the initial intention for specifying 0x0700 fill expression.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Andreas Krebbel <krebbel@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vmlinux.lds.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b43f8d33a3697..18ede6e806b91 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -31,10 +31,9 @@ PHDRS {
 SECTIONS
 {
 	. = 0x100000;
-	_stext = .;		/* Start of text section */
 	.text : {
-		/* Text and read-only data */
-		_text = .;
+		_stext = .;		/* Start of text section */
+		_text = .;		/* Text and read-only data */
 		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
@@ -46,11 +45,10 @@ SECTIONS
 		*(.text.*_indirect_*)
 		*(.fixup)
 		*(.gnu.warning)
+		. = ALIGN(PAGE_SIZE);
+		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	. = ALIGN(PAGE_SIZE);
-	_etext = .;		/* End of text section */
-
 	NOTES :text :note
 
 	.dummy : { *(.dummy) } :data
-- 
2.20.1
