Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691751;
	b=bg1PpYtoYS7L9v+t1U/EPeURYJHP81CI8WPcfq4ZQjRdQvlgTuRNfHlRS9eJDh3HU9gU
	 fjbM2QkWW8Pday0YezJiK0fnf8w999X5Idod9btSQwIaSiH1UG4y5oXHxFZvafpFdSFlF
	 oPt6XTgiCnIxe+dw8YLmOTDGdjW6VpZlxpv1uM+c9HjodVrPtU6Qp8Un2G9n4g84VhbnO
	 VhXiOCezYLi8+HrsViWc49rH0QHYJeFb5vcOlt5/F3L+Jvh+2gm9peAg57kz1jzBukkOQ
	 aH/iyt1UU/GDKgMTkF48t7iFJl5E+bZytLAns3H/fYOe1um+9rGnyYjCn/ncSQph9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691751;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=h6atE1eiwuCb7s2iVfEQ/DOpR2uoMH4CREq7+ID+nSU=;
	b=24KLY5ei0MBFwCbrVNPko2FLKV9vuTXyX/Eo7YM/iq10KQu00I5PIx8ZaZhx9cD9efvw
	 SGkz7yvf1p+OqdKuh7sa4/nfHTfpg+EjbmK8PgAn36lkjwLzRIkaaeQMPVlm9+FwsDmYO
	 UG2DvDIsxWekuSqJ5WiV2ec1r2K5IeE/QEblpDM25U3+/ci61Wg/dTrNrFO91mYefoNzx
	 ZvRQr3GBBOsHZhM4Oto6/C6J+T7fjVGku+1isnAMSBvUJrmIb93CihjVV1YGcZjsfumoR
	 Qxc2Nx/VFrHEJ9eZl/JcMUxXO/YABLBWh53V/L+4VGnaUK0FyPIo8ZNeEKvLWwBWsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhZQrkbz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C447606A31E;
	Thu, 26 Nov 2026 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhZQrkbz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D505E1F000EC;
	Thu, 26 Nov 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691750;
	bh=h6atE1eiwuCb7s2iVfEQ/DOpR2uoMH4CREq7+ID+nSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FhZQrkbz9fLLnez5g+K/QukESaIZIWw4BT9B08hF5j5QN2u6tKoJzJ/Yb/7cnqB06
	 xmLy3Wcd/+Voi2G+cmzi7XjISmA4zNa9ThOqO0aFQw+C5bMuBQj1Lk6itrFCWHRYPP
	 Jka7N3AyNFtHwsawLaetbg6iFvshEsmLB1RYhXPtDlqBqvtLqZEYicW5T9i7jVez//
	 Ax6uVcl6ftm7I1WlpQ0rhuZRHvzUYiXOnWeMhJuREHnMcCgscaqFCcPFebtk3I2of/
	 JYgnQXacJLJciJaZNGT+pTjMR4p1+op/86rB8u49OUkdSz7jnoVEY2tWzEh+RXgIaH
	 6eNcuB/DKwnaA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:21 +0200
Subject: [PATCH RFC v2 08/54] x86/mm/pat: fail a split at an unexpected
 level with -EINVAL
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-8-723f1e33c3d8@kernel.org>
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

__split_large_page() returns 1 when it encounters an unexpected level, or
when another CPU split the large page first.

split_large_page() frees the page table and returns 0 in both cases, and
__change_page_attr() looks the address up and tries again. For an
unexpected level it tries forever.

Getting there would be a bug, because no mappings ever use P4D leaves.
Still, a level CPA cannot split should fail the request rather than loop.

Return -EINVAL for an unexpected level and pass it up to the caller.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index db41f94f2355..217c739371ee 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1178,7 +1178,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		break;
 
 	default:
-		return 1;
+		return -EINVAL;
 	}
 
 	ref_prot = pgprot_clear_protnone_bits(ref_prot);
@@ -1230,6 +1230,7 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
 	pte_t *pte;
+	int ret;
 
 	spin_unlock(&cpa_lock);
 	if (cpa->init_mm_read_locked)
@@ -1241,8 +1242,11 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 	if (!pte)
 		return -ENOMEM;
 
-	if (__split_large_page(cpa, kpte, address, pte))
+	ret = __split_large_page(cpa, kpte, address, pte);
+	if (ret)
 		pte_free_kernel(&init_mm, pte);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }

-- 
2.53.0

