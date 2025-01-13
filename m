Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A13232
	for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778756; cv=none; b=PYFnsN06O7S+PXzRgOf9iFMh/wpyc1XAhiGjimiaHJxeZk+lVeGFD+pUgiGSf6OlKWrInRpCIwHTwYTJAETBn0kBWzgWUw5XiL3le5LrwKf2sJjjaCkgpHoFOORV7FbNrvfyFgQmKP5Jvhuk53DkufiezipavBcPRGzIpBzym+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778756; c=relaxed/simple;
	bh=grdeH3i3qZWvVei0BqLpq3JTPfxETbMSVvSfDMFCxHo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mPgpYd8PGwYwU75bMprwq71fN4nilBSpihMza/I5ftCGUJVqmQs6NY4q1FGSTMLjVkUl7KjEuS9c0XTaKbtDE0OPs2JX9eq+JgYM4njRvn0Wqe7AvRUK7fnF4ZhJ9GgRuygif/pe0D2M2GvpvIL27BiS7OMJMCK6wb+zlV45AlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/4371VP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/4371VP"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ecebc5bso23428725e9.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2025 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736778753; x=1737383553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OzIqGGH3vBKieE2zzlwNtC18zjNLUz1ZncrxL4Bmag8=;
        b=p/4371VPLb5iCGBsOJnOU5Ld/fDlwACGSYNZWfP10PeH2dqWqmkzoJ3cieICNFajN9
         3ar1cf53y0bKeqV9kmY207IPtGVX8N47mXAOLdhI4QEz5h4h/03ThT4DZgBo/nwkoEK2
         97ViBy0fPHDLteMdYuPKmB9eVz3ADPdYTOOQXQMYwPqno5NiiJRo91w657x4XRavj4Ah
         XSTBNonYACHaIdqi6eHq6VwEpJnGzCaemDo4vcHb3iiRPEoMwK6MntTzM7FPbWInQxR8
         2t5d/M9h7gjsxvfs8SyVSHQ9yg7KtHhI/31pSeKSoB4SVYF+Iu39otUbao07cSaZY9T6
         jcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778753; x=1737383553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzIqGGH3vBKieE2zzlwNtC18zjNLUz1ZncrxL4Bmag8=;
        b=mic61Py9ihtKhrb5tzof5Nt/8RPvNtu+wlki4xuI42U5Dzljd4H48zdLBeD7TX/m2p
         BZeLoE47eh0AJZeTDWdR993QRjEvLlZLfUd7I6uDnxuabIV2B/1rm0cPWK3cFJYBDmuO
         RDPrFlEzHB2YYU+08nhY88GbHpaIYLfjiY0DjGXfHu+yzrIZFH+FChBkoKj4X+6/fLID
         yxKZR0pcP4fUASJ3TvNvGWJ61dw8NfUGLd5H0ucznDqN48ZYFKB40qcnuY0Tc9+qQIYd
         SplHiGy9KKG4M7DSnB1xPt6lgP5rQuNJtNkcKU4nFLq4FChG0Dbt8QkF0q2OYNmlX9Hu
         6dbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK+3RkMODBult4d2sTy1QrkRdqmtxMDgdtfRooBblS73Kq/lZW/qwx7zS1qvNktJzhaSYOD5zK28CG@vger.kernel.org
X-Gm-Message-State: AOJu0YypE2wg9+K/16+1NVQIDjYBqAHhLI7K4dYTz4WsvjBtPnQ1ZheD
	BeSFBrrVh9u1XT5mueQyng460CEjNa/FYktlii3S9CSUcM9F37e9ZZdgQ8zfND+zp8e2Yg==
X-Google-Smtp-Source: AGHT+IFQeNAamqcGdcN8c7ytefb3W1Z5eHAuyFOJ2VehyPJ1eN/M3OxG5yO9oTpeEg8FqBs7yp+CS2pm
X-Received: from wmsp9.prod.google.com ([2002:a05:600c:1d89:b0:436:6f3f:58de])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4510:b0:431:54d9:da57
 with SMTP id 5b1f17b1804b1-436e26ffb2cmr209267185e9.30.1736778753695; Mon, 13
 Jan 2025 06:32:33 -0800 (PST)
