Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691959;
	b=en2k61Tzz9CNcqRR3URGeO0l9sd7TbV/QYSHCOH2nTrcamR2XQe/7zUWc21ajHpufrbi
	 Z6InFsEpCQfIGfHV9baO0CMYUUMY6Dejpp2dEl7/K7+BpTqEXlHCYiic2XS7mReLYD+yu
	 O7oEKKBNiQOrUM8owKYcK8QcIN/erZH33CTbM/Pa+Lbq4yDw4At8CLkk+HdEQzKGAnsWK
	 gr7q0fcNPDYGGnjS98jlIcnCZN0+qkhdrOy3enZDjo9lG7lSyB+6WdWc/ZdJStZK+HPkw
	 XYT75IW3exICT22XXcv0FD3zZZ9rb6SYgzuyXNSBSWTtG39JYavaj+f+5vfno2M9+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691959;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=iLAnEU4rO4fcnrHELtjeHX6slJhEFWQGHKKApZ60Fc4=;
	b=4HarAPpcpzqbR+hL8ifDQ87wTP0HV8rnHq5zhOaFoQZZmdNHaFCExxrV7z7YoDB/9rGe
	 r7qoS3ffE+R7Hqxy5pZJuQEWdt3hALwjqfaU6jK1IPuBn0VAfmXx/Nx095u7RfIh2Nm9R
	 eno7yj5MFf3Dt8TQS+R1X+0kehYm05pjdbUZZLOwIPljSgPZoYPICZ+P8nSEPL+wSHDhj
	 lAcIrItLdqh0syZCyCJ0y1eEj7KGqUNLWhJWbm8oBZJvQHMIy+LE704AkO6Ca6OGEw19N
	 80U1WDxDLl5u7DH53/p7B2pSlFBD6zT+MuSFfGdy4r1nTnDeISSM0kV10OWN+j3aDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNsQFQQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF5606A31C;
	Thu, 26 Nov 2026 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNsQFQQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D71F000E1;
	Thu, 26 Nov 2026 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691959;
	bh=iLAnEU4rO4fcnrHELtjeHX6slJhEFWQGHKKApZ60Fc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aNsQFQQzIyU0oDJ6kE0wDY/5N+D85rsC9dcGR3vVr338d3zGkmN0dsXGVVuSFEAV8
	 oTEYZLgMqucU1Fu7hhNNp/yLJzWYpeHiF/7r8JvCBa8kZDoKstZEw4H7kbnI8aQh6D
	 9CGAgzkzR1AfUB4pvPo49Bt8QOYpoZYaq4xYpvAR4p1L/0Cl24BbGBQoGwoU63qyx1
	 qwE75UrJ6O6rFWOFt+DxjdIIVM//Pf5zleYvK1o/QM84bMS+qpeAgXizRKQL+2xJOH
	 KyRei3fbOJDs84xcMc7o5ASUM5N6XBvC9Wqd9KXD76MdAopEEzyl/DShKPBPkL6klm
	 xsi3RfrDsbWdg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:43 +0200
Subject: [PATCH RFC v2 30/54] mm/pageattr: introduce arch_cpa_can_split()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-30-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

Currently CPA core presumes that the split of a large mapping is always
possible. After deciding to split a large mapping, core drops the locks,
allocates a new page table and calls arch_cpa_split_leaf().

If an architecture does not support splitting large mappings, the only way
for it to inform the core is to fail arch_cpa_split_leaf().

arch_cpa_split_leaf() only updates the page tables, and normally shouldn't
fail. A failure there means something went terribly wrong, so having it
check if splits are supported at all would mix capability and corner case
checks.

Besides, if an architecture does not support splitting, the locks and
allocation dance would be there for nothing.

Add arch_cpa_can_split() and fail a request that needs a split the
architecture cannot do before the allocation, with a warning.

By default an architecture cannot split large mappings.

An architecture that can split must override both arch_cpa_can_split() and
arch_cpa_split_leaf().

Since x86 can split all large mappings, hardwire its override of
arch_cpa_can_split() to true.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/include/asm/pageattr.h | 7 ++++++-
 include/linux/pageattr.h        | 8 +++++++-
 mm/pageattr.c                   | 3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pageattr.h b/arch/x86/include/asm/pageattr.h
index dea7141c3713..8a3e2a35211d 100644
--- a/arch/x86/include/asm/pageattr.h
+++ b/arch/x86/include/asm/pageattr.h
@@ -14,7 +14,12 @@ pgprot_t arch_cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf);
 
 int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
 			void *table);
-#define arch_cpa_split_leaf arch_cpa_split_leaf
+static inline bool arch_cpa_can_split(struct cpa_data *cpa,
+				      struct cpa_leaf *leaf)
+{
+	return true;
+}
+#define arch_cpa_can_split arch_cpa_can_split
 
 int arch_cpa_process_fault(struct cpa_data *cpa);
 #define arch_cpa_process_fault arch_cpa_process_fault
diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
index f8b6b17e0b0b..25f04e61ee85 100644
--- a/include/linux/pageattr.h
+++ b/include/linux/pageattr.h
@@ -96,7 +96,13 @@ static inline pgprot_t arch_cpa_new_prot(struct cpa_data *cpa,
 }
 #endif
 
-#ifndef arch_cpa_split_leaf
+#ifndef arch_cpa_can_split
+static inline bool arch_cpa_can_split(struct cpa_data *cpa,
+				      struct cpa_leaf *leaf)
+{
+	return false;
+}
+
 static inline int arch_cpa_split_leaf(struct cpa_data *cpa,
 				      struct cpa_leaf *leaf, void *table)
 {
diff --git a/mm/pageattr.c b/mm/pageattr.c
index 6fb89632b679..dcece32ebad2 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -421,6 +421,9 @@ static int __change_page_attr(struct cpa_data *cpa)
 	/*
 	 * We have to split the large page:
 	 */
+	if (WARN_ON_ONCE(!arch_cpa_can_split(cpa, &leaf)))
+		return -EINVAL;
+
 	ret = split_large_page(cpa, &leaf);
 	if (!ret)
 		goto repeat;

-- 
2.53.0

