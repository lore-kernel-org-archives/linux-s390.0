Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2929711C;
	Mon,  5 May 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484523; cv=none; b=qily6+AFg1H8Gkf/kppA8dCn/vb3PdwTqvAS1QpTbz/KzFOK3Pj+YJ1aCXMu8rsEdCI8+Ynh6fvv7MerX2ZNUZl3xBMlOxNZ7jikNiFg2E2SgPRp/nB3QzuwYq0C01neO+PPKymcE/qYg25isZ50jy/hT0s6RIE8b6FqfW7oaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484523; c=relaxed/simple;
	bh=U1ridXpLRTNZDBkHjEBPQb0jeOdaoyd2hB9o89KazIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2SIX+bhQm1e89tt2MOgypQEtqoAVAMLAnkfAR+HIUULEryhconH/M6UEcNX8dYmU9e/wh0ZXC19EZGLfd1w2k4WZr9F7RGNxgVRl2JO8SvfjZuJI7nLu1d8vfsm+Ekufc7As5F3Cr73yTxMtsA1S+axBwJClrxQtrVr7helc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0TT+32z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0TT+32z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FB2C4CEE4;
	Mon,  5 May 2025 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484522;
	bh=U1ridXpLRTNZDBkHjEBPQb0jeOdaoyd2hB9o89KazIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0TT+32zlz1R2JM7KPrCKI6GaQ6BcxgRVs2L6IbhDV8bdn/jbiHnt5wGacE8sVF2d
	 KzVTXqR3DZeAzd+6w3U3ObF62vd4MXl6hghkxB/plhvQc3pskc8xDWmNpS8Gx3SDt8
	 47EAoJmwlQ5BS8LTdh2NXQ9ngmeOaBDK5SMsY6hoGpOxWAO5cKy4/EY2HZ/lvOeIN0
	 M1dXSsqPqsa5oxXOkGsTw1Qgs23a8Qorp71SM+OkWd0Gw9IPQ6zIy7owzjrk7zHuXs
	 ela3E9XJXcbj8tGrS1wQDwTecxQsH4gGHUkn4XeoIAAvrYqCOgdrn9L5ddslpG4rLY
	 jdry83iCYoSMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	david@redhat.com,
	zaslonko@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 513/642] s390/crash: Use note name macros
Date: Mon,  5 May 2025 18:12:09 -0400
Message-Id: <20250505221419.2672473-513-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Akihiko Odaki <akihiko.odaki@daynix.com>

[ Upstream commit d4a760fb77fdac07efa3da4fa4a18f49f178d048 ]

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://lore.kernel.org/r/20250115-elf-v5-5-0f9e55bbb2fc@daynix.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/crash_dump.c | 62 +++++++++++++----------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 276cb4c1e11be..4a981266b4833 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -246,15 +246,6 @@ bool is_kdump_kernel(void)
 }
 EXPORT_SYMBOL_GPL(is_kdump_kernel);
 
-static const char *nt_name(Elf64_Word type)
-{
-	const char *name = "LINUX";
-
-	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
-		name = KEXEC_CORE_NOTE_NAME;
-	return name;
-}
-
 /*
  * Initialize ELF note
  */
@@ -279,10 +270,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
 	return PTR_ADD(buf, len);
 }
 
-static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
-{
-	return nt_init_name(buf, type, desc, d_len, nt_name(type));
-}
+#define nt_init(buf, type, desc) \
+	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type)
 
 /*
  * Calculate the size of ELF note
@@ -298,10 +287,7 @@ static size_t nt_size_name(int d_len, const char *name)
 	return size;
 }
 
-static inline size_t nt_size(Elf64_Word type, int d_len)
-{
-	return nt_size_name(d_len, nt_name(type));
-}
+#define nt_size(type, desc) nt_size_name(sizeof(desc), NN_ ## type)
 
 /*
  * Fill ELF notes for one CPU with save area registers
@@ -322,18 +308,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
 	memcpy(&nt_fpregset.fpc, &sa->fpc, sizeof(sa->fpc));
 	memcpy(&nt_fpregset.fprs, &sa->fprs, sizeof(sa->fprs));
 	/* Create ELF notes for the CPU */
-	ptr = nt_init(ptr, NT_PRSTATUS, &nt_prstatus, sizeof(nt_prstatus));
-	ptr = nt_init(ptr, NT_PRFPREG, &nt_fpregset, sizeof(nt_fpregset));
-	ptr = nt_init(ptr, NT_S390_TIMER, &sa->timer, sizeof(sa->timer));
-	ptr = nt_init(ptr, NT_S390_TODCMP, &sa->todcmp, sizeof(sa->todcmp));
-	ptr = nt_init(ptr, NT_S390_TODPREG, &sa->todpreg, sizeof(sa->todpreg));
-	ptr = nt_init(ptr, NT_S390_CTRS, &sa->ctrs, sizeof(sa->ctrs));
-	ptr = nt_init(ptr, NT_S390_PREFIX, &sa->prefix, sizeof(sa->prefix));
+	ptr = nt_init(ptr, PRSTATUS, nt_prstatus);
+	ptr = nt_init(ptr, PRFPREG, nt_fpregset);
+	ptr = nt_init(ptr, S390_TIMER, sa->timer);
+	ptr = nt_init(ptr, S390_TODCMP, sa->todcmp);
+	ptr = nt_init(ptr, S390_TODPREG, sa->todpreg);
+	ptr = nt_init(ptr, S390_CTRS, sa->ctrs);
+	ptr = nt_init(ptr, S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
-			      &sa->vxrs_high, sizeof(sa->vxrs_high));
-		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
-			      &sa->vxrs_low, sizeof(sa->vxrs_low));
+		ptr = nt_init(ptr, S390_VXRS_HIGH, sa->vxrs_high);
+		ptr = nt_init(ptr, S390_VXRS_LOW, sa->vxrs_low);
 	}
 	return ptr;
 }
@@ -346,16 +330,16 @@ static size_t get_cpu_elf_notes_size(void)
 	struct save_area *sa = NULL;
 	size_t size;
 
-	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
-	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
-	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
-	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
-	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
-	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
-	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
+	size =	nt_size(PRSTATUS, struct elf_prstatus);
+	size += nt_size(PRFPREG, elf_fpregset_t);
+	size += nt_size(S390_TIMER, sa->timer);
+	size += nt_size(S390_TODCMP, sa->todcmp);
+	size += nt_size(S390_TODPREG, sa->todpreg);
+	size += nt_size(S390_CTRS, sa->ctrs);
+	size += nt_size(S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
-		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
+		size += nt_size(S390_VXRS_HIGH, sa->vxrs_high);
+		size += nt_size(S390_VXRS_LOW, sa->vxrs_low);
 	}
 
 	return size;
@@ -371,7 +355,7 @@ static void *nt_prpsinfo(void *ptr)
 	memset(&prpsinfo, 0, sizeof(prpsinfo));
 	prpsinfo.pr_sname = 'R';
 	strcpy(prpsinfo.pr_fname, "vmlinux");
-	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
+	return nt_init(ptr, PRPSINFO, prpsinfo);
 }
 
 /*
@@ -610,7 +594,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
 	/* PT_NOTES */
 	size += sizeof(Elf64_Phdr);
 	/* nt_prpsinfo */
-	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
+	size += nt_size(PRPSINFO, struct elf_prpsinfo);
 	/* regsets */
 	size += get_cpu_cnt() * get_cpu_elf_notes_size();
 	/* nt_vmcoreinfo */
-- 
2.39.5

