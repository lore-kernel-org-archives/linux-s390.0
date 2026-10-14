Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776143F6C46;
	Wed, 14 Oct 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792008113; cv=none; b=CjEw6HMF+kuocVgAwZgV7J+kIJWlFRzqTi20yCUUX1UoifRdT1l/VfeYdR+UdjzuvObcd2HHa4asDeoWB2st4Hctj4TskSymHX9U6m+0SPnmKyt/7GVrMIg9sse/+QFxpdpOQDbVdTGMSFft/fg0GS30Ye1A4ziUtavgzuolMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792008113; c=relaxed/simple;
	bh=FSO1aVs2xOjSlXTyXhQOhP4+Sw/wcu+3L4EjwIrF/yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVJh86ZFNqCxRsYgg4BUpT1KEH+DINabHVuKZUjgJ6yUrJ9ci6v/1THz0q09oNbXxTOV0/Hkjyq2uQsLBl1crsPMY73TEFch+piPwt1/mO4HEK5QDERG+Q6UfU62RWitPmVlgvgBWt67aRZ/TNNIsT8w2S2/dQ2ZDAj1oT58jUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X20flyHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X20flyHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86EC1F000C4;
	Wed, 14 Oct 2026 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008112;
	bh=Rsic+Y+PmaC/Vsg5mTVmg514JRZUXBZ/4xelFR/iVKk=;
	h=From:To:Cc:Subject:Date;
	b=X20flyHiddFjfL6F/ORa4GvgSQladWZ07EIoy+IieSNPDJbtLXGqqlPfhJTfWhODX
	 KqTZx7c/w9oNL7uBU4dtF8lkHwCejh4ogyhZM8IK8yTUhIGYEPipnlONLVY7uIj1Ta
	 2490TqF2zpuyuJ1aYJbkcoc1UN+eIFEkXGCfcTwTLGkodudaixa3ScxlR4GBMwZyVD
	 A/ENTpQySnbc80myHg5cJ5hLBI4++pkStG9cgyCVmBHBfDZXCzvfgZGfRATYYCFUyW
	 3dv2wg35lhdGYJ24X4B6zCRnJgIUWwaBKf1ip98zcYuZcT26BgBEloGF1m6owZ1SLK
	 hKVG3nMPTMYSQ==
From: Sasha Levin <sashal@kernel.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: drivers/s390x: select uvdevice tests using the target architecture
Date: Wed, 14 Oct 2026 16:01:49 -0400
Message-ID: <20261014200149.1365017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uvdevice Makefile decides whether to build its test from uname -m,
which describes the build host. A cross build for s390 on another host
therefore silently omits the test, while the non-s390 branch provides
no-op build and installation targets but no emit_tests target.

Select the test from the target ARCH when it is given and from the
host's SUBARCH otherwise, accepting both the s390 and s390x spellings,
and include lib.mk unconditionally so that other architectures build,
install and emit an empty runlist. ARCH itself is left unset so that a
native LLVM=1 build keeps using the compiler's native target.

Drop the include path derived from tools/arch/$(ARCH): the test only
needs asm/uvdevice.h from the installed kernel headers, and the path
does not exist for the s390x spelling.

Fixes: cbac924200b8 ("selftests: drivers/s390x: Add uvdevice tests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/drivers/s390x/uvdevice/Makefile | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
index 755d164384c46..586a9aa6fb158 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
@@ -1,20 +1,13 @@
 include ../../../../../build/Build.include
 
-UNAME_M := $(shell uname -m)
-
-ifneq ($(UNAME_M),s390x)
-nothing:
-.PHONY: all clean run_tests install
-.SILENT:
-else
+top_srcdir ?= ../../../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH_PROCESSED := $(or $(ARCH),$(SUBARCH))
 
+ifneq (,$(filter s390 s390x,$(ARCH_PROCESSED)))
 TEST_GEN_PROGS := test_uvdevice
 
-top_srcdir ?= ../../../../../..
-LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
-
-CFLAGS += -Wall -Werror -static $(KHDR_INCLUDES) -I$(LINUX_TOOL_ARCH_INCLUDE)
+CFLAGS += -Wall -Werror -static $(KHDR_INCLUDES)
+endif
 
 include ../../../lib.mk
-
-endif

base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
-- 
2.53.0

