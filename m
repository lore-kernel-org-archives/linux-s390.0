Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A22309B5
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920153; cv=none; b=LqyBRtyAkKN3Bq9Ta3Nt0lelwGyk29p8kqi3cSKdYC8C80YBw1qM/+J2NvTDwev91JlutE1cZoAE0yqSisWR19AKxJVjKt6jzyhStptteD2+6PV5W7NF9vi/CK6If23Xn1o4+Vkn4vkh8KnH5+ujiIGt9yeAfOPEpZwc8OFhrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920153; c=relaxed/simple;
	bh=JF3FfcrCfNzsuJEQqs2GHPMkdzmPYzsry0avRsoHtk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKr81a1WorOkxsHnKSvacI9w+urbWiOD20dcsgx3tCEmdp8mYfhVULjZVHDKoK7mElzjCRPz00mMIFhUQFrG6PzMpXbzHuOwMtZAZFocS9ASt4iFIEMQ9DypHqtZVay9gJXbmcusGt3X8D1qYajByD5tbC0nPJzjcZmaGDX4jHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wESmEgiD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wESmEgiD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so138939635ad.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920151; x=1737524951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqxfn2Bh8pqSgpWAhYuCaH8o2BUeXgVOaRACTrcmMAY=;
        b=wESmEgiD7hn3U+PaL+I6rdb9VBHeGpO4JRPnv2iDRb73IF9jAXhpbMm8LaNrr5I6Hm
         bqgPKCYlmNLSUoROqYDaw6OxrmMW5i5AcIpupg9E4We5Lw1/0J77DfjKKeo9Bvb2rtbl
         yH7iSQvW0u5JojIPkkqsGHlisHu7brFQ8neFgArhax1xuX6IP++qTvYPSp3k7FLsaLvC
         D+lvoAevauVTfEEZFCgp8Y0IxClAEXEzfrqGZWD//mqsXAsegAxyfnyqF8c37Sw6199o
         NvVkq7qVQZ4TJ1bzxgHWwfI7w7IOmamdXwFKHqblntOM4bcdXvshfMkrT+HUbw0HiF0k
         +jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920151; x=1737524951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqxfn2Bh8pqSgpWAhYuCaH8o2BUeXgVOaRACTrcmMAY=;
        b=Qrvd/Kv/HXXgM0JPcmT2Ud41nBbD9To1ppmqSyQUmWo/Au2Iv7o/UiMk1OtbLwONKB
         qDKjvBZKpuAAxKg0CbrsHZ+joHjKWtjW0kxhxRNw454j/VHmWwetbZmyzXMG+wmz+vGA
         KnhuN2dKn5N9VEvRt9vQcwGRsb7+hVN7Qe0Kw8CbxPJaQAvpxQg6K6W26IUrnAufX+zo
         6dBBeksQD5hp7TLopI2EtPdBpDiFpfIeYsZ1vit31735MXJOB5LW3SF4xjhgpVEDnZkD
         3mcVqxg6hoWOQRoM2Tr7AGtAaSux/wbhWO1SneFiRblhfRrtKDLrtoQiD85BbVUHWbbw
         Oa/w==
X-Forwarded-Encrypted: i=1; AJvYcCXCX55/V5df0j3Fbm5y61enVE6XJhnQVN7yPtSlb1uL0xIgH2mSAsurjtW0vVkKUXX5em/71nagTbgw@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGeXk5ukXnsNBDZk+KEiwwX/p+axH+/rjmtOW1j2RekLjA716
	b/dNBD+8dpDQkj66cyr591ofbDHAFWy8hAKN6mzsIpK4Hj4KUzBcS4GregJ6DCg=
X-Gm-Gg: ASbGncuAj0pJHq39fQllYNIh6KeBysNcN8sikpCqKy3OswcoSjmGmbtX9xQNbZcG3h4
	QeRGdHpoUGm02Kf31y1wTl6HXUg5u0JOHveKnvCyRSvwAkrlLloRyEzF2/0Jmk1Fx2863/ZXBHS
	6f5kvX527S55UWDAyvyImMBrorEyf0rLi/hJN7EGHyVasXtWpbXqfEq5keSCX50dkhCE9MYdnxz
	G5bZmrW573Oe0UNavLBu+PGVSQqQohugkgwvir8Kj/apF049NAQaq7LZzI=
X-Google-Smtp-Source: AGHT+IGEE8Fm6k+e43goXL9XR3kNG0Qk7QvIMeGK5viYe25EF4qO0xqHuY9x+AzGWdKmvE+R7dTOXQ==
X-Received: by 2002:a05:6a21:1087:b0:1e1:b727:181a with SMTP id adf61e73a8af0-1e88cfd3cb1mr47297876637.24.1736920150754;
        Tue, 14 Jan 2025 21:49:10 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d406a94b8sm8295174b3a.167.2025.01.14.21.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:02 +0900
Subject: [PATCH v5 5/6] s390/crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-5-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Heiko Carstens <hca@linux.ibm.com>
X-Mailer: b4 0.14-dev-fd6e3

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..022f4f198edf 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -248,15 +248,6 @@ bool is_kdump_kernel(void)
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
@@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
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
@@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
 	return size;
 }
 
-static inline size_t nt_size(Elf64_Word type, int d_len)
-{
-	return nt_size_name(d_len, nt_name(type));
-}
+#define nt_size(type, desc) nt_size_name(sizeof(desc), NN_ ## type)
 
 /*
  * Fill ELF notes for one CPU with save area registers
@@ -324,18 +310,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
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
@@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
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
@@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
 	memset(&prpsinfo, 0, sizeof(prpsinfo));
 	prpsinfo.pr_sname = 'R';
 	strcpy(prpsinfo.pr_fname, "vmlinux");
-	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
+	return nt_init(ptr, PRPSINFO, prpsinfo);
 }
 
 /*
@@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
 	/* PT_NOTES */
 	size += sizeof(Elf64_Phdr);
 	/* nt_prpsinfo */
-	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
+	size += nt_size(PRPSINFO, struct elf_prpsinfo);
 	/* regsets */
 	size += get_cpu_cnt() * get_cpu_elf_notes_size();
 	/* nt_vmcoreinfo */

-- 
2.47.1

