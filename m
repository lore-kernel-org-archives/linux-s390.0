From: Shuah Khan <shuah.kh@samsung.com>
Subject: [RFT][PATCH 00/12] change drivers power management to use dev_pm_ops
Date: Mon, 10 Feb 2014 09:12:23 -0700
Message-ID: <cover.1392040064.git.shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pm/>
List-Post: <mailto:linux-pm@vger.kernel.org>
To: rjw@rjwysocki.net
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, manuel.lauss@gmail.com, chris@printf.net, linux-mmc@vger.kernel.org, sonic.zhang@analog.com, adi-buildroot-devel@lists.sourceforge.net, mirq-linux@rere.qmqm.pl, davidb@codeaurora.org, dwalker@fifo99.com, linux-arm-msm@vger.kernel.org, ian@mnementh.co.uk, gregkh@linuxfoundation.org, linux-pcmcia@lists.infradead.org, ingo.tuchscherer@de.ibm.com, linux390@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, shuahkhan@gmail.com
List-ID: <linux-s390.vger.kernel.org>

Change drivers to register pm ops using dev_pm_ops instead of legacy pm_ops.
.pm hooks call existing legacy suspend and resume interfaces by passing in
the right pm state. Bus drivers suspend and resume routines call .pm driver
hooks if found.

Shuah Khan (12):
  arm: change locomo platform and bus power management to use
    dev_pm_ops
  arm: change sa1111 platform and bus power management to use
    dev_pm_ops
  arm: change scoop platform power management to use dev_pm_ops
  drivers/macintosh/adb: change platform power managemnet to use
    dev_pm_ops
  mmc: change au1xmmc platform power management to use dev_pm_ops
  mmc: change bfin_sdh platform power management to use dev_pm_ops
  isa: change isa bus power managemnet to use dev_pm_ops
  mmc: change cb710-mmc platform power management to use dev_pm_ops
  mmc: change msm_sdcc platform power management to use dev_pm_ops
  mmc: change tmio_mmc platform power management to use dev_pm_ops
  drivers/pcmcia: change ds driver power management to use dev_pm_ops
  drivers/s390/crypto: change ap_bus driver power management to use
    dev_pm_ops

 arch/arm/common/locomo.c     |   93 +++++++++++++++++++++++++++++++++++-------
 arch/arm/common/sa1111.c     |   88 +++++++++++++++++++++++++++++++--------
 arch/arm/common/scoop.c      |   44 ++++++++++++++++----
 drivers/base/isa.c           |   30 ++++++++++++--
 drivers/macintosh/adb.c      |   41 ++++++++++++++++---
 drivers/mmc/host/au1xmmc.c   |   43 +++++++++++++++----
 drivers/mmc/host/bfin_sdh.c  |   40 +++++++++++++++---
 drivers/mmc/host/cb710-mmc.c |   37 +++++++++++++++--
 drivers/mmc/host/msm_sdcc.c  |   42 +++++++++++++++----
 drivers/mmc/host/tmio_mmc.c  |   42 +++++++++++++++----
 drivers/pcmcia/ds.c          |   36 +++++++++++++---
 drivers/s390/crypto/ap_bus.c |   30 ++++++++++++--
 12 files changed, 481 insertions(+), 85 deletions(-)

-- 
1.7.10.4
