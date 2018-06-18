Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 18 Jun 2018 13:17:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.18-rc2
Message-Id: <20180618131722.46ed6b3d@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

  common I/O layer
    - Fix bit-fields crossing storage-unit boundaries in css_general_char

  dasd driver
    - Avoid a sparse warning in regard to the queue lock
    - Allocate the struct dasd_ccw_req as per request data. Only for
      internal I/O is the structure allocated separately
    - Remove the unused function dasd_kmalloc_set_cda
    - Save a few bytes in struct dasd_ccw_req by reordering fields
    - Convert remaining users of dasd_kmalloc_request to
      dasd_smalloc_request and remove the now unused function

  vfio/ccw
    - Refactor and improve pfn_array_alloc_pin/pfn_array_pin
    - Add a new tracepoint for failed vfio/ccw requests
    - Add a CCW translation improvement to accept more requests as valid
    - Bug fixes

Shortlog:

Dong Jia Shi (4):
      vfio: ccw: fix error return in vfio_ccw_sch_event
      vfio: ccw: shorten kernel doc description for pfn_array_pin()
      vfio: ccw: refactor and improve pfn_array_alloc_pin()
      vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
      vfio: ccw: push down unsupported IDA check
      vfio: ccw: add tracepoints for interesting error paths

Sebastian Ott (6):
      s390/cio: sanitize css_general_characteristics definition
      s390/dasd: simplify locking in process_final_queue
      s390/dasd: move dasd_ccw_req to per request data
      s390/dasd: remove dasd_kmalloc_set_cda
      s390/dasd: reshuffle struct dasd_ccw_req
      s390/dasd: only use preallocated requests

 arch/s390/include/asm/css_chars.h |  62 +++++++-------
 drivers/s390/block/dasd.c         | 171 +++++++++++++-------------------------
 drivers/s390/block/dasd_alias.c   |   6 +-
 drivers/s390/block/dasd_diag.c    |   3 +-
 drivers/s390/block/dasd_eckd.c    |  46 +++++-----
 drivers/s390/block/dasd_eer.c     |  10 +--
 drivers/s390/block/dasd_fba.c     |   6 +-
 drivers/s390/block/dasd_int.h     |  26 ++----
 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 140 ++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_drv.c   |   5 +-
 drivers/s390/cio/vfio_ccw_fsm.c   |  17 +++-
 drivers/s390/cio/vfio_ccw_trace.h |  54 ++++++++++++
 13 files changed, 282 insertions(+), 265 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h
