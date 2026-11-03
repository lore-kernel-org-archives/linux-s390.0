Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719134;
	b=ega5ukbYkOsLjyik82KKBWQDAhOQwyXiSPHWc4bR75R17oxqqJbzAXTE+C1x1l++LFQy
	 tI7ZwYs+kvr8w0qIkpInaGvXA0D7wV5zb6u0yLydC8ZRKSsaBLb7UWyHlNecvP6HmgxBg
	 T5Jk7e+6klKhFNNaobKOyxXYq5pG7PUGH6p6W+zhIBgtDe6/krQyp2frg4d1uT1taucuW
	 s5b9iSBDmzr7fj3TrcaUMoaJql1pLOV+mCFK5GNUNnsx51ZYlLaGcIKQgpwyL+HE6PUYJ
	 IFOs3k5osvyR86uEa7bkFuYJEkvISyELOL3SqHVZlqYESPY+nhuA/krIxboAGtkaC9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=x+ielrpl05GqbiDgrjkNFqFmUWyU2mlgjjUSLSA7ydE=;
	b=2dCLuZmECvTdOkwngrAhCV3oy/4pglS1yRTYGoohKvVqoH3H3XPAHr2VLZHv0X7rDGKd
	 cS1Limiy0nlWU5waK81fCp0NGzzhR7TGf6//P6grdwZ5Z9tjFQLnHBdAjp990cCXYzFTx
	 UZ/2+OYRS16xe8exGfInJuPsETlZGKnK06xkjK9QdNyqj/F9N+KLJAi1M8nPjmCZjjdxY
	 KMs0EQJHqB8EgLa7sTaCuZ/eIvlDAUk5OJfADmjrDCFqzLNjOA1AkqcyG//ecICawrwTu
	 PIpPS+d+PZCqlcqy6EX8vqm2mIhkHZUA4I7Rnm3IJDTz1DBonmfYKRJfTJ+7Rt7qnaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=XJy5WLJl;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697676082BE0
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697676082BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=XJy5WLJl
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea0efd636dso38509195ad.0
        for <linux-s390@vger.kernel.org>; Tue, 03 Nov 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719133; x=1794323933; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x+ielrpl05GqbiDgrjkNFqFmUWyU2mlgjjUSLSA7ydE=;
        b=XJy5WLJl/KGluYS1/F4VW4v6k6VyGhteiZQJFtWPoTcx/SvN10DLFHXPZQlIvRT6UP
         Hpae4Oq4Wqt0fWSDTJyIcK7TOpMTEIlxdmK89VeW42IAQclMGfNCtJHvN7rGpfgmrg74
         k4HNO2eNR63JrGMry9w/vqCs7wB+paZYgii/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719133; x=1794323933;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+ielrpl05GqbiDgrjkNFqFmUWyU2mlgjjUSLSA7ydE=;
        b=EKmsdmcNW7CB7JzrBwxcUrqTF0ca7VxRzaHBno73pFbILwlHErl234/Q7/WrtmkKlq
         rLUwaxDFEcQB/tfnqPTf3xJAp7VlPWjgwcFryItil4dNihJhsXhMjcda/8o6Zyi+Cyb3
         xfINpQiUOZVZBWywjKhZM+rusCbt0sTJxh8f6UCBadDiYpVJBGZEHANifoZNipsuJRUm
         ev+1RXeddgbhhLeeYayV6ucoUxNjn2+VwFIlOW47pxUugTTjpb2rfqC4vKXTVOjgxAw1
         46nPG4EfOumoHZJcvOQEGZOExu1U9ZfPVgnmSFG3UqA2lWAu6dLMxk1DPlinZJ1XlshH
         gHcg==
X-Forwarded-Encrypted: i=1; AKwUvByJ5r8ZAPfOMBXNzmligKZBGpI/F/PQwlxz3tayDayrXS1cFA4zJxajcgGRCqWTJ0KmBiatmt+SC+Qf@vger.kernel.org
X-Gm-Message-State: APuU4Z+1KWaKPjCqkYpMIF04uLg9nmDDpoI6Yb62H4SU8loxB1mZmFWi
	wqz9ji8LuztYKnf0++nwL66obHRylFV7Fw2XiWPnWr9in5pqFi9iwf7zE8wDlR35FSQ=
