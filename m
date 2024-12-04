Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137461F7080
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316910; cv=none; b=bJTqZXHPRC2H/gnj8oK8WHxozz3Fg6p4W6BgpLdABjoMlXxanx9S/1Z9DwJJOC1LR2T/tkM08vQSzs6KLOCeSfWMnMd2g33wrzKIAogolmuUyl1uQeu0Wrh6VhZtigS+WhiSJ1zftq/Act+EE+RQMw4wuxqordQpyKVwtIckgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316910; c=relaxed/simple;
	bh=GU+EylrtNkBl0PCgVUrji2d7nB4cQuMPE/K3NHw4YGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMAfUbaE3swduQoiz7um/zkgu0JmHYDNVGZdRg4bZcMr2kXz3TWYo8Wm8DZ7nglZMqYQk4FRctTRxuR6qREPBqbK/SnZk57X91BX1fJAvARecpbQNT2uEIwFpvJSuFQKUOcRYpw5voM0GkJ7J1sz0UzpCvrHHtYOkpub/CegNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6nHUCsJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6nHUCsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
	b=O6nHUCsJ7VBy/f4+kT+4tfTdhK/ev61TkwjjZmbff2s2hSLFi7tSIAgK3HtznPqESiFD67
	3GPit59iFITU0dpq2t2encr920VrsREEynoNQas1dY6Twbx1LmfOX6U7FTd0C2wr16YROs
	ko1dwVeLZENjU3yZ0sIbtda2Qki/U44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-2VQirv0mOTuBtGyJtqBPrQ-1; Wed, 04 Dec 2024 07:55:07 -0500
X-MC-Unique: 2VQirv0mOTuBtGyJtqBPrQ-1
X-Mimecast-MFC-AGG-ID: 2VQirv0mOTuBtGyJtqBPrQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dfa9b758so2188674f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316906; x=1733921706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TMBFu0zsYs/BK8mI3BuEemyVvVnFxsrbDwOUtwonV0=;
        b=nf1JrAUERSkoQ6yFlMn4T2kxtQpUrKvLBFnXxXX6nKOtR7YNtTXIXV7q304kJpJULY
         G1I8++C2nQNSlruIG6+EIAJ5JjUl3Bn3zLDUiD62f0sNWb9ncc3+7zG45Rdiv35jNtl/
         j7AEV3dLxMlTGAmS5zu6iE7Z1IRkzQslvYvqwpQt/PL/IxhNz0gDG9PG1D59jnKhNaMS
         7LFbzZ+7gjD6+JN4Ipc/TP29h8IyrFA7FJtn7EPlxiTuBPcnkEKZWWRnY7EWTRlqNuz6
         hr6tVvxgyeC5mMA04yXzLQ0cLGLSMy5DP1c61laXPDnGRBMUN3whj5u3pQfVRNW/rTbU
         uA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpAeaXvfuZKAtEyhW9UIqWVZqG40CflpybLfjtaPdOblN+gKuJhQswzESxoQB+blYvtpXkptfIlZL6@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqNs8Yv49ZMqx7vdxziqNDfdUerQRCLltaYGdYknJjiURWNKF
	1w5w8uJKALdApn2pclp36tU/OWvTCMNEnSSchP8gh6PMDo4l4emurxgppORePY1AtgPgJGjaTLk
	thRxsQdXqZNWHMgDPU0OHDVungCDl2jmeyaEIpJWTnADr3+u2wHkvZjDS7bo=
X-Gm-Gg: ASbGncvp126qA3Y7Pf3du8itY/u0mUNU+q24kHYlZtIoQKtmYriaN/8SnlagyUyTaCh
	SC6C8RYDOxbzNNY1YKhKXEAIu9WehKrNVazW9MU9jywfcMoKC8l8ddcNYt/BnGJhWO8zCY/j/eR
	uSKZSodpkOoR04Chhm4a5bvxaY1iqkJGfpE11juvRH7kwKmCOFnQbGxW22ci9zTP0KURfqFTBej
	VKiVpr5NL1cUwIL3e3EvCHO/9HZ6xVKQZC1WNeW6j8/vcHNBHVELDFTwij0vmDXjyK8OU0ExXEI
	GKv9pPetRuV/G2910maL/QPenWVCXULPLAs=
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561613f8f.43.1733316905766;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3Vs5XvVpD9wVjl4Do+O4dwdUFKsmLeUCgsK0LBk5udBDNdRPox9DV3gXL42llKQONJirIJg==
X-Received: by 2002:a05:6000:156e:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38607c0e1e7mr3561572f8f.43.1733316905408;
        Wed, 04 Dec 2024 04:55:05 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ed8dee66sm10241947f8f.104.2024.12.04.04.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:04 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 06/12] fs/proc/vmcore: factor out allocating a vmcore range and adding it to a list
Date: Wed,  4 Dec 2024 13:54:37 +0100
Message-ID: <20241204125444.1734652-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 21 ++-------------------
 include/linux/crash_dump.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8d262017ca11..9b72e255dd03 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -709,11 +709,6 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore_range * __init get_new_element(void)
-{
-	return kzalloc(sizeof(struct vmcore_range), GFP_KERNEL);
-}
-
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
@@ -1116,7 +1111,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
@@ -1139,13 +1133,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
@@ -1159,7 +1148,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_range *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
@@ -1182,13 +1170,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_range(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 788a45061f35..9717912ce4d1 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -121,6 +121,20 @@ struct vmcore_range {
 	loff_t offset;
 };
 
+/* Allocate a vmcore range and add it to the list. */
+static inline int vmcore_alloc_add_range(struct list_head *list,
+		unsigned long long paddr, unsigned long long size)
+{
+	struct vmcore_range *m = kzalloc(sizeof(*m), GFP_KERNEL);
+
+	if (!m)
+		return -ENOMEM;
+	m->paddr = paddr;
+	m->size = size;
+	list_add_tail(&m->list, list);
+	return 0;
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1

