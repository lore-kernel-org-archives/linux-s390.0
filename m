Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Tracking user space vDSO remaping
Date: Fri, 20 Mar 2015 16:53:26 +0100
Message-ID: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150320155326.8_fu9mxiBfLgBgRjSnh-UmVnn4nHeSJQarSLm7XRaPk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>

CRIU is recreating the process memory layout by remapping the checkpointee
memory area on top of the current process (criu). This includes remapping
the vDSO to the place it has at checkpoint time.

However some architectures like powerpc are keeping a reference to the vDSO
base address to build the signal return stack frame by calling the vDSO
sigreturn service. So once the vDSO has been moved, this reference is no
more valid and the signal frame built later are not usable.

This patch serie is introducing a new mm hook 'arch_remap' which is called
when mremap is done and the mm lock still hold. The next patch is adding the
vDSO remap and unmap tracking to the powerpc architecture.

Laurent Dufour (2):
  mm: Introducing arch_remap hook
  powerpc/mm: Tracking vDSO remap

 arch/powerpc/include/asm/mmu_context.h   | 35 +++++++++++++++++++++++++++++++-
 arch/s390/include/asm/mmu_context.h      |  6 ++++++
 arch/um/include/asm/mmu_context.h        |  5 +++++
 arch/unicore32/include/asm/mmu_context.h |  6 ++++++
 arch/x86/include/asm/mmu_context.h       |  6 ++++++
 include/asm-generic/mm_hooks.h           |  6 ++++++
 mm/mremap.c                              |  9 ++++++--
 7 files changed, 70 insertions(+), 3 deletions(-)

-- 
1.9.1
