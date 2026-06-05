Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535243BB669;
	Fri,  5 Jun 2026 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638097; cv=none; b=ilrjtDK3vheQ7Mvgf2CWybmSE/yf12eSQhYeoOsjNYZWPy9CxvRHAakOE/4n7YX2wgOPXlcGlMNc/TE9BbeOr+3Lil8qQdWsXw0aTZD3i4S4NvFLjW1zDsX/7GiZIlHJEMn35S/0OXuVVUqZAgIyIobUhUlQ9Qcr7zXmsMuc70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638097; c=relaxed/simple;
	bh=Ls8jAn9uxSIuXUvxGwKTd0oyRzMQf9ICZGzwFlvvGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TyOIEOZPmXtcF0EJ+u+4iPMXXXdP/8qnWs/UlRdqzwycX0zj/X1xEX5QPf4B7h+EM0Fk2iI4hYTvdv+qhwxUiSqvfOu/Hj6Z/iAN4ymBlrFf1x5AeEuxOLs1t1kPlcui0x+T3ZFr6afVfASOEBxkmGnqurv62OKQLdYj+hmiLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MObfmUyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MObfmUyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DC91F00898;
	Fri,  5 Jun 2026 05:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638096;
	bh=SPlBajyEY6daFB22p/LrTuA35kcRxPh5dhkRnYY+Ggo=;
	h=From:To:Cc:Subject:Date;
	b=MObfmUyEGI4gsHNOfRmcE5B8Djlg4lkrTjak7Rs1Zj6fqLyBs1fZayWXdKO/94FLh
	 eooAeTUtNPcqchnhpY0yfIckQaBlZ76Msx9ff3F8LASsQQFduhFp9guhMYEbWgp3vq
	 8YDEsuX7JPq9023+cb8AIqyA0BUJedImk9x3elmDrNMDx/eVYtSMm2QE4reZ3OFwx5
	 EQ8zscZIjBFf/bxt/Cii844N/Sfx7iPyrFrACWrhoOqmuVnN21tbPBx0YtuiNouuGp
	 nkaDjdWBtRWSca0QUcsrdxv7X78mAXHTXJsNoBREfILvFrrsM/Y1x8ouOjgYr9WMLe
	 Jfhb220uBXmFA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0DF60F40075;
	Fri,  5 Jun 2026 01:41:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 01:41:33 -0400
X-ME-Sender: <xms:jGEian6pbR-I090HCRq40lABCksHe_AMB-tMU-ksxzL_HbSyBS0yKA>
    <xme:jGEiajvRRAC1Tj8t6DkGoYYfBIkyUIAYBaNwdNIhkk_6rNBN86RfumUO-7N67Bvz6
    4KtuohlS_Q1UaG-wIO55zGGP5VZdbRsWDNnAG1bXmVMUqV261VZPQ>
X-ME-Received: <xmr:jGEiavoLx40h6nXgPtksAw3ktngeKFB3savDUCnwY_dYiQs3Wjs0MHTX_Dg>
X-ME-Proxy-Cause: dmFkZTFc+6I5dnayd2BYaWnu3DfmchaRspDny6hXOeQ0WXB+cUQ8+NyHSxw59pEB4HYxYa
    hQ/jpd2pfuJ3tb8YfwNEy34LuyXTLFRcJbt/R3UZar0R7U6maQKv8Ka6NzqAWGME+IqBdu
    RQdq5hY1TEX4Mkzh6yYHh+p5reirdqtNwaqftTDkO7sP45Jaff/WH/0OIgW/vJp50latAm
    /rZjqCPZR5E6s9fBO3Fb5bdDNNFP7jhf5AaUB5cFypzcKqHlteCps9x6FxSEcbNaEgP8SO
    zQY036UKu1kACwxOSXMerD2djNH46JMVmwsHENjblrU+CF4vthjwdTe26BiLxe3GIJfiJG
    RjxR1yUIIVwSsXPKsrNdSCXGu6UprlEJkGbJ3B1VFu+tZg4rlXYG22BD0s8OrcXSQwm7NC
    l4CbhELYEZuVNoKuLdDMRZr6C/IjJWC97a4XxBGAxUFbF8LpyT/BC/HsxqwBEQ/HRLMbAh
    Dpp4/sZ1kF0bb4aiYj3m13E2PmMVn7cftH8o+dAQNxJdTp5fTb/EjC26ZGRBOA1Q80npOd
    2Qex/+DWN7SgpELtlSBBcSbTL2nubPHJymTzywzvBJolNNEtkVlORFC1UwerW2cGz53Isx
    M8QJPTjEsaTF7VLs8NWwd5o0BuRMm78L/vG+Z9c0aa9bn7IoCunGEhauKf3Q
