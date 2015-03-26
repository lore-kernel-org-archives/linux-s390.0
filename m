Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH v4 0/2] Tracking user space vDSO remaping
Date: Thu, 26 Mar 2015 18:37:51 +0100
Message-ID: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <20150326141730.GA23060@gmail.com>
References: <20150326141730.GA23060@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150326173751.1ZdVNhf7SKwdtA2FJ2Uj-Qj2NPBnZdMoso7eVKcE9Oo@z>
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

Changes in v4:
--------------
- Reviewing the PowerPC part of the patch to handle partial unmap and remap
  of the vDSO.

Changes in v3:
--------------
- Fixed grammatical error in a comment of the second patch. 
  Thanks again, Ingo.

Changes in v2:
--------------
- Following the Ingo Molnar's advice, enabling the call to arch_remap through
  the __HAVE_ARCH_REMAP macro. This reduces considerably the first patch.

Laurent Dufour (2):
  mm: Introducing arch_remap hook
  powerpc/mm: Tracking vDSO remap

 arch/powerpc/include/asm/mmu_context.h | 32 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/vdso.c             | 39 ++++++++++++++++++++++++++++++++++
 mm/mremap.c                            | 11 ++++++++--
 3 files changed, 79 insertions(+), 3 deletions(-)

-- 
1.9.1