X-Gm-Gg: AYBFou1KRCury2aHhdBe0Pt0ORl/7nk/ssXmgmPwVj+4nls1419DxXIGwfMHvzmhPNY
	010fvQ2JOC9kYiMkjN3uXQu9pSPoJuNU/WQ7mAFiJEBhaawmCjlotQwd6vk6X2lj3/gfdrtcifx
	lJWRU2MU9hDXg9L9CSPtMsAliXf69IeQbXG/o6DZGTQi1P3s6hTNrNeygFn2+qGD15l8w4BiDih
	AKsnozWSaFRc0/bVVYdt7QD5IrpsttYgOvb6QyBOX4EwiUwZw8YsdQuOgz2SFpuEMbGm24SPzUO
	JWa9bqkU2r7sfG8BOBd+bFJ9iJlOth968A8RF2t3G5O63xA06s3MEaR6nrrVBmoHjPVJ/jnV+9A
	8GrD2gRPz14UnpSNB1hFG6ri1v1a/ZkN0dFrn9/wRnxzM6k7ismrjeuHbB+ESo8T0Et+LxzEXp+
	KyIG4TejZtRUu2EM7R7NbD/lGD9JQiG0hAXUNobyYx6voXc9d07LLfC0UBsH5Lf0NIclHqmPS1C
	H4Mddy5H+V4WwF1YxehUE2ucGQC4TWTA+jj9AnJBz96T/ewyhFCk9wqdGhxUR3ORexoHVWWbL7k
	4Ooyca3EAmPoZ7RwhTRz/ebaUgRVXAdBDmXld9BjJn8S8mAJWsirA47iCiUFeB93kJ6xxeMClUw
	GhOjv3zSkbkGZ0uKclHpjUFidO3ASI+F/ukjl8A48cWojyzmvJJxsm6gqF0t6tDcproLCEQHnUP
	fod+bZpzQoi48gHzpJfQ==
X-Received: by 2002:a17:903:1b26:b0:2eb:1e07:adc5 with SMTP id d9443c01a7336-2eb364026e5mr130622425ad.2.1793719132693;
        Tue, 03 Nov 2026 07:18:52 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266b84sm43036115ad.43.2026.11.03.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:18:48 -0800 (PST)
Date: Tue, 3 Nov 2026 23:18:45 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 6/8] mm/mseal: Seal system mappings in
 __install_special_mapping()
Message-ID: <74ead8d457288df215405298e213246ef6a1ce68.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

VM_SEALED_SYSMAP isn't really a VMA flag, it's an alias for VM_SEALED or
VM_NONE depending on CONFIG_MSEAL_SYSTEM_MAPPINGS. Every caller of
_install_special_mapping() on an architecture which supports sealing
system mappings has to remember to pass it, and it keeps those callers
on the legacy vm_flags_t API.

Let's instead have __install_special_mapping() seal the mapping itself
when mseal_system_mappings() says so, and remove VM_SEALED_SYSMAP.

The only special mapping on these architectures which didn't already
pass VM_SEALED_SYSMAP is the x86 uprobe trampoline, which is now sealed
as well. The previous patch makes sure that's safe.

Since this seals all special mappings, the architecture opt-in now
requires that none of them are moved or unmapped.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/userspace-api/mseal.rst | 3 ++-
 arch/arm64/kernel/vdso.c              | 9 +++------
 arch/loongarch/kernel/vdso.c          | 3 +--
 arch/riscv/kernel/vdso.c              | 2 +-
 arch/s390/kernel/vdso.c               | 2 +-
 arch/x86/entry/vdso/vma.c             | 5 ++---
 include/linux/mm.h                    | 6 ------
 init/Kconfig                          | 5 ++---
 kernel/events/uprobes.c               | 2 +-
 lib/vdso/datastore.c                  | 2 +-
 mm/Kconfig                            | 3 ++-
 mm/vma.c                              | 2 ++
 mm/vma.h                              | 5 +++++
 13 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index c039d782f9f5..060c9829306b 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -133,7 +133,8 @@ Use cases
 
 - System mappings:
   The system mappings are created by the kernel and include vdso, vvar,
-  vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+  vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprobes,
+  uprobe trampolines (x86).
 
   Those system mappings are readonly only or execute only, memory sealing can
   protect them from ever changing to writable or unmapped/remapped as different
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 50596dab23f9..542adc47cd02 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -127,8 +127,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
-				       VM_SEALED_SYSMAP,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -254,8 +253,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, AARCH32_VECTORS_BASE, PAGE_SIZE,
 				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYEXEC |
-				       VM_SEALED_SYSMAP,
+				       VM_MAYREAD | VM_MAYEXEC,
 				       &aarch32_vdso_maps[AA32_MAP_VECTORS]);
 
 	return PTR_ERR_OR_ZERO(ret);
