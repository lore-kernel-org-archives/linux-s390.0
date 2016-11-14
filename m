Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 14 Nov 2016 00:14:07 +0000
Message-ID: <lsq.1479082447.763513823@decadent.org.uk>
Subject: [PATCH 3.2 049/152] s390: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
In-Reply-To: <lsq.1479082446.271293126@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

3.2.84-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 68c5cf5a6091c2c3fabccfd42ca844d730ec24c6 upstream.

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for s390 at all even though ARCH_DLINFO can contain one NEW_AUX_ENT when
VDSO is enabled.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which s390 doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: b020632e40c3 ("[S390] introduce vdso on s390")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/elf.h    | 1 +
 arch/s390/include/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -199,6 +199,7 @@ do {								\
 
 #define STACK_RND_MASK	0x7ffUL
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							    \
 do {									    \
 	if (vdso_enabled)						    \
--- a/arch/s390/include/asm/auxvec.h
+++ b/arch/s390/include/asm/auxvec.h
@@ -3,4 +3,6 @@
 
 #define AT_SYSINFO_EHDR		33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
