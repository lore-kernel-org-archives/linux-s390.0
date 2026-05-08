Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA017274FDF;
	Fri,  8 May 2026 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214078; cv=none; b=kmGKVm9R6zdd+Clg/sFlYkelZkncczA/M3+bQJqKFoxcNJjR6xa1DCtknYhGD/zOVnhX7DzZkyWKbyCKmANK3UbT+X2SDSfcwlKKcnITWp0YNnA7pDCWQjYrhcvyqLAnWBiCIsV3aJH0RVbH72szRsNm7lEY3sjlHa05DAJ2qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214078; c=relaxed/simple;
	bh=nEtlYvKMNq0QtGXWVG1xywkm2//4BsKX5ldIrGo2JS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiNJ6PF79kXn2UkYSWKWnFYcyjMlKZrophdK7uZFZeWfKlGP41PXWGVxaontnsc3CLtP8BLSE4EQFRH5UgfATilcD6YeBQe5BfOAFF+Qo5yhDcRFgt2dS8mxEl9ye/dOmxX6crRlGB5xxClNvnbIKOkqPmuGArV7keBc79byeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3m3+eVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3m3+eVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A0C2BCC9;
	Fri,  8 May 2026 04:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214078;
	bh=nEtlYvKMNq0QtGXWVG1xywkm2//4BsKX5ldIrGo2JS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3m3+eVfEfB0EJkyDk68ysHqJ95fgB6bAxFeSY8zdsa2cuUo0r7wLHhfZqKKS/LtR
	 7vqaY0hFPClVQRyY5aa+ERAociSuV3DWZZEo3PC22kdkSneUo12NfBKvSRg1KOEa+5
	 rNngVHtPGyt/sQNOchXlfwPw/8wBk6zCGUHkrV2jfYWYW2T6y6hR7CSfgAeFS50ktv
	 mjUalRD1DHmQOrPpZq6fg0Fjh+BggDkRHR9011dlMdlJ1RHc9d2h8wUZ+W8ZEXXR4n
	 K4WHK2MIOMDP21gyRNFqp6/N9jf1JoiStLj1tklIat+FNzJ7+BtIiphD2UeDCxwUNN
	 OBvgUHRdABneg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6AC29F40078;
	Fri,  8 May 2026 00:21:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 08 May 2026 00:21:16 -0400
X-ME-Sender: <xms:vGT9aX8X2buV0-qEzIA5eyNEr3drol3Vyv40H9wYab5zEEF2O0VDBA>
    <xme:vGT9aa0hPP_6iKwDxW0nVHOJHrkavtYtNgKf9g5xPlOiMETWNBrjsvEHWRqOTSRSI
    mX-wJkrzL6ao5HBCsG7bTP5HxcYVlxER_vvSEjPhra1hUSbo9I>
X-ME-Received: <xmr:vGT9aXWb74et3nTUQ7jkNHV5ns5FQzv_FzLyPaeZT5prT-r9bObLZ8d_JluTKc4eO29Gj9RDco_kBrbvCAO2FMan8xwSzGbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekieffgeevhefgudffveffheettdfgkeeilefhhfduhedugedvhedtteegvdeugfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghsse
    hsohhuthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghn
    shhsohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:vGT9acPxzYUaPybao-a2Kyf-AQbadZpiTjfmPOc3ByxWTPNNcC8ERw>
    <xmx:vGT9afIPpOjvgRjymn39JHDK35hC6Yqp3TILIUKigGoKR6HzmPYpVw>
    <xmx:vGT9aWLs5H2qJC3QQ8Nh1GN_kNqAGr0XGCUgUG7hkZRSkdxEopP_-Q>
    <xmx:vGT9aTW0NAnQkMA1cj3UuYJTeIDMRs1EeB0-fxXo-WXOFQW3ysVtgg>
    <xmx:vGT9aXHj-56wKgzUL-P81V0Z4wIZzSMhP0n46A3rweQoQ-gz-jm4FBWw>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:15 -0400 (EDT)
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
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 01/11] preempt: Introduce HARDIRQ_DISABLE_BITS
Date: Thu,  7 May 2026 21:21:01 -0700
Message-ID: <20260508042111.24358-2-boqun@kernel.org>
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

From: Boqun Feng <boqun.feng@gmail.com>

In order to support preempt_disable()-like interrupt disabling, that is,
using part of preempt_count() to track interrupt disabling nested level,
change the preempt_count() layout to contain 8-bit HARDIRQ_DISABLE
count.

Note that HARDIRQ_BITS and NMI_BITS are reduced by 1 because of this,
and it changes the maximum of their (hardirq and nmi) nesting level.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-2-lyude@redhat.com
---
 include/linux/preempt.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d964f965c8ff..f07e7f37f3ca 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,6 +17,7 @@
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-23 are the hardirq disable count (max # of hardirq disable: 256)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -26,29 +27,34 @@
  *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
- *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00f00000
+ * HARDIRQ_DISABLE_MASK:	0x00ff0000
+ *         HARDIRQ_MASK:	0x07000000
+ *             NMI_MASK:	0x38000000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
-#define HARDIRQ_BITS	4
-#define NMI_BITS	4
+#define HARDIRQ_DISABLE_BITS	8
+#define HARDIRQ_BITS	3
+#define NMI_BITS	3
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_DISABLE_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_SHIFT	(HARDIRQ_DISABLE_SHIFT + HARDIRQ_DISABLE_BITS)
 #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_DISABLE_MASK	(__IRQ_MASK(HARDIRQ_DISABLE_BITS) << HARDIRQ_DISABLE_SHIFT)
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
 
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_DISABLE_OFFSET	(1UL << HARDIRQ_DISABLE_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 #define NMI_OFFSET	(1UL << NMI_SHIFT)
 
-- 
2.50.1 (Apple Git-155)

