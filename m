Return-Path: <linux-kernel-owner+w=401wt.eu-S1760275AbYGQP4X@vger.kernel.org>
Date: Thu, 17 Jul 2008 17:55:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] more s390 updates for 2.6.27
Message-ID: <20080717155558.GB9422@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

Besides a couple of small bugfixes this contains our rewritten qdio driver.
This should be the last large s390 patch for this merge window.

Thanks.

Adrian Bunk (1):
      [S390] chsc headers userspace cleanup

Cornelia Huck (2):
      [S390] dasd: Fix cleanup in dasd_{fba,diag}_check_characteristics().
      [S390] cio: Export chsc_error_from_response().

Frank Munzert (2):
      [S390] zfcpdump: Make SCSI disk dump tool recognize storage holes
      [S390] vmur: Fix return code handling.

Heiko Carstens (2):
      [S390] Increase default warning stacksize.
      [S390] Fix stacktrace compile bug.

Jan Glauber (1):
      [S390] qdio: new qdio driver.

Stefan Haberland (2):
      [S390] dasd: fix unsolicited SIM handling.
      [S390] dasd: use -EOPNOTSUPP instead of -ENOTSUPP

 arch/s390/Kconfig                 |    2 +-
 arch/s390/kernel/stacktrace.c     |    1 +
 drivers/s390/block/dasd_diag.c    |   25 +-
 drivers/s390/block/dasd_eckd.c    |    4 +-
 drivers/s390/block/dasd_fba.c     |    7 +-
 drivers/s390/char/vmur.c          |   10 +-
 drivers/s390/char/zcore.c         |  101 +-
 drivers/s390/cio/Makefile         |    2 +
 drivers/s390/cio/chsc.c           |    9 +-
 drivers/s390/cio/chsc.h           |    2 +
 drivers/s390/cio/qdio.c           | 3929 -------------------------------------
 drivers/s390/cio/qdio.h           |  835 +++------
 drivers/s390/cio/qdio_debug.c     |  240 +++
 drivers/s390/cio/qdio_debug.h     |   91 +
 drivers/s390/cio/qdio_main.c      | 1755 +++++++++++++++++
 drivers/s390/cio/qdio_perf.c      |  151 ++
 drivers/s390/cio/qdio_perf.h      |   54 +
 drivers/s390/cio/qdio_setup.c     |  521 +++++
 drivers/s390/cio/qdio_thinint.c   |  380 ++++
 drivers/s390/net/qeth_core.h      |   12 +-
 drivers/s390/net/qeth_core_main.c |   87 +-
 drivers/s390/net/qeth_l2_main.c   |   26 +-
 drivers/s390/net/qeth_l3_main.c   |   25 +-
 drivers/s390/scsi/zfcp_dbf.c      |   12 +-
 drivers/s390/scsi/zfcp_dbf.h      |    2 -
 drivers/s390/scsi/zfcp_ext.h      |    5 +-
 drivers/s390/scsi/zfcp_qdio.c     |   42 +-
 include/asm-s390/Kbuild           |    2 +-
 include/asm-s390/chpid.h          |    6 +-
 include/asm-s390/qdio.h           |  646 +++----
 include/asm-s390/schid.h          |    3 +
 include/asm-s390/setup.h          |    2 +-
 32 files changed, 4019 insertions(+), 4970 deletions(-)
 delete mode 100644 drivers/s390/cio/qdio.c
 create mode 100644 drivers/s390/cio/qdio_debug.c
 create mode 100644 drivers/s390/cio/qdio_debug.h
 create mode 100644 drivers/s390/cio/qdio_main.c
 create mode 100644 drivers/s390/cio/qdio_perf.c
 create mode 100644 drivers/s390/cio/qdio_perf.h
 create mode 100644 drivers/s390/cio/qdio_setup.c
 create mode 100644 drivers/s390/cio/qdio_thinint.c
