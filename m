Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Jun 2017 16:36:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.12-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170612163628.1c851d2e@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

* A fix for KVM to avoid kernel oopses in case of host protection faults
  due to runtime instrumentation

* A fix for the AP bus to avoid dead devices after unbind / bind

* A fix for a compile warning merged from the vfio_ccw tree

* Updated default configurations

Christian Borntraeger (1):
      s390/kvm: do not rely on the ILC on kvm host protection fauls

Harald Freudenberger (1):
      s390/zcrypt: Fix blocking queue device after unbind/bind.

Martin Schwidefsky (1):
      s390: update defconfig

Sebastian Ott (1):
      s390/vfio_ccw: make some symbols static

 arch/s390/configs/default_defconfig     | 39 ++++++++++++++++++++++++++++-----
 arch/s390/configs/gcov_defconfig        | 28 +++++++++++++++++++----
 arch/s390/configs/performance_defconfig | 27 +++++++++++++++++++----
 arch/s390/configs/zfcpdump_defconfig    |  6 +++--
 arch/s390/defconfig                     |  8 +++----
 arch/s390/kernel/entry.S                | 19 +++++++++++-----
 drivers/s390/cio/vfio_ccw_ops.c         | 12 +++++-----
 drivers/s390/crypto/ap_bus.c            | 38 ++++++++++++++++++++------------
 drivers/s390/crypto/ap_card.c           |  9 +++++++-
 drivers/s390/crypto/ap_queue.c          |  9 +++++++-
 10 files changed, 146 insertions(+), 49 deletions(-)
