Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/5] s390: open-code s390_personality syscall
Date: Wed, 16 Jan 2019 14:15:19 +0100
Message-Id: <20190116131527.2071570-2-arnd@arndb.de>
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, Dominik Brodowski <linux@dominikbrodowski.net>, Mark Rutland <mark.rutland@arm.com>
List-ID: <linux-s390.vger.kernel.org>

The sys_personality function is not meant to be called from other system
calls. We could introduce an intermediate ksys_personality function,
but it does almost nothing, so this just moves the implementation into
the caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/sys_s390.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 31cefe0c28c0..560bdaf8a74f 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -79,12 +79,15 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
 
 SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
 {
-	unsigned int ret;
+	unsigned int ret = current->personality;
 
 	if (personality(current->personality) == PER_LINUX32 &&
 	    personality(personality) == PER_LINUX)
 		personality |= PER_LINUX32;
-	ret = sys_personality(personality);
+
+	if (personality != 0xffffffff)
+		set_personality(personality);
+
 	if (personality(ret) == PER_LINUX32)
 		ret &= ~PER_LINUX32;
 
-- 
2.20.0
