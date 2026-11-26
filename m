Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691704;
	b=g2MK0RMkfGZe7zBOZDbF4KZg4c6Y4OwUhcFP7SuPuYbnjiYS9WZ9FYmYQ6uX1Oru6syg
	 3cfYKKy5U1v7H0dhhQqzTdggkIMuublHtSfNjIXEQAdDnh1RjQ7ENW9CcY+WjjBLzIRa5
	 tQJEf9niQm9WBFXJzOo4buUbkTzulHL4sZelTsVgOor5zehJ4DkkEHrZhxuC6d4saryfG
	 iP4tyoF0RdIB8Q1/814FCroXjQjrNvNSa4Kj21NuQwU2YZQJ+WfStshRDo8bw3ixT05f3
	 EDDH11uzLeTO+u2LdamtkTlwaMh2nAZI8aQz0gHtyJO9/yPhDwQGYP+jE1xLWBOXv0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691704;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=bj8/4t1D3486bMWuOXwhLcAKxLKyES2zSNh6vuKXpeY=;
	b=nFGkTjTM9HZDWEFUo9WRyXKvii1PE9c/19iwXACJrx3UWaV0/RdVzJjsZFIqNIVQR95w
	 gsEg6YK7lgnWNedRePWpNBKCSYgNG6lOnymPY/e2CaCbjg4u050pqw0PfY1YV1ndxc1qx
	 QypfiN8T3LzWmb3fWBI1QLSTCdMugM0LarjPl8/aVGhBv4N6koOKDrdv5VB9vj1sq7w2/
	 QbcvDdpoxUfIMIQ0mH3il+bIen2EH8P+dYJGD02C2UuzSitfzc3y6r5LCJbF6ctnQXxfi
	 v+zTTjP2I7gEnEANoQh9MXZdGaaWqd1GGiPXKvYVoVQ85rnCALjQ2hQdRuvtSwF8m5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtsNJXH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B71606A321;
	Thu, 26 Nov 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtsNJXH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18B61F000C0;
	Thu, 26 Nov 2026 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691703;
	bh=bj8/4t1D3486bMWuOXwhLcAKxLKyES2zSNh6vuKXpeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UtsNJXH5LkGbLvmX8h3OWLUUPvo5d1Agxt9hiYQPPnM54LtZfxIJvEkh7mIytiaPL
	 R/iQ8gA7kJPLRFnQ2FHCXHvqEw5yPC6eW6oxNL4Gli3chYbPmwhbjwy2PutbebUGMc
	 R73R+kL6N6mVGWCCB1VsAFs8AB9+g4AyJv+7cH0WQ+PHsw7ExmQ0tVphZP274UDziY
	 3gfWXTO7rOPovoqCNUi+BQdyjUiAqRxeTnYvKTBDnS5fdyx3AoxmmN1YYITXMeU6u5
	 58JA57EHTN+Mt/ar7zYd+kdqSTSqOfYOBW/fd8UrNniZmSKj+/mHWAgxeBE9NdurAa
	 swzGR3b7HpeBA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:16 +0200
Subject: [PATCH RFC v2 03/54] s390/boot: parse boolean parameters like the
 kernel
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-3-723f1e33c3d8@kernel.org>
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

The decompressor has a copy of kstrtobool() that takes only y/n, 1/0 and
on/off. The kernel's kstrtobool() also takes true/false since 0d6ea3ac94ca
("lib/kstrtox.c: add "false"/"true" support to kstrtobool()") and
enabled/disabled since ae5b3500856f ("kstrtox: add support for enabled and
disabled in kstrtobool()").

The decompressor ignores these values, so "cmma=false" leaves CMMA enabled
and "prot_virt=true" does not enable it.

Copy kstrtobool() from lib/kstrtox.c. This also adds the break after the
on/off switch, which only replaces a fall through to the empty default
case.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/string.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index e4ad196cb720..c12fee2670e3 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -132,13 +132,21 @@ int kstrtobool(const char *s, bool *res)
 		return -EINVAL;
 
 	switch (s[0]) {
+	case 'e':
+	case 'E':
 	case 'y':
 	case 'Y':
+	case 't':
+	case 'T':
 	case '1':
 		*res = true;
 		return 0;
+	case 'd':
+	case 'D':
 	case 'n':
 	case 'N':
+	case 'f':
+	case 'F':
 	case '0':
 		*res = false;
 		return 0;
@@ -156,6 +164,7 @@ int kstrtobool(const char *s, bool *res)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}

-- 
2.53.0

