Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924068;
	b=RnOLoV/GunRy1RVVkbg30jeybe/AFeinufw9t5bGZWjoWDOoXz9fVH+SnHqbJBWeIG+v
	 cj4r6fHKcEC2ZOpOfbpYr4fXzFTFbIMEX51fNJQXKbmF2pjwoAilt73jFYHJUS8WH7fpS
	 g5cnooEwZ7Wzscv6r9dXy/es3iaVELgGGLzOpwfxXsk3Lm2od93qLDs6HhiUuv5iR61Uh
	 3BMeC8C12uo2g7zc8s0i8SnmDHUEaNb5h1seEDjZgs4Av/9oScLvg/BeFNwy4Fq8FNRnX
	 jjnojlTc3Pm86lbs2E5mt8CqJ1OFGdoMfKYJBvsj6VrCj4Qd4SIDIbGbERf2NZmCc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924068;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=zI+crKsh6am8tsCzPTpsROvUSZD6KicW2WP2b2xt+Q0=;
	b=hiuZJREW/HAr6BdAf6NV9/YX8Ekjvfk0kPtfAYczPL9SXP7jpwd2P4Utc0p1gBLCmWFz
	 hgR7GGGrIDFTzSRh0UXE9oW5iITFIy+5Y/WcOHLukpkTvHANUN3ENSuwWaDuP066QoTUH
	 Kijeqw8aljXH1tFi6Johu2ZkpVInqRrf/nXOKPD/yvp+a1t8WYIQrcyjeKSxdFaFiR7yt
	 dUmNV8YgHJRW+Wu4JXNkxvqewxKQoGbZnfdiqzVfjRNt3IBIH3NVgL6r+hOrgc7JVL9YV
	 UfhY0R5SYAn5Mil6L5IBhFrp0BlJzsVFuaTGZ5W/jS5UJdt6ZkiMkvhdLlJ5FHCyIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbXYbI3x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C4606A329;
	Tue, 17 Nov 2026 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KbXYbI3x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D9C1F000C4;
	Tue, 17 Nov 2026 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924068;
	bh=zI+crKsh6am8tsCzPTpsROvUSZD6KicW2WP2b2xt+Q0=;
	h=From:Date:Subject:To:Cc;
	b=KbXYbI3x81dskh+oWDMdyPT4Z/FJMj6bW5Lsv9xGCVxgLdCwq1FZ7oGHuFCY431QQ
	 Dv9Y1pHcIWsELImWV3CZEGBJ/34GXXxPvHWdFI6KfqQNTUOOJVWhjmxvsGJNBbjWBl
	 d+PD3+10I2oQpjmcztO+pSK3GMOqyq+H0AXa8GkP2S8yAH4bu52IZxVPhvdi4knQCC
	 nXjPfNwM4Ha70QEKM26tu1fJA7nenvnP0QBstBje7C8mJQHVsPRexYFjP3udGOW685
	 YizXuxeUHebkUTkoVZJzj5qzJWtaQrxc7WqHQ4zpVmNDcvToqJkZYHq3ZZh83hlodl
	 E4fSSumFxDApg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 16:01:04 +0200
Subject: [PATCH] s390/kdump: write protect the crash kernel memory by its
 virtual address
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
Message-Id: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ7CIBBEf6XZs8QCRsBfMR4A13ZNpGa3miZN/
 72gxzfzZlYQZEKBS7cC45eEplJBHzrIYywDKrpXBtObs9baqQctKEps6JU34WSD9c67CHXwZvy
 11b/e/iyf9MQ8t4dmpCioEseSxxZNTAOV4yvKjAzbtgOgqwpvjgAAAA==
X-Change-ID: 20261117-fixes-s390-82943938787a
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.16.1-dev

crash_protect_pages() passes crashk_res.start to set_memory_ro() and
set_memory_rw(). That is a physical address. Since the identity mapping
may start above zero, it is not the address of the crash kernel memory
in the kernel page tables.

With CONFIG_RANDOMIZE_IDENTITY_BASE the page table walk finds no mapping
at that address and fails. The error is ignored, and the crash kernel
memory stays writable after "kexec -p" loads it.

Use the identity mapping address of the crash kernel memory.

Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address spaces")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
I found this while working on a generic implementation of the set_memory
APIs. Only build tested.
---
 arch/s390/kernel/machine_kexec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..20ea3018462f 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -151,15 +151,16 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 
 static void crash_protect_pages(int protect)
 {
-	unsigned long size;
+	unsigned long addr, size;
 
 	if (!crashk_res.end)
 		return;
+	addr = (unsigned long)__va(crashk_res.start);
 	size = resource_size(&crashk_res);
 	if (protect)
-		set_memory_ro(crashk_res.start, size >> PAGE_SHIFT);
+		set_memory_ro(addr, size >> PAGE_SHIFT);
 	else
-		set_memory_rw(crashk_res.start, size >> PAGE_SHIFT);
+		set_memory_rw(addr, size >> PAGE_SHIFT);
 }
 
 void arch_kexec_protect_crashkres(void)

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261117-fixes-s390-82943938787a

--
Sincerely yours,
Mike.

