Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931035E1B6;
	Tue, 26 May 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808938; cv=none; b=OhqaSc8n5ORiv8QP/s+dxhjn82mpqcLKaKOVNrD+mo1XRhSEifUMOC+ApX9v3CBsUNbl6BFs5l1oBNiVaFT18/z5cu7AxELXbE8tKij61nXH+BjxSB9SF/RfVMw5jRsz3Dyi/XKfCCmA3tjC1VLnYESjaGJ9L1VhH5IPS4kuLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808938; c=relaxed/simple;
	bh=ojydZY/xJWBLbjMhhVliboBMhbb87iswhHxUUdAbCJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDW5bMFtqZbtDypBUc6gFbXNHFdUJb4DmOZfxLf/8ttr4MyB4cgPdX7K7cQ5QBkoiFOS1y2FnSwQna295S4QlBjCbcm3nm/YoVoilBybfeNDkv2dK3TsmwJhnQTr7gY+aZh5/57twHH2BfYZumsnOCOQI8sqJhWNLQOw61aQknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVkrhOlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVkrhOlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F91F00A3D;
	Tue, 26 May 2026 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808937;
	bh=4UV14d2V2OqZJ8JzFOmve9/BnIh5+l2yEacWnRAtXuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVkrhOlhMzdD8r7B0DwpVDnJfVBv6mo5fa3cmV1p1OSkM2ofZHU5WZVYWxaTe81Yt
	 JluPgRz5N1XMUJNTNF0E9kHV6zC5uZqy89YDQlkdr91s26FTB7nAT00T/b5n7JuAmP
	 bKEimm0iACxTh7l6zI4O1RuwlsQiliah/s1gBlUNOiV82dOws+UYBARrUVzsrOvBkF
	 Hh+nRgLAe7T9Q1gdQTOOuD88eT8VV9rvbRzJd2qMRTGMv4vBBsyOoSNH1PoEU+IkVO
	 n9RyePwCNyTMTEFTC5TZ/JAHbOnRCQqNdRluGXyTjBoa4iNxYThaQELSj4BcS+rBA0
	 NyN4pJCUGFw1Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 37CA1F4006B;
	Tue, 26 May 2026 11:22:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 11:22:14 -0400
X-ME-Sender: <xms:proVahaEXjV0jhKznqYl7XJtqGpXZEh_HicxXMKYwH-f9isMl-DHCg>
    <xme:proVatSQpC80uCd8YtRBR66nF5w9rUNrUX1lTZcxORYVkTt8XloGORRd9wEXKYGWI
    4YUrAP-FbsM9dqlyFD8pdfQUp4ITjsuzbhdGIHLUkRfL6AcbkAx6w>
X-ME-Received: <xmr:proVap24Sf4-Z3lC7PFZu6F6S3D8YCqwHz7qlzaAxYQW1neIlerClbbOXGWAF3qXpQ_CoZTkvcWimBndkRQEZ9wgPRKEGk_w>
X-ME-Proxy-Cause: dmFkZTFpmA1McbnqjIdDoCcC8/dKh9RDeYcaA/XB6dgQZoHsdisS7Rnte/RUY2pDCqsaCf
    lYH/GXfkGRmzTYnB4S+g0DoIzy4KUSXH1v1hqWsXA4v5WIAvvT6c8zNgUsod23Kpq2+47O
    yYMzbMVdimQJPpKCDvwUMQiSwLgkBGzQ1ckebHI5CwcU5PXtm0paPap1/zDmdG+vWcQc/M
    pmWI2idDed0xMRSQV9XOsN/PBFcH6SBYELvyO/AtrMtpHg8r71AQlMzDlEp1H1iVazK3oS
    DonyrliF9qRbQD87XBn6QOt2bC/09pqeijaNsBJFU0GwQ/sar+bEYdVoRVtkXuEiBwHIjv
    ed+IpSYcEjKMbJGHQ50rASuPpU7mT2upFRbankV1vEt8Udx8iERnnoTH5NFb3Y5VY/8WL2
    pEegsK9HBig2eJRAJqIg0jjeKPcLs1uNP0ZReNxmdY5zQzd3f1TJbk8K7y+TeGpfjFtQxI
    2BpjE/mTLo0A1N9hfh5OwjZfGG+DZ+d5HOqVfzAW03mI/Rz0aQXx2WypcwCXKj/MEB+IgU
    y0dRiJEMF0lPGI/vRxna//ZHzL40srGY8P0xEtX8Eo7r5hREOIXoDEo3xWpy2SUQJGT5C4
    tz/NlTWZ+Dtk+UCW3324dEw1xixif2/TKAWXO1aLDHbE/reOEOCQKTIu9zvQ
X-ME-Proxy: <xmx:proVaiFvmZsAYEeQ34UYS7v0FNA1LXhdVr6bJTpCxkAEGOnoJPy2Xg>
    <xmx:proVaitOzOvpnSxkO7QjXOCOCeZlfwa9wBf21PlHr1FsPiHUsrSz6g>
    <xmx:proVautWtQ_ddccY1lzJxgcp40reV2c_dNCOaiT7r4WRhDuylsP96g>
    <xmx:proVatToULMTAsbrd2SWoQthm1d3REWOcn9QYv78XWui9AAPxMobUw>
    <xmx:proVamUic5KXF6cwrWUQZ3rGq19F9zXKKJ9kF9A98OqFRZPxk8bF1FqT>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:12 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 08/12] sched: Remove the unused preempt_offset parameter of __cant_sleep()
Date: Tue, 26 May 2026 08:21:44 -0700
Message-ID: <20260526152148.30514-9-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preempt_offset is always 0 in all the callsites of __cant_sleep(),
hence remove it. It also allows us to clear the code a bit by stopping
using a "preempt_count() > .." comparison.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 include/linux/kernel.h | 4 ++--
 kernel/sched/core.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5570a16cbb1..24414c79e59a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -72,7 +72,7 @@ extern int dynamic_might_resched(void);
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_sleep(const char *file, int line);
 extern void __cant_migrate(const char *file, int line);
 
 /**
@@ -95,7 +95,7 @@ extern void __cant_migrate(const char *file, int line);
  * this macro will print a stack trace if it is executed with preemption enabled
  */
 # define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+	do { __cant_sleep(__FILE__, __LINE__); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..75dba7cc09bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9165,7 +9165,7 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 }
 EXPORT_SYMBOL(__might_resched);
 
-void __cant_sleep(const char *file, int line, int preempt_offset)
+void __cant_sleep(const char *file, int line)
 {
 	static unsigned long prev_jiffy;
 
@@ -9175,7 +9175,7 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
 		return;
 
-	if (preempt_count() > preempt_offset)
+	if (preempt_count())
 		return;
 
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-- 
2.50.1 (Apple Git-155)

