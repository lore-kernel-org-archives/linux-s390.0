Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC51A3A98;
	Mon,  2 Sep 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304123; cv=none; b=HNI02RN8c1QE+AXVQkLZdbwCbSP4CVoIdYMmPT/xDJxIbuy0tVwcYVGUEpDAWGjdn83XwZbG8YR8joRj7tJQVbk2HQZlAnP5VbCEARJuTLClmt5VHkfLYT5zj2BOZbzr8boE5RRhCtC9fTYXE4qGe+o3bN5QeoiJJsSaKZqBkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304123; c=relaxed/simple;
	bh=Oas/y5WsR2uek3LQJA53gCtjxNPODnZnDS04Vmdm0SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b/WMa/2TFxKHea4O9WQAbVW0NV9tp402DA96pKn4RSt2M1OcsaUPgpX6qejmin6xK55vqZj+GNmvWygm1X04xmN3iE5gx8UYo/0X11/g3+S35shSG1WUirG4IGC902ybnsdOznu2kO8XidxDLUz8eDf60Hagdd3rHSxDX4YREnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8jxrlHN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8jxrlHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCAEC4CEC2;
	Mon,  2 Sep 2024 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725304122;
	bh=Oas/y5WsR2uek3LQJA53gCtjxNPODnZnDS04Vmdm0SM=;
	h=From:Subject:Date:To:Cc:From;
	b=t8jxrlHNVdQXEDhwqdc20wAj+gPH80qUonuGgv2lMOAereLM62SZkpGPh6RAw9Q9b
	 cBNdNdELgobbYczEeegAXNuBmkG7+MBKa3Udw2wp+tjLbthGJxD6C/atbKR7nQEKwI
	 NAVDsSjvSJZ9+1oRX/kkvqkAIgsWJCEN3vAjweczQiDR8G8rv2/iGBjY0OqiwXsYOC
	 1YZQ4+Nhih70PVTlXd97kseJ3xxY4C8apxLBnSHWiBfctlrlY5bLTNsKDQhWc4cvZV
	 gw+pLSbt1GGlFl6jRG9lXzrbyPWAt8owB6/wy3UdR0nEgwgZKF32T6/tL0RJDOum7q
	 AtI7A5Vf8oy6Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] mm: Care about shadow stack guard gap when getting an
 unmapped area
Date: Mon, 02 Sep 2024 20:08:12 +0100
Message-Id: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABwN1mYC/x3MQQqDMBBA0avIrDuQqgHtVUoXSWaMgxhLplVBv
 LvB5Vv8f4ByFlZ4VQdkXkVlSQXPRwVhdCkyChVDberWdI3BecbIqUQBdXS0bKg/FyaMf5cJrQ/
 Wd2S4twTl8c08yH7/35/zvADZttxrbwAAAA==
To: Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 Mark Brown <broonie@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Oas/y5WsR2uek3LQJA53gCtjxNPODnZnDS04Vmdm0SM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm1g0tzzAYejDFf/YyyXU75xxYTOzlmhmKdU7A0Mjv
 QTPoE+GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtYNLQAKCRAk1otyXVSH0DS/B/
 9wL/O0zfApTjzan3whOoMvydnSM37kQyhnnpfHRjUqEv3U+31o7LNZtf8cgkcFnfvN/mcjg6zqfUbL
 sgE3gILwU/gP0rpIIqOBcdMi0yW/6RMxDx3KYAXsoMcW+HgREp4Jmstlc5mrqGzeY9D8bRILVJSjtt
 CxzlZDYaBGUyD6JX4rA4vmDkKdsx+ZsnFmkTKKS4DYRkMaU9mg1/cG7jWJa8t7opzkAXW5a9k1msEw
 fa0BXHW/LfCE9M6grMvRbR+VL7UOyIE9Bsha8/dsbR6EJN8gbJiRaqql1/7PoOt5/VXpmT+GO8cCfj
 ebeheDgkstF5WtU2RPgxVpDKwWWfI3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As covered in the commit log for c44357c2e76b ("x86/mm: care about shadow
stack guard gap during placement") our current mmap() implementation does
not take care to ensure that a new mapping isn't placed with existing
mappings inside it's own guard gaps. This is particularly important for
shadow stacks since if two shadow stacks end up getting placed adjacent to
each other then they can overflow into each other which weakens the
protection offered by the feature.

On x86 there is a custom arch_get_unmapped_area() which was updated by the
above commit to cover this case by specifying a start_gap for allocations
with VM_SHADOW_STACK. Both arm64 and RISC-V have equivalent features and
use the generic implementation of arch_get_unmapped_area() so let's make
the equivalent change there so they also don't get shadow stack pages
placed without guard pages. The arm64 and RISC-V shadow stack
implementations are currently on the list:

   https://lore.kernel.org/r/20240829-arm64-gcs-v12-0-42fec94743
   https://lore.kernel.org/lkml/20240403234054.2020347-1-debug@rivosinc.com/

Given the addition of the use of vm_flags in the generic implementation
we also simplify the set of possibilities that have to be dealt with in
the core code by making arch_get_unmapped_area() take vm_flags as
standard. This is a bit invasive since the prototype change touches
quite a few architectures but since the parameter is ignored the change
is straightforward, the simplification for the generic code seems worth
it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      mm: Make arch_get_unmapped_area() take vm_flags by default
      mm: Pass vm_flags to generic_get_unmapped_area()
      mm: Care about shadow stack guard gap when getting an unmapped area

 arch/alpha/kernel/osf_sys.c       |  2 +-
 arch/arc/mm/mmap.c                |  3 ++-
 arch/arm/mm/mmap.c                |  7 +++---
 arch/csky/abiv1/mmap.c            |  3 ++-
 arch/loongarch/mm/mmap.c          |  5 ++--
 arch/mips/mm/mmap.c               |  2 +-
 arch/parisc/kernel/sys_parisc.c   |  5 ++--
 arch/parisc/mm/hugetlbpage.c      |  2 +-
 arch/powerpc/mm/book3s64/slice.c  | 10 +++++---
 arch/s390/mm/mmap.c               |  4 +--
 arch/sh/mm/mmap.c                 |  5 ++--
 arch/sparc/kernel/sys_sparc_32.c  |  2 +-
 arch/sparc/kernel/sys_sparc_64.c  |  4 +--
 arch/x86/include/asm/pgtable_64.h |  1 -
 arch/x86/kernel/sys_x86_64.c      | 21 +++-------------
 arch/xtensa/kernel/syscall.c      |  3 ++-
 include/linux/sched/mm.h          | 27 ++++++++-------------
 mm/mmap.c                         | 51 ++++++++++++++++++---------------------
 18 files changed, 69 insertions(+), 88 deletions(-)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240830-mm-generic-shadow-stack-guard-5bc5b8d0e95d

Best regards,
-- 
Mark Brown <broonie@kernel.org>

