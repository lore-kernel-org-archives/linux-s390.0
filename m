Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE020FA99
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517562; cv=none; b=M6rthJZjffh8Uqkp8Ll7NchANoAsb7t8s9D2bVP8v++qLOgupOniSgXtUfvmwu2hdr4lZ+CKCi+JP+Hirua6W2JXoZb64dVKdmaieok49ljrs3KK8Fpt0/6V4YEKkpZBUyKM1by1xHoFxaw6p6ANL14c/AlcZpLJ11UmDJFgauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517562; c=relaxed/simple;
	bh=nXOdIfm9ySJobxsp8pLUXFITkXzVKArzeGkIz68tqOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCEvW4tkRGALkhtQe0r8eLiGmREB/owtrNDm4QQhabMIJS+284ygFtCGcc4z3CpYHkGf9NqpqTJ6r6YFSCnbCfpOi0XTrh8EgD4XP8Lkyxmn5eiU9sMc9P1INtFfB2y0yz6C9C1QLOvAwiq6DzV2Ad4r3hQKUHbzH6XLGX2Cvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3461E32;
	Fri, 10 Jan 2025 05:59:48 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AA83F59E;
	Fri, 10 Jan 2025 05:59:17 -0800 (PST)
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
Subject: [kvm-unit-tests PATCH v1 1/5] configure: Document that the architecture name 'aarch64' is also supported
Date: Fri, 10 Jan 2025 13:58:44 +0000
Message-ID: <20250110135848.35465-2-alexandru.elisei@arm.com>
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

$arch, on arm64, defaults to 'aarch64', and later in the script is replaced
by 'arm64'. Intentional or not, document that the name 'aarch64' is also
supported when configuring for the arm64 architecture. This has been the
case since the initial commit that added support for the arm64
architecture, commit 39ac3f8494be ("arm64: initial drop").

The help text for --arch changes from*:

   --arch=ARCH            architecture to compile for (aarch64). ARCH can be one of:
                           arm, arm64, i386, ppc64, riscv32, riscv64, s390x, x86_64

to:

    --arch=ARCH            architecture to compile for (aarch64). ARCH can be one of:
                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64

*Worth pointing out that the default architecture is 'aarch64', even though
the rest of the help text doesn't have it as one of the supported
architectures.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 86cf1da36467..5b0a2d7f39c0 100755
--- a/configure
+++ b/configure
@@ -47,7 +47,7 @@ usage() {
 
 	Options include:
 	    --arch=ARCH            architecture to compile for ($arch). ARCH can be one of:
-	                           arm, arm64, i386, ppc64, riscv32, riscv64, s390x, x86_64
+	                           arm, arm64/aarch64, i386, ppc64, riscv32, riscv64, s390x, x86_64
 	    --processor=PROCESSOR  processor to compile for ($arch)
 	    --target=TARGET        target platform that the tests will be running on (qemu or
 	                           kvmtool, default is qemu) (arm/arm64 only)
-- 
2.47.1

