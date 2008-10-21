Return-Path: <linux-kernel-owner+w=401wt.eu-S1753410AbYJUJWT@vger.kernel.org>
Date: Tue, 21 Oct 2008 11:21:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081021092148.GB4980@osiris.boeblingen.de.ibm.com>
References: <1224168620.9617.14.camel@localhost> <1224230354.4631.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224230354.4631.1.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

since Martin is on vacation I send this pull request again.

please pull from 'kmsg' branch of

        git://git390.osdl.marist.edu/pub/scm/linux-2.6.git kmsg

to get the kernel message catalog code. This has been reworked half
a dozen times and this is the outcome. The bulk of this patch set
are the printk changes and documentation files for s390. The three
patches are:
  "[S390] kmsg: tagged kernel messages.",
  "[S390] kmsg: tagged device messages." and
  "[S390] kmsg: Kernel message catalog script."

The short-log:

Christian Borntraeger (2):
      [S390] kmsg: convert vmcp to kmsg api.
      [S390] kmsg: convert cpcmd to kmsg api.

Christof Schmitt (1):
      [S390] kmsg: convert zfcp printk messages to kmsg api.

Frank Blaschka (1):
      [S390] kmsg: convert qeth print messages to kmsg api.

Frank Munzert (1):
      [S390] kmsg: convert vmur to kmsg api.

Gerald Schaefer (2):
      [S390] kmsg: convert appldata printk messages to kmsg api.
      [S390] kmsg: convert monreader printk messages to kmsg api.

Heiko Carstens (1):
      Fix kmsg_doc script file permissions.

Hongjie Yang (1):
      [S390] kmsg: convert dcssblk and extmem printk messages to kmsg api.

Jan Glauber (1):
      [S390] kmsg: convert cpacf printk messages to kmsg api.

Klaus-D. Wacker (1):
      [S390] kmsg: convert lcs printk messages to kmsg api.

Martin Schwidefsky (10):
      [S390] kmsg: tagged kernel messages.
      [S390] kmsg: tagged device messages.
      [S390] kmsg: Kernel message catalog script.
      [S390] kmsg: convert xpram messages to kmsg api.
      [S390] kmsg: convert time printk messages to kmsg api.
      [S390] kmsg: convert setup printk messages to kmsg api.
      [S390] kmsg: convert ap_bus to kmsg api.
      [S390] kmsg: convert sclp printk messages to kmsg api.
      [S390] kmsg: convert cpu related printks to kmsg api.
      [S390] kmsg: convert vmlogrdr printk messages to kmsg api.

Melissa Howland (1):
      [S390] kmsg: convert monwriter printk messages to kmsg api.

Michael Ernst (1):
      [S390] kmsg: convert cio message to kmsg api.

Michael Holzheu (3):
      [S390] kmsg: convert hypfs printk messages to kmsg api.
      [S390] kmsg: convert s390 debug feature to kmsg api
      [S390] kmsg: convert zfcp dumper printk messages to kmsg API.

Peter Tiedemann (1):
      [S390] kmsg: convert ctcm printk messages to kmsg api.

