Date: Mon, 15 Jan 2018 12:52:42 +0100
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: [PATCH] s390: fix setgid16/setuid16 handling of -1
Message-ID: <20180115115242.GA15131@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Eugene Syromiatnikov <esyr@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For some reason, the implementation of these two 16-bit ID system calls
used cast instead of low2highgid/low2highuid macros for converting [GU]IDs,
which leads to incorrect handling of value of -1 (which ought to be
considered invalid).

Discovered by strace test suite.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 arch/s390/kernel/compat_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index f04db37..e48a31a 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -110,7 +110,7 @@ COMPAT_SYSCALL_DEFINE2(s390_setregid16, u16, rgid, u16, egid)
 
 COMPAT_SYSCALL_DEFINE1(s390_setgid16, u16, gid)
 {
-	return sys_setgid((gid_t)gid);
+	return sys_setgid(low2highgid(gid));
 }
 
 COMPAT_SYSCALL_DEFINE2(s390_setreuid16, u16, ruid, u16, euid)
@@ -120,7 +120,7 @@ COMPAT_SYSCALL_DEFINE2(s390_setreuid16, u16, ruid, u16, euid)
 
 COMPAT_SYSCALL_DEFINE1(s390_setuid16, u16, uid)
 {
-	return sys_setuid((uid_t)uid);
+	return sys_setuid(low2highuid(uid));
 }
 
 COMPAT_SYSCALL_DEFINE3(s390_setresuid16, u16, ruid, u16, euid, u16, suid)
-- 
2.9.3
