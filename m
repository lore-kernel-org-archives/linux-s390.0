Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6753314B1
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729872; cv=none; b=MejIuMrMk4m5OR+GA3wbVx8gTM8kRGm3s+wPT2Wnk3qpXniz8AM+a41cYMa1TlFwalEGCn2a9C/CNPTISffVcndaLlgw8cgsV/8zdbweyE9jj9IsstJfU/O9mdY+pOMSSVNKcQlKnNy7wS9JPoCTf3C5yfY+xfyDTnqHUwxrB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729872; c=relaxed/simple;
	bh=KDOJlWebDr1r9JKcB/6qXXsMuiPZ+GrvsOQJ8M+vAGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i19d0RWmFDDuU02zoNdn9qYrx5It3cT4OknbtbA0RPJv2ueEnF7uaRTtA75qlnWNJDSUoKJBwWrJgS52zUo+WZtnYGGbRVcsPb9E74+rvLylFIEu5hH/lU4g1+59Wf7C7ifrj6xg38BfgNX+8iKZPFxWl5HJgxnE5/PPCC+mjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QRQj1tz2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QRQj1tz2"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a16441so664099666b.2
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729869; x=1757334669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=QRQj1tz2wCYs/dw/kpTXZlD+jIy5gt0yrnfJgBeIMZTw7rXoFpyN02yhhU0/c5CfOF
         3DwTx/LO7H0Shh7hHHvTY1L9bcnK5mj+kNha49DViiEK00n2lG0EcAJrXeE0UExKbUpC
         FXCIb3ZYwq7ih+LfEXYc8XOtBYA7mmLP36z8iPML0Un8008JO381ZlkusHZz+wzBOJBp
         mb2kx15zXIDojufwabs97GVReA+0X6+xyJdBBR4NYw/lmYEmiWhxi68HiXiqKR4RBXTl
         yzq4hBQ+CWvUq0RvyIz+mXXCFw/8+Tg3CbAF1TjyqpdPP5lo1KBs9ARYuYmm7Zow5fHv
         Mgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729869; x=1757334669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=QTFPDSY+Ebsz9ykyMj84lX/7ldu5j9vv2IENLbU8N7HYOacDNOyCPjdQ18m9f8lqeN
         nEzY4yYkmX6OlzWx1avU1W4I1MCf9/sUtv+JxYX7Tv5STbcQ9xO1Ns0AGsR0l6jialhA
         VK1qyqH8dtY0EQ88/KnpVzszPIyBy7GvUJ+Brrrjh+v1gaM7wQe0wKIGmY/2GP+K66Vx
         9/7+i/V6+kJDzawmTR3IACo2OARunv9XxBXtkTc0Nh4bfXhcAMIi1lWO1Q1W24PcJ2la
         XkJ+MgmX0Tg5GZFD+HazFKez1EOoKXpWFbdHCIjw5O5SKq0TuKONBSES4mwE1tlOCVeX
         5qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTeOFbw5StprUjb0R9SdrNHdugSRlsPl79qZrHGLWLj98+7/93hDXm7ELabCOsANJs7YcnnhMviRMf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5+ZFBCO28Qdvzu/DqhqOa2dBV/u/4Ns8nucMks1RpHiUrN6R
	VodjwEuP4+hyvoLLQ9xk+iLlXUufxwhUOfacXKwYiZZD6WSDYl080E8gTg7zFp+KO3I=
X-Gm-Gg: ASbGnctLlV2jt+8MavyycCnpUUigg0H1Qx8slY+IqaaFjMVzQePaVmBSV3jDbu8qBMf
	dut4ONovpu8a1ht7ZBWhs9YNp9q/4vOrSlIIOymQUdPV3G4+G9UC1igyeb28pg3O5JD/EIGnqA0
	iUr0bcT9eRarY110WtKEU60qx3f9Ipovi43D1a+R9R9CztdUUN1LrlShxyg0OjkMp4GK6Zcqfy2
	XUvPURYxcbbjTD4UfLVqf9xFRrlYKQx8Ty1dMaCVFdzld1RBup6qLPsWPQodxooK8jSX4GJPjT9
	8ngQc0WgBQDeQQcsV8c4K9PU4RiRivZfiT4p474lLUjqo/4S1JPPo+rx9tWtCabPFweX1rBx7M5
	Vnyo3iV6/Li5zGGZmq3wLNDXTKA3nz2aviogQf15felJlVc6O7eIt3Ov1UdbgRqqKv4ytAV4LPl
	7YREDc6JvBB/ue7ADmCzGyyrUq8AS34lFQ
X-Google-Smtp-Source: AGHT+IETxUI3qvvcJof3qThaTHBjP7BahOV3yuMasi46ZJMakvC6EwAs8jjOUppbppRZ2B64GjsX3A==
X-Received: by 2002:a05:6402:5207:b0:61c:5cac:293f with SMTP id 4fb4d7f45d1cf-61d26869f4fmr7390296a12.6.1756729850374;
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
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
Subject: [PATCH v5 09/12] mm: constify ptdesc_pmd_pts_count() and folio_get_private()
Date: Mon,  1 Sep 2025 14:30:25 +0200
Message-ID: <20250901123028.3383461-10-max.kellermann@ionos.com>
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

These functions from mm_types.h are trivial getters that should never
write to the given pointers.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..46e27ee14bcf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *const folio)
 {
 	return folio->private;
 }
-- 
2.47.2

