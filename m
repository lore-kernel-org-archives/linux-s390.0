Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6E396D39
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644911; cv=none; b=O4U0VDN01bZn3kJdfxg18yH00I7RbyoWYvhbqCBwRX1dmGpScnea0wzagfkvZUi1TYC5lNnXFyRWmfwnqh+jZoYjiuadG5dxPoFDKfNZouUFIs3EY1hlYL/QTGuXMQYBqZl8/Kk+w8p/EXS2APvBu65rrlmIpeP6+fNvQi4Vfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644911; c=relaxed/simple;
	bh=3GnyT2WlT0kxCiLmP60OzV4FCCTn3R5BE0Og+KeeECM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lyUg1omMZjpGA+KQdBSOdv4prgAalOaI6331KIlAjC/bN2o4UysknLLGuUGL9JpT4xDI8/blK5ktd5RULMycKv6bSV8tj1GBpuYsdOFlwREBlLoEbx6nDVHC9B+kngQFJOmXw63vewoHBJfoEaPTvcyq/D2d2UWCZyCDzHs8V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3VRt8CW; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3VRt8CW"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127876be621so1606465c88.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644908; x=1775249708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=D3VRt8CWARQqchkoVurjC4qsPYFQHqYRQ5wPHD+n7PhrnmA/rhV4BubaAkZKuK/Ncp
         U4CQGhDnve2aiJXLV2ZIifCOBVUByeTg+mK60IYlMgb9KcIkiuRvmGDmKT4ZSz9Jhftf
         uRUWafi6IB6M8O+OWsLXgvyAJE51PooUXJSoOamOd1qh3k7I+0y0NT5RfyZT24RyrpdT
         0zFhR6Jj9GSi/oBuvaCv5vzcLJAw/H5mYzEKgPGfS6kZ9Xsr1qhIKI6cqReEOr9IJRra
         MmKD0jJG3A8J0STrIcqxYhIs1QMZc5480dp1Gpp5NSuWYAgCEZhuLVPDKoSz6AYEl22e
         UttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644908; x=1775249708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0m3laKqVZc6BVbp9FlOKUOANtvuTeySm/ZmFaYOMpk=;
        b=gdSz8Ao8ScKIVTDZw5UY8stxsQn6D+K9ka6GuPUKHf7QnA09WaXMw4rmdy6l1cOkwu
         FvYl0yBdzzFbCrOA7y6yO0D7WKbyZ+sfyQBgavPlDaAs43vR115ad3nN4m0MQtRctpoP
         x5MPFsgxkZ7ssO9vuNBcDPOLN394MZejBunJe6ryvnSo5p/hCgCf1b9xqibVrDXI9blD
         O193R7qUyjSa42WCC4onfEtVimJed5p9n0JtSl/uVRhqCcOyCCDW5nG6rqygwoP9qKj7
         bu2vvltd8Bz1FBcfDegAci8SSGN6y28RJaRitsdlMC/9ldIdsTBfM5FhCbBf5KZgS/uI
         KXxA==
X-Forwarded-Encrypted: i=1; AJvYcCWxPbYEHqrNL8UHmpvccekqE+9BVXWGHQnNFPjTS5I54AUtSNTeSRmT63+8x6RodRkUrdrNxkaJnx0i@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuB8JbJcVaroDZZ+xlq4sKQW73TM5TRKNO5RxUl5x6O8f9yQn
	/DX/R7xkRCJ4gHosptmc6mgH9+ACSxGZcPQwxfQcKIN505xjyPc+YVZfd/fp+Pyv5cWjKsP4AMv
	7JrscYg==
X-Received: from dyz2.prod.google.com ([2002:a05:693c:4082:b0:2c1:2155:75eb])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6981:b0:12a:80f2:89a4
 with SMTP id a92af1059eb24-12aabb97edamr3324672c88.10.1774644908020; Fri, 27
 Mar 2026 13:55:08 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:54 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-4-surenb@google.com>
Subject: [PATCH v6 3/6] mm/khugepaged: use vma_start_write_killable() in collapse_huge_page()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in collapse_huge_page().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/khugepaged.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d06d84219e1b..a1825a4dec8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1166,7 +1166,10 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma)) {
+		result = SCAN_FAIL;
+		goto out_up_write;
+	}
 	result = check_pmd_still_valid(mm, address, pmd);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
-- 
2.53.0.1018.g2bb0e51243-goog

