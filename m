Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2932E6BD;
	Fri,  8 May 2026 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214084; cv=none; b=KvfoFsw8f9Ahi6KmB13c/1XfoSG/063TIATM5t3WWzb7SO5BGyMPq3aAF8CaheJkkWeOPc/DavQwqYgYWQnRcgWz0wEzOh30tB7VFUJ/VY0fYFZr2zVPk4ivdI78K17d/RKSjL1BdCQMFqyh/y7PzTZOoXyILRgBDn8lVGAT1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214084; c=relaxed/simple;
	bh=YaVjrXKhfpqvIJygzREE5zKBOLGP3K/KF1IwfTEAxVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ5IDcJqUhxX0L5lH8+z7rClT57WXiTjjpxqHQ49kZAm72ZAcY331FWeY8gW2NzLDPg5xezFGIn8zrHgvCVBcB/rOiXnqazpOGcNK4S0begEqktXw78WKREMEvNehEEvS7J2699NbYdvYlP9Yy7spNa4NEORhnQVxBmONi9o4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nShIt0pN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nShIt0pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4ECC2BCF4;
	Fri,  8 May 2026 04:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214084;
	bh=YaVjrXKhfpqvIJygzREE5zKBOLGP3K/KF1IwfTEAxVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nShIt0pN9p7AUaSFwwuyd4jn6+Tgs+Ui/0NP945QtXIOqRkPjQBJI+LGVQzZ48M1B
	 WxqJ3G4jun1wj/n+favIV2BtHC8yJ2h/9B5f71Tmon+Z9lGmMa+Ic0BgzWr+S0qDXk
	 BKd6soK/56xk5OskypX+qrhRUNB7MElBWivzKA0KcMPQ7s5v/oIN4+sxIi5zzpehja
	 l9PQtXv86hz5QbzPV1h28xRTxNXan7FJJA0DCsQ7Hg/4g+6ND9+EPMbyhP+n8EsJ4l
	 snlfRO5oUoarTe2D3e+vw9qPm+XL9474MZff9KwEjX6Vd/K7x3HyfGIcsEqScYDNab
	 Y5ANqAydABuIQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6FA90F40076;
	Fri,  8 May 2026 00:21:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 00:21:22 -0400
X-ME-Sender: <xms:wmT9aV9s4znCPFThYOgEZ_Bk-sZ77vd4Y8dzSHDF-A-kjKTYDeEnjw>
    <xme:wmT9acWejt5GWptNU2we2pVN-EGxBZK1KmS51uRSWWFlMxRUy3SyNy4IeICMhgSEG
    uBZu0wqhO58m2SA2-TZH2soTEHzkOXSiOFlx8vFQ3CUYxSlja0>
X-ME-Received: <xmr:wmT9aX9dT1JtKxSGkVFXw3CwKmAZ8xC9K1OnIuCR9sdoEvrNJFQma7XztzuqZCi6u40cX7EVDkDa_Cu9TMB8mYxHdRpn8VBm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekieffgeevhefgudffveffheettdfgkeeilefhhfduhedugedvhedtteegvdeugfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghsse
    hsohhuthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghn
    shhsohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:wmT9acY2Th8m0jQ-L6wSWLD8iWdI3z6W5l0-qkTXmF62zGgveTZizQ>
    <xmx:wmT9aU_LkL_Vy9aG-yPOCtbUktqE0fuJQ11KTFexXmo8EgfaqeeEqA>
    <xmx:wmT9af-ChWNVBERVPVeRd4TAsbR3Wuo4XsyokzMxhZzUIhySqrDK9w>
    <xmx:wmT9aRi9wLxlPfTm46i5G7_OhY_s0bnB7x76Wy7Ur0IYq2pHhWA29g>
    <xmx:wmT9aSEmKaxJh2QziyQ9kckTpiQYT64k80Pr1Tt9ASZ22yhctIHy6poZ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:21 -0400 (EDT)
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
Subject: [PATCH 04/11] openrisc: Include <linux/cpumask.h> in smp.h
Date: Thu,  7 May 2026 21:21:04 -0700
Message-ID: <20260508042111.24358-5-boqun@kernel.org>
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

From: Lyude Paul <lyude@redhat.com>

While OpenRISC currently doesn't fail to build upstream, it appears that
include <asm/smp.h> in the right headers is enough to break that -
primarily because OpenRISC's asm/smp.h header doesn't actually provide any
definition for struct cpumask. Which means the only reason we aren't
failing to build kernel is because we've been lucky enough that every spot
including asm/smp.h already has definitions for struct cpumask pulled in.

This became evident when trying to work on a patch series for adding
ref-counted interrupt enable/disables to the kernel, where introducing a
new interrupt_rc.h header suddenly introduced a build error on OpenRISC:

     In file included from include/linux/interrupt_rc.h:17,
                      from include/linux/spinlock.h:60,
                      from include/linux/mmzone.h:8,
                      from include/linux/gfp.h:7,
                      from include/linux/mm.h:7,
                      from arch/openrisc/include/asm/pgalloc.h:20,
                      from arch/openrisc/include/asm/io.h:18,
                      from include/linux/io.h:12,
                      from drivers/irqchip/irq-ompic.c:61:
     arch/openrisc/include/asm/smp.h:21:59: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        21 | extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
           |                                                           ^~~~~~~
     arch/openrisc/include/asm/smp.h:23:54: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
           |                                                      ^~~~~~~
     drivers/irqchip/irq-ompic.c: In function 'ompic_of_init':
  >> drivers/irqchip/irq-ompic.c:191:28: error: passing argument 1 of
     'set_smp_cross_call' from incompatible pointer type
     [-Werror=incompatible-pointer-types]
       191 |         set_smp_cross_call(ompic_raise_softirq);
           |                            ^~~~~~~~~~~~~~~~~~~
           |                            |
           |                            void (*)(const struct cpumask *, unsigned int)
     arch/openrisc/include/asm/smp.h:23:32: note: expected 'void (*)(const
     struct cpumask *, unsigned int)' but argument is of type 'void
     (*)(const struct cpumask *, unsigned int)'
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));

To fix this, let's take an example from the smp.h headers of other
architectures (x86, hexagon, arm64, probably more): just include
linux/cpumask.h at the top.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-5-lyude@redhat.com
---
 arch/openrisc/include/asm/smp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/smp.h b/arch/openrisc/include/asm/smp.h
index 007296f160ef..84653aaffa96 100644
--- a/arch/openrisc/include/asm/smp.h
+++ b/arch/openrisc/include/asm/smp.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_OPENRISC_SMP_H
 #define __ASM_OPENRISC_SMP_H
 
+#include <linux/cpumask.h>
+
 #include <asm/spr.h>
 #include <asm/spr_defs.h>
 
-- 
2.50.1 (Apple Git-155)