@@ -278,8 +276,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	 */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
-				       VM_MAYWRITE | VM_MAYEXEC |
-				       VM_SEALED_SYSMAP,
+				       VM_MAYWRITE | VM_MAYEXEC,
 				       &aarch32_vdso_maps[AA32_MAP_SIGPAGE]);
 	if (IS_ERR(ret))
 		goto out;
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 1edc8fb720de..c9ffc124bfb1 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -109,8 +109,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vdso_addr = data_addr + VVAR_SIZE;
 	vma = _install_special_mapping(mm, vdso_addr, info->size,
 				       VM_READ | VM_EXEC |
-				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC |
-				       VM_SEALED_SYSMAP,
+				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 				       &info->code_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 5666cec180ac..4213de6afb9a 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -140,7 +140,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 
 	ret =
 	   _install_special_mapping(mm, vdso_base, vdso_text_len,
-		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_SEALED_SYSMAP),
+		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
 		vdso_info->cm);
 
 	if (IS_ERR(ret))
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index a905f989f910..a9dd3876e7fd 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -65,7 +65,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
 	vdso_text_start = vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
 	/* VM_MAYWRITE for COW so gdb can set breakpoints */
 	vma = _install_special_mapping(mm, vdso_text_start, vdso_text_len,
-				       VM_READ|VM_EXEC|VM_SEALED_SYSMAP|
+				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       &vdso_mapping);
 	if (IS_ERR(vma)) {
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 4bd3b22beea9..e49d4e4d7b67 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -178,8 +178,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       text_start,
 				       image->size,
 				       VM_READ|VM_EXEC|
-				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
-				       VM_SEALED_SYSMAP,
+				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       &vdso_mapping);
 
 	if (IS_ERR(vma)) {
@@ -198,7 +197,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 				       VDSO_VCLOCK_PAGES_START(addr),
 				       VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP|VM_SEALED_SYSMAP,
+				       VM_PFNMAP,
 				       &vvar_vclock_mapping);
 
 	if (IS_ERR(vma)) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d89e6f823c9f..09c047dc9faf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -567,12 +567,6 @@ enum {
 /* Temporary until VMA flags conversion complete. */
 #define VM_STACK_FLAGS vma_flags_to_legacy(VMA_STACK_FLAGS)
 
-#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
-#define VM_SEALED_SYSMAP	VM_SEALED
-#else
-#define VM_SEALED_SYSMAP	VM_NONE
-#endif
-
 /* VMA basic access permission flags */
 #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
 #define VMA_ACCESS_FLAGS mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT)
diff --git a/init/Kconfig b/init/Kconfig
index 4013781e0a02..35d349cff1a3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1955,9 +1955,8 @@ config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	  A 64-bit kernel is required for the memory sealing feature.
 	  No specific hardware features from the CPU are needed.
 
-	  To enable this feature, the architecture needs to update their
-	  special mappings calls to include the sealing flag and confirm
-	  that it doesn't unmap/remap system mappings during the life
+	  To enable this feature, the architecture needs to confirm that it
+	  doesn't unmap/remap any of its special mappings during the life
 	  time of the process. The existence of this flag for an architecture
 	  implies that it does not require the remapping of the system
 	  mappings during process lifetime, so sealing these mappings is safe
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..2290a4cbebf8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1727,7 +1727,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
 				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|
-				VM_MIXEDMAP|VM_SEALED_SYSMAP,
+				VM_MIXEDMAP,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 1426bf4e0c12..e8933ff44aa4 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -124,6 +124,6 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned
 {
 	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
 					VM_READ | VM_MAYREAD | VM_DONTDUMP |
-					VM_MIXEDMAP | VM_SEALED_SYSMAP,
+					VM_MIXEDMAP,
 					&vdso_vvar_mapping);
 }
diff --git a/mm/Kconfig b/mm/Kconfig
index 40172787dfa7..316515589cdb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1363,7 +1363,8 @@ config MSEAL_SYSTEM_MAPPINGS
 	help
 	  Apply mseal on system mappings.
 	  The system mappings includes vdso, vvar, vvar_vclock,
-	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+	  vectors (arm compat-mode), sigpage (arm compat-mode), uprobes,
+	  uprobe trampolines (x86).
 
 	  A 64-bit kernel is required for the memory sealing feature.
 	  No specific hardware features from the CPU are needed.
diff --git a/mm/vma.c b/mm/vma.c
index 423383d59c59..67116be0260a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3705,6 +3705,8 @@ struct vm_area_struct *__install_special_mapping(
 
 	vma_flags_set_mask(&vma_flags, mm->def_vma_flags);
 	vma_flags_set(&vma_flags, VMA_DONTEXPAND_BIT);
+	if (mseal_system_mappings())
+		vma_flags_set(&vma_flags, VMA_SEALED_BIT);
 	if (pgtable_supports_soft_dirty())
 		vma_flags_set(&vma_flags, VMA_SOFTDIRTY_BIT);
 	vma_flags_clear_mask(&vma_flags, VMA_LOCKED_MASK);
diff --git a/mm/vma.h b/mm/vma.h
index 3fc3b47a954b..3982b239d0b4 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -800,6 +800,11 @@ static inline bool vma_is_sealed(struct vm_area_struct *vma)
 }
 #endif
 
+static inline bool mseal_system_mappings(void)
+{
+	return IS_ENABLED(CONFIG_MSEAL_SYSTEM_MAPPINGS);
+}
+
 #if defined(CONFIG_STACK_GROWSUP)
 int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 #endif
-- 
2.54.0

