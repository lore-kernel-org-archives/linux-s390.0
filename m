Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B23559E1;
	Thu, 30 Apr 2026 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521904; cv=none; b=nJtCdTanY4zjc2/yTa1w8vAX9pDTQk/BZlGD/yru6rJQm8l5w5QIC7/aMDUg0iZYY3/ZpS4VFCEfwi8mExsu5+OVknhKy7EvJa0MZ3GcnCfxvSwVeorKA4fPBIQK2gzIKlVMrlYMCvUfPYx4W/gEbn9EmNeE1YOm+mvd0Qx5ctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521904; c=relaxed/simple;
	bh=3UzddeMl13pC5cJUrT4HHkjYBFF8Z0grqJoknqLkHzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnOShz8To6mIT6H4owX1k8DQRlDqDvbWxVPtLQPN3hnuPrMdGDcslKU1bTKtIZIzVKTKtNg1y0D6Aka4xGdyrpcx4W8fuIF/wjvVAnve859gE0C/oqXPUFflnlweraPvY82UiVgWNiIVj9VKvPX1AxgRzOLyJuY+NeHfdqNdHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKwVglCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKwVglCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C627C2BCC4;
	Thu, 30 Apr 2026 04:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521903;
	bh=3UzddeMl13pC5cJUrT4HHkjYBFF8Z0grqJoknqLkHzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKwVglCF7XEsFftOn0BAtLwGM5IZ72wXKgPaG3s9rdnfQtx+pmDdlMhp0BTc5EYNf
	 FJboHwOiMXC33Onbze1GSoNvzLlFPIK9rhRrqSsueRkYACFW51iYCE+t5LiSSUtrDZ
	 6Zgo/egoBF46WoaKKLJpL+hNtjheakCbbtpFjT8y7TDrK7Ows6M9EqK3rdErLUzivK
	 4Ay85oZFt3iFrC53ukdn7sqXcw6md9eq3jFLK0YjDszHvyQDD9gHGtkAjd47bH+XH1
	 stGeQfEGcaAiSsSh1IY9gXD9Yt5DxgBQ/zzQ6kcBG30A7WMR3XO465Eebcb6ZNIjyv
	 BawWjDw+St+Lw==
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
Subject: [PATCH v2 2/5] mm/swapin: Retry swapin by VMA lock if the lock was released for I/O
Date: Thu, 30 Apr 2026 12:04:24 +0800
Message-Id: <20260430040427.4672-3-baohua@kernel.org>
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

If the current do_swap_page() took the per-VMA lock and we dropped it only
to wait for I/O completion (e.g., use folio_wait_locked()), then when
do_swap_page() is retried after the I/O completes, it should still qualify
for the per-VMA-lock path.

Tested-by: Wang Lian <wanglian@kylinos.cn>
Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Wang Lian <lianux.mm@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 199214f8de08..00ee1599d637 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4791,6 +4791,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	unsigned long page_idx;
 	unsigned long address;
 	pte_t *ptep;
+	bool retry_by_vma_lock = false;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4896,8 +4897,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	swapcache = folio;
 	ret |= folio_lock_or_retry(folio, vmf);
-	if (ret & VM_FAULT_RETRY)
+	if (ret & VM_FAULT_RETRY) {
+		if (fault_flag_allow_retry_first(vmf->flags) &&
+		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT) &&
+		    (vmf->flags & FAULT_FLAG_VMA_LOCK))
+			retry_by_vma_lock = true;
 		goto out_release;
+	}
 
 	page = folio_file_page(folio, swp_offset(entry));
 	/*
@@ -5182,7 +5188,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 	if (si)
 		put_swap_device(si);
-	return ret;
+	return ret | (retry_by_vma_lock ? VM_FAULT_RETRY_VMA : 0);
 }
 
 static bool pte_range_none(pte_t *pte, int nr_pages)
-- 
2.39.3 (Apple Git-146)

