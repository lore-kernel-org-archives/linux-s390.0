Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2F3A48C5;
	Tue,  7 Jul 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451192; cv=none; b=SuQ3+/ZobVlz5x7CWKVWREBMogNkBzz3aPprnhGegAachKaCh6rxZOP13WaFaM6UZcq/3H/gQSLLL4Sa/VTasBPBtXiZq3ShOR4fzzFz+uluMZUrPc8FzYYE+EWXFUf43PkpdOKvchJhbuxi/reC/vvp2QHzrj3EYhtXg9FhO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451192; c=relaxed/simple;
	bh=PYhMM85AzHjZdVZlu3JZJgIVicv/CXGGISuxXGgoBrA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=c1KH8+9E55/I9kioXoE/5ZKz3/svlgeg+RTUvxsIEDnAkDexvlWNIsPo52r0xMFL1W+80PlJdEoJeCwLxhjAoYZR2qkzg8C5ctyG+GlMFCPGkVMpZzr/RFfCfdeYjoZ+oineqooSjMC5pMN8ofqoQrtk8m1RGSit80ZSU5Ogvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAQsikH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAQsikH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC491F000E9;
	Tue,  7 Jul 2026 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451186;
	bh=EqhpiB2ZofNX2Hns8Xgz4OVDOubexQBaPatIimxnT/c=;
	h=Date:From:To:Cc:Subject:References;
	b=OAQsikH32zcXysH6hCjDCdC0GZdQsSYEYwKYLO4211wdV8Gx5U5QTVE1+P//2FXpn
	 uIqA0JY8lGaPQiDHJVOdRGZSp+QbqEjfTrKS3EEXVNmeOvIQBrVQEfC4uIvhb5uzt+
	 eT9i9M6+UlE8GQ+lRJyRHgkq+kITYoE5ZzhOkYUKb2PU4bWHESCf+nr7SFJdz6XhZt
	 2iGqe+3vU4x0dhlP0lRwEovJHlRUe0zFn5tWw2ueZ7uZSvdCbVVh6SrVwQHTuvbp8Z
	 nNfr1ROiFTyIDkK/ZvtATvAtmDATTdK6yv/sLVE04ZyzvrA9oLmxeUKMvdWrrAByna
	 52gUU2XWEgjgQ==
Date: Tue, 07 Jul 2026 21:06:23 +0200
Message-ID: <20260707190254.030598804@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
the subsequent invocation of add_random_kstack_offset_irqsoff().

As a bonus this avoids the overhead of get/put_cpu_var() in
add_random_kstack_offset().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/syscall.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
 {
 	unsigned long nr;
 
-	enter_from_user_mode(regs);
-	add_random_kstack_offset();
+	enter_from_user_mode_randomize_stack(regs);
+
 	regs->psw = get_lowcore()->svc_old_psw;
 	regs->int_code = get_lowcore()->svc_int_code;
 	update_timer_sys();

