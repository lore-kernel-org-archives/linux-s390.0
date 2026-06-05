Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF1401A0D;
	Fri,  5 Jun 2026 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638109; cv=none; b=ZXkSIyxzY8cEkrpYAGNQ8f7rOEEQgLUDR0pHhDgsw2miGxaOcrGB3SQMbKFmXNMUgNJ+zvNAcR0Hu2g57Us24GRrn8SsMF1E5RhxSIyzgVEXplqRtacM4SHr4w/w9g+oGPS/WD8QfRjbf6WwFNbbmdTIHm4hXpuqOrZrVteBONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638109; c=relaxed/simple;
	bh=OCIQ1JNYaYn1HO1wd9Wum3zvGhBgUH5HslNCfI5WKfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkVvUUf8gblidwrekLGt+SgwDqRX4fJjJ110yk6SRWjkV/sbs3c0Yr3DfdML4fRwNdPucAiWjE2weupMfxDoppJ76yDzWb7kiVyyenQM1Zi9qoHNe78jV75zkcn1qDVj5RhHg452BG3h9GLNIign4Qsu7ubZALAvrfjrRalgZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RShrFXJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RShrFXJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577001F0089B;
	Fri,  5 Jun 2026 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638108;
	bh=na6ChhIW2x+wIN9W0OHq/rAhwLKFaVTMYx/jBn9ncTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RShrFXJCQcqwe0yCV7e2WjfLKFGrueu70yGHB59yRWOyCSwQzAtnrFSBdjYVBwyNu
	 jcL8zIRElJyagC9JOOSTS0BrBXu8bA8aY5Q9wKkA990JVg9197ltIP+zAyw+ADyNlp
	 /Wn8/+hQgaj3+fX3jxJGg+0Nb2UoNTmOWcwDzoXuVTPAj4EHSl4luv54xMxeqfgnxH
	 7tmQJkiPX0pDBx/KFQeY3gVq0LboIc/94tMT+WPmCPfSV4PhEA0aNkZCZCaM+gdERi
	 S0U4N91eEjpEC7VSfZC63+dUxdS2S38SofG9Cm5tA8t1c/0S02P3t5AGk2R4o1lg8+
	 J74yyg5TaRV3g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A0AAAF4006D;
	Fri,  5 Jun 2026 01:41:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 01:41:45 -0400
X-ME-Sender: <xms:mWEiagGPzDNw9Fd6jcWAQGFiM_agWiPEzjyNTNh_ootOgXC2N75C9A>
    <xme:mWEiagI8pB3Oeuqhtngqe7m9rLa1weaEfTlmwTJ-Bo-Mmy_bkOkpBlTp-xS4cuGw2
    a6anGqMs4PWSP772pw1TFRoY4CcBGfyplo75P6p4wNotWo64a65>
X-ME-Received: <xmr:mWEiarVMysrQpXeopAtRPnbFRcLsLNCfEAdn2JGo6Ov8Rj0LNnAV70pezQk>
X-ME-Proxy-Cause: dmFkZTFG0WJa+84B5ZLakFCJusLrHx60u/M2e4tgb8vvSWGQWHXMFZeKktHow9VrFaQhwL
    60vkPLe/GHUXrF9uQjn9EtWhYCiYebO343SXKkauObGNd0gaHEDMGyAUdMEWI3xvV5+MXM
    Y5XIGIH+RCj/YpjPsc3XHQUzqyjdf8JDGbXE7uRDsVlh2adsQWoVoEG+11Li6tmpxBjo+n
    GbGHXxcMsG5BC+v/PWXz65OFiJmnJTn18gjrdwmPsAQA0I/XEj3HJhBv36WGSvCgORqSG4
    pkDfFOinWXk05Px2n3ZYSDFusuNrnah7Cqk2jZsViR99U7a3ccatK3SGLf/zDxH9xSS8M3
    BYqcTNPoSFWTUAYnzRQsPMjoijWzTQhJOBECvxoAHstZsQERmbxNGFxrYJ8nuf451xz6Gi
    JZckgK1Vr5EFN2I5rL2HrR+uvyRf0Y+ZKW5Aw/kjsrHcSbsPMzgMKvgil5ZUhIbAr+LJ5o
    eosapYegMdAxAxC/a1+cCt7IJcekuaTmfVEbYwAJwRPjaQcP6RF4fHYxtzwOSbipcxtilW
    zSZYZFVdtyChk/sU7KPXknN2o+XmbO6+PO+/G8uhRcp2pRsqwCpE9WqpYEAFBbyOIc0hBF
    e6ovp43WLtoCFTStA2qhLzt36hynsitQNYUu5oVB7X6mw6jqChkvdvQitnRw
X-ME-Proxy: <xmx:mWEiav2h_9kCWCJ3d6n8nrQPh1btokbBBVyuD8DAS5GOFjY_F4UpaQ>
    <xmx:mWEiatoENQZWGEtid-OJArj3To2FhSPd4maL0_H1VuW9whomaH0eOw>
    <xmx:mWEiaj-OmikDacgWrz7F39PYYtItAqERdGvWo2JLBvnXKX8FvsJKWA>
    <xmx:mWEiakm6IQrGHxNntMQ1JxCZ9tRBrjuWg_DjFaJkYZjmjd0SbBxFbQ>
    <xmx:mWEiam59ryaprfqdDo_-z6ynUNv9sCCDTP0R8g3ShxwYJAjFwe9-cdSE>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:44 -0400 (EDT)
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
	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 08/13] sched: Remove the unused preempt_offset parameter of __cant_sleep()
Date: Thu,  4 Jun 2026 22:41:23 -0700
Message-ID: <20260605054128.5925-9-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605054128.5925-1-boqun@kernel.org>
References: <20260605054128.5925-1-boqun@kernel.org>
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
2.51.0

