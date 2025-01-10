Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CA1F9428
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497683; cv=none; b=j0GgnbsGG85LGnYZ/nmMY4QahxcTqzfdYKNushaEOuasM6OU36JzlpZ60R4SurAGC+8bZY0tjenYVnNj14H4Bn3NFHlNRkbGfGeApDMQXYbEquyOXyY6S4i8U2TBGuzdxxhDCRYEuSjD1WiFLAhtoNXwJ6otF4MZIZTJrSl2t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497683; c=relaxed/simple;
	bh=M8SAhPu2VZZagY1W1mnCTepi03ML4YVIFYpzeiVDu+g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kczR6lUU9WOeq4Fl8t5LlGYeMYT+rwsqU4o73GSHl9MLiOXpGLcYD2b1woYnv9aSTq4jP3LL/mjSsXa0yIjKH4q+m+S1oNECxIYEpOvAW+6l3dHje0AdW/K7/coAet8LhHdj32MN70PMM+VbayfOBVBhOJY5exZfRMMwP2NbyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ao3P64kK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao3P64kK"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so1029751f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736497680; x=1737102480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+He27ln4e+a+fHoBq8fWvUdNVutb9NtrOMSMA+rzNo=;
        b=ao3P64kKQDEy3Wk2gWeqh9+XFeAurfbYEHz2dayFfp14SOnxrG/WEXC+r+VS3UuQnW
         5xYZuiTjf9lcOPdHyxihRHjw3MlHPQ9QDwQYYGEau8xXYuMCEqhlIywSMOTaHo/HGNZf
         Kn8VlmRhvzW1wAMucg3DABHUPRuh32QnLaD58pIjkiA142tk3RAp0jR7QXn1fwj19l8r
         54FVE5Bz2Fn5v09wqm4fidv6MbanvXRZQiUw135f2njMhhoYLnwzS8T8s33TeGPWOHtS
         O5EC/pH4ztA4xPIPZXLOeJVFaEuyyNlt5rRu4F5owHrdH3V8/m2gTwh7A1AWkUF5HFIl
         mEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736497680; x=1737102480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+He27ln4e+a+fHoBq8fWvUdNVutb9NtrOMSMA+rzNo=;
        b=HUbx2K/OqFgnIXcCRP2shpKGWoBwIZRz+pmL6CG6qVb5rMFKG8Lrz6IAAKvdHeRETk
         iaxLzk+EOr4mKrZTdSafXoEc6u1EJYJmKUxXeAedrh3TeRNZnl5tHFumN3DoZ2lmX3Bj
         C1OPeB2qxpqSw6LOWR/1rB4VJRy+J6lKLiCTaF3NEo2k0K8pwoQkNesJlHF3HlvTzRUQ
         U5Dhkkg/55+tLUYJgmKol32rfY9GMlT9cFnSUbRsdezWpoXWR9GkvXtQxu+5dzEfyJBP
         n8vbioD9AV7XR6e8knRj1trel36oYLeIgYGc7f2VhH4HR4fgPEIr6PU1+bRIhGUJvzNa
         RHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFB4sLGUf2FrqaA/ehdkT7R2I58qLDnfHZL4oxpIkFD4jhpWHJAp6Lzs/1JjBnAJvtig+EUAhnec2O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xW9YHMyGkVt/5E56i2THJQszcAWcgSSdU791wcG7/pNUVb64
	0kcxIZCp39ABLrU6I6YaS7JrQ5wxL7B7TW4V073vbDxXZn+JR5CCRjQd6QMac0j8OuB+7A==
X-Google-Smtp-Source: AGHT+IHllbdvdpNeIVSUCIWzmwjLgK47yyaQGnjKJuHkrzM4n3hoLPsW3VD6z3VeT2CzpCll5061RsnL
X-Received: from wmbfm21.prod.google.com ([2002:a05:600c:c15:b0:434:fe2b:fea7])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:184e:b0:385:f64e:f163
 with SMTP id ffacd0b85a97d-38a87312f41mr7988646f8f.32.1736497680388; Fri, 10
 Jan 2025 00:28:00 -0800 (PST)
Date: Fri, 10 Jan 2025 09:27:45 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4529; i=ardb@kernel.org;
 h=from:subject; bh=AUBKLLIPMNBxUb7a34I5INNn0MWf/ugl8eWGUaKnNsY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIb3hFuO6sB8O7BeZ5DRbPWsSZ1l8uxFVlaFQWjnziRjf/
 Nwf+fs6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwESYPjIyTLz67ZrIrlgey1Ql
 jeuvL+pMme09pTjx/NTMDONiU0ZeD0aGHZ3i3E5HHm1ZvqqK3682//cF9vtXM9+cM7Faz/4rKru eDwA=
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110082744.457067-2-ardb+git@google.com>
Subject: [PATCH] kbuild: Strip runtime const RELA sections correctly
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
 arch/riscv/Makefile.postlink | 9 +--------
 arch/s390/Makefile.postlink  | 5 -----
 arch/x86/Makefile.postlink   | 5 -----
 scripts/Makefile.lib         | 3 +++
 4 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
index 829b9abc91f6..65652fd6a252 100644
--- a/arch/riscv/Makefile.postlink
+++ b/arch/riscv/Makefile.postlink
@@ -19,13 +19,6 @@ ifdef CONFIG_RELOCATABLE
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
@@ -33,7 +26,7 @@ vmlinux: FORCE
 ifdef CONFIG_RELOCATABLE
 	$(call if_changed,relocs_check)
 	$(call if_changed,cp_vmlinux_relocs)
-	$(call if_changed,relocs_strip)
+	$(call if_changed,strip_relocs)
 endif
 
 clean:
diff --git a/arch/s390/Makefile.postlink b/arch/s390/Makefile.postlink
index df82f5410769..008acf35c37e 100644
--- a/arch/s390/Makefile.postlink
+++ b/arch/s390/Makefile.postlink
@@ -19,11 +19,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/relocs.S
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
index fef2e977cc7d..8db8b7d338ad 100644
--- a/arch/x86/Makefile.postlink
+++ b/arch/x86/Makefile.postlink
@@ -20,11 +20,6 @@ quiet_cmd_relocs = RELOCS  $(OUT_RELOCS)/$@.relocs
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

