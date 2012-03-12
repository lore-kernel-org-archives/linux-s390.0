Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20120312002046.202047769@1wt.eu>
Date: Mon, 12 Mar 2012 01:20:51 +0100
From: Willy Tarreau <w@1wt.eu>
Subject: [ 06/12] [S390] KEYS: Enable the compat keyctl wrapper on s390x
In-Reply-To: <feb44625a10a45049eddf27890e95d54@local>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, dan@danny.cz, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2.6.32-longterm review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 1d057720609ed052a6371fe1d53300e5e6328e94 upstream.

Enable the compat keyctl wrapper on s390x so that 32-bit s390 userspace can
call the keyctl() syscall.

There's an s390x assembly wrapper that truncates all the register values to
32-bits and this then calls compat_sys_keyctl() - but the latter only exists if
CONFIG_KEYS_COMPAT is enabled, and the s390 Kconfig doesn't enable it.

Without this patch, 32-bit calls to the keyctl() syscall are given an ENOSYS
error:

	[root@devel4 ~]# keyctl show
	Session Keyring
	-3: key inaccessible (Function not implemented)

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: dan@danny.cz
Cc: Carsten Otte <cotte@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d172758..6d99a5f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -227,6 +227,9 @@ config COMPAT
 config SYSVIPC_COMPAT
 	def_bool y if COMPAT && SYSVIPC
 
+config KEYS_COMPAT
+	def_bool y if COMPAT && KEYS
+
 config AUDIT_ARCH
 	def_bool y
 
