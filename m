From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v4 0/3] dma and virtio prep patches
Date: Thu,  5 Nov 2015 21:08:53 +0100
Message-ID: <1446754136-125772-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Andy,

to make it obvious which version is the latest, here is a branch

The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git  dma

for you to fetch changes up to fc7f9754db6ce0c12281da4055281f731d36bdee:

  s390/dma: Allow per device dma ops (2015-11-05 21:02:40 +0100)

----------------------------------------------------------------
Christian Borntraeger (3):
      dma: Provide simple noop dma ops
      alpha/dma: use common noop dma ops
      s390/dma: Allow per device dma ops

 arch/alpha/kernel/pci-noop.c        | 46 ++---------------------
 arch/s390/Kconfig                   |  7 +---
 arch/s390/include/asm/device.h      |  6 ++-
 arch/s390/include/asm/dma-mapping.h |  6 ++-
 arch/s390/pci/pci.c                 |  1 +
 arch/s390/pci/pci_dma.c             |  4 +-
 include/linux/dma-mapping.h         |  2 +
 lib/Makefile                        |  1 +
 lib/dma-noop.c                      | 75 +++++++++++++++++++++++++++++++++++++
 9 files changed, 96 insertions(+), 52 deletions(-)
 create mode 100644 lib/dma-noop.c
