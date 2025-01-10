Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75820FA87
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517569; cv=none; b=cXhf3EkTI7BvKbfW2RPYfWaYUXyNi25xDUPRYcuFpo73N6htydX3LPoaMfAjAj2xmL27MRhB9ZSwxQ76sWIkFsSMEutUGHOI6BxcX9TLwg3wLU/a56zyj2eOS9evakuT4tuipJ6gAl+RCmaMQLjBViHywDElgPUq83uIoYmHu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517569; c=relaxed/simple;
	bh=I0jxUxeeWcFKjR2yLCSseqwrOP6basArqiRUBOV0EBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTr+sn9tTZfbB3fvg3SyoK06Ge3npq+ZKgH0R7Wpok9U9/YfXLSSZlLk1QjBcVoul5iOewuEdB4R4ea5wSBr6Wn25nrAziMBEiv4eLtTjLnhANThU427n204AvI6m2dDrcNHTXEDuTTEU3T4Ih5FWrE+7lexEunswUNRWJxcXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8033A1FC7;
	Fri, 10 Jan 2025 05:59:55 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6DF3F59E;
	Fri, 10 Jan 2025 05:59:24 -0800 (PST)
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
Subject: [kvm-unit-tests PATCH v1 4/5] arm/arm64: Add support for --processor=max
Date: Fri, 10 Jan 2025 13:58:47 +0000
Message-ID: <20250110135848.35465-5-alexandru.elisei@arm.com>
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

For arm64, newer architecture features are supported only on newer CPUs.
Instead of expecting the user to know which CPU model supports which
feature when using the TCG accelerator for qemu, let's make it easier and
add support for the --processor 'max' value.

The --processor value is passed to the compiler's -mcpu argument and to
qemu's -cpu argument. 'max' is a special value that only qemu understands -
it means that all CPU features that qemu implements are supported by the
guest CPU, and passing it to the compiler causes a build error. So omit the
-mcpu argument when $PROCESSOR=max.

This affects only the TCG accelerator; when using KVM or HVF,
kvm-unit-tests sets the cpu model to 'host'.

Note that using --processor=max with a 32 bit compiler will cause a build
error: the CPU model that the compiler defaults to when the -mcpu argument
is missing lacks support for some of the instructions that kvm-unit-tests
uses. The solution in the case is to specify a CPU model for the compiler
using --cflags:

  ./configure --arch=arm --processor=max --cflags=-mcpu=<cpu>

This patch doesn't introduce a regression for arm when --processor=max is
used, it's only the error that changes: from an unknown processor type to
using instructions that are not available on the processor.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/Makefile.common | 2 ++
 configure           | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arm/Makefile.common b/arm/Makefile.common
index a5d97bcf477a..b757250dc9ae 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -25,7 +25,9 @@ AUXFLAGS ?= 0x0
 # stack.o relies on frame pointers.
 KEEP_FRAME_POINTER := y
 
+ifneq ($(PROCESSOR),max)
 CFLAGS += -mcpu=$(PROCESSOR)
+endif
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -O2
diff --git a/configure b/configure
index 138840c3f76d..46964d36a7d8 100755
--- a/configure
+++ b/configure
@@ -67,7 +67,10 @@ usage() {
 	Options include:
 	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
 	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
-	    --processor=PROCESSOR  processor to compile for ($default_processor)
+	    --processor=PROCESSOR  processor to compile for ($default_processor). For arm and arm64, the
+	                           value 'max' is special and it will be passed directly to
+	                           qemu, bypassing the compiler. In this case, --cflags can be
+	                           used to compile for a specific processor.
 	    --target=TARGET        target platform that the tests will be running on (qemu or
 	                           kvmtool, default is qemu) (arm/arm64 only)
 	    --cross-prefix=PREFIX  cross compiler prefix
-- 
2.47.1

