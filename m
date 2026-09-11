Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596A49B201;
	Fri, 11 Sep 2026 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142431; cv=none; b=MmgNssqGGbT/odCURG3hEKLXSqkcTPVo3ZlUj6CqgddLR70oMALRkCOOIcDnYXsos2jwEe/wO6zHYGj7UqSuAqG0LGd9eCYY6Aq3XyxiQg6QfxscDg6Zh/vytt98zdXa+RQORc2YImBOD4fiGRmlW754DV1Km23MbYrgmHvUxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142431; c=relaxed/simple;
	bh=+QEQyKkJoiMrA/3HTit19JPln4erh+u17aGYAdQZSM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In6F3UpLlWCqtN195zDrbXTVY/lF4O6LbP82dYP0cdjbXwEtcCdHjtTCOyqyb8LD2ZMsKnnLj5SbIXbUeGxW8lEt9Dqv5tA/5QKiqRoODgsiHizDAabH4DI7SQpd9ea9GULpxMeRWdxT5t+LciWNHt9fu6avh6fjuUXWMc0gq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SLoD59aq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SLoD59aq"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6CD32809D8;
	Fri, 11 Sep 2026 18:00:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hp5OaKgBkdr5; Fri, 11 Sep 2026 18:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789142426; bh=+QEQyKkJoiMrA/3HTit19JPln4erh+u17aGYAdQZSM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLoD59aqxSs996kB13PggG5d5KZSymG6FrTn/9qyt9fCyre211izYGiY6fXvoZDFU
	 zglLAO4aKZXzC0B9EXg8jUT677zWP1T9n//Yy1UzljXKJ5td7EuPaSM0zsdVkxytGV
	 tTZf7TMnWHZ1VxWn1Y2XiznRWhIOj5rlVlXJ4DhCF8pD46Y/V8xqPg/4PyHLom0W/m
	 lI4enV+zi0Ex2DReM7t2kUGCp8tk7UrRDaj258gRG2ed674dEWA9JWr976eHb1mbJQ
	 WlELrzcVjeVCqk2TpUWHY/2GHdg0tDHkhekUVeSGI5KRfZ+QEWHMlSGMWAZntPJkmy
	 OyqJHqCOTFUjA==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] tracing: Delay module ref count for "enable_event" trigger
Date: Fri, 11 Sep 2026 19:00:13 +0300
Message-ID: <20260911160016.355492-1-aliamemis@disroot.org>
In-Reply-To: <20260828134340.2501683A24-agordeev@linux.ibm.com>
References: <20260724132415.1b5005db@gandalf.local.home> <20260828134340.2501683A24-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 03:43:40PM +0200, Alexander Gordeev wrote:
> This patch increasingly looks as a regression on s390.
> We are hitting this once in a while when running the ftrace selftests:
[...]
> I did not manage to come up with a reproducer - if you have any idea,
> please let me know.

Sent a fix:

https://lore.kernel.org/all/20260911155650.354844-1-aliamemis@disroot.org/

It's the deferred trace_event_put_ref() reading file->event_call after the
instance rmdir already freed the trace_event_file. Could you give it a run?
