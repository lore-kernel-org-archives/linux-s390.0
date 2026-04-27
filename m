Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385A3B27CC;
	Mon, 27 Apr 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281878; cv=none; b=LCwnSBt9CpLvkaQmr28CKlVvwnKkMx3vVIt5YCa/+P+MHOFLW1NiSjXWU+d4kG1QeZ3KMYZFF2rbhKWhNbGQko/rirEElhLVjX+ONNu5PYkJ0m+aDNAu9bss1M0g5wrEBJUeEcPJPu5vYqg+zS2BiTxBK6OAXLLiPw078CB9zxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281878; c=relaxed/simple;
	bh=LlOIaS2qbwbDKSkNzUl6EoUeFODi0sapea3ORJiYiIs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YQyHCeVohGK9PboQOB83CAK1uFRt4CSTM83mP6OT6U6xyg8PH3id7C6jKf3YhFshHSH0XmWNSjt5nzbTUFGbOmKJAp5OHZfJEffSNEBAlVgaOJod6rZGBIdakatHckdMn/PJzCQ/XMvkDK41GqvFcmvZ6B5rjoG/ewiPSBcmieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu7MRKZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu7MRKZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074B5C19425;
	Mon, 27 Apr 2026 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777281878;
	bh=LlOIaS2qbwbDKSkNzUl6EoUeFODi0sapea3ORJiYiIs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pu7MRKZRHeQo4ILlIicC532P4mKNm7SuW3Jj9fn9NLWNlfK7RHyc8KH+M/gsUhoZs
	 PaLC/HIgHJdvodRmZBqGZqqFSpsdeUiE7O0WWzj8sjPMyQ6adArx62CjwIdD1DYuxz
	 n3lioAhIZI/LQZm746OQxnKjqx15kX6vax2ZNBJ+6nPFXBw34OJWBu+twbULieMbAa
	 XZO4rhbFJ3V4BWVE6Cl8LwMBN8F7MK8AkS2Pk9UxLx0yQWWGdMpljTS/7b3Ka3apho
	 wEicfT10ixq6DUZup/SkeLxV5jejywuiKzOWRBOzPSsZ8+xCZymZrP9bRgsLhvOAbu
	 UW+F70bsJ/L4A==
Message-ID: <08ecabe9-0664-4aea-82fb-f9cb1739f762@kernel.org>
Date: Mon, 27 Apr 2026 11:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ryan Roberts <Ryan.Roberts@arm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
 <69c4c12c-7cdc-4a17-9eb7-6fb1a61f9834@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <69c4c12c-7cdc-4a17-9eb7-6fb1a61f9834@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 11:02, David Hildenbrand (Arm) wrote:
> On 4/27/26 07:20, Alexander Gordeev wrote:
>> Convert pgtable direct entry dereferences to the corresponding
>> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
>> reads when no lock is taken.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> ---
>>  mm/page_vma_mapped.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index b38a1d00c971..a4520bb10d2a 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -41,7 +41,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>  	if (!pvmw->pte)
>>  		return false;
>>  
>> -	ptent = ptep_get(pvmw->pte);
>> +	ptent = ptep_get_lockless(pvmw->pte);
>>  
>>  	if (pte_none(ptent)) {
>>  		return false;
>> @@ -219,17 +219,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  restart:
>>  	do {
>>  		pgd = pgd_offset(mm, pvmw->address);
>> -		if (!pgd_present(*pgd)) {
>> +		if (!pgd_present(pgdp_get(pgd))) {
>>  			step_forward(pvmw, PGDIR_SIZE);
>>  			continue;
>>  		}
>>  		p4d = p4d_offset(pgd, pvmw->address);
>> -		if (!p4d_present(*p4d)) {
>> +		if (!p4d_present(p4dp_get(p4d))) {
>>  			step_forward(pvmw, P4D_SIZE);
>>  			continue;
>>  		}
>>  		pud = pud_offset(p4d, pvmw->address);
>> -		if (!pud_present(*pud)) {
>> +		if (!pud_present(pudp_get(pud))) {
>>  			step_forward(pvmw, PUD_SIZE);
>>  			continue;
> 
> Wasn't there a problem with folded page tables, where we would no longer be able
> to optimize out the folded page table accesses?
> 
> I thought we discussed ways to resolve that. Let me dig ...

Here is what I have after the discussion following
https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/.

Completely untested of course:

From b4715d49feb588032c6bb44bd97cf06739b5c99f Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 27 Apr 2026 11:16:21 +0200
Subject: [PATCH] mm: optimize pmdp_get() and friends for folded pagetable
 levels

Using pmdp_get() and friends in common code on a kernel config with
folded page tables is suboptimal: pdmp_get() and friends defaults to a
READ_ONCE(), forcing the compiler to actually read that value even though
it will not actually be used afterwards.

This was recently reported by Christophe Leroy [1].

Once we realize that the output of pdmp_get() on these kernel configs is
entirely ignored, as pmd_present()==1 and pmd_leaf()==0 are just
hard-coded, we can just make it return some dummy value.

pmd_offset() is expected to be called with the pudp afterwards, simply
performing a typecast of the pudp pointer to a pmdp pointer.

Let's introduce a pmd_offset_lockless() that does exactly the same:
perform a typecast.

[1] https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/pgtable-nop4d.h |  8 ++++++++
 include/asm-generic/pgtable-nopmd.h | 19 +++++++++++++++++++
 include/asm-generic/pgtable-nopud.h |  8 ++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd4..cfe87036d61c 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -32,6 +32,14 @@ static inline void pgd_clear(pgd_t *pgd)	{ }
  */
 #define set_pgd(pgdptr, pgdval)	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgdval })
 
+static inline pgd_t pgdp_get(pgd_t *p4dp)
+{
+	pgd_t dummy = { 0 };
+
+	return dummy;
+}
+#define pgdp_get pgdp_get
+
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
 	return (p4d_t *)pgd;
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..e87a42407563 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -43,12 +43,31 @@ static inline void pud_clear(pud_t *pud)	{ }
  */
 #define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
 
+static inline pud_t pudp_get(pud_t *pudp)
+{
+	pud_t dummy = { 0 };
+
+	/*
+	 * Given that pud_present()==1 and pud_leaf==0, page table walking code
+	 * treats this like a page table and calls pmd_offset() /
+	 * pmd_offset_lockless() with pudp, ignoring the returned value.
+	 */
+	return dummy;
+}
+#define pudp_get pudp_get
+
 static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 {
 	return (pmd_t *)pud;
 }
 #define pmd_offset pmd_offset
 
+static inline pmd_t * pmd_offset_lockless(pud_t *pud, puf_t pud, unsigned long address)
+{
+	return (pmd_t *)pud;
+}
+#define pmd_offset_lockless pmd_offset_lockless
+
 #define pmd_val(x)				(pud_val((x).pud))
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff..2cacd9571b2f 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -39,6 +39,14 @@ static inline void p4d_clear(p4d_t *p4d)	{ }
  */
 #define set_p4d(p4dptr, p4dval)	set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
 
+static inline p4d_t p4dp_get(p4d_t *p4dp)
+{
+	p4d_t dummy = { 0 };
+
+	return dummy;
+}
+#define p4dp_get p4dp_get
+
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 {
 	return (pud_t *)p4d;
-- 
2.43.0


-- 
Cheers,

David
