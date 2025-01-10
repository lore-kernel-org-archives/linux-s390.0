Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB3520E71D
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517568; cv=none; b=WIk7x2byILuStVaQr3qi+bLScnCtcb6WpulvrlSxlUvIZeX14cGhKnKD22xCcLoemMO7aqJVrFM2VBx2FhghjzJi6fcY6taCkMJP6vCYXLG8VeE6GSqWiRqxJATPHmnnqMuuMlxCibggbtRzGYiAqrlA7EaAglNIsgHhlpo+5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517568; c=relaxed/simple;
	bh=udBxpb3HOOOvvPrarp7g6N5TtQvw/QJWWhnlFNSSzO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5jih5kwxrg2BnzYfIRgN1XeFK8LTUReLKFEuspH8SyYytv8uAvabBtES00ZtSq50ARetXxiQlUak5gE8/0co7lGg8+GJnFxxSPjUiPaJ9p7onPi7JoJ6DdPOUbLjSBGPbespm5Nf94pwMzMHfovRJgXkk+wIGbbrxJJm2QIE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170421FC4;
	Fri, 10 Jan 2025 05:59:53 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5CF83F59E;
	Fri, 10 Jan 2025 05:59:22 -0800 (PST)
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
Subject: [kvm-unit-tests PATCH v1 3/5] arm64: Implement the ./configure --processor option
Date: Fri, 10 Jan 2025 13:58:46 +0000
Message-ID: <20250110135848.35465-4-alexandru.elisei@arm.com>
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

The help text for the ./configure --processor option says:

    --processor=PROCESSOR  processor to compile for (cortex-a57)

but, unlike arm, the build system does not pass a -mcpu argument to the
compiler. Fix it, and bring arm64 at parity with arm.

Note that this introduces a regression, which is also present on arm: if
the --processor argument is something that the compiler doesn't understand,
but qemu does (like 'max'), then compilation fails. This will be fixed in a
following patch; another fix is to specify a CPU model that gcc implements
by using --cflags=-mcpu=<cpu>.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arm/Makefile.arm    | 1 -
 arm/Makefile.common | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arm/Makefile.arm b/arm/Makefile.arm
index 7fd39f3ada64..d6250b7fb686 100644
--- a/arm/Makefile.arm
+++ b/arm/Makefile.arm
@@ -12,7 +12,6 @@ $(error Cannot build arm32 tests as EFI apps)
 endif
 
 CFLAGS += $(machine)
-CFLAGS += -mcpu=$(PROCESSOR)
 CFLAGS += -mno-unaligned-access
 
 ifeq ($(TARGET),qemu)
diff --git a/arm/Makefile.common b/arm/Makefile.common
index f828dbe01d33..a5d97bcf477a 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -25,6 +25,7 @@ AUXFLAGS ?= 0x0
 # stack.o relies on frame pointers.
 KEEP_FRAME_POINTER := y
 
+CFLAGS += -mcpu=$(PROCESSOR)
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -O2
-- 
2.47.1

