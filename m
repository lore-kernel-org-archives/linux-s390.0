Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9BD3382F7
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158197; cv=none; b=uS8zmRZo5Hhfhk/Pc/YwokplrG77tW2FXGN3xatUAur0LSvuSXHvLD88NyGJwk2sTsL09cXI8kYIwUeB/yq9qTmOenm1mobMMRZtEE53lH4F4sz8rJ0hYB4WJQRP3IiHyEwvXL/CMbrIqL55mC9umxgg631YEx0mt8dpDXOqvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158197; c=relaxed/simple;
	bh=k8vibHg0a/FCBygledpiedlSEfAweaWApztc8G2PWnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzWsERPyj1QTs++QYUAZsNR2f/HLqXNKLb5N11RLpgQiB1J5lCi4wPjyIx9cFbwtfgbsprT3Y4sqUPNV9D7Ooag0MEbysydnXf3uBqKXH2TTuA9SqklFW4ZtIWGD+yWq1xefwI07hhF1+qcDeQ4i+LCLJO2w/soCbGww5Qp6R2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTDOSeQ4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTDOSeQ4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7385a1476aso2196998a12.2
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158195; x=1774762995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCLfYASgT0jKid/tJ2FF95GlZkyQeWGLzgzFGOQGNX4=;
        b=qTDOSeQ4Qtmnjgypt5z5+M6sVHCc2VQSL4OSpBiKaDJIOau0T/7F2TfinA+DHmAFC9
         feD8hz5eKLzrULOZE0bbmqVgKSKAj9jm0l3w0oZc3zbHMdxvewZawYvyxgWFIz1W148S
         7gHa+GJagVTctWodEboCUCemZr2N28fEGFHrEGyXZpW4Lvs4uZNImFGBvTwtUningz72
         xyNDn4YoCDlRGHzDIY8mPewDG7R8kvaRH0QyS+SYknYHHLEsXBGjqa6MZ0RCIW03mncl
         ApyC6lIaQcFbMwdQkgN3dEIVvKyHueFOO5gJegq6Q5Yet4ENBnyo+9q/ffXC4HKRsGgH
         rpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158195; x=1774762995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCLfYASgT0jKid/tJ2FF95GlZkyQeWGLzgzFGOQGNX4=;
        b=QM4zjZvKQ9B0n11qn6NDa1qZe5rrlXYKFpJGtiVxaNXz2zCl+xWhtMLE1tlrbPTyPR
         6pAg7HcMUhlHqMjKigyjcUI9+Gg3s8rRy51gw5iuBdBAl37ItLGJGf5HDdo5+RpAMmgO
         NBmxrXBseSc2o9NM1X1D+nfoxGt70PZUDNMvkoVd+0Q1BbkoykiOMt/A2Ij+WBze6WTC
         SWyXcrWTrgI8CxLAeESQQWoc++LeDO1ydXUjHAitoM8HEyHjBARqfy2N3fWYMwjiIS6W
         Az9mTrhC0svKmjQKHI+IrkdVya6JIKmQAXcoyxEeWifreyB4QgH+9XsTMWvBpZgrU8wH
         Gq6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC0szHt4dkZaLDcDr7eK7PDUfdd0XnVEDxwklqBg2DrUqSV7ewY4+QqGTR+wt++KXEVO01jqP1D5lC@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgYf3lGTPYeHzVa5vh1jMcVW6n4i3rt9sSZdv8BX1x+oRpREx
	ZZb1s4UBkRcLQGDSYQkpSnlsQxZO3XoHIW+dHkDzfxiW4/V/EnrbpS5tWnlrOVWw+eis3l+vvVa
	/masZIw==
X-Received: from pfbfb12.prod.google.com ([2002:a05:6a00:2d8c:b0:829:769a:a81])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4191:b0:829:809e:8977
 with SMTP id d2e1a72fcca58-82a8c346979mr6884137b3a.49.1774158194950; Sat, 21
 Mar 2026 22:43:14 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:05 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-2-surenb@google.com>
Subject: [PATCH v4 1/4] mm/vma: cleanup error handling path in vma_expand()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
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

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.
Change variable name for storing the error code from "ret" to "err".

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a43f3c5d4b3d..ba78ab1f397a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1170,7 +1170,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int ret = 0;
+	int err = 0;
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
@@ -1200,12 +1200,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
-		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
-		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+	if (remove_next) {
+		err = dup_anon_vma(target, next, &anon_dup);
+		if (err)
+			return err;
+	}
+	if (vmg->copied_from) {
+		err = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+		if (err)
+			return err;
+	}
 
 	if (remove_next) {
 		vma_flags_t next_sticky;
-- 
2.53.0.1018.g2bb0e51243-goog

