Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326F1AF4E9;
	Tue, 26 May 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808918; cv=none; b=KyqJP36K8nEBGHMiHie79yUH3xdpZIGNhAx8SLZITbj0EjfT7XQ6+aMTkBP56Snlzuvu88VAQpvXJ5E6XHDifgvAj1vhASksPBAJUxkFtp/Acgqm8l1OM6u1LiRr6oxUJo4ZDgm8by0RVv8PWIDKk0cYfX25EcEeacr+7cstqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808918; c=relaxed/simple;
	bh=fTKrci0yQyhLBN7q+ikXPwSrGDqHjqNeY3AAetkN90s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIP3N1IWbLB7EROQu9CMCxxczBuz+Tj1VU5eXttvQSmH4BX2swydYWaE1eEPuWmdk3yXrIh3kDv8zCwMU8FJYiOTEnaGQzuRfKMMC1iKU+l+7oIguFTPW35H2XHISNCIL7RKJbJpDcHCZaZBaVJ2xe+29WNoe3am/H+fB9WUZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2LpCiSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2LpCiSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6D1F00A3E;
	Tue, 26 May 2026 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808916;
	bh=0hQwi5+nW+dV7R2wQlzvmP6fT6QYtAlQz+HAiPUDCiU=;
	h=From:To:Cc:Subject:Date;
	b=m2LpCiSJVU237ta4inGXHLXDL24OGeldS92bZjWJO9r0T42Netl7PViNUuprrIp2g
	 q54ZJ6vboC0uEPuEDNdGwHKfKQqtq0+gI6BY3joCLPiaWEnVX9eX4CZANoZbEeGOX0
	 3TnaUTC8fvk675J3v16G/IKiberS1ZXAbKE1YW+CQcLpIAJUCCrem/aip6VXlsNLZg
	 czO0b2dqwSrNRap+s9Szq2QffQTzJ993TBu/vqFDOZ8Jz+9Vt1oOnz4R/LF6hEmQAn
	 jwLY/iRGVl4vCiLH9stLELphBKzw4FuifhN2VaSOW7y7DSKbZvjKXXPhzY6snwZ3zT
	 No+11v9zStpiw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 403B0F4006B;
	Tue, 26 May 2026 11:21:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 11:21:54 -0400
X-ME-Sender: <xms:kroVagybSl3oAEyYhVs-fulOrUpWcDtTdoCA2nEPrqyKMz1FtwwNlA>
    <xme:kroVapJbk8oSsIW9WpJakxFiyLTOges66Pi7_AwIcpVAlNtGyMSODtgi1Qmn_Cb1B
    gFxV36cWxt1SFWEVHYL1kUOFgyD9vagp4B2aiDLr3ZkOoQt5CXOLg>
X-ME-Received: <xmr:kroVaoO_RCv6pL7iuPtVvqH2Wg6JxHVYnCWei9fqChxvHNWccchDLJG1Ivvh-DGOdgTQlf6OgK1MUV_8c8M0yCCZeuVc8Q89>
X-ME-Proxy-Cause: dmFkZTEc8a0D2GdCjrvIhiNGB2Nh4cWuQxL5ZFYu9/Yar+XUr10figlOqIqzZ35yWmZKqP
    1e7rvFFTLvMZqOu3FuGq4lX65NtD/MteFhq94HrvbeDHeIwRMhuzkfUd3Nj2G1+NpBICKp
    6sF87Mj5FVmkDzWHyKKu0EBWLAfJk7BHjLPIkbXNytuoqAp+/FLkSEjFELHI2kl2/BQmsY
    eymRo7s3JBXS0yRHUCuZp9MDu+CdW526s52Lixpit9kqC/DNyw6ZSWLKiIA/7Ex68TstWu
    XLy1p2JlIkBHFPlZ0WVdh/zUtiR8MDz6pF8Le6EA7VH4rNS53h+8SZCydHfWRQSzORE1UF
    wDnMDwsNqklA3mcHdWLOQAM3r2KNCVwvSj+z84CmnWgHTJydUvi4FW3gB61UWhRqNelRbK
    fNNn4UUiBB80v7p+rmHEjjIfepwm+q5guv4qBZzmqOtd3Hb3Pdt67nxs9yLRaE7d0cbUPJ
    dKhtAwrfGFqyfQJb+74inmexhzMSsgwmWjQytC2PNoeoOZDL8te1G6KGLMdysorHkrVnFx
    oKkYZzf8IBLTZM8dvN/4AMUDU8tGzJyTv0GdTQdHHoH5dRkSGEHK/LGnpep0JXhtd2q+rM
    bbWVifmiPwINUswNxaO+84i5I65WWLTBXUsTGAmEa+8Yhy0i0cTy2iaTHBjg
