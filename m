Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536B37269A
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812568; cv=none; b=khMlOE1rXBWwtgkYCnQFumnKdYM3mTkvgXtz+/1DKg968myJb6xt3qSV02jbu1RkfRUR9qVRw60k1QzNVfI272xqjMZ/HtJ9ANn86aQk4mQRDpvx5PjDcKNXui51ZDMwQxcuznZPYHQAOLijcSJGsJW5PEv26ww2BI33clfantg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812568; c=relaxed/simple;
	bh=DJTgV5qxMyImLlFX+U+L2ks4BfgjBA2zyruQwbl7css=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N81SrJm66JL/4n+ua6HCNXMQNxQOEL9pH0WdR8IZT18e+6A9mg12tXOvK/XNZrgqT1dJ1uu3vfLUloNK+4aKedsyzMNTCeaDLXw2y4+wojPn1rWvTKY8tjmprDOJv1oV1vU86XNwYW5whDzIRCDmi1jgjmAWsOLsJyG7XByCKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP3DvTWX; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP3DvTWX"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8f9846c8so3613583c88.0
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812566; x=1777417366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+O4M27v2Tss7FIEhY4PBkpamm/Ohd33d6CzOiSw8EfE=;
        b=TP3DvTWXpzsyLE7pr2NsQ2mDfIi5KiFK5MuI6ietIQgmQR8rIpCx7uXTyMqjPMQeAM
         3D3o7m7jfDEAddNFFIZFJxboiE3u6xtu5wFnNfAnn2bTgXm7/po/bAZpsnVZz9uW7R5R
         qRj5qwAFTcpBuCU528tOTQrfmnt99cn95HejB/qUu57XLQpzsqsh31klInyVPBX3+5Si
         s7V9jWbcfc1te2CJkitg6JWuz5nn6PvAfjZynhKsu2L3vUbmOBGnrs44mSIjNNe8uAQB
         if3MOLEwxazqlR6EzPTlCR7lhvwIqvZ/sNxD7aeh6KpZAvHpXzeRjoSRs2UAxiuPGVTy
         +80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812566; x=1777417366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O4M27v2Tss7FIEhY4PBkpamm/Ohd33d6CzOiSw8EfE=;
        b=ACD51Oz0TEKsHXBGBw21cPf6IqCV2l8QynGL7fzaPbEaykRG2enZ8w53Sf5JxrpYc+
         sx39+JD8Ojt884lEipaTshH9/w8llFs0Hnv81VbD/9GSE4pifzG1EqyzMJ7IG/hFKv9k
         JKaEG6eWW4uW55iuCVlOk4yrH21/OZwcnL0M7YZytr5CIzpmZwTZL8I3FAEJkUc6HmDW
         S7FnG9Vxhs3c3qNniLrCtlIk6jth1epTj/aeJ8E1A4JXiEkOunYJH+6XsBGDePU4UGZn
         /dSanxQ5xYIR7jIFUt//7LRTOn+SjVvIB6eIo5e2O0Fz+uANTccoqoWQuVuUyy0cuWYz
         df7A==
X-Forwarded-Encrypted: i=1; AFNElJ8wjzkETXoAvWvq6P96WOpyKowuzJARweR2ee0FY0r8DVzcWvF/U1FIuSmoTpOFfHA1l75k5QiTk/PH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vSsaWxzX4MMgOPUmpnNxXkl7gFt+ikpepjlAG5Lgykzvp/pj
	ja/6KBZHhxpVvu0LfJ3AzfVSlgjvN3VwWEw7suvIjWFS4VOj5EqbeQzO
