Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501293822A4
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497265; cv=none; b=pr60JXUtKl+/b4NHTGGALSRdPzK/hU4A0uXeTeZcMr/yvns6UruNlWYx8m6Ghg6nZmLKdZKWLwRqdU4HHY87fCQtMawQjuraSS/u9cEetaPCDFr4I2x08ZXnuBTLorzlZajYm0B7IKeXupPCIpI1crYb4FiqVW+cG6c+y5Xl1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497265; c=relaxed/simple;
	bh=iMdpSNk8+RaGvFrZtAgkNCTaLGJq9rYLnclyIXgOR1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmXR/qgOLcQ8uZ9FZlaEcyuqyvgab1O/zZs8y2PEXo760b1sE9WXJbhBYDXj+uj/1XIVIfFpGpd4YS+M8KXY1wVxvP+A+W+Lk2NFqUxgJKU75MOYLdIDT4mmiQge9PIutlVtpaOJwHAMXjbyyl33Gd7Wnx9u1739EzApAxWvq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXd4GLjS; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXd4GLjS"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c45281a06so358755c88.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497263; x=1778102063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0jlWaNcc6qDFBI62ibD+GVbVAHZzVlW6Nqyi6nQpvzc=;
        b=MXd4GLjS2k2eUQwS5dCqESwgPK51tc6mh1JpzR0iTyt4uUlLSk6cduY1DmyI0SoSRg
         HJ5ka8Om4oq0S52pUrSy2S2xBXeUek3RnSpHW1S+4vno5jRIyT7Snw8ZVKwcSm9TVWCi
         O8XzcUojEY3C7WW1i+C7bgPM1in2nyaMGWXM+UhaFx5/VGPGd7umzd1K7tMyMWniN36x
         IVrWRCsryKsBoVmq82V4SJGShfX9PZBU6NR8MaUaW9KHBWDoAYlzQpLonEfvnd4i7jqm
         fNsME3udEdADp6nRYVUVm+fh/puO2cTohgIL28wDWTZl+R7DCq65j/FmGpU6yYu5s6ZN
         aXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497263; x=1778102063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jlWaNcc6qDFBI62ibD+GVbVAHZzVlW6Nqyi6nQpvzc=;
        b=CEd2HM0b5UZ3mMqZ+M4zcOH8xlv21zqv5pjFEBsQSY0ejM0Q4LrcgC39qSYAIwCLX6
         waVthgBG7bB2KC+xJ9uD6FpyEx1S2tyCYC+oS/r/rE4EYgq0SxJJXg318MbrA9dunBNh
         BrXgpJtUK/lM8oc1f7IrJZaHByKzMLeCjkmwiwMueuMb1690mrhP8ICAsDek1t1LM1Vu
         n3yat/FEbBTcXXaONXv4At8j0iYs91bR76Cy1REPzSK3FnX5rORZscmYqaSRlOCL+IZW
         JP7iUv4r1aBtooOK6sokmN9VXuqDv4CIY9a60UNPtil73TKXVH/pf0PU2efCIPBvkbom
         L3Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/KVW5OnGaGHE4QfMInwQ1W8JpAzCy6/Tx8BS69bndDgT/JfA31BP5TeUBylpq0QcXLg30bAUgtooJ5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+3w7CHMOM+bNeKMftjhAkgM7MMdOGD++L0xHWp2zIm0J3uhA
	Z/oa+N4QNj+WYtKDOfuc8w63sZV3SQaeqW/SVNP+nwLOeDk+x07OPBoC
X-Gm-Gg: AeBDietXUgN3vxBlRH0TccpoxZ9Ls2OsOcH64mjzLDaHloOgqswH9reeHSPNlXBq/Vg
	MCltGXwpHtsr3EEGF0jijEF16ceJ5FqmSV+/X1I4VHSPyWPHAv6oK4wDs0sPhBPdWklcEYwXqZa
	Gb95llz4la0Zx3nl+1N478o8VnKsHmRSNvKSNxhQZaAves/q2ltosxrkDdbJJKdM/rgiKqzgjep
	LsGwkItyaP1I1BRm4HuqbuhjaXdwx1d5z4M+U5zl3whm4mM+7BgOkwvZQJPFjI7axYgqDc5ia76
	lyGiZ/lMQx/RE/8nG5/dyIklY/xWDQNFKEQzXtAn5WZlPHetwu6MBQdSXBsL9318Qh4lWRAmg3z
	9FQKIzKBm680W9PEH1Zl7rlwgS41UKLsj80DG/tdOHec/61CAg/i9pO8PH0oCchzaxa5oksq6Jt
	Pcq8P0xsk2uiox0htJasqB7ErZp6hxOSiWpx513G4pniDbL61n7EfTdi4toAuLNkn8zsAL+HEc6
	s3SKcJ09K20IeQ=
