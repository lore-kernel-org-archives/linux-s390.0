Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A520E6E9
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517571; cv=none; b=kZIWW8+uvxrBA3VKl/8J8j5SnieDqZVwC/k7J8vW7UWO2sEjy1qvRBDLcfpjG0qf4ijMPRu60M8lI9BQW06GCfFRcBy38bqEegpX2p3E+nbdWeVSELMSwBVifgRwosWAUwiTQURAM2YZntvCYlTDQY/NDJuJjdn/wqCBInbRLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517571; c=relaxed/simple;
	bh=GBcTlIht9VhsQmcioCAwDv2nehDX/CgDvKHwSYWYoQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/QBAXjPuZdkFpbz/D2cC3OW8bkLG6XDloUaQaGo6ogMptwbfZGcnQ/uPTT3r6HaRxjnvDls7OieLNGnb3ghkrE+96nAYG/09I0XvKOywgt+efj2730okXrlgLHAuDEfRU5hNEjfCwata9PmlkV4w9Jih4Q7t/2YswV6Pg6ff+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E67DF1FCD;
	Fri, 10 Jan 2025 05:59:57 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825AB3F59E;
	Fri, 10 Jan 2025 05:59:27 -0800 (PST)
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
Subject: [kvm-unit-tests PATCH v1 5/5] configure: arm64: Make 'max' the default for --processor
Date: Fri, 10 Jan 2025 13:58:48 +0000
Message-ID: <20250110135848.35465-6-alexandru.elisei@arm.com>
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

Newer architecture features are supported by qemu TCG on newer CPUs. When
writing a test for such architecture features, it is necessary to pass the
correct -cpu argument to qemu. Make it easier on users and test authors
alike by making 'max' the default value for --processor. The 'max' CPU
model contains all the features of the cortex-a57 CPU (the old default), so
no regression should be possible.

A side effect is that, by default, the compiler will not receive a -mcpu
argument for compiling the code. The expectation is that this is fine,
since support for -mcpu=$PROCESSOR has only been added for arm64 in the
last commit.

The default for arm (cortex-a15) has been kept unchanged, because passing
--processor=max will cause compilation to break. If the user wants the qemu
CPU model to be 'max', the user will also have to supply a suitable compile
CPU target via --cflags=-mcpu=<cpu> configure option.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 46964d36a7d8..3ab0ec208e10 100755
--- a/configure
+++ b/configure
@@ -14,7 +14,7 @@ function get_default_processor()
         default_processor="cortex-a15"
         ;;
     "arm64" | "aarch64")
-        default_processor="cortex-a57"
+        default_processor="max"
         ;;
     *)
         default_processor=$arch
-- 
2.47.1

