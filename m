Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795692111;
	b=G1aU2oGZqrDLAVnB5fCcgG83+ap5wIhmwIIrNDgeIfK2GWsFkGPGq7ErOiYgd/jAMrLS
	 DAw4FZdWKEWiJsN8JpI2+sqnGkPfnj+matzOq/yRfJoGX+zADC65JiJqKoSquMC/dyMfd
	 2pYdvwtqxUz2FZ+rKKRQC7OIp7mrXtP9Ug4bl0/iNOsQtM7iggmV6GIyZGsj0GX/aRS6d
	 tNW2pXuEiM884Jj6+S/MHbgdOY26Sx9lFh/vYzS4NMW7cyVHzdJjMwNOwWqz63ES7cOMp
	 0LjF0lvpPR3XkBLbQy+KOxToMgReaEAxY06HBi8wUPZWxyqzCd0hbpE8ar8WyYTBHjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692111;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0iJQZ4JiZ/q2z43yM7sOmznlEhFue5dKtH3ZUaEt9EQ=;
	b=fXz4jYlDyccTrK9DTD/4DRcYgyVHQ9yMhYroE8wNKXc++MKqVBWZdN+z8Y0aqkkKqGF5
	 rx/AkSNUOdqqcInx+uJsShG8czDDvYtjN9Td1QsVOGKT9B1aX/l/WVfNz6wEdxLaB7rwK
	 tiGWGKp/IF6DWGoW+WmQ6c1M4zrW0ac3v/Uy04MW+67Y3abPDJre5sENTfPi+bHcPExHK
	 6vWFnXrkM9YGE74sKcpbyCQovt1PNT3NynaqUXT6MK2AX2PCkTXuXWZKVlVq35KivOSms
	 opIbHhtZJFjWFZR5bNEPJqu996sSl3zatljeBW009FP2rCmfZ7yTdkZD0bnijHXCclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dx43PY55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FF606A31E;
	Thu, 26 Nov 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dx43PY55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016FA1F00A01;
	Thu, 26 Nov 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692111;
	bh=0iJQZ4JiZ/q2z43yM7sOmznlEhFue5dKtH3ZUaEt9EQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dx43PY55rPzSGwZLE10j3vMNvaChqjvukI+hPnb8O51peEgCTLD7xqLTbXfhZ4QnH
	 7pS+CZwsAXWfxbp/4JWBDp9do/VBawZXTV3ccWCbpuxUm3w6GIXCKgzhyOTodD89yQ
	 ebb1YIe3iMbTjMMO/txFQf9GfMmJqyzqek8CWJtoABUH/UGA97XeGs0zu1baThNVfB
	 qDDME3ZyjhYMlfHBuGiRumtfOFkh2Ov+xT0sD1dGDygGZA0oxdLDYurcRO0mTEOe5u
	 Z6FZ9HTm6ofPbgw7bA+4BeT2anx67vEy634jk1w4kSn7Xl1XzAFdMJa49y6aHSgZNL
	 iNMGCJcVGRqGA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:59 +0200
Subject: [PATCH RFC v2 46/54] s390: remove set_memory_rwnx()
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-46-723f1e33c3d8@kernel.org>
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

set_memory_rwnx() has no users since commit 33bd8d153c33 ("s390: Keep
inittext section writable").

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/include/asm/set_memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index e3562bf0c1aa..23987b721ed9 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -57,7 +57,6 @@ __SET_MEMORY_FUNC(set_memory_rw, SET_MEMORY_RW)
 __SET_MEMORY_FUNC(set_memory_nx, SET_MEMORY_NX)
 __SET_MEMORY_FUNC(set_memory_x, SET_MEMORY_X)
 __SET_MEMORY_FUNC(set_memory_rox, SET_MEMORY_RO | SET_MEMORY_X)
-__SET_MEMORY_FUNC(set_memory_rwnx, SET_MEMORY_RW | SET_MEMORY_NX)
 __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);

-- 
2.53.0

