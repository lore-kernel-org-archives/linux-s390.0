Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691978;
	b=X+zj1KU8Sp8WbjmfgQTfGcMrYKShgTqaYHaRw28S3iiXh5pToSyKXbfIOqwXDTmEZ3Bc
	 JkGGS9OZZ2C+671S/n5Tq1eAXfBgGnF6cAZ3yMtp77btNxZq9cB+HX3/YGtIHFDc+E/jZ
	 Gb27JimceYVtztzE8ov8JGNmt75tTO/brrTfmbBaximfXvitMs2lPQMEOLQeoAGUm8wY/
	 uPRzXBrnBxS53iiJs1sBZa5cVg8N6epani/PkGHx80zUsDaTA/3PDATCJ5NuldAQMtDxl
	 vhcU0swhNVUCRmVUW/9Ru28O5vBt8Fv34lNl5lkYDTlDwLffJX2nOrFyNdCQporGiiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691978;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=6IUAESVFtsidcpD6OicOHeScwyTIg4rQEjzbtezfzqA=;
	b=zMT0ZB2iZ/4DJIS4r0mUp8gjA9PcLLQFy27CH7BskJvR86w+f8Sc+Nk2mtj8cLR870us
	 Ft/jgnz16H1qjYU40PnpTasOJb30FJNqJY/4FCFeAEujTYU/HH5KZbVBWvU//Mjb5zNFn
	 3cDj7Be5Fh5/d2tzBguZ/OBx67a4A104j0d/9N5MX3WRaceEfWrxtBNVfgBR5VFp9B6s5
	 RzH9PLD8GRtRDzrz/XjChZ9uDDLvXF6DkTy32vUm8PsfNe1HXixEnP6BKs4TRyWbIs5Qn
	 kmKZWlSWiT0pk7kykXeOuHelKVwPmxX3eZk28EwU0BrvTWqh6sv85YrCbmt+cl8bQRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzgtvDcA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11F606A321;
	Thu, 26 Nov 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzgtvDcA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D211F00A03;
	Thu, 26 Nov 2026 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691977;
	bh=6IUAESVFtsidcpD6OicOHeScwyTIg4rQEjzbtezfzqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PzgtvDcA4yy/D2Uepj3A4ekmgkoMVvK8vCHb6UdANFhGAR3OBnrXkvAS3r9CqvP2I
	 eDmwCIrTD3P98wMkVnY3W85BeGo+ZeBhcoHLlCd12HdFjujk8Zaf5uhR8BV51AOM9P
	 oW6Xtzx0AUymGG49kFi+8vJRbIFAGKIoVzVQwMCXSTZexmCClqXB7irUaJOvnH7AT5
	 H8yglHbC98pbN4quyuAGcNaw3RNs1KOwrdkUjWO3r1r/5ZIYpv9vJVR16CKt6bfdWC
	 KH8ca4HCAeD7eXntGrPQqRIQieHY1E0JUb0HMs7NmNLeElY0r6qD2n6VSHz7fdgu6N
	 3KyI5zsbNkYeQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:45 +0200
Subject: [PATCH RFC v2 32/54] asm-generic: add an empty pageattr.h
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-32-723f1e33c3d8@kernel.org>
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

linux/pageattr.h includes asm/pageattr.h for the overrides of the CPA
hooks. An architecture that is fine with all the defaults has nothing to
put there.

Add an empty asm-generic/pageattr.h and make it mandatory, so that such an
architecture does not need an empty header of its own.

LoongArch, ARM and powerpc will pick up the asm-generic/pageattr.h when
they switch to the CPA core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/asm-generic/Kbuild     | 1 +
 include/asm-generic/pageattr.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6ea..fd9fb2c3260b 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -42,6 +42,7 @@ mandatory-y += mmu_context.h
 mandatory-y += module.h
 mandatory-y += module.lds.h
 mandatory-y += msi.h
+mandatory-y += pageattr.h
 mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += percpu_types.h
diff --git a/include/asm-generic/pageattr.h b/include/asm-generic/pageattr.h
new file mode 100644
index 000000000000..07bf3b0e84a0
--- /dev/null
+++ b/include/asm-generic/pageattr.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_PAGEATTR_H
+#define __ASM_GENERIC_PAGEATTR_H
+
+#endif /* __ASM_GENERIC_PAGEATTR_H */

-- 
2.53.0

