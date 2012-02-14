Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] KEYS: Enable the compat keyctl wrapper on s390x
Date: Tue, 14 Feb 2012 14:50:22 +0000
Message-ID: <20120214145022.12531.16731.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: keyrings@linux-nfs.org
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, dan@danny.cz, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

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
cc: Carsten Otte <cotte@de.ibm.com>
cc: Christian Borntraeger <borntraeger@de.ibm.com>
cc: linux-s390@vger.kernel.org
cc: stable@vger.kernel.org
---

 arch/s390/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

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
 
