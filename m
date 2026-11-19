Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069031;
	b=z7sJ81aashRwUt03RWWt2Kvd6BF6dYX6boujF2rEMT38+eIni7PSB6eL7XT2DfkJnWf1
	 yUmUVYRJMpquMKz72NMBDuuJpS5xTuBe8jilGqCUiatGUUFY9vuHME2AnNLMTx8p37nhi
	 8oeJhMn6VCNJiN4RTZWRrGapdfPETxOlRdvfpB9IwngxL/DX4LyBXHYZC7LTuDkZAHegj
	 Kon9SwrJiEm4HCBnZD51rzLXOSib+nipdk0JbqYT0eNr9sMuVONMmn6TXyBlvjHWf15AK
	 UPCVd/clkKHevLILzt9BTzly/ubbbh/eYI9bKXI7aSllJqZ5ijHNT32Umm7HXt8fYjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069031;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=jAZ3SnNAJjB6kTaL5eHDhSogy8KQgK6+JZEcWaMgZsQ=;
	b=V5J9lGSWD0cNuwWrQppVd3qiUafREc9uGAtqB8GJt7mNQGZJUDfSHC9r97dJ4YGqSC69
	 WsaVKbqlvJbrJ8aWFK0DtlNBmeIEE5OsoKKxdxxcyQ3zOcPhwWShFFzVx/Zt/eE2G6MGj
	 Z3A4hlxDTsVL5L5qTO2XjIL2ivSZox+5mIT0BSrR59/DbxQP00WOBEudj4NcQgU1mxtty
	 dBsYYgw3n13N7UZ5OJnY5gqYxY5NPvYoHgsZFYsS9CiG/kU4PxI4nyvB18gaf4POq0hPd
	 +GaBcNzwmieHNvMbkrHRr3DeyQmROyGszG8l0NyVtw9c74M+ZoXpzBL6UCS4+sKRhLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QPur/Mce";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C97606A320;
	Thu, 19 Nov 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPur/Mce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CBD1F000C4;
	Thu, 19 Nov 2026 06:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069031;
	bh=jAZ3SnNAJjB6kTaL5eHDhSogy8KQgK6+JZEcWaMgZsQ=;
	h=From:Subject:Date:To:Cc;
	b=QPur/Mced9X4RWzkGAt/MsAw+bqXt6yVON5lBH/7OyoiOaTbtzFItUhDCUIBWDdre
	 ZGouoE1rykai0wUQlOVqCf0GlA7TrbLaI2Mqs8gYX/JQ9Oo2Wv4yYD/dlpAaTFIAXX
	 7IftOiVoRagY/2JtvK8msJVyzyhR0zNeTTJ24nH7TIsTApifHRXe0eKDJ6rYh/TTub
	 jmzTR3ax1PmxnZG5lGOM7weBavns02NIAauS40hYqQBCpuwRdocLfEJkR7ay2DzFMT
	 sD7YpoQ9CvRkXi7y5T0RyOjL3xyq6FU+Kn1gekCcdzIt/umGs5YWm5g7jWFh3p4MWR
	 YpdheBZ8DOQsw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
Date: Thu, 19 Nov 2026 08:16:56 +0200
Message-Id: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAwFr1J5TURTlfK5CmKRGDcxiKSyC6pU9
 e4ksJynN7OCkjApXJoVhD6snFMBu2sAo0uBDN8LQ9d2g7X2bJxgNE/MaeRg/BF7b1s84WGAokx
 CIy+/3PX2Z337B+FcG/XhnZLx4hLGOmXhwGn/cjqTwLZ9AUFdywKQAAAA
X-Change-ID: 20261119-arch-kconfig-b7c4b10c8c56
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

The intention is to take it via kexec tree.

---
Mike Rapoport (Microsoft) (2):
      MAINTAINERS: add kernel/Kconfig.kexec to KEXEC
      arch, kexec: declare kexec and crash capabilities in Kconfig.kexec

 MAINTAINERS            |  1 +
 arch/arm/Kconfig       | 12 +++---------
 arch/arm64/Kconfig     | 36 +++++++++---------------------------
 arch/loongarch/Kconfig | 20 +++++---------------
 arch/m68k/Kconfig      |  4 +---
 arch/mips/Kconfig      | 12 +++---------
 arch/parisc/Kconfig    |  8 ++------
 arch/powerpc/Kconfig   | 30 +++++++-----------------------
 arch/riscv/Kconfig     | 28 +++++++---------------------
 arch/s390/Kconfig      | 28 ++++++----------------------
 arch/sh/Kconfig        | 16 ++++------------
 arch/x86/Kconfig       | 48 ++++++++++++------------------------------------
 kernel/Kconfig.kexec   | 42 ++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 102 insertions(+), 183 deletions(-)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261119-arch-kconfig-b7c4b10c8c56

--
Sincerely yours,
Mike.

