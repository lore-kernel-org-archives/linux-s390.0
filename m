Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54338655B
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812571; cv=none; b=Qt0MyJEgGvHujpQH8sLwTFxmXWzECO8dXOtik0sokyvQklYWhpODK04D9qq/xDAq8SFXMhohCbM0w/EUqHeukmhXvKcIENyQWKPwu0yYfHD25fpFALmT8yYUU92tiZrw+rd82Yc5k0abWuoUYNCO0NBt3sBycYHP8yZWy3ejRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812571; c=relaxed/simple;
	bh=9NM8vR01ylWdR69tTI/CB/XMMKN6dhRFED8qVzMJFYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiDLEsMoA+SujGfd8QsFI5qgIaVfKGN3BtrNIHXf1qvWtD0/QSX+NxVPkfr3Sao45zkw3x6Ddr62PGfvU2sSGK4Sj06T4y3PqoWrvvBG/hkHJ1wjVonJud9934Sf6+tWMKXsaaM7PSPfBrwx58rXQgXNMt97t4/q7nnB7mTuuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxZpJS/4; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxZpJS/4"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8c9c4cd8so1319420c88.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812570; x=1777417370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDzLT8xllq1iBGA+qtx0OEDuRYSfNoyHs8R3lM9bdik=;
        b=qxZpJS/4UUR1J37RA5G5fIuwrVmskObSTSwd2ynP7IcSUvOHLFrwAG2fU+vC8o4UFA
         LRSje7v5h/Vm1UUEJvRUOd9XbsEAP3g82juFNX3WceyMxx9b9g48jVua+eQHlxRD6ue1
         GPyO56jxQ7zTuPSDRRPHxtR01BM+JfJnY1xAFpfwE6XaN5yL+kypn9en6AukTUcj/HxQ
         PJKEYP8q27XlN+UPdPDolT9c82p5TMWUTt+xDSztWCQ2MrGakt6K/qOVPZ9zIcDURQWc
         PEVcTFd6aw9gPyRQjTtinFb962RAEg03bbSlEscE7iua4lnDCM+kNxNn0T8yqSTgcTYn
         S4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812570; x=1777417370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDzLT8xllq1iBGA+qtx0OEDuRYSfNoyHs8R3lM9bdik=;
        b=fpkKU6V5i93A9t5h8wtwwGTUv7wsJXhGcfYmRYJKSeSyUJ08ydl4nHJb3zmfWwMKl4
         6wNFe95TYHXC4eOVpUFJlYw6HH5yZR/v75ZjQ99BjPAwKniW6rwI448dzgDYS186JfY+
         5f/NJ7PIa3zwwRsU87G1z0akRfu+XyWiDe2fr0+W3xbGA/cIIsG3j2dslxWc8hBTJm53
         m0jADaFSND12OOtpsTfuQjoQiyNTFsBrJefW+nOeGniCe6Rt6GWcddtS6+AEn2eAuH0U
         F+SoTXvZu2wLg1ffsmiPwi0MaoV96UdFBUYS1Ds6nZGY9doLgm71EqcQIUR0jjon+dzA
         aWkA==
X-Forwarded-Encrypted: i=1; AFNElJ9dY7o8J9tiGltfCCH1WuyWiVOsLQzgv8mfdJdPdFdIjtcYx3vdRWhn1KTJLN3TGZ7ErFt+mAhP5WHq@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZlHfqn9PD73TlEfRJ/GY2/Ae+RUyl69bNuFDkT/IBAnV1s7+
	VUAvvg1gl+nltHy5Y+M/otQyR1ME/SFzmlrbOSleGUtHFtWIZNa4YCmh
X-Gm-Gg: AeBDiesdoT1U2lBIP0lDecn1PXWDJTtI3BI8A6wUtTGNdwdRlJKXobHWbdEjTJcvJ8o
	R4MKrY/RiMzVFI5V/75qTRrHHXUq8c1lfWJyKgkMcmtba7LcwKs9W40xeSZlY1qR8IW5oeTn1h6
	ijZuabJr+IreqmBzLrGzCVOXRlgDgPOu4m1B337tXmPPyE6qlgoyQUmN35Y0N9kGiDRZ61UwkrL
	Voa7LM9oBaX4YHd28VjZWHl8NGcpD4mPnm3r9+nCVKWfyOs6m5N5NJAx8wMiVEgfSJ9EX+VlXsq
	MtJ9AEZTFO7Nvj2E8htTmt727CUl8CyvxZeFuHy1hTTtcS0wEJxd8lXI0fRMsDE/FwIj9VoN+0m
	D5CFPfUjkESkrm8iixtUBvkYiMpFeONQ2hNolXX0GMZMJXUTUx0noo5pApNrceaBoJUrxeVKAqH
	2BFMOXuUXxBdXSMrMggcJ0ft6uBnrdfYRSba0ETeYNbHBW15x3vJCeSPQvOFSu7IjFg7j8rINoK
	Q8E3bwgXv/j4g==
X-Received: by 2002:a05:7022:e985:b0:12d:b2ca:a9e9 with SMTP id a92af1059eb24-12db2caab80mr2271908c88.8.1776812569428;
        Tue, 21 Apr 2026 16:02:49 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:4678:d28b:b946:bcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm26453546c88.14.2026.04.21.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:02:48 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From: Minchan Kim <minchan@kernel.org>
To: akpm@linux-foundation.org
Cc: hca@linux.ibm.com,
	linux-s390@vger.kernel.org,
	david@kernel.org,
	mhocko@suse.com,
	brauner@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	timmurray@google.com,
	Minchan Kim <minchan@google.com>,
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for exclusive file folios
Date: Tue, 21 Apr 2026 16:02:38 -0700
Message-ID: <20260421230239.172582-3-minchan@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
In-Reply-To: <20260421230239.172582-1-minchan@kernel.org>
References: <20260421230239.172582-1-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the process_mrelease reclaim, skip LRU handling for exclusive
file-backed folios since they will be freed soon so pointless
to move around in the LRU.

This avoids costly LRU movement which accounts for a significant portion
of the time during unmap_page_range.

-   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
     exit_mm
     __mmput
     exit_mmap
     unmap_vmas
   - unmap_page_range
      - 55.75% folio_mark_accessed
         + 48.79% __folio_batch_add_and_move
           4.23% workingset_activation
      + 12.94% folio_remove_rmap_ptes
      + 9.86% page_table_check_clear
      + 3.34% tlb_flush_mmu
        1.06% __page_table_check_pte_clear

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2f815a34d924..fcb57630bb8d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1640,6 +1640,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 	bool delay_rmap = false;
 
 	if (!folio_test_anon(folio)) {
+		bool skip_mark_accessed;
+
 		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 		if (pte_dirty(ptent)) {
 			folio_mark_dirty(folio);
@@ -1648,7 +1650,16 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 				*force_flush = true;
 			}
 		}
-		if (pte_young(ptent) && likely(vma_has_recency(vma)))
+
+		/*
+		 * For the process_mrelease reclaim, skip LRU handling for exclusive
+		 * file-backed folios since they will be freed soon so pointless
+		 * to move around in the LRU.
+		 */
+		skip_mark_accessed = mm_flags_test(MMF_UNSTABLE, mm) &&
+				     !folio_maybe_mapped_shared(folio);
+		if (likely(!skip_mark_accessed) && pte_young(ptent) &&
+		    likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);
 		rss[mm_counter(folio)] -= nr;
 	} else {
-- 
2.54.0.rc1.555.g9c883467ad-goog