X-ME-Proxy: <xmx:jGEial4QER2MrYz0DiDUDJTLXRdmyy4sQPfOBLh--p6E8484ePvGKw>
    <xmx:jWEiaicqOB0Nq2Wcw2UqV6QRBAqL9B5h-SAx_FgKDB17GXzl0BbAig>
    <xmx:jWEiagiecPLdtMT_wqMPQ4ardSZLgJsKqWeVe8FvkR0wca5Uc-lpcw>
    <xmx:jWEiat4IwbpUPMVrOQ3uAqNXnEsZDnDVf39rqZQ8w6mLTWaT0MoCLg>
    <xmx:jWEiat_QeSJwiP0onTcKhoVUIw9TYHNqOUQ0_iNoX_CSNMiaNUGoFc-i>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:32 -0400 (EDT)
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
Subject: [PATCH v3 00/13] Refcounted interrupt disable and SpinLockIrq for rust (Part 1)
Date: Thu,  4 Jun 2026 22:41:15 -0700
Message-ID: <20260605054128.5925-1-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

Please take a look at the v3 of refcounted interrupt disabling.

Changes since v2:

- Fix NMI_OFFSET underflow issue reported by sashiko. See patch #1
  (__nmi_ext()) and #10 (__preempt_count_nmi_exit()) for details: we
  have to replace preempt_count_sub() with preempt_count_set().
- Add WARN_ON_ONCE(in_nmi()) in local_interrupt_disable() per Peter.
- Remove the use of should_resched() in local_interrupt_enable(), see
  patch #13.
- Remove my gmail in SoB.


v1: https://lore.kernel.org/rust-for-linux/20260508042111.24358-1-boqun@kernel.org/
v2: 

Boqun Feng (9):
  preempt: Introduce HARDIRQ_DISABLE_BITS
  preempt: Introduce __preempt_count_{sub, add}_return()
  irq & spin_lock: Add counted interrupt disabling/enabling
  locking: Switch to _irq_{disable,enable}() variants in cleanup guards
  sched: Remove the unused preempt_offset parameter of __cant_sleep()
  sched: Avoid signed comparison of preempt_count() in __cant_migrate()
  preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS
  arm64: sched/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
  irq: Optimize reschedule check in local_interrupt_enable()

Heiko Carstens (1):
  s390/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS

Joel Fernandes (1):
  preempt: Track NMI nesting to separate per-CPU counter

Lyude Paul (2):
  openrisc: Include <linux/cpumask.h> in smp.h
  irq: Add KUnit test for refcounted interrupt enable/disable

 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/preempt.h              |  18 +++
 arch/openrisc/include/asm/smp.h               |   2 +
 arch/s390/Kconfig                             |   1 +
 arch/s390/include/asm/lowcore.h               |  13 ++-
 arch/s390/include/asm/preempt.h               |  49 ++++----
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/preempt.h                |  61 +++++++---
 arch/x86/kernel/cpu/common.c                  |   2 +-
 include/asm-generic/preempt.h                 |  14 +++
 include/linux/hardirq.h                       |  41 ++++++-
 include/linux/interrupt_rc.h                  |  76 ++++++++++++
 include/linux/kernel.h                        |   4 +-
 include/linux/preempt.h                       |  35 ++++--
 include/linux/spinlock.h                      |  49 +++++---
 include/linux/spinlock_api_smp.h              |  41 +++++++
 include/linux/spinlock_api_up.h               |  16 +++
 include/linux/spinlock_rt.h                   |  18 +++
 kernel/Kconfig.preempt                        |   4 +
 kernel/irq/Makefile                           |   1 +
 kernel/irq/refcount_interrupt_test.c          | 109 ++++++++++++++++++
 kernel/locking/spinlock.c                     |  29 +++++
 kernel/sched/core.c                           |  18 ++-
 kernel/softirq.c                              |  22 +++-
 lib/locking-selftest.c                        |   2 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   7 +-
 26 files changed, 554 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/interrupt_rc.h
 create mode 100644 kernel/irq/refcount_interrupt_test.c

-- 
2.51.0