X-Gm-Gg: AeBDievqpvhggo7TxDqPuW4nlwBdc9hQitkur8oMoGntILxxZsl8HAUi0K29a/VXZog
	VFhdzYjCQXBqonGd2yBKwOEahkUZieHKulseZacm69hlVVltVfmp13DZMrLp/H6w+3T+ItmZjtt
	BfrEXd2Hw8VDUjQ8QdMmfYwjD5qRcCVtj3G+Vl0fZggSuYrtqjOoA2uKpO0DIK5fW2A2KIdh6uJ
	X7vsr4ZZIs+5t6vZwtTbYOkp6jEx2I9A8m/LNG9egXeHvkSqjRIG1EPlaBOdE+4mDLRDlVa0xc4
	FTg4sHGCeIIOgX0y/erxRrm50ePNljwaN7jcoeFJdvH6s3JHMafTAMim/KwipQnJW7aQQkoYGYn
	CqkDaayOiG1qe4VuJOOEydaPkMC7lI+8521JHp+mTCpJAhE7uHidUnM4zikwtYgXbxzGaB+7rFL
	Jj2y5NXhEpNQa531TNNIDApfxmJoPmGokilVwiAJNTD+aK0R5wZZyjf9r6+iU1qR4930zCG+JTZ
	AxABD7GBlGTSA==
X-Received: by 2002:a05:7023:b13:b0:128:e693:b61c with SMTP id a92af1059eb24-12c73fa713emr10677778c88.27.1776812566137;
        Tue, 21 Apr 2026 16:02:46 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:4678:d28b:b946:bcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm26453546c88.14.2026.04.21.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:02:45 -0700 (PDT)
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
	Minchan Kim <minchan@google.com>
Subject: [PATCH v1 0/3] mm: process_mrelease: expedite clean file folio reclaim and add auto-kill
Date: Tue, 21 Apr 2026 16:02:36 -0700
Message-ID: <20260421230239.172582-1-minchan@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minchan Kim <minchan@google.com>

This is v1 of the patch series to expedite clean file folio reclamation in
process_mrelease() and introduce an auto-kill flag to close race windows.

Currently, process_mrelease() unmaps pages but file-backed pages stay in
the pagecache, relying on standard memory reclaim to eventually free them.
This delays memory recovery in memory pressure scenarios (e.g., Android's
LMKD), leading to redundant kills of background apps. Also, the requirement
for userspace to send SIGKILL prior to process_mrelease() introduces a
race window where the victim task clears its ->mm before the reaper can
act, failing the syscall with -ESRCH and delaying reclamation due to
arbitrary reference counts (e.g., reading /proc/<pid>/cmdline).

Summary of v1 changes since last RFC
(https://lore.kernel.org/linux-mm/20260413223948.556351-1-minchan@kernel.org/)
- Patch 1:
  - Unified free_pages_and_caches() in mm/swap.c to handle both CONFIG_SWAP
    and !CONFIG_SWAP
  - Clean up description - David
- Patch 2:
  - Used !folio_maybe_mapped_shared(folio) instead of folio_mapcount - David
- Patch 3:
  - Used mmget() instead of mmgrab() to ensure that memory reclamation is
    performed synchronously and deterministically by the reaper, avoiding
    delays caused by non-deterministic scheduling of the victim task.
  - Dropped the custom KILL_MRELEASE signal code and modifications to
    siginfo.h and signal.c. Instead, use standard kill_pid(..., 0).

Minchan Kim (3):
  mm: process_mrelease: expedite clean file folio reclaim via mmu_gather
  mm: process_mrelease: skip LRU movement for exclusive file folios
  mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL flag

 arch/s390/include/asm/tlb.h |  2 +-
 include/linux/swap.h        |  5 ++--
 include/uapi/linux/mman.h   |  4 +++
 mm/memory.c                 | 13 ++++++++-
 mm/mmu_gather.c             |  7 +++--
 mm/oom_kill.c               | 56 ++++++++++++++++++++++++++-----------
 mm/swap.c                   | 42 ++++++++++++++++++++++++++++
 mm/swap_state.c             | 26 -----------------
 8 files changed, 104 insertions(+), 51 deletions(-)

-- 
2.54.0.rc1.555.g9c883467ad-goog

