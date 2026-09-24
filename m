Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6253382FC;
	Thu, 24 Sep 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253657; cv=none; b=dHE4VJwuziNKPNjgR3WZIiZjZexW9mn8cMMdgPgUbYQ9WMjhip0S+RD7ifW54vbYHfUvWXc8ky9sncRdLBoyTEDOP7VCY/GupBv+8H/ixE/Pr1hHyT6CbBrunEtCr0lObjmq2f6au8dKipa8PO+kHSAQa2ZzrDPpjWlrsRIyLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253657; c=relaxed/simple;
	bh=y+5pn/pWC5QLaJQTqQCDTnAs1uZmOeIS2o5nwkRR5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaaQq+JjM2De+WHUH8QKFnwSN9k2zKBCp7/CBcQqvJKQH+Wo4jktaiQuMwQBiaUY69PFaimDlPUl5YFIdJ/yMK7RWrHqCHm10gec3c6w8zinSFn4dgtrdoUZGISIK6x6H2KaSzSdl7os6+R2yxl+hjJVlOuCQz4fp4Y9s66avCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ae0Uf3En; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ae0Uf3En"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FSZpwLgOJPdOKAc/3G0H25D/GGiZaAGASzntlGWjFxM=;
	t=1790253655; x=1791463255; b=ae0Uf3EnVSCWKhF78a2GnhWMX0g9CTDhWMqeqDgRF3DnWq6
	CCvl+aACShoyfi68Eu64rI5gAmqeUSQxdoNT6eQ4Df5yG2VaQI6UE7HzQMgr89AcIMOlSwFo150Pe
	zuduRHal6EZh2BwKxG9FxAnmqPxpnEyEnIuiUaOgdKfsfQO+amPDZk0MKLk/3C1tC01FsAagWToQj
	vBH8vtXyZbAwqyPlpVOxAGkDuWTd3G2QFC8EzlfOZyhfDZIuGYTXy5WXgunPmLwlXRPubGcHBcv7Y
	FDhFS0510+K/NgSyGfhhLUwKFSjs6T/rPYodt59j1KTICcTHDqTODJSPNDYwXsRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9ikt-000000092x8-0JIB;
	Thu, 24 Sep 2026 14:40:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] ORC: unify orc_hash.h generation
Date: Thu, 24 Sep 2026 14:35:52 +0200
Message-ID: <20260924144039.7f1bd78fad93.Ibd2ade12789c15c5fa6c45b4661d471fbb4e177b@changeid>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124039.1621965-6-johannes@sipsolutions.net>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no real reason this needs to be duplicated,
and while not a lot of code, I'm adding it yet again
for UML. Move it out to the common Makefile.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Makefile                | 13 +++++++++++++
 arch/loongarch/Makefile | 12 ------------
 arch/x86/Makefile       | 12 ------------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 751a08643bf8..110aa0036e3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1490,6 +1490,19 @@ filechk_compile.h = $(srctree)/scripts/mkcompile_h \
 include/generated/compile.h: FORCE
 	$(call filechk,compile.h)
 
+ifdef CONFIG_UNWINDER_ORC
+orc_hash_dir := arch/$(or $(HEADER_ARCH),$(SRCARCH))/include
+orc_hash_h := $(orc_hash_dir)/generated/asm/orc_hash.h
+orc_hash_sh := $(srctree)/scripts/orc_hash.sh
+targets += $(orc_hash_h)
+quiet_cmd_orc_hash = GEN     $@
+      cmd_orc_hash = mkdir -p $(dir $@); \
+		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
+$(orc_hash_h): $(srctree)/$(orc_hash_dir)/asm/orc_types.h $(orc_hash_sh) FORCE
+	$(call if_changed,orc_hash)
+archprepare: $(orc_hash_h)
+endif
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4b22f95aaafb..96ceda11e307 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -35,18 +35,6 @@ endif
 CC_FLAGS_FPU		:= -mfpu=64
 CC_FLAGS_NO_FPU		:= -msoft-float
 
-ifdef CONFIG_UNWINDER_ORC
-orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
-orc_hash_sh := $(srctree)/scripts/orc_hash.sh
-targets += $(orc_hash_h)
-quiet_cmd_orc_hash = GEN     $@
-      cmd_orc_hash = mkdir -p $(dir $@); \
-		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
-$(orc_hash_h): $(srctree)/arch/loongarch/include/asm/orc_types.h $(orc_hash_sh) FORCE
-	$(call if_changed,orc_hash)
-archprepare: $(orc_hash_h)
-endif
-
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8af6b80cffdd..9089318a621c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -331,18 +331,6 @@ ifeq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
-ifdef CONFIG_UNWINDER_ORC
-orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
-orc_hash_sh := $(srctree)/scripts/orc_hash.sh
-targets += $(orc_hash_h)
-quiet_cmd_orc_hash = GEN     $@
-      cmd_orc_hash = mkdir -p $(dir $@); \
-		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
-$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h $(orc_hash_sh) FORCE
-	$(call if_changed,orc_hash)
-archprepare: $(orc_hash_h)
-endif
-
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
-- 
2.55.0

