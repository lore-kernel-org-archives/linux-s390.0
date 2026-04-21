Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282F372EF7
	for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812573; cv=none; b=uzTr5dihNlhysrB828559ZYBN/F59y7ChrsxDVgaKGQEgRziC1Dh3d/OlDeZNlBo71Fn2XOFxvi0svBGSMQ7fOqBOmEo6tKrQT5y5dr9mJkkrGigzB11YCjosmPKyNsiwqEEUUg2AIXFfIb6gbA0Q6vluyo33+5fWlM03AXN07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812573; c=relaxed/simple;
	bh=uCqTMx2Vrw9oUnN/NUn/zWaQzWq7nFi9S8FCWPuGSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhyT0NilLRaFujtjPz8OnME8L8HrsSgNR2bA6mcjrt/2zqwAHi0a+JeNyBQhc8n9kRXPOsUOJf3nPZWnXb9wbZou1UgBVDGTY28Q8MyX+pjMjpL7hnMTxr6aiSoEkcgiKfI7X1XALPTOrZ8vMcQbSKosO4vsqw44QvXKJFdI9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlcNzM/I; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlcNzM/I"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c565476d7so11130931c88.1
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2026 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776812571; x=1777417371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwpK6htKdPchlWbZaSeEAHqzDpDsOuggPLlaoXdeCJA=;
        b=XlcNzM/IyJTeUf5regBMn924oOIzWAhakBeum3kCBO7S42JL3e7yNlI3ERVgtNWrlr
         wmP7luqzFVpWHlffLkRaLQJbBIVSlPCbuolRR17NyoUYl14EfhwyOxEUgXqb/YKqnq+j
         6gGqbKVqLgOLIcyh3l+Lt6/1pzpVKcpfJaHQshErNChm580Rlyopc9saATwJgJ7TWV/k
         OttQGhe2MRPT0TeQBrOPruleBlgUScKtbLIks2xmaC9iVonYjuYIEunw9FLZsJpVExv8
         C3BuA/sRPuEoNzqEhqrJd2+h3JyD3z2f4HChAXFV6emm7GbptaYCc76gg2cXD/kVvFLX
         n37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812571; x=1777417371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwpK6htKdPchlWbZaSeEAHqzDpDsOuggPLlaoXdeCJA=;
        b=kYWTBZdMCejkspNuE4D3YYXK6QViStYbV4zYE2YDc2oee1mI6bEsM944A/o+9hHfTW
         M4lmn2Nx/7Xx5L43biR7uru8JPi8pCAizCyin94vPCxnyJgMcgX3RL/UEKrg6PN2aCiI
         lIOcXlbu/MIZCWVEzrK2AXdqlq79NmCVil9bRW1j9/pZONdZMIY/WrEyToBYnX+aYbTm
         RCcvNMBTiGt0qJW0vn6F+rCMhZknEkjzzfUM8ozejoETWbqzYDDB0gFo8QfPXPZDQeum
         ifMvEwMXjCvMPgt2MBYqdWzvxim9s26cGHvHSs3COvrWtOAPK6XVW/cRmfk5qkJEaVGX
         pzrg==
X-Forwarded-Encrypted: i=1; AFNElJ8Wh7H/KW+EdxkJ6yxzO0T67uoyUY+4jPkzndoKrz4VqtARSILav2lXE7g94zuZIpxxHToRf74GlWlm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6r90r8tXhqQ4RtAgzwPKNkyO4FvlBfDqfMagbNNuTXACHojDW
	Pu6EuMR6kf4L7//54gX8izo6uB5bhEWrNKLVzco5q89FOiDQh2Ki9od7
X-Gm-Gg: AeBDietnS9TrUx9PRK4ylZh7/Mh6m5Y7jM+2sPm8Wowg0LurdtBKi6IfRRwbHZ6I2Cn
	Xb978uMoXchPh1ZrOVCvOt6oL5aHpcf/e2DWNXy2DDYeQIJKxTPhXR3iXviamzB23cKCmVATY72
	vHb7YuVX6k7ZhdJX4ItqP80zJT/gd2tkSl3AAc/uq4um1UKlDUl4Tjt7WLinV8/TR2C64gT8bKo
	ADH8xKMD9tbg92g1AiDYEhnUMne332ID9TyqBmscwyqVcTGjhMGiDDu7Z5qRXHwvxdIUr/q0G7w
	KU+F5tgV14LcN2G4vl8kW4WkJWXx5cSMTlxsRkxa9ynjgm9tiZZxvLi/qBT2Bq6C3189wRl31lu
	BYpLa3ZKmEE9ZE/GJy+hc5hOWQmhWLmNgRVPSM9yXQ+bzle13Hik8A6Rm5PbAJ0+EtdpKqlA+Yp
	dyy4jp2iBXHAJE+Ua50OyQDKq8PnXsgMoF9MZ5nKmlA32QvUYfqxma6o8sPmh8fXZxM97NAQUfy
	zy/nioI/K3yMA==
