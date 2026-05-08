Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF5A33858B
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214096; cv=none; b=OGK4JwLhX80xrf2/DEHSuOA0Ihn0YRrRC9mi4CKhGu/MkBPsWO1MnOBziGwjIqkuXRCbm6w3IlcSakbKDhJW42DwTsBdgQLq3d2qGPDhAKyOo2h7LmR7oSKM0qxuixIpBlrqo5o0eUITTWphaTCVWnU9/VcWMzwg7vs7CQje3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214096; c=relaxed/simple;
	bh=wDMVfUrzPOq3wjVripDr7k5x+efPDSt8Ygrh6gZKILc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtap8DdrgOh+rKQeB4/Vy+Xn/jqJ5rFf0jLijXL0Dfs7o2Cp755L5DyHBdKuS9iYSCsP/kI3qUQuxfN57Q+zMBNJXG0xgR7DhJeswoER7zFzx1QGTMIV71UUqZST8F1po5lKAhz//fDiDhfEdyESYwYrfbi3glEBpLQSF8Yijw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdCosXeE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdCosXeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9693C4AF09;
	Fri,  8 May 2026 04:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214096;
	bh=wDMVfUrzPOq3wjVripDr7k5x+efPDSt8Ygrh6gZKILc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mdCosXeEI1X/yKpxvQPgPh0baQyYgOe3NzTdNFHKMWfxmhRDZkQnHg1ekyigaQ9Z4
	 hU7/m7T2RKIi3XFd/0/k5HfbEn6yYHX0O5wOi1jZbmIc5Zo0z+DA9nbG9vNzLbysMj
	 khnUE2+zbTIxtiguwO+ayqPBiYEwZr++5XgPU0hdnk1krSi1ySpYAr/xXOtmFN6z8l
	 sQ9Wfeoaue4whE+UOg86ThABZZqL70Oh6ur43VLBGLeDccSf8bI0PlQn+Ovj0Zl0NR
	 Gfijec1PETnm09DR5kShWf7GbKfIcSYXbJAO2AeOWdbb1L1x3wAIQj6ZQUJFAc8t0+
	 2ULCZfjKGsC4g==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A436F40078;
	Fri,  8 May 2026 00:21:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 00:21:34 -0400
X-ME-Sender: <xms:zmT9aSGrQG9QL1osn7o6GhHPHK2DznS29VqGQLZ7syhrisHq2HWj7w>
    <xme:zmT9aZNC-thVI3Kdb9_s3BRdTAeko9obivNjYUPmUIoXWECYnESaFjkTDrnvVaE9Y
    irBT9owCH9AFLkHQtVLylGOnU8ZOI0eTPpG63DbbLGADXMZ12PV>
X-ME-Received: <xmr:zmT9aemKqq-8Ilo3Xgfd7GxG8CzELQ6Gq17a0Vj_HMWH7QW3FyqgL2qMNkIlTW3ZTJF8AHgPH41I9zlqhpSGghACGJTiP2Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtfedugfeivddvfeegjeehleehvdfhhefhffeuleehtdevgfeggefgheduuedtteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeehiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmh
    grrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhonhgrshesshhouhhthhhpohhlvgdrshgvpdhrtghpthhtoh
    epshhtvghfrghnrdhkrhhishhtihgrnhhsshhonhesshgruhhnrghlrghhthhirdhfihdp
    rhgtphhtthhopehshhhorhhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehhtggrse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdr
    tghomhdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:zmT9adNAi1puNGlTK3I1K7Adwwmfd8I5HrLT6XPtSHiIDvC-guZahg>
    <xmx:zmT9aYp5e9gluVVCNUXKHroUA2D9EX7FuFHGy5yMWl-hHs3wYTWFLg>
    <xmx:zmT9acNQgsa3yC0PO3wkuk5avc1k85iQqvz1-KozZ5HF6u0sehNwlg>
    <xmx:zmT9aWONMfUtIywH13UPMC-2LPf-yNcobI_hrg41vaAiVf3DRY1Y2Q>
    <xmx:zmT9aawBh6AzYyFSnyQ3uo5dEkq_s_oq6wD7UHQ72qcJeav2sGf8He8D>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:33 -0400 (EDT)
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
	Miguel Ojeda <ojeda@kernel.org>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>,	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org
Subject: [PATCH 11/11] arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT
Date: Thu,  7 May 2026 21:21:11 -0700
Message-ID: <20260508042111.24358-12-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508042111.24358-1-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
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
index fe60738e5943..1ed5173872fc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -248,6 +248,7 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
+	select PREEMPT_COUNT_64BIT
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
-- 
2.50.1 (Apple Git-155)

