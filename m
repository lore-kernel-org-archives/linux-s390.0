Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgIUOkk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 10:40:40 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.8 09/20] s390/init: add missing __init annotations
Date: Mon, 21 Sep 2020 10:40:16 -0400
Message-Id: <20200921144027.2135390-9-sashal@kernel.org>
In-Reply-To: <20200921144027.2135390-1-sashal@kernel.org>
References: <20200921144027.2135390-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit fcb2b70cdb194157678fb1a75f9ff499aeba3d2a ]

Add __init to reserve_memory_end, reserve_oldmem and remove_oldmem.
Sometimes these functions are not inlined, and then the build
complains about section mismatch.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 07aa15ba43b3e..faf30f37c6361 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -619,7 +619,7 @@ static struct notifier_block kdump_mem_nb = {
 /*
  * Make sure that the area behind memory_end is protected
  */
-static void reserve_memory_end(void)
+static void __init reserve_memory_end(void)
 {
 	if (memory_end_set)
 		memblock_reserve(memory_end, ULONG_MAX);
@@ -628,7 +628,7 @@ static void reserve_memory_end(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void reserve_oldmem(void)
+static void __init reserve_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
@@ -640,7 +640,7 @@ static void reserve_oldmem(void)
 /*
  * Make sure that oldmem, where the dump is stored, is protected
  */
-static void remove_oldmem(void)
+static void __init remove_oldmem(void)
 {
 #ifdef CONFIG_CRASH_DUMP
 	if (OLDMEM_BASE)
-- 
2.25.1