Date: Mon, 13 Jan 2025 15:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5275; i=ardb@kernel.org;
 h=from:subject; bh=wUg0mP/r/+W1sG3n3TuyOrD53kw2VZ0233ES5hgrKL4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb1V+Ztpk/CP/SZ9zqc43/1juvV8Y8gnGft5h/z/Zkf1X
 7qqw+fbUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZS5Mnwv1os/c2dXB+v0vZr
 OzhdA/IkdVh4I+Nn1TtnXxKJuX7MieF/QoNBWOUnw4zvy99c3N1fPbmT8/Ax++0LX7X+2dj0ZEI sCwA=
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113143222.1868692-2-ardb+git@google.com>
Subject: [PATCH v2] kbuild: Strip runtime const RELA sections correctly
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Due to the fact that runtime const ELF sections are named without a
leading period or double underscore, the RSTRIP logic that removes the
static RELA sections from vmlinux fails to identify them. This results
in a situation like below, where some sections that were supposed to get
removed are left behind.

  [Nr] Name                              Type            Address          Off     Size   ES Flg Lk Inf Al

  [58] runtime_shift_d_hash_shift        PROGBITS        ffffffff83500f50 2900f50 000014 00   A  0   0  1
  [59] .relaruntime_shift_d_hash_shift   RELA            0000000000000000 55b6f00 000078 18   I 70  58  8
  [60] runtime_ptr_dentry_hashtable      PROGBITS        ffffffff83500f68 2900f68 000014 00   A  0   0  1
  [61] .relaruntime_ptr_dentry_hashtable RELA            0000000000000000 55b6f78 000078 18   I 70  60  8
  [62] runtime_ptr_USER_PTR_MAX          PROGBITS        ffffffff83500f80 2900f80 000238 00   A  0   0  1
  [63] .relaruntime_ptr_USER_PTR_MAX     RELA            0000000000000000 55b6ff0 000d50 18   I 70  62  8

So tweak the match expression to strip all sections starting with .rel.
While at it, consolidate the logic used by RISC-V, s390 and x86 into a
single shared Makefile library command.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: https://lore.kernel.org/all/CAHk-=wjk3ynjomNvFN8jf9A1k=qSc=JFF591W00uXj-qqNUxPQ@mail.gmail.com/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: add missing include of scripts/Makefile.lib

 arch/riscv/Makefile.postlink | 10 ++--------
 arch/s390/Makefile.postlink  |  6 +-----
 arch/x86/Makefile.postlink   |  6 +-----
 scripts/Makefile.lib         |  3 +++
 4 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
index 829b9abc91f6..750d2784f69e 100644
--- a/arch/riscv/Makefile.postlink
+++ b/arch/riscv/Makefile.postlink
@@ -10,6 +10,7 @@ __archpost:
 
 -include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 quiet_cmd_relocs_check = CHKREL  $@
 cmd_relocs_check = 							\
@@ -19,13 +20,6 @@ ifdef CONFIG_RELOCATABLE
 quiet_cmd_cp_vmlinux_relocs = CPREL   vmlinux.relocs
 cmd_cp_vmlinux_relocs = cp vmlinux vmlinux.relocs
 
-quiet_cmd_relocs_strip = STRIPREL $@
-cmd_relocs_strip = $(OBJCOPY)   --remove-section='.rel.*'       \
-                                --remove-section='.rel__*'      \
-                                --remove-section='.rela.*'      \
-                                --remove-section='.rela__*' $@
-endif
-
 # `@true` prevents complaint when there is nothing to be done
 
 vmlinux: FORCE
@@ -33,7 +27,7 @@ vmlinux: FORCE
 ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 	$(call if_changed,cp_vmlinux_relocs)
-	$(call if_changed,relocs_strip)
+	$(call if_changed,strip_relocs)
 endif
 
 clean:
diff --git a/arch/s390/Makefile.postlink b/arch/s390/Makefile.postlink
index df82f5410769..1ae5478cd6ac 100644
--- a/arch/s390/Makefile.postlink
+++ b/arch/s390/Makefile.postlink
@@ -11,6 +11,7 @@ __archpost:
 
 -include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 CMD_RELOCS=arch/s390/tools/relocs
 OUT_RELOCS = arch/s390/boot
@@ -19,11 +20,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/relocs.S
 	mkdir -p $(OUT_RELOCS); \
 	$(CMD_RELOCS) $@ > $(OUT_RELOCS)/relocs.S
 
-quiet_cmd_strip_relocs = RSTRIP  $@
-      cmd_strip_relocs = \
-	$(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
-		   --remove-section='.rela.*' --remove-section='.rela__*' $@
-
 vmlinux: FORCE
 	$(call cmd,relocs)
 	$(call cmd,strip_relocs)
diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
index fef2e977cc7d..8b8a68162c94 100644
--- a/arch/x86/Makefile.postlink
+++ b/arch/x86/Makefile.postlink
@@ -11,6 +11,7 @@ __archpost:
 
 -include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 CMD_RELOCS = arch/x86/tools/relocs
 OUT_RELOCS = arch/x86/boot/compressed
@@ -20,11 +21,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/$@.relocs
 	$(CMD_RELOCS) $@ > $(OUT_RELOCS)/$@.relocs; \
 	$(CMD_RELOCS) --abs-relocs $@
 
-quiet_cmd_strip_relocs = RSTRIP  $@
-      cmd_strip_relocs = \
-	$(OBJCOPY) --remove-section='.rel.*' --remove-section='.rel__*' \
-		   --remove-section='.rela.*' --remove-section='.rela__*' $@
-
 # `@true` prevents complaint when there is nothing to be done
 
 vmlinux: FORCE
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7395200538da..f604f51d23ca 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -374,6 +374,9 @@ quiet_cmd_ar = AR      $@
 quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 
+quiet_cmd_strip_relocs = RSTRIP  $@
+cmd_strip_relocs = $(OBJCOPY) --remove-section='.rel*' $@
+
 # Gzip
 # ---------------------------------------------------------------------------
 
-- 
2.47.1.688.g23fc6f90ad-goog

