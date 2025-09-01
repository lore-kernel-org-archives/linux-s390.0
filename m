Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B8341AD1
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729845; cv=none; b=bcue7zrAbB0oe8WNzhNWJ+zLZ9VjqHkWY2bMaVnHEh5PKbxrCnKSIE+L/nWqd6Cu2g84oeDnd2GmsPMNqLLWYk1mLoJSx63pkM3MXF5QH9V5RS9U4AYRw6hLWqFyWxHG4LQdtk+s7V5L3MlwKs4TlI8YHBNxJROmruj0Hj3nQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729845; c=relaxed/simple;
	bh=JLsm20nRUfCdVD6uJy+GUl3NfrLb9BR0ocnDc7c6Sws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJeP3NwpqHFvLjhl5DfJc/y2bMdtCWKP3DT/wrOPJQ7n21S1YGkH6ax2zGamEIH2zyz6E5DLBsqiY2mT3Z+QP5UgxgoZVbQ5xyg1U4HufQV23Wna5nYYWTHDJYHjy+Y25pwTRtf7ejAnpI9ZWariXmJU1hPDvj3CM1r+dqROO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XP7+ZoAj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XP7+ZoAj"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso3415511a12.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729841; x=1757334641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=XP7+ZoAj2t+s/GqoFImqvaRcFKXis5a6i5gTR8BK58n5jcvvJvZHMf6vUAHpplIU51
         +SbrYotB8qxVo1h8sLJ84e8ImOgY98uja9OZndbkvHgLgHteEOLQ8edqMl6Eb4uivxya
         /9x2ggMJocoeC/7pAFQi6yrww/lmHDMRDlytUnW84ZYu9FuRZff8dkS5bL1Mc5k7iJ7+
         eChSaNk0sssJNnCct0MtOPjNu3J554hm5e77ImZd9KhHTI6Zn+8DWLjh/cTWTLUamb2K
         B3JEl57OmmcqJ/CZNam1VstrIWRULwuzdFIApVWAKSIKeChVcrm3dkw9iffdQEDGUfmx
         5ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729841; x=1757334641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=JV9eMPqdDlBv0U985PGwtFIp5tbYumvmpRiE3J19KUUK5zO6FuIQZq8pC7W53w+Jgu
         Yj+pZiM7p0e2aYzNuzFke9s0Y7xpHKVkPzs5X3kmnfVDQDGpBLYIe4LYFNmumv/pgayy
         NvuAoD1CKNDRA6/zyRyfoVirBow8LpCkPWxmWXRjc7ydMEmkeGDPvM8shqqzCB42GTH8
         Hp11qRwEf177VQcDQhQI/HBUW92xwEdwBWQlNmmsoCXvBjbFi0m7nmw2uAMUpdXKxYpg
         ND9VTdr7c+x45v1tIoj41BYUaJYAmD9VlsiINd9WNp7em0feRqEpv41cUGooT4Cjzstx
         iGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDKvnwwla+WiKeP+t6ZC9o6TxFG/6UFqcWwdgcEUOFJsavyGA2BZJCOmfpJjTBNsSBLzIF9xpZZMVc@vger.kernel.org
X-Gm-Message-State: AOJu0YyisDJPHR1iI2lvs3LLtHzXLq8DbBxdy+NRhYzNaU0qZYujakzJ
	vt1MJAfNcVfEAdfdk7yA/4FlVSh/RtH1lkZcAkK6lT7GamPCbOBKC4m/RYoyuvaBTzk=
X-Gm-Gg: ASbGncsJjIqfgbrQaBzaLRXtzv3GN/jcwllBlTCmm1UmJ4lKWtkU04ziQlpUxuE5pGB
	aUPG1HTzbW8I00Bzu9nFI57Y1yClTJs+4rHf1rxxKFeVkC4dgoKtOKJX1tOhBYHplzFVdGvyq/E
	aerGhzkU0u9f1BL02A4k7B93OiYmhK0TOvQ79MVuHhHExL9udTH9VLTouE1uH+5ipyOKoFoiWud
	hgbxNpbzmBLOSIkUdj2rOFZSVolduAIZGQHMf8n+StaMp558BQzhdKlKkNuglfxiUZexmKtCrTx
	rQquo5ak/nw8ARS9z8HIK7buCCb4f74KDE09z8JIaEPUf3bT50Hji6S1FYzIoPK7YTzTcr7jT0P
	jpqlfV3GOtvthcGC4SaN0vm51IEvkHMX7ZWvVjhb8G4lfVCJXW+RR3vqJjmbScb/8zguHL4rUrH
	PtizYSpxdd9+JeYhmpQxEZwnppcnDhwXNb
X-Google-Smtp-Source: AGHT+IGRe72s+UHTnGokGr7x1pyG7G81cHBjYzB5waC3bIIZTDAVVMuEn5lgB7KxjuKhIwvrTnRPsQ==
X-Received: by 2002:a05:6402:2554:b0:61e:ae59:5f04 with SMTP id 4fb4d7f45d1cf-61eae597256mr563365a12.27.1756729840654;
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
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
Subject: [PATCH v5 04/12] fs: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:20 +0200
Message-ID: <20250901123028.3383461-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
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
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2