Ursula Braun (1):
      [S390] kmsg: convert iucv printk messages to kmsg api.

 Documentation/kmsg/s390/aes_s390    |   32 ++
 Documentation/kmsg/s390/af_iucv     |   35 ++
 Documentation/kmsg/s390/ap          |   28 ++
 Documentation/kmsg/s390/appldata    |   93 ++++
 Documentation/kmsg/s390/cio         |   98 ++++
 Documentation/kmsg/s390/cpcmd       |   18 +
 Documentation/kmsg/s390/cpu         |   74 +++
 Documentation/kmsg/s390/ctcm        |  212 +++++++++
 Documentation/kmsg/s390/dcssblk     |  174 +++++++
 Documentation/kmsg/s390/extmem      |  311 ++++++++++++
 Documentation/kmsg/s390/hypfs       |   61 +++
 Documentation/kmsg/s390/iucv        |   21 +
 Documentation/kmsg/s390/lcs         |  170 +++++++
 Documentation/kmsg/s390/monreader   |  135 ++++++
 Documentation/kmsg/s390/monwriter   |   17 +
 Documentation/kmsg/s390/netiucv     |  149 ++++++
 Documentation/kmsg/s390/qeth        |  501 ++++++++++++++++++++
 Documentation/kmsg/s390/s390dbf     |   89 ++++
 Documentation/kmsg/s390/sclp_cmd    |    6 +
 Documentation/kmsg/s390/sclp_config |    3 +
 Documentation/kmsg/s390/sclp_cpi    |    2 +
 Documentation/kmsg/s390/sclp_sdias  |    4 +
 Documentation/kmsg/s390/setup       |  164 +++++++
 Documentation/kmsg/s390/time        |   39 ++
 Documentation/kmsg/s390/vmcp        |   14 +
 Documentation/kmsg/s390/vmlogrdr    |    5 +
 Documentation/kmsg/s390/vmur        |   36 ++
 Documentation/kmsg/s390/xpram       |   61 +++
 Documentation/kmsg/s390/zdump       |   13 +
 Documentation/kmsg/s390/zfcp        |  888 +++++++++++++++++++++++++++++++++++
 Makefile                            |   16 +
 arch/s390/Kconfig                   |    9 +
 arch/s390/appldata/appldata.h       |    4 -
 arch/s390/appldata/appldata_base.c  |   12 +-
 arch/s390/appldata/appldata_os.c    |   21 +-
 arch/s390/crypto/aes_s390.c         |   14 +-
 arch/s390/hypfs/hypfs_diag.c        |   10 +-
 arch/s390/hypfs/inode.c             |   14 +-
 arch/s390/kernel/Makefile           |    4 +-
 arch/s390/kernel/cpcmd.c            |    7 +-
 arch/s390/kernel/debug.c            |   37 +-
 arch/s390/kernel/processor.c        |   98 ++++
 arch/s390/kernel/setup.c            |  166 ++-----
 arch/s390/kernel/smp.c              |   17 +-
 arch/s390/kernel/time.c             |   14 +-
 arch/s390/kernel/topology.c         |    5 +-
 arch/s390/mm/extmem.c               |  106 ++---
 drivers/s390/block/dcssblk.c        |   74 ++--
 drivers/s390/block/xpram.c          |   41 +-
 drivers/s390/char/monreader.c       |   41 +-
 drivers/s390/char/monwriter.c       |    5 +-
 drivers/s390/char/sclp_cmd.c        |   29 +-
 drivers/s390/char/sclp_config.c     |   10 +-
 drivers/s390/char/sclp_cpi_sys.c    |   12 +-
 drivers/s390/char/sclp_sdias.c      |   18 +-
 drivers/s390/char/vmcp.c            |    8 +-
 drivers/s390/char/vmlogrdr.c        |   26 +-
 drivers/s390/char/vmur.c            |   15 +-
 drivers/s390/char/zcore.c           |   14 +-
 drivers/s390/cio/blacklist.c        |   14 +-
 drivers/s390/cio/chsc.c             |    8 +-
 drivers/s390/cio/cio.c              |    5 +-
 drivers/s390/cio/cmf.c              |    8 +-
 drivers/s390/cio/css.c              |    8 +-
 drivers/s390/crypto/ap_bus.c        |   10 +-
 drivers/s390/net/ctcm_fsms.c        |   45 +-
 drivers/s390/net/ctcm_main.c        |   71 ++-
 drivers/s390/net/ctcm_main.h        |    7 +-
 drivers/s390/net/ctcm_mpc.c         |   14 +-
 drivers/s390/net/ctcm_sysfs.c       |    2 +
 drivers/s390/net/lcs.c              |   78 ++--
 drivers/s390/net/netiucv.c          |   64 ++-
 drivers/s390/net/qeth_core.h        |    8 +-
 drivers/s390/net/qeth_core_main.c   |  148 ++++---
 drivers/s390/net/qeth_l2_main.c     |   40 +-
 drivers/s390/net/qeth_l3_main.c     |  214 +++++----
 drivers/s390/scsi/zfcp_aux.c        |   11 +-
 drivers/s390/scsi/zfcp_ccw.c        |    2 +
 drivers/s390/scsi/zfcp_cfdc.c       |    2 +
 drivers/s390/scsi/zfcp_dbf.c        |    2 +
 drivers/s390/scsi/zfcp_erp.c        |    2 +
 drivers/s390/scsi/zfcp_fc.c         |    2 +
 drivers/s390/scsi/zfcp_fsf.c        |    2 +
 drivers/s390/scsi/zfcp_qdio.c       |    2 +
 drivers/s390/scsi/zfcp_scsi.c       |    2 +
 drivers/s390/scsi/zfcp_sysfs.c      |    2 +
 include/linux/device.h              |   27 +-
 include/linux/kmsg.h                |   42 ++
 kernel/printk.c                     |   46 ++
 net/iucv/af_iucv.c                  |   19 +-
 net/iucv/iucv.c                     |    9 +-
 scripts/Makefile.build              |   14 +
 scripts/kmsg-doc                    |  470 ++++++++++++++++++
 93 files changed, 4958 insertions(+), 742 deletions(-)
 create mode 100644 Documentation/kmsg/s390/aes_s390
 create mode 100644 Documentation/kmsg/s390/af_iucv
 create mode 100644 Documentation/kmsg/s390/ap
 create mode 100644 Documentation/kmsg/s390/appldata
 create mode 100644 Documentation/kmsg/s390/cio
 create mode 100644 Documentation/kmsg/s390/cpcmd
 create mode 100644 Documentation/kmsg/s390/cpu
 create mode 100644 Documentation/kmsg/s390/ctcm
 create mode 100644 Documentation/kmsg/s390/dcssblk
 create mode 100644 Documentation/kmsg/s390/extmem
 create mode 100644 Documentation/kmsg/s390/hypfs
 create mode 100644 Documentation/kmsg/s390/iucv
 create mode 100644 Documentation/kmsg/s390/lcs
 create mode 100644 Documentation/kmsg/s390/monreader
 create mode 100644 Documentation/kmsg/s390/monwriter
 create mode 100644 Documentation/kmsg/s390/netiucv
 create mode 100644 Documentation/kmsg/s390/qeth
 create mode 100644 Documentation/kmsg/s390/s390dbf
 create mode 100644 Documentation/kmsg/s390/sclp_cmd
 create mode 100644 Documentation/kmsg/s390/sclp_config
 create mode 100644 Documentation/kmsg/s390/sclp_cpi
 create mode 100644 Documentation/kmsg/s390/sclp_sdias
 create mode 100644 Documentation/kmsg/s390/setup
 create mode 100644 Documentation/kmsg/s390/time
 create mode 100644 Documentation/kmsg/s390/vmcp
 create mode 100644 Documentation/kmsg/s390/vmlogrdr
 create mode 100644 Documentation/kmsg/s390/vmur
 create mode 100644 Documentation/kmsg/s390/xpram
 create mode 100644 Documentation/kmsg/s390/zdump
 create mode 100644 Documentation/kmsg/s390/zfcp
 create mode 100644 arch/s390/kernel/processor.c
 create mode 100644 include/linux/kmsg.h
 create mode 100755 scripts/kmsg-doc
