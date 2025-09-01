Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC727280E
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759832; cv=none; b=R+5AaiyswnMnhIhY/j+gq0to4kGOWJgPZM/afpHPJnqQqWMc3TcUIC+Me15cK8deR0Cn3pIJtqra9ksbRTIvu1l0mLde7uTPqxpUPP6T4t9BsgeqMgxQRgQ5ZFUQuSbq2iCkLxmDDqiz8W73Ts9wR4+Sd0GKYykqwSQktmBsfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759832; c=relaxed/simple;
	bh=t7XT6CEbh7zjmSeSWCr8ZD1olx5I3kyEJDSmUA/OyVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpV0HkgNdA9rZVuM6xaYYdjnHY2HPzvr1dQC65Zh6BA3Bsx+NPt7IStEctHuBeZ2oWeMzLktEUF71tsv4Rs3hlV4VXFehAtBAIgNG6AoKn3IRf2TvzOU4wAX9Mr9xUf/xdwPHgl56aXyzZi06MUDbiVJRxYZkm98Pea/bmFc9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gLK6PNaB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gLK6PNaB"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afec56519c8so783141966b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759829; x=1757364629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=gLK6PNaBOzEjiJLFIBBwG8cqcduLvvio1BVX1TRz97HZpLz9lDaGp6o0CD3qN/XB0q
         o/4OqHjiotjvrZYa+wf1FTUJ8T65cXLA2ScYnw1k6ZfioDI0BVxJMkB4l2BCYUDrINot
         rmGggpiREPYta3Rs+GBXRkuEORhN0RuXWt76fjtcuZwGzdUSA40Ub2CnGPEY1pgVwIwy
         g3WN3zz1o1T4EQhtfHqnjvl4hZSvCvSp9sAY7YPaEFPIITppvKBoXQTFmhX4Sm0Diq1/
         Kue/GBW55svAnQzp1ap83FKsFfc/YTmbN03CxMqbS5Bk4md+DNIOT2bJHkpTTYkEtN8w
         9Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759829; x=1757364629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=t7/nYLkEd1V5w00bmzePPPckJoC906+arMbQ3yG548wHMkr14HxMGeZ2CIw1cbzI/W
         bXpTqOesgj/MVqw8wVU6sV01WduDlj3/BTmgDHsZ1HkclnU04orrFBrdARLPivxF2A43
         SAxI/VDKBtF40GTaMQwV9G0/HybDpPy/bawe63/AVK4ru8QsSA2Urb6a26XEk6bl4Pst
         IoLBCP+mXUgALtZoAq3sjGeJaZZsR1E8599/9/4lFAyJfmIJ22aVpWOYKWFpv26Gq4bk
         bKx36ojRdfpoZkiCc7JIgpZBo9Zi9Nq39Tkrh1yDhIO27E6edBp+w8Nel3LqbL/JmAjm
         +j8g==
X-Forwarded-Encrypted: i=1; AJvYcCXk3pvHUSO/lPiAME31BveuYdPkxUgzKrkKwcCLzWr4mYm59oxredC7kIAsHQcW3wZjoHhjtBJDXTr5@vger.kernel.org
X-Gm-Message-State: AOJu0YymJK4SmNY28T8V4zxZlPxwmnvRv6WbWal/Yu23m0fR9zJOcUS/
	03ULUGC34telYJCheaV3cUN16Y1ZmGVmZC/4Ci3hwWeHj/hZjm4zWR41/d8qnV9TzxE=
X-Gm-Gg: ASbGncvSri601DM7Qlc1NVaX0wowfJjHDGwatanXmtR6OYH4md13xs2zTsAANgVmAMU
	LGSf/SiGy0sMfmnN4nbteyaz0H5JobkdJsHpG8i+gSj6uDjkRYPGrB/J/0aqZDQKOCkkFKOCBHq
	OieeMasreVvheGScSxBq+Y2KAG0E6eVFoTIiHxLIFIHw+tCEbJcEd/AUOFCn24bxI4P6loEJhmT
	07WfBaZKaMKoDekJv7vJ1cUtGmkPaKSdBWpsVcYtatiUbQHxBaYUvnUWJAJtnGU7bXQ+6EIBmjT
	Kr5g1gQ++rvg2xwoqDxaVc63z91h+IrHwObs365iEdLgmBfbC8h/lfR49v34kpLxAi5wzBm/SSc
	8Qp4hEmtsBc0oYwSGsV61APCk1WGX6jl2vFScrUd0Zp4Z2Um0rprwzUWOCxCzJ2rq3oLByV1FNI
	xxEP1VEg9Hyfl87JeBLI2SMlFPxFVoSOji
X-Google-Smtp-Source: AGHT+IF8f2IkqJ53snw7rUXbJM+rbFqtblA8YnCowS1e50uvKMXTh+/K+YqxtlkXHOf7uiwvUXJSGA==
X-Received: by 2002:a17:907:1c81:b0:aff:a36:e6e with SMTP id a640c23a62f3a-b01f20c705cmr970127566b.57.1756759829377;
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
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
Subject: [PATCH v6 01/12] mm: constify shmem related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:10 +0200
Message-ID: <20250901205021.3573313-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
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
index 640fecc42f60..2df26f4d6e60 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2

