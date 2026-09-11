Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4045498927;
	Fri, 11 Sep 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142232; cv=none; b=Ylmew8arCcJ8TxuPPvRzx4XZJYgMGCnlMSfJDplZyQ6FMmkmf4RbpBz7BPFuSEp2d9em/DOt6Q+zY2Ej3a+vLIMz458xIUFZp67GE1HYOebiLFg1eZeu5UPfWY5vUHVbtuLsxRU/oR9wGGV5MgGcknPlBp+YI73SOWRoBU80UGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142232; c=relaxed/simple;
	bh=YsIahrjsMCLx8Vmej19Tp6nrCVLGETYWzUEZiMxepNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6Yt/OfNAohJhu7Ba9xQ4QQA0NmDZ4ndb5KVpYNbOSrt+6D71cyB6YQSlBf+ik3vNgVDG6z1PRbOYTu59BZGpQ9IGBjgUYqS8nmWgbArbamvgPBPTTIsVpoZLmQxtJODTzCbqdo1I/7BFuQV7YUADvSXwtEACGIFgO6AdOMY3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=N9G2QCoq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="N9G2QCoq"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8C29480F31;
	Fri, 11 Sep 2026 17:57:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7CclxIKH0vMb; Fri, 11 Sep 2026 17:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789142221; bh=YsIahrjsMCLx8Vmej19Tp6nrCVLGETYWzUEZiMxepNU=;
	h=From:To:Cc:Subject:Date;
	b=N9G2QCoq0+Pgl5QtPP9JYVHa0974oXqcLacRQ9116+3oEulyC/UOcMFEcWZTqiR2A
	 z2Dyd1WuvoV6Y5/B+IlXczqljy//UEBq4jrbB9MSFiAagQOTp7s8FxD9lOOf83k4RC
	 stN/UaLerY/FMTCkxrcfx48FQj0rPqGs3Zin51aBVgcrBxPfqBeywqFlldSsRDu5ew
	 zpwmtQSAIAKVd4nvQ6LLVjqxHWdrNJ5NXt4KUpvXB00GrFGsMCRl/7+jkToN1RQiPt
	 OQkdZFGu4H4mfzjNq9YqoozI4XqX7tCrNGZPTQBZvAPMJZ/6vRLuusfqVX14xHXhqj
	 5fUpwlL0Acqvw==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Don't dereference trace_event_file in deferred trigger free
Date: Fri, 11 Sep 2026 18:56:47 +0300
Message-ID: <20260911155650.354844-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The enable_event trigger defers trace_event_put_ref() to the
trigger free kthread, but the trace_event_file can already be freed
when the instance is removed.

Keep the trace_event_call directly in enable_trigger_data so the
deferred free does not access the freed trace_event_file.

Fixes: e091351b3881 ("tracing: Delay module ref count for "enable_event" trigger")
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Closes: https://lore.kernel.org/all/20260828134340.2501683A24-agordeev@linux.ibm.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 kernel/trace/trace.h                | 1 +
 kernel/trace/trace_events_trigger.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..0de92b4575e5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1952,6 +1952,7 @@ struct event_trigger_data {
 
 struct enable_trigger_data {
 	struct trace_event_file		*file;
+	struct trace_event_call		*call;
 	bool				enable;
 	bool				hist;
 };
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 149300cc5e8a..4d2fde996c0f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1728,7 +1728,8 @@ static void enable_trigger_private_data_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
-	trace_event_put_ref(enable_data->file->event_call);
+	/* The file may already be freed here, only the call is kept alive */
+	trace_event_put_ref(enable_data->call);
 	kfree(enable_data);
 }
 
@@ -1801,6 +1802,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->hist = hist;
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
+	enable_data->call = event_enable_file->event_call;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data)
-- 
2.55.0

