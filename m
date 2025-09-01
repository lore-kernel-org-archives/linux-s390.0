Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A730BB87
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718370; cv=none; b=Ug6l2bSoJ1wWQLJQYg3R7eeqYfuoQSzkqCRLthU98MvLmxKNcqXR45T5frl5JRYy8oDbGMg/tMVOVKhVg8y95oEPgaLgkYWt9p18MmleAypiriANzQJ36AeAs5Ci67JXmHvPHNRtwNw9BFIIxghbXV95TClGd2P1gbYCjYDbkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718370; c=relaxed/simple;
	bh=+9zVED1lHiuNiZ1RPeRxS3Ssm9MpRMNLvSgKjt52v7k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiJwnMwPV/UPDLd+NlSZm4g/oiIuz4QOduEwSXaIuFU7k5Zlo4aMFbS7bH3nzgL/vcPd3LZyFHNyl6XwT/gLg/lkaGUu4KSQ9oK8f2fpP5fqgyXZ/10juSn2BN+3L2BeqC3CiFX5Dp1BvGNqqryVx1sAAl1FEnrZuGO1HfwJGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=anaTr1CN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="anaTr1CN"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042eb09948so112245866b.3
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718366; x=1757323166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsR/STrnydl4a6f2Yv7mj4KlfpOG0wbJ52LB7E1pZ7E=;
        b=anaTr1CN9wCZ5ePMrch/oFngDKxnpI2+DAygB3XZhVHI1kmdu+Jmcgl77x3ZOIgBi4
         CkhJm6RIsGmqD5sm2LDeC+j887fN4hAVplU+OMcvFvgKfL+xFFUmAdP8QOXkXvf7OSPv
         VybgUz9Xc1oqNnzfyA5vuMyXoZk/53KUfKBbWzVJUCTsLDCYOQqgEw3VjVBnl+1rcEN3
         6HGM7ny3pol9p4IBUPfbZLv96TySiOhJ6ZQDp4/vkUG8CsTJWmE8vFm83C9nYgHec53a
         NyH1mqimEN2SBabWMIKD1gUyjrC610ZJrM5ISxGR21cnPdGQ4TYteHUrD3PfrpHwZPg2
         uEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718366; x=1757323166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsR/STrnydl4a6f2Yv7mj4KlfpOG0wbJ52LB7E1pZ7E=;
        b=slHYorm4vEuS4Q8oMaGMtatfJXpZVUs9ZL9feQu/C+Ee1V0JxNVd7vVmnEhNVEH6QL
         3HFL3FOY6wWBJc70g/x1l268vRqYW88/u/7xHaIetToN7FKFo/N3hgpvdhqmDgXZ3Ngl
         aHkFv0WiBgGemHZhcTDjXi5AEvmJXeEiTXflLUj3tt8JvRZqCtLdJoNeCTy33uwlewnp
         Gpyyy+R1SgzIJ8+j6k4/zV1tuEgxmGuyehGwztjFrr3WRFfoqRw0HoOPxbTLmakcTOQJ
         V2XWtjcd58q+5b+Q47TIoWnNz7t96KaHK3oCx8MD6Y+d/wQhSUZVz03soMMIOCwFAetr
         QoVw==
X-Forwarded-Encrypted: i=1; AJvYcCVNCrGloHVWveddEIFHWmLjz5vF8QId1puSC5Dv0drggbRHmqPifyEE84b0cle8sMOUuvkWLs1UtdKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSmDu3KAR3DasrV9wHwIqb95ZrU2gZWrgxWOloWcU9fzwyALb
	CI45jQLhHxZH2IiAvxhZ6nsiEpAfsb7DxrvCwxEBRCc8J21Ar1m+03NbCgLtRXsVvQE=
X-Gm-Gg: ASbGnctlIEV7vgsnvdScL8qiZuC8/Wr1J+nIhLJ+aWYZ3RosMvKwIADcgiCqDvj8B5W
	6fJ9AvJ2wB3L6SmTPk70z7f3USqRABWzS6CQQPhX8kOeWEiO7RViNAp8xha3QKlsEF4WjhyDWvN
	mBwglI5ymLI3D+4wids1xYoKkBBVO8pXQW3rdsk3S5af/0mbAh3osgx5Aec7vqr7dRLnX3RZgFR
	pY88WyYIaqbJ3w9/rdE9EFwAiun9gFn14z194IilVSQixfSOUq8862iBI9TMsujhgrb2CAxt3Xs
	1UGlQYD9NA5HjTyBRS7UlZZinESSuMOEbmpZFD6njaWXJcB2Eo+WeRdDc48dkPrnZNiFVLaWG9p
	c2PGcBDbebvBonjMSVz3AgLa7EzMX6LMrUGrhjyz5EkuHUATHkReAXg/YAy7Viu3JHpCm7lz6vi
	HotkrfXfgVC18zw/jDIop6yDZNV+UiMTF/
X-Google-Smtp-Source: AGHT+IGLx5jJD5g8VFu3vDjbftCHYb2Ijzb40t+FBcgd7shPE2wS/JLAjEdNECBMIdCPyPMz8moKGA==
X-Received: by 2002:a17:906:c10b:b0:afe:954b:25b2 with SMTP id a640c23a62f3a-b01d8a26dcbmr694211066b.12.1756718365873;
        Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:25 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/12] mm/shmem: add `const` to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:04 +0200
Message-ID: <20250901091916.3002082-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to vm_area_struct and address_space
pointer parameters in shmem functions that do not modify the referenced
memory, improving type safety and enabling compiler optimizations.

Functions improved:
- vma_is_shmem()
- vma_is_anon_shmem()
- shmem_mapping()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h       | 8 ++++----
 include/linux/shmem_fs.h | 4 ++--
 mm/shmem.c               | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd14298bb958..18deb14cb1f5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -979,11 +979,11 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
  * The vma_is_shmem is not inline because it is used only by slow
  * paths in userfault.
  */
-bool vma_is_shmem(struct vm_area_struct *vma);
-bool vma_is_anon_shmem(struct vm_area_struct *vma);
+bool vma_is_shmem(const struct vm_area_struct *vma);
+bool vma_is_anon_shmem(const struct vm_area_struct *vma);
 #else
-static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
-static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..0e47465ef0fd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -99,9 +99,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
-bool shmem_mapping(struct address_space *mapping);
+bool shmem_mapping(const struct address_space *mapping);
 #else
-static inline bool shmem_mapping(struct address_space *mapping)
+static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 640fecc42f60..d55bceaa1c80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *const mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *const vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *const vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2

