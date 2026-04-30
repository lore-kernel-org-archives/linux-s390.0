Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287A319E839;
	Thu, 30 Apr 2026 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521920; cv=none; b=DiXndxxemP/308EwKpkY4C2jN6TfqdD6AYjCc/IE/eATtwdhFqUKASbpGDgdUROq66V5+zIV+aJuVBMasf9xyoPqCTXUORqapWoXn0kCDYOH46zsPdU4ZZkjk4y6EPIBxJQQpJBSux8d2thgX9pNte6neK7ysVfPEsuDxSvxuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521920; c=relaxed/simple;
	bh=pbXcAk16+rZv3mixELQ0Ipha1GpoRaVFtegxsWu8Zqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5K+6NjbuMbAAL9PPzmC8U+pksa3pl3diVTqlf5UKoEcVbwJ9hiszi6HDFeQrQNewX84XYtx6h48VlbQ/U4LweKTRY0EpgCiTirc5sNulMCpGbAcFPyMKkT1wLH4e2uK1pzXYnAKd1jcHCCrQssBhLmb8q0iw6iBvBtg9YuDIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocBfK8O4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocBfK8O4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6E6C2BCB8;
	Thu, 30 Apr 2026 04:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521919;
	bh=pbXcAk16+rZv3mixELQ0Ipha1GpoRaVFtegxsWu8Zqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocBfK8O4Ywas1DnfVulkPf8JAygFLLLSXfSSIhFab5aPydgPGyQRMZl4VC0fcDxzh
	 ZSF8ZjBo9bGMKXhwl/M9RckUdNTcuoEDs1sQYC8HxwbacO47214ueIB5PuN5R9qPyl
	 7/vXQCjK6DhEeLKCFGPA8mBl5pi8Xir7/uhc151Nze4/YpDG2oez+rIhbMYqevbaCB
	 eLjkznrbZrf9uMIIMqF0/apYtZGMqURcRmb3l4AFBitMcYEDgyMeHrj8n9yVB0vf4O
	 no7KHvYOh/5gIxhaiyHe3dpMaQbh59rmzxY6J3CuNafpQ/IRafc5BIkfCVPTmXqOYt
	 bTDK/08BVuABA==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	willy@infradead.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	pfalcato@suse.de,
	wanglian@kylinos.cn,
	chentao@kylinos.cn,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	liyangouwen1@oppo.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"Barry Song (Xiaomi)" <baohua@kernel.org>
Subject: [PATCH v2 5/5] mm/filemap: Avoid retrying page faults on uptodate folios in filemap faults
Date: Thu, 30 Apr 2026 12:04:27 +0800
Message-Id: <20260430040427.4672-6-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>
References: <20260430040427.4672-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For uptodate folios, we are not waiting on I/O. We should
be able to acquire the folio lock shortly, so there is no
need to drop per-vma locks and perform a full PF retry.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b532d6cbafc8..0d2f6af5d0fe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3533,6 +3533,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		}
 	}
 
+	/*
+	 * If the folio is uptodate, we are likely only waiting for
+	 * another concurrent PTE mapping to complete, which should
+	 * be brief. No need to drop the lock and retry the fault.
+	 */
+	if (folio_test_uptodate(folio))
+		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
 		goto out_retry;
 
-- 
2.39.3 (Apple Git-146)