X-ME-Proxy: <xmx:kroVag8DthoomKlo_BXoZGQ6V1IYJ-byKB03FK7PyxOm5nZY1fnZhQ>
    <xmx:kroVaoEeR3snZSyIqn_eikQ0Bo3bWf1boG0Rnf2-bK6Y24qZGtBfzA>
    <xmx:kroVaolPdSFdJoEvggbZXwd1pqGksSrgohVtwI9h0NpT8HSJVQHubA>
    <xmx:kroVahq4E_GgWdS0KfntacoyBcxaxeOUCIBzrWLjAiGPFl5TSlBmFg>
    <xmx:kroVajNHJq0pUr5G5QX3qwvGrHttu0-vPZRLhOZ21LFi0eZ2cIk-cEda>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:21:53 -0400 (EDT)
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
Subject: [PATCH v2 00/12] Refcounted interrupt disable and SpinLockIrq for rust (Part 1)
Date: Tue, 26 May 2026 08:21:36 -0700
Message-ID: <20260526152148.30514-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

This is a follow-up for Lyude's work [1]. After learning the current
preempt_count() usage and how ARM64 handle this, I came up with this
series that could resolve your feedback [2]. The basic idea is based on:

1) preempt_count() previously already masks our NEED_RESCHED bit, so the
   effective bits is 31bits
2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
   proposal), the effective bits that record "whether we CAN preempt or
   not" still fit in 32bit (i.e. an int)

as a result, I don't think we need to change the existing
preempt_count() API, but rather keep "32bit vs 64bit" as an
implementation detail. This saves us the need to change the printk code
for preempt_count().

v1: https://lore.kernel.org/rust-for-linux/20260508042111.24358-1-boqun@kernel.org/

Changes since v1:

* Rename PREEMPT_COUNT_64BIT to HAS_SEPARATE_PREEMPT_RESCHED_BITS per
  Mark Rutland.
* Add s390's support for HAS_SEPARATE_PREEMPT_RESCHED_BITS for Heiko
  Carstens, thank you!
* Reorder patch #1 and #2 per Steven Rostedt.
* Keep the NMI count warning per Steven Rostedt and Joel Fernandes.
* Fix an race between interrupt disabling and softirq reported by
  sashiko (see the changes in __irq_exit_rcu()).
* Add Context Analysis annotations for the newly introduced API.
* Sync the preempt bits changes to BPF tests.

I would like to target this changes for 7.2 if possible.

[1]: https://lore.kernel.org/all/20260121223933.1568682-1-lyude@redhat.com/
[2]: https://lore.kernel.org/all/20260204111234.GA3031506@noisy.programming.kicks-ass.net/

Regards,
Boqun

Boqun Feng (8):
  preempt: Introduce HARDIRQ_DISABLE_BITS
  preempt: Introduce __preempt_count_{sub, add}_return()
  irq & spin_lock: Add counted interrupt disabling/enabling
  locking: Switch to _irq_{disable,enable}() variants in cleanup guards
  sched: Remove the unused preempt_offset parameter of __cant_sleep()
  sched: Avoid signed comparison of preempt_count() in __cant_migrate()
  preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS
  arm64: sched/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS

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
 include/linux/hardirq.h                       |  43 ++++++-
 include/linux/interrupt_rc.h                  |  65 +++++++++++
 include/linux/kernel.h                        |   4 +-
 include/linux/preempt.h                       |  35 ++++--
 include/linux/spinlock.h                      |  48 +++++---
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
 26 files changed, 544 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/interrupt_rc.h
 create mode 100644 kernel/irq/refcount_interrupt_test.c

-- 
2.50.1 (Apple Git-155)