X-Received: by 2002:a05:701b:2415:b0:12d:b26f:cafd with SMTP id a92af1059eb24-12db26fcc16mr2120556c88.5.1776812570960;
        Tue, 21 Apr 2026 16:02:50 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2a00:79e0:2e7c:8:4678:d28b:b946:bcc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm26453546c88.14.2026.04.21.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:02:50 -0700 (PDT)
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
Subject: [PATCH v1 3/3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL flag
Date: Tue, 21 Apr 2026 16:02:39 -0700
Message-ID: <20260421230239.172582-4-minchan@kernel.org>
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

Currently, process_mrelease() requires userspace to send a SIGKILL signal
prior to the call. This separation introduces a scheduling race window
where the victim task may receive the signal and enter the exit path
before the reaper can invoke process_mrelease().

When the victim enters the exit path (do_exit -> exit_mm), it clears its
task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
leaving the actual address space teardown (exit_mmap) to be deferred until
the mm's reference count drops to zero. In Android, arbitrary reference counts
(e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
VM accesses) frequently delay this teardown indefinitely, defeating the
purpose of expedited reclamation.

This delay keeps memory pressure high, forcing the system to unnecessarily
kill additional innocent background apps before the memory from the first
victim is recovered.

This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
an integrated auto-kill mode. When specified, process_mrelease() directly
injects a SIGKILL into the target task.

To solve the race condition deterministically, we grab the mm reference
via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
victim from calling exit_mmap() in its own exit path. This ensures that
the memory is reclaimed synchronously and deterministically by the reaper
in the context of process_mrelease(), avoiding delays caused by
non-deterministic scheduling of the victim task.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/uapi/linux/mman.h |  4 +++
 mm/oom_kill.c             | 56 +++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 17 deletions(-)

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
index 5c6c95c169ee..730ba0d19b53 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -20,6 +20,7 @@
 
 #include <linux/oom.h>
 #include <linux/mm.h>
+#include <uapi/linux/mman.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
@@ -850,7 +851,7 @@ bool oom_killer_disable(signed long timeout)
 	return true;
 }
 
-static inline bool __task_will_free_mem(struct task_struct *task)
+static inline bool __task_will_free_mem(struct task_struct *task, bool ignore_exit)
 {
 	struct signal_struct *sig = task->signal;
 
@@ -862,6 +863,9 @@ static inline bool __task_will_free_mem(struct task_struct *task)
 	if (sig->core_state)
 		return false;
 
+	if (ignore_exit)
+		return true;
+
 	if (sig->flags & SIGNAL_GROUP_EXIT)
 		return true;
 
@@ -878,7 +882,7 @@ static inline bool __task_will_free_mem(struct task_struct *task)
  * Caller has to make sure that task->mm is stable (hold task_lock or
  * it operates on the current).
  */
-static bool task_will_free_mem(struct task_struct *task)
+static bool task_will_free_mem(struct task_struct *task, bool ignore_exit)
 {
 	struct mm_struct *mm = task->mm;
 	struct task_struct *p;
@@ -892,7 +896,7 @@ static bool task_will_free_mem(struct task_struct *task)
 	if (!mm)
 		return false;
 
-	if (!__task_will_free_mem(task))
+	if (!__task_will_free_mem(task, ignore_exit))
 		return false;
 
 	/*
@@ -916,7 +920,7 @@ static bool task_will_free_mem(struct task_struct *task)
 			continue;
 		if (same_thread_group(task, p))
 			continue;
-		ret = __task_will_free_mem(p);
+		ret = __task_will_free_mem(p, false);
 		if (!ret)
 			break;
 	}
@@ -1034,7 +1038,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * so it can die quickly
 	 */
 	task_lock(victim);
-	if (task_will_free_mem(victim)) {
+	if (task_will_free_mem(victim, false)) {
 		mark_oom_victim(victim);
 		queue_oom_reaper(victim);
 		task_unlock(victim);
@@ -1135,7 +1139,7 @@ bool out_of_memory(struct oom_control *oc)
 	 * select it.  The goal is to allow it to allocate so that it may
 	 * quickly exit and free its memory.
 	 */
-	if (task_will_free_mem(current)) {
+	if (task_will_free_mem(current, false)) {
 		mark_oom_victim(current);
 		queue_oom_reaper(current);
 		return true;
@@ -1217,8 +1221,9 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	unsigned int f_flags;
 	bool reap = false;
 	long ret = 0;
+	bool reap_kill;
 
-	if (flags)
+	if (flags & ~PROCESS_MRELEASE_VALID_FLAGS)
 		return -EINVAL;
 
 	task = pidfd_get_task(pidfd, &f_flags);
@@ -1236,19 +1241,33 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	}
 
 	mm = p->mm;
-	mmgrab(mm);
 
-	if (task_will_free_mem(p))
-		reap = true;
-	else {
-		/* Error only if the work has not been done already */
-		if (!mm_flags_test(MMF_OOM_SKIP, mm))
+	reap_kill = !!(flags & PROCESS_MRELEASE_REAP_KILL);
+	reap = task_will_free_mem(p, reap_kill);
+	if (!reap) {
+		if (reap_kill || !mm_flags_test(MMF_OOM_SKIP, mm))
 			ret = -EINVAL;
+
+		task_unlock(p);
+		goto put_task;
 	}
-	task_unlock(p);
 
-	if (!reap)
-		goto drop_mm;
+	if (reap_kill) {
+		/*
+		 * We use mmget() instead of mmgrab() to keep mm_users > 0,
+		 * preventing the victim from calling exit_mmap() in its
+		 * own exit path. This ensures that the memory is reclaimed
+		 * synchronously and deterministically by the reaper.
+		 */
+		mmget(mm);
+		task_unlock(p);
+		ret = kill_pid(task_tgid(task), SIGKILL, 0);
+		if (ret)
+			goto drop_mm;
+	} else {
+		mmgrab(mm);
+		task_unlock(p);
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		ret = -EINTR;
@@ -1263,7 +1282,10 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	mmap_read_unlock(mm);
 
 drop_mm:
-	mmdrop(mm);
+	if (reap_kill)
+		mmput(mm);
+	else
+		mmdrop(mm);
 put_task:
 	put_task_struct(task);
 	return ret;
-- 
2.54.0.rc1.555.g9c883467ad-goog

