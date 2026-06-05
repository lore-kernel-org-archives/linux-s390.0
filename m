Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486E3FE658;
	Fri,  5 Jun 2026 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638117; cv=none; b=pJK4EoMUiiPDQhL04rgF4Hh9zsaYO2Dv/O5t2ZZwSwSmv2fb0Aa5uDgbJSmipEZFGRJB47j89BwIbbJIldcm++Q5IwdS6PG9hA2YBxANYY/fqDpzYehvNnV7OLZON6ROjWnZQdFniQue7hWFLCwJN2jYxost9Ivk/9b0hJOgSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638117; c=relaxed/simple;
	bh=1Z0r1dd+5UaBxiJIV7yyJHPW2au7yP4Ki/behDAnWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng8yY9RsPixLkjkbm7gOgjEW30HrmjI4PUK10tzqaWaEBwVcykAZ+0U13AmUmcnJn37NGkTdUf7fA0EYeCdfrmUgTECn28/VpHPldGfWVb/HU+rrAeIKHvWnEuu0zsBt/Ml8KsLEWxbJQm74Cp63gBTC4Ue7/6KC9L+N3pye1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi/kWcPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi/kWcPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9C41F0089A;
	Fri,  5 Jun 2026 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638115;
	bh=5fQe3JBbW1ecnzj9lOjL0hmTD9Wg7GMvup213RdzMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gi/kWcPBW3EaGbMHej9lPJNdHzD0aaT8t6m94Sjb60a27aJe7SiCne06Jsn+qxN96
	 37Y/n1XbOxEYpKdk49Ahtlzy2PwZ0iIpLwdYfYd8psvWHzyR8CEgchyzJPtRZvHS4r
	 tIrYbyabjXurnV9xC63mXw5P0tsIRx+JcoMvwdpsep7j/w9zRYfFMO4AuLsmq2cgvv
	 nBkwod7gMrEG8isIGul3Ofp7t9ajodlfFo/by06YuEXHLen9VPQtepXJiCal9ygT/G
	 8DlzVulejJ3igmv2NIcyt0Gtxy1ms1LGR2LOgAXAHlh3kiDSpks4jlsEamObzqj9xq
	 E7FpkXeg/8QMg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9C7CF40068;
	Fri,  5 Jun 2026 01:41:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 05 Jun 2026 01:41:52 -0400
X-ME-Sender: <xms:oGEianlN_5rsB1GeTKn6p8es7AKhoEEYWtxLU-mB0Hl5BMwJCG6axg>
    <xme:oGEiaj_gEhoQMawMdeXMc6D9msfX9jUtd-JsByJR3cz5tUJu5KaAwFWC0C9QDVVKo
    W1EqjlJFsP8lh4bJRLcwyoyrOb79KU1DF-oaP01O9sAX4pcU5rIVg>
X-ME-Received: <xmr:oGEiamiHuv84r2AaGggsNvomEYPG4qG4kbH0jRaO3Is7p084U0ZMDKjg49Y>
X-ME-Proxy-Cause: dmFkZTFG0WJa+84B5ZLakFCJusLrHx60u/M2e4tgb8vvSWGQWHXMFZeKktHow9VrFaQhwL
    60vkPLe/GHUXrF9uQjn9EtWhYCiYebO343SXKkauObGNd0gaHEDMGyAUdMEWI3xvV5+MXM
    Y5XIGIH+RCj/YpjPsc3XHQUzqyjdf8JDGbXE7uRDsVlh2adsQWoVoEG+11Li6tmpxBjo+n
    GbGHXxcMsG5BC+v/PWXz65OFiJmnJTn18gjrdwmPsAQA0I/XEj3HJhBv36WGSvCgORqSG4
    pkDfFOinWXk05Px2n3ZYSDFusuNrnah7Cqk2jZsViR99U7a3ccatK3SGLf/zDxH9xSS8rM
    AOeG5ePFZZfA76kOVqoCfj7btvpGgV7BkafEpMDLqRqYQteE3BP+Zkc3tGEg6HKAx5ebSG
    +mfyKbfml1bRlYZdW9QkLLsmbzmqf4KpTRUTEWVFfODasljVxHQMv5gX9K8gy1vxzFXTaU
    cZCZZhuI5rcfutz0yazglWB3rJwiDthh8IdApnGVTsXOrx3v5UsJw77FXSlh9Kv42p15JE
    WawlWP7bZ34qpayMprYpdDmWSqEzyCJKbCu+zWYZNgKoMIsVhnPsVU7hmpSe6Ah/EF1PrW
    mwcS+qw7SgGtRJaM1gozqo5XbhQOYZn73l24WeQ/UR8UYb5mg5SORHHlOdLw
X-ME-Proxy: <xmx:oGEiaiMLDgx_zc02cCydtWl7WMYUSSLaYNW5slQEuBbWP3YaQzrk-g>
    <xmx:oGEiatOKVnKiuxjAhXwiQQ6XEs_Zvx8GEQkgHnfsbqev8tQaH29gkg>
    <xmx:oGEiavhrrjEwhs_FJU3DtSmkKAy5Lal6sw0JPtn9b1MxdwHKa89OzQ>
    <xmx:oGEiagVqmNKa6epK2ezpJDG0mPMWS6bDFcgGpXuHWOKRwKrNQVX1kw>
    <xmx:oGEiapcxNGDbEAt0F2WpSoI8ywrFTOxZe7EyJ0w7eM88nQxH9B5MnxO7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:51 -0400 (EDT)
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
Subject: [PATCH v3 11/13] arm64: sched/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
Date: Thu,  4 Jun 2026 22:41:26 -0700
Message-ID: <20260605054128.5925-12-boqun@kernel.org>
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
2.51.0

