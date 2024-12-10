Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E30226194
	for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2024 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798514; cv=none; b=GFRq7rFduvuC91aSs7T2dT3XL0pQ/mekLwWRt2d1xXNlUlghU3bZ6MxFEdtCuNqZezCNVy6/z6Ghmzwg7t3cPM9p3Rfdwnbq+ML6Zpl+j2FbZFQvj994NOMqffjGSpZ339zu3QiP3DaToLCw3Tnktd6crv/XQAMJECAYlWDuZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798514; c=relaxed/simple;
	bh=3rw7IdVRCH81NY7IYEFDBonBrqPpECuYjHxmMdU8RfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qhu9c24QZDXP4akmgOhsQUOCb/tehOavYWKARfCnaGzoYE6gWb1hFbEUqqsyyJC7mviqLFEymODzYFBbC/Hig5QAajNtzxOdQwyX2xNp7pxu7K/h5zXD5peru8077zuGXB/2fjLK9XKAll2Y2IR+Ku/S/ZbsZkDwD8yhEmt+O0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fThUyNP/; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fThUyNP/"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2975e172b3bso4105611fac.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2024 18:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798511; x=1734403311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfykOM1fOarLfySIdaHc0pH2J2Kgj1GMXq62gJs/y4s=;
        b=fThUyNP/UJnjai8CUfhr6Bv80crvmwQOgz3zH9imuIAQ73KtCMOCZmbd/lNB3iFGaW
         aqBex5n5mF+HI+iyBVLcYHwSnjrUoOyvmgUGBh/HoJCfUXUTkV+B4KlaIsUNPkKEGkCY
         0XW8DyAeScKtnQfHjrea6UZuXNNehxo8vZqY7nbeugA+2U306JlfYUNrzUCvHjZQMDmj
         BFNKOSQLAhm7AR/3Bngwp0VcX2THbEpHw0d+Ol9fiByRkv7lTaw0BKJy4I+VyVKmRWFQ
         /udEXz1cl74aEW0jGIn4mrgzYAQ5h/ZJDcN2PwFkiosTAAD18e2wuJBrHhZR6tDmVnpg
         q1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798511; x=1734403311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfykOM1fOarLfySIdaHc0pH2J2Kgj1GMXq62gJs/y4s=;
        b=jycd/6mUj1Hd101UJJZpjJcDEIpMMiOb1kB6zvxeNj7y3EtE6IBzGikO+OHaxTBS8j
         XKph8VS2dQ4hm7WjN3WRXnOraM438SYRFqzZ6DaBg1oovvwKmkSiRbAmfi/zgu5xf31i
         +grTtjEaSvIkk5VILdrKBf6oBrsWsEnGA+gxeBZEc1QeTqsmLqOcGgBxkmnpQFUiQFM0
         KEOvy1tHHMg5QuCV/wr1V+hgWqTi+s2GPaMaDA8rdaQKf9omlCADXSyDSzQxApRxMKX8
         vDFSgm+8C07//shWECeNXysSrSqQsdyv+8LTIBqskLOoW5/C2fVA5QjfYrknkJmQMveb
         tQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVh5wHHyqrPpRTpNz7vTnsLMe++pFvG6DU/VcVu80uhYB/FvPK5tiyxuzT3XI1FIuSyskZdzdndGYWl@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyJazHHXwNrJB+eaj5qGVQZn/DjswyzlhTs8bnr8CsZjA/9hP
	C3NU8qPO5gdaKqxzes9INRnRslOdJJem7MCSj9Ptm2go7apw5z3iYGvz3N3EpMqz+aRm+JRsg3/
	HXMAQmbGabq8oloYIfVpBtA==
X-Google-Smtp-Source: AGHT+IGyaGimLFtOc8xFMrBxHlvoKkgipEDRsXSRpIYCtUs3FtGiq87tnN7DOlflNQnY8+3VkwfOeHU4ERQxyW4QXg==
X-Received: from oabps11.prod.google.com ([2002:a05:6870:9e0b:b0:296:5847:48e8])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:3108:b0:29e:287e:3706 with SMTP id 586e51a60fabf-29f732d630amr9859551fac.17.1733798510837;
 Mon, 09 Dec 2024 18:41:50 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:17 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-16-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 15/17] mm: powerpc: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce powerpc arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/powerpc/include/asm/book3s/64/slice.h |  1 +
 arch/powerpc/mm/book3s64/slice.c           | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index 5fbe18544cbd..89f629080e90 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -10,6 +10,7 @@
 #endif
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 #endif
 
 #define SLICE_LOW_SHIFT		28
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index bc9a39821d1c..70b95968301a 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -647,6 +647,37 @@ static int file_to_psize(struct file *file)
 }
 #endif
 
+static unsigned long slice_mmap_hint(unsigned long addr, unsigned long len,
+				     unsigned long flags, unsigned int psize)
+{
+	unsigned long hint_addr = slice_get_unmapped_area(addr, len, flags, psize, 0);
+
+	if (IS_ERR_VALUE(hint_addr) || hint_addr != PAGE_ALIGN(addr))
+		return 0;
+
+	return hint_addr;
+}
+
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned int psize;
+
+	if (!addr)
+		return 0;
+
+	if (radix_enabled())
+		return generic_mmap_hint(filp, addr, len, pgoff, flags);
+
+	if (filp && is_file_hugepages(filp))
+		psize = file_to_psize(filp);
+	else
+		psize = mm_ctx_user_psize(&current->mm->context);
+
+	return slice_mmap_hint(addr, len, flags, psize);
+}
+
 unsigned long arch_get_unmapped_area(struct file *filp,
 				     unsigned long addr,
 				     unsigned long len,
-- 
2.47.0.338.g60cca15819-goog

