Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCC3B8D5C
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512536; cv=none; b=sZ7LsN80Bxr850Imz/Yqqahm8fId7OtHb7w36B8XgY78i17UrOc0J5wIoVf/HNK/ug3rvJ1ogbm8+sym6b9TiGWsJr25W1r9B8bvjfL/11VLxAvIuLM/JEjWvl6nptkOyrLFAnEn5we27v9LKQPzL/bV6gS/IoLDFta+ih7KF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512536; c=relaxed/simple;
	bh=7fxUvQarsZza+ZSNU1G51Ztbl4ikxZMWuEapYuAipV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OhWX/qPqi3pi4XFy7CaRn7LCQDpfpeTRMxkMCH2kFZ3RmmZIjFsG94qplElSz1cQnh4/lrdH9Nh02lGWvYWoYj13lqiwWQ/+fllhDncxmjfzVL1z+h7vg4LkxW3brX5BXEJtxTIHfdkA7Du8KADS/H20Wfl6Mm399Yq9rESTjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fc4bFJFx; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fc4bFJFx"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ffce2570so4641817eec.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512535; x=1775117335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=fc4bFJFxER2E6T+QO701rz5XLCfU0mh6Ee4++ewdR7OSdiAKUDGN+vu8QOgwOXC9uP
         dhuLANhMBE7sLE+eNruFgKAMEjZmzYzyuuzH49tWMfCUG7aQCeiqUXFnnaQqQxVjIkZB
         LT666Bxwm76QTmS5Ck0Z0CX/CQwl7Nxd5zF63yuhmwFRf8ikJcEXW325s3fnbWdvDd9+
         5WVNAIS4vQU0o83ty2f1YJ+EIiZvrLq1HdoHFcL6UdUqeq1e7frei+h7nsCs1ZdzU+EV
         53EOVLbUoIk1b6oFfaZ/aoEM3Gkq1dkwDL9f/MgbPiWmBH3DZs24hsP/rpkbnsaI0Rc/
         FtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512535; x=1775117335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgLz5FVqf/NV7m9qbKXaNWE4w/1GDJf1IUGYhV4ad8=;
        b=aLo3BoQaMZMLFKyDCX8ClQzmrwsOvCd/+KeQmBhsaPGwV5zWcUreeEC8MFJSe+6YDk
         I3hTAWQ1sAcK/R6/i3BaYIeHbBLeaN5EFeoJ5bgK1l7KOQ8tzGYg3pl83WaM7VzyXyMM
         zPWABW4Prcgkcsvr3wSQ65NKzO+8mnZB3GobYV7LUmtNPw7rubCj5/inN55RYoXF7ocT
         M4IlKpjDGg24exfTu5H/Nn8SZMy7p5EOaDZK8/CGn5t5RgSJhCOd+g2tZd7wP6mPZJvB
         wfO7DP0iWR/Xg1BLO8gC3BteYNOE22Ast/0cKrmtPGhua7cFgrdUiIeuVgd/jJ+rmbwv
         IZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVugGL0r94BdoK4ph59KlNz6MJUO8loDE0zviCSIZf3N4io8NLGPdQQifOT7GQoHebQcZDaOOo1EdjP@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmACzHbD29oZ7wU5aRiK/lOTai5KmFaBGiNQ5J3+AqWuUXYDL
	ziByGJ3M9+Fyj24rB/tBDVfSrIftnhqUrnF6Ly0Vdky6xiLL1gBGIgB4ZL80TihOJZqeJnUTcs0
	y6aTyzg==
X-Received: from dyt4.prod.google.com ([2002:a05:693c:8084:b0:2c1:63c5:aa2e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7304:b0:2c0:c96a:a4db
 with SMTP id 5a478bee46e88-2c15d2ba52bmr4025361eec.4.1774512534535; Thu, 26
 Mar 2026 01:08:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:36 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-7-surenb@google.com>
Subject: [PATCH v5 6/6] KVM: PPC: use vma_start_write_killable() in kvmppc_memslot_page_merge()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() in kvmppc_memslot_page_merge().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..0a28b48a46b8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,7 +410,10 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
-		vma_start_write(vma);
+		if (vma_start_write_killable(vma)) {
+			ret = H_STATE;
+			break;
+		}
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-- 
2.53.0.1018.g2bb0e51243-goog

