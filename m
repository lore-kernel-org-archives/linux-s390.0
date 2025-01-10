Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741D20FA94
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517564; cv=none; b=XQokr2B8hjx68i8nMO7KiCP9R0ZIPCTcSkuXoerR4ehxPFAHo1ydquQOZWybKoymHSJAtGQPsnAmUeBNeT7vmS5aNw53OyGezbiS0msvAEog07l9hq+MuW/fpfiJeZdbf+PT/fjEbKBKBQgk8QOIW2f0zaJU+zmZLw8o8eVgkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517564; c=relaxed/simple;
	bh=i1H9yyCl5pTbf4n0isBinjznQDuh4HRxw8NOP2Fan90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfB3ltKV9QSFz6D1DYZ9qVfBb+UI/vaUlSDDnnHj3EZPGGC2aUe0WKhcjykq34vwEkjPP0awshrrWDaFLiisAMeDZ9Novx7M/JhV8/dY12x9UAz3FlLMi7El88P7HoMjtQSNM5rbfX7foGnz5D0LBEwjsJWHlVGg7McQoJ1USLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C481F91;
	Fri, 10 Jan 2025 05:59:50 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE423F59E;
	Fri, 10 Jan 2025 05:59:20 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: andrew.jones@linux.dev,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	thuth@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com
Cc: kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	vladimir.murzin@arm.com
Subject: [kvm-unit-tests PATCH v1 2/5] configure: Display the default processor for arm and arm64
Date: Fri, 10 Jan 2025 13:58:45 +0000
Message-ID: <20250110135848.35465-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110135848.35465-1-alexandru.elisei@arm.com>
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help text for the --processor option displays the architecture name as
the default processor type. But the default for arm is cortex-a15, and for
arm64 is cortex-a57. Teach configure to display the correct default
processor type for these two architectures.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 configure | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 5b0a2d7f39c0..138840c3f76d 100755
--- a/configure
+++ b/configure
@@ -5,6 +5,24 @@ if [ -z "${BASH_VERSINFO[0]}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ] ; then
     exit 1
 fi
 
+function get_default_processor()
+{
+    local arch="$1"
+
+    case "$arch" in
+    "arm")
+        default_processor="cortex-a15"
+        ;;
+    "arm64" | "aarch64")
+        default_processor="cortex-a57"
+        ;;
+    *)
+        default_processor=$arch
+    esac
+
+    echo "$default_processor"
+}
+
 srcdir=$(cd "$(dirname "$0")"; pwd)
 prefix=/usr/local
 cc=gcc
@@ -33,6 +51,7 @@ page_size=
 earlycon=
 efi=
 efi_direct=
+default_processor=$(get_default_processor $arch)
 
 # Enable -Werror by default for git repositories only (i.e. developer builds)
 if [ -e "$srcdir"/.git ]; then
@@ -48,7 +67,7 @@ usage() {
 	Options include:
 	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
 	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
-	    --processor=PROCESSOR  processor to compile for ($arch)
+	    --processor=PROCESSOR  processor to compile for ($default_processor)
 	    --target=TARGET        target platform that the tests will be running on (qemu or
 	                           kvmtool, default is qemu) (arm/arm64 only)
 	    --cross-prefix=PREFIX  cross compiler prefix
@@ -283,13 +302,8 @@ else
     fi
 fi
 
-[ -z "$processor" ] && processor="$arch"
-
-if [ "$processor" = "arm64" ]; then
-    processor="cortex-a57"
-elif [ "$processor" = "arm" ]; then
-    processor="cortex-a15"
-fi
+# $arch will have changed when cross-compiling.
+[ -z "$processor" ] && processor=$(get_default_processor $arch)
 
 if [ "$arch" = "i386" ] || [ "$arch" = "x86_64" ]; then
     testdir=x86
-- 
2.47.1

