Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888933B961;
	Fri,  8 May 2026 04:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214093; cv=none; b=NkOWdVCcTGmYFccOc8r775HrCKbtMzUzHcZ4BZ/9brdc5WqlUZAz/+4VjiPULpPMJeGpvLPA/CuUB05PSIYr8cZwDsOjaVJKc6qaE4upimZVtAzdbJ3sugYeWQHd3LOnUu9onqdToumJ1NL+kNT+f+oHgWcbwJOfTUS+0Oz0mO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214093; c=relaxed/simple;
	bh=ZkuDvku83t97+XBYhvWo9Uns8mWKuzVanjRuYZy6FiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEPi61gPEPpyo3sMzL++pwyO7usZw1LHUIOfqCW8y8T6ZUWi1r3E3F3ZhRCf0ZiTHl5fjPPXdFrj3/zBmAMdX8o8GWmMc15cyqziukiZq1zKA0S8yyrqh6Fzu5HIN5i8ni2Jc1SNW7BiAeSF8eZfS1PY3Fry062t8c0KGU4/rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyrpmPBF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyrpmPBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D2C2BCF5;
	Fri,  8 May 2026 04:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214092;
	bh=ZkuDvku83t97+XBYhvWo9Uns8mWKuzVanjRuYZy6FiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cyrpmPBFrjuJv9YyykuztldWzeQVvrkyrmSpKQpKSihkaco1IK7vVkjTvFL7GjHk2
	 PZB1a3SaO7DHd6CHUV3jIMCokRtVNZKiN8oOEl5RKPK8+TTr+GJ5gB9Q9mSwiiB+FX
	 Sf2Nt+24dLe0TqCuAzkRr0NeVLIiJcmwUzMfV6Ryw+riOSQltfB16NBIgEETohPrVP
	 EcWAmC4gdj0+Aruy1aZZNsxPHmkfwUq8ttEungeJOguihW9dovXQKsidVPDOCfGg9J
	 MYDYLx56/E8N2ltMS8Ku1l33pHO8SBiJoiCQqCFe1M+mdDeaQSfaPOQvfTMAhXzYdZ
	 c1faRG6W8N3SA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94622F40078;
	Fri,  8 May 2026 00:21:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 08 May 2026 00:21:30 -0400
X-ME-Sender: <xms:ymT9aTsQ7upm8WjxfX9gtVxzlbAVMkGuzjtpyM11eyh5KbktIpxo5A>
    <xme:ymT9aXELHqZTCbU1khMd0VDRFeDqFwIyXjU8hCRH_2Buh8if_TCM1kSXRwvFXiJSR
    pYcYXm2AqBVkVwm65AnS-4DixbHvu5WvmQknBTugKCWl14Py8G0JEs>
X-ME-Received: <xmr:ymT9absqk3xe6g4opY5yNRUvMXMUrKcRqj3P3ajzTY8nQJzAOGdfVe_zRLHA1NokuxGasHtI5uaDG2rSdSavb-bq9C4-yrRR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtfedugfeivddvfeegjeehleehvdfhhefhffeuleehtdevgfeggefgheduuedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
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
X-ME-Proxy: <xmx:ymT9aVKB4EMmadPOyKLBG2vVfocJwFBqCN7IJaavyQLBdasVlQO0ag>
    <xmx:ymT9aetQ5OHNX_5_JJ_AolAUlYVnQ8JLil2VXsH65h_oPWJX68foRg>
    <xmx:ymT9aWuO736AwF242w8c92jRyidSJuS3Q6bKI-EVP-UpWwzKpDnVZQ>
    <xmx:ymT9aRSiut4apqqXwG5rP13VQ9hQ_KcTL6BSSoG-r1FS3ialInENUA>
    <xmx:ymT9aW0NmkeF_juJjsEjDqWK2t_zCLDfTWhvqAWs29l7OjL28-HOAM4l>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:29 -0400 (EDT)
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
Subject: [PATCH 09/11] sched: Avoid signed comparison of preempt_count() in __cant_migrate()
Date: Thu,  7 May 2026 21:21:09 -0700
Message-ID: <20260508042111.24358-10-boqun@kernel.org>
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

Currently preempt_count() is always a non-negative int on all archs
(PREEMPT_NEED_RESCHED archs will mask out the MSB when return
preempt_count()), hence the checking in __cant_migrate() is in fact just
checking whether preempt_count() is 0 or not. In a future change, we are
going to use all the 32 bits of preempt_count(), which would make
negative int values possible from preempt_count(). Therefore convert the
"> 0" comparison into a zero checking to prepare for the future change.
No functional changes are intended.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75dba7cc09bd..636e6a15f104 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9207,7 +9207,7 @@ void __cant_migrate(const char *file, int line)
 	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
 		return;
 
-	if (preempt_count() > 0)
+	if (preempt_count())
 		return;
 
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-- 
2.50.1 (Apple Git-155)

