Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbfFRVFw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Jun 2019 17:05:52 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v1 17/22] docs: add arch doc directories to the index
Date: Tue, 18 Jun 2019 18:05:41 -0300
Message-Id: <361595adad058766dd3429db996dd78b5e234621.1560891322.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org

Now that several arch documents were converted to ReST,
add their indexes to Documentation/index.rst and remove the
:orphan:  from them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/arm/index.rst    |  2 --
 Documentation/arm64/index.rst  |  2 --
 Documentation/ia64/index.rst   |  2 --
 Documentation/index.rst        | 10 ++++++++++
 Documentation/m68k/index.rst   |  2 --
 Documentation/riscv/index.rst  |  2 --
 Documentation/s390/index.rst   |  2 --
 Documentation/sparc/index.rst  |  2 --
 Documentation/xtensa/index.rst |  2 --
 9 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index bd316d1a1802..9c2f781f4685 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -1,5 +1,3 @@
-﻿:orphan:
-
 ================
 ARM Architecture
 ================
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 018b7836ecb7..96b696ba4e6c 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 ARM64 Architecture
 ==================
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
index a3e3052ad6e2..ef99475f672b 100644
--- a/Documentation/ia64/index.rst
+++ b/Documentation/ia64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 IA-64 Architecture
 ==================
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2f9bf37b8989..82cd9528dff0 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -116,7 +116,17 @@ implementation.
    :maxdepth: 2
 
    sh/index
+   arm/index
+   arm64/index
+   ia64/index
+   m68k/index
+   powerpc/index
+   riscv/index
+   s390/index
+   sh/index
+   sparc/index
    x86/index
+   xtensa/index
 
 Filesystem Documentation
 ------------------------
diff --git a/Documentation/m68k/index.rst b/Documentation/m68k/index.rst
index f3273ec075c3..aa121cfcbbd9 100644
--- a/Documentation/m68k/index.rst
+++ b/Documentation/m68k/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =================
 m68k Architecture
 =================
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index c4b906d9b5a7..e3ca0922a8c2 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================
 RISC-V architecture
 ===================
diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
index 1a914da2a07b..4602312909d3 100644
--- a/Documentation/s390/index.rst
+++ b/Documentation/s390/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =================
 s390 Architecture
 =================
diff --git a/Documentation/sparc/index.rst b/Documentation/sparc/index.rst
index 91f7d6643dd5..71cff621f243 100644
--- a/Documentation/sparc/index.rst
+++ b/Documentation/sparc/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 Sparc Architecture
 ==================
diff --git a/Documentation/xtensa/index.rst b/Documentation/xtensa/index.rst
index 5a24e365e35f..239c5f0a5c67 100644
--- a/Documentation/xtensa/index.rst
+++ b/Documentation/xtensa/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================
 Xtensa Architecture
 ===================
-- 
2.21.0
