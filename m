Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25016363084;
	Tue, 26 May 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808943; cv=none; b=PHCk7sk+pyOON0kL1/N2depeU358PayovNQm4Mb4JlgBvvKUfb3qRTLGdEN5N0G1B1DVgpbpCeY1GIP2tVe81kb+S/pxClogKMowSsLLeWCKxmDMlLbrr9tu2UhCEFx7TrpQrYIUNKB+Nskoc994ldXlNTJTZEj6qFIxUrQbmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808943; c=relaxed/simple;
	bh=Z82SRTfViDGMogbdljsdRjgJQzLo4HNgFr7e4VKosb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBctrkf9Amw3a0ZXjWnaaB8N4wAySsA+08TDEwv9LlGeKlTNEZ9/3+f6aaoqRZo7si02zaZrBaDJImHdrAd+BXrxG63g1J7CyCCdJcsbGMuhkxTbrlnrjxTx5CDjA5OvEYOQotCpz6wXFb3Gs8BNHvf+eR2iIULiem7xBWmEJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKz0/w7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKz0/w7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800A61F00ADE;
	Tue, 26 May 2026 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808941;
	bh=v42NgC0fdcn56Nn20BKSdfY3OACyeZqMYj+lGiSubwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKz0/w7K1qylS5jNvyCmz1m7auRHdjWi6yDCyDiZuKJD3ICpbwm8U4N1Gr/pxcNiC
	 AAiCE7KP6Vo50untPL/Gg4ZAA2Qns6mba0Tn51aM8i3ff5dPC14ivbyPliRTuFpXn9
	 bYHPU/SgNHpdx7b1Qqe4mwxUYMY8ttpnvwsP5nowEPozzBb/t6kKQ8FeiZXGywlImq
	 3Kdq3RZlLwXEB6/SXZFkHgzdO/tf/bjb+q1d5c9VlK3NbD+R9zBCFEqyFfLMWSRMgs
	 HKVxMM/l1yKPbulztHMYorzhFvQVhBYGUJwUUaqmYlioCpZic7ejlYboRYihj5r/xg
	 pwGrM34B7pgYQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id ABCF7F40088;
	Tue, 26 May 2026 11:22:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 11:22:19 -0400
X-ME-Sender: <xms:q7oVauMbRKNIcX0buzYVFJuTvXI9SkBq-xdFlaGdjs37_H7M2keGOg>
    <xme:q7oVah1hxPf5Dza9y-hrZnlIIqvzC7EovsT2RD-HXRZTwikP8QLisRToVsdwwXkMO
    whTpQk-UWFPnCHszsuiAE6FHvTfrm2CXRgRniq5mU_YamvXDjycBQ>
X-ME-Received: <xmr:q7oVarL9QhokwshDQoNQ_fcm6RNTgsRzyKCwLd2R6uiOPl7_Uy7o_oNsAo49SZm59IT00mUhhOoTPOhUu-Mk1WftJoZVTabC>
X-ME-Proxy-Cause: dmFkZTFpmA1McbnqjIdDoCcC8/dKh9RDeYcaA/XB6dgQZoHsdisS7Rnte/RUY2pDCqsaCf
    lYH/GXfkGRmzTYnB4S+g0DoIzy4KUSXH1v1hqWsXA4v5WIAvvT6c8zNgUsod23Kpq2+47O
    yYMzbMVdimQJPpKCDvwUMQiSwLgkBGzQ1ckebHI5CwcU5PXtm0paPap1/zDmdG+vWcQc/M
    pmWI2idDed0xMRSQV9XOsN/PBFcH6SBYELvyO/AtrMtpHg8r71AQlMzDlEp1H1iVazK3oS
    DonyrliF9qRbQD87XBn6QOt2bC/09pqeijaNsBJFU0GwQ/sar+bEYdVoRVtkXuEiBwHIVJ
    +vPnz7YRz2gRtfvdleAquLDzEvrynvx94NYhsHKQkHBAYDBJmTuhALx1WmJ0oQVkmj5ABW
    UtUh4XZureKmq68D7B+MJ1NE+qtTkPqUsgs7UFLReMFU7Uth479W+ocM97I1qfPl/F1LhS
    qloIyRSVZETQHrb0OqeC+IKcktI/o29cw0IsNSiQA6VV8Q0gO+9Yi7oaA9mx+x7RScD0EK
    0KiuLh09SFrpIterdpQufJFc6lDZrOnzg5g5/cHE5HDzrM4BqcRXMrbhIbyKelQv1rW4s+
    QKJKBJTXjKVO4MrZ1Qe0AuVk6j53/jm5tPzZ4bafWuOsGC/UB6YsUeyJ+meA
X-ME-Proxy: <xmx:q7oVahK3KF5rWO6Cxodzim136HwCpZJjxX58mkb-XD9rdEgP_0j0SA>
    <xmx:q7oVash1nM2frd15FRj_8EsBQrqJQyJ1RylNmYxmJ4KhM7tMGH6yGQ>
    <xmx:q7oVasRCqeNDM6F5Ccx-wb9wa0so2a0ldZLv0GodRTpcLAYH-b7HDA>
    <xmx:q7oVajlKHbKt_A_5HNJUPCnJz2wsFaqlkeJJgX-eumGpKZRPJfhxpQ>
    <xmx:q7oVamZYFQ40bG-EvVA7dVNWDf9FKnmOta6BN2NC1WrtUWiuZckwXLmX>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:18 -0400 (EDT)
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
Subject: [PATCH v2 11/12] arm64: sched/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
Date: Tue, 26 May 2026 08:21:47 -0700
Message-ID: <20260526152148.30514-12-boqun@kernel.org>
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

ARM64 already uses 64bit preempt count and the need reschedule bit is
maintained in a separate 32bit than the preempt count. Therefore preempt
count has enough bits to represent 16 level of NMI nesting, hence enable
it for ARM64. This saves a per-CPU variable and additional instructions
in the NMI path.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..8178cb857115 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -248,6 +248,7 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
+	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
-- 
2.50.1 (Apple Git-155)

