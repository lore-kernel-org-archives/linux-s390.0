From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 13:41:14 +0000
Subject: [CRIU][PATCH 3/3] s390: Enable travis
Message-Id: <20170714134114.36870-4-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We have to use "debian.jessie" instead of "ubuntu.xenial" because
qemu-s390x-static can only run z900 instructions and Ubuntu is
built with a more recent architecture level set.

We first enable only gcc because there are still some issues with clang.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 .travis.yml                        | 1 +
 scripts/build/Dockerfile.s390x.hdr | 4 ++++
 scripts/build/Makefile             | 2 +-
 scripts/build/binfmt_misc          | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 scripts/build/Dockerfile.s390x.hdr

diff --git a/.travis.yml b/.travis.yml
index d4d53e4..eaa8401 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,6 +13,7 @@ env:
   - TR_ARCH=armv7hf
   - TR_ARCH=aarch64
   - TR_ARCH=ppc64le
+  - TR_ARCH=s390x
   - TR_ARCH=armv7hf     CLANG=1
   - TR_ARCH=aarch64     CLANG=1
   - TR_ARCH=ppc64le     CLANG=1
diff --git a/scripts/build/Dockerfile.s390x.hdr b/scripts/build/Dockerfile.s390x.hdr
new file mode 100644
index 0000000..be75712
--- /dev/null
+++ b/scripts/build/Dockerfile.s390x.hdr
@@ -0,0 +1,4 @@
+FROM s390x/debian:jessie
+
+ENV QEMU_CPU z900
+COPY scripts/build/qemu-user-static/usr/bin/qemu-s390x-static /usr/bin/qemu-s390x-static
diff --git a/scripts/build/Makefile b/scripts/build/Makefile
index 5308711..234649a 100644
--- a/scripts/build/Makefile
+++ b/scripts/build/Makefile
@@ -1,4 +1,4 @@
-QEMU_ARCHES := armv7hf aarch64 ppc64le # require qemu
+QEMU_ARCHES := armv7hf aarch64 ppc64le s390x # require qemu
 ARCHES := $(QEMU_ARCHES) x86_64
 TARGETS := $(ARCHES) alpine fedora-asan
 TARGETS_CLANG := $(addsuffix $(TARGETS),-clang)
diff --git a/scripts/build/binfmt_misc b/scripts/build/binfmt_misc
index a5c922e..3e76b66 100755
--- a/scripts/build/binfmt_misc
+++ b/scripts/build/binfmt_misc
@@ -8,3 +8,6 @@ test -f /proc/sys/fs/binfmt_misc/aarch64 ||
 
 test -f /proc/sys/fs/binfmt_misc/ppc64le ||
 	echo ':ppc64le:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x15\x00:\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\x00:/usr/bin/qemu-ppc64le-static:' > /proc/sys/fs/binfmt_misc/register
+
+test -f /proc/sys/fs/binfmt_misc/s390x ||
+	echo ':s390x:M::\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x16:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-s390x-static:' > /proc/sys/fs/binfmt_misc/register
-- 
2.7.4
