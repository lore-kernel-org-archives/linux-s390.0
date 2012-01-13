From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/7] bitops: introduce for_each_clear_bit()
Date: Sat, 14 Jan 2012 00:53:17 +0900
Message-Id: <1326470004-10096-1-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, Robert Richter <robert.richter@amd.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

This patch set introduces for_each_clear_bit() which is similar to
for_each_set_bit(), but it iterates over all the cleared bits in a
memory region.

This also renames for_each_set_bit_cont() to for_each_set_bit_from()
because it is anologous to list_for_each_entry_from() in list.h
rather than list_for_each_entry_continue(), and then introduces
for_each_clear_bit_from(), too.

Akinobu Mita (7):
  bitops: rename for_each_set_bit_cont in favor of anologous to list.h
    function
  bitops: remove for_each_set_bit_cont
  bitops: introduce list_for_each_clear_bit
  mtd: use for_each_clear_bit
  s390/char: use for_each_clear_bit
  uwb: use for_each_clear_bit
  x86: use for_each_clear_bit_from

 arch/x86/kernel/cpu/perf_event.c       |    4 ++--
 arch/x86/kernel/irqinit.c              |    6 +++---
 drivers/mtd/chips/cfi_cmdset_0001.c    |    6 ++----
 drivers/s390/char/sclp_cmd.c           |    5 ++---
 drivers/uwb/allocator.c                |    6 ++----
 include/linux/bitops.h                 |   13 ++++++++++++-
 tools/perf/util/include/linux/bitops.h |    2 +-
 7 files changed, 24 insertions(+), 18 deletions(-)

Cc: Robert Richter <robert.richter@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Cc: linux-usb@vger.kernel.org

-- 
1.7.4.4
