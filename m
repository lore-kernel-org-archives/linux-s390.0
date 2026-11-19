Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069042;
	b=s7w3kHD2NObAaoXQJmgU6CWi1tPL25Pd9rkBIe+VXoWKY9+PkoKkTNx+k301TUD8IC0k
	 ZEaHjj9zZ4hydz+W9ku6M4FpOeird1xL0jWrTRkeuMOR4MZawOAR5l4mc+UTi4TvZBTrE
	 z/wRCfZ7EvNVtjbuH0XgU0OSoCu00kiRyfxwB0DI+xyX90rGKf6bHwVbgznwec0FZkxGL
	 b8XpeCJoKPys1sqc4WDFupXyF1Gcx/4w+JvnJUyhHooxhkk72U7uCub0qHv8RxnJpbMHm
	 AvBn9F8P1G5N6b1Zj9GZp2UGmgAUiKDhxDJ6mTz8TmwOuSZeMFckBV902liFKMoXCcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069042;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=RCALj7r6ipQ65VvrYt8UYoxBLY7ziLYM55JY1qfnc/M=;
	b=a6TIEOjLax/OUjMSClY7MK5HLUb3YfXcLwZoNBtV6BofHOU5IFXLlRBSwa2zRVuNZUej
	 W4yGuMVXweXg49rpNUNwByem2pASdJX7tmxpkIW7tNiUQyhCSDD1wNAlLHqkmTfWnFLpq
	 42Q1MDF4NNnjKlSTP+JbNy2CXkMAW1pETqTFGOq1Sebluu/onFAPw59T32372ZDc8VEy3
	 yNi0sAJCKwmfW31oNsQ4r+Hvv/U0bbLYfm0wr9V/YBoh9XcfIQ6lZxEyxwKxKFo9w9h8y
	 rQ5QDD6GySYIL+SWSbDfwzATmw1QsT7GhhCkeGFG5eMeS41fxUiCgOHz4bK8eatExzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4RsFvpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12B606A320;
	Thu, 19 Nov 2026 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4RsFvpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6BC1F000C5;
	Thu, 19 Nov 2026 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069042;
	bh=RCALj7r6ipQ65VvrYt8UYoxBLY7ziLYM55JY1qfnc/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4RsFvpp42re8uGBqIQQaz0PqGBIw37xPLwUslFEUgkmtfZ+L4DJ5tF9O6rwFB/pv
	 oTwcMalP+8YPREtTdZ/mO/uTE4CmQs2HCIVDtU9aDm0/l6ErDkOsAtNCDy3Owc2dfw
	 NhTWj7mEPGBVVIEkqz/SNG4/lnaJ1Ckq1d9I080njZAAP4lOXWETkMzicnDdMGwSZa
	 IuzwpjwfJJm/EsTZ1ALj7RxDfmTdqZwGJkhENJAdmNDATjggpuNt1CBYTdf69f4D4y
	 gn7NwSaO9QjgPGJeNtc+ljTmnnsG4TxH+MTkTbIp9qZ3L4/OYHNVJr062yUMTDzgJT
	 te95/HcZEQPRQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 19 Nov 2026 08:16:57 +0200
Subject: [PATCH 1/2] MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
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
Message-Id: <20261119-arch-kconfig-v1-1-37c276fe4d26@kernel.org>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, Paul Walmsley <pjw@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, 
 Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, 
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev
X-Mailer: b4 0.16.1-dev

kernel/Kconfig.kexec is not matched by the KEXEC entry, so
get_maintainer.pl does not report kexec maintainers for changes in that
file.

Add it to the KEXEC entry.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d738990161bd0..c61a1f0ad330e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14782,6 +14782,7 @@ W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
+F:	kernel/Kconfig.kexec
 F:	kernel/kexec*
 
 KEXEC HANDOVER (KHO)

-- 
2.53.0