X-Received: by 2002:a05:7022:3d12:b0:128:d715:b717 with SMTP id a92af1059eb24-12deac586damr120667c88.13.1777497263244;
        Wed, 29 Apr 2026 14:14:23 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:ef7d:2499:eb8e:9f62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de320ed98sm4408879c88.3.2026.04.29.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:14:22 -0700 (PDT)
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
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL flag
Date: Wed, 29 Apr 2026 14:13:59 -0700
Message-ID: <20260429211359.3829683-1-minchan@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, process_mrelease() requires userspace to send a SIGKILL signal
prior to invocation. This separation introduces a scheduling race window
where the victim task may receive the signal and enter the exit path
before the reaper can invoke process_mrelease().

When the victim enters the exit path (do_exit -> exit_mm), it clears its
task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
leaving the actual address space teardown (exit_mmap) to be deferred until
the mm's reference count drops to zero. In the field (e.g., Android),
arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
remote VM accesses) frequently delay this teardown indefinitely,
defeating the purpose of expedited reclamation.

In Android's LMKD scenarios, this delay keeps memory pressure high, forcing
the system to unnecessarily kill additional innocent background apps before
the memory from the first victim is recovered.

This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
an integrated auto-kill mode. When specified, process_mrelease() directly
injects a SIGKILL into the target task after finding its mm.

To solve the race condition, we grab the mm reference via mmgrab() before
sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we assume
it will free its memory and proceed with reaping, making the logic as simple
as reap = reap_kill || task_will_free_mem(p).

To handle shared address spaces safely in the auto-kill mode, we bail out
immediately if the mm is marked with MMF_MULTIPROCESS when
PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users of
process_mrelease() from behavior changes while preventing unsafe reaping of
shared memory.

This policy differs from the global OOM killer, which kills all processes
sharing the same mm to guarantee memory reclamation at all costs (preventing
system hangs). However, process_mrelease() is invoked by userspace policy.
If it fails due to sharing, userspace can simply adapt and select another
victim process (such as another background app in Android case) to release
memory. We do not need to force success or affect processes that were not
targeted.

Fundamentally, this allows process_mrelease() to trigger targeted memory
reclaim (via oom_reaper infrastructure) quickly, even if the victim is
not yet in the exit path, while reusing existing race handling between
reaper and exit_mmap.

Suggested-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/uapi/linux/mman.h |  4 ++++
 mm/oom_kill.c             | 27 ++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index e89d00528f2f..4266976b45ad 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -56,4 +56,8 @@ struct cachestat {
 	__u64 nr_recently_evicted;
 };
 
+/* Flags for process_mrelease */
+#define PROCESS_MRELEASE_REAP_KILL	(1 << 0)
+#define PROCESS_MRELEASE_VALID_FLAGS	(PROCESS_MRELEASE_REAP_KILL)
+
 #endif /* _UAPI_LINUX_MMAN_H */
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5c6c95c169ee..efa6541b1c47 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -20,6 +20,7 @@
 
 #include <linux/oom.h>
 #include <linux/mm.h>
+#include <uapi/linux/mman.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
@@ -1217,9 +1218,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	unsigned int f_flags;
 	bool reap = false;
 	long ret = 0;
+	bool reap_kill;
 
-	if (flags)
+	if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
 		return -EINVAL;
+	reap_kill = !!(flags & PROCESS_MRELEASE_REAP_KILL);
 
 	task = pidfd_get_task(pidfd, &f_flags);
 	if (IS_ERR(task))
@@ -1236,19 +1239,29 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	}
 
 	mm = p->mm;
-	mmgrab(mm);
+	if (reap_kill && mm_flags_test(MMF_MULTIPROCESS, mm)) {
+		ret = -EINVAL;
+		task_unlock(p);
+		goto put_task;
+	}
 
-	if (task_will_free_mem(p))
-		reap = true;
-	else {
+	reap = reap_kill || task_will_free_mem(p);
+	if (!reap) {
 		/* Error only if the work has not been done already */
 		if (!mm_flags_test(MMF_OOM_SKIP, mm))
 			ret = -EINVAL;
+		task_unlock(p);
+		goto put_task;
 	}
+
+	mmgrab(mm);
 	task_unlock(p);
 
-	if (!reap)
-		goto drop_mm;
+	if (reap_kill) {
+		ret = kill_pid(task_tgid(task), SIGKILL, 0);
+		if (ret)
+			goto drop_mm;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		ret = -EINTR;
-- 
2.54.0.545.g6539524ca2-goog

