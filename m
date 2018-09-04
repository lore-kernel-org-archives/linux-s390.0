Return-Path: <linux-mmc-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 00/25] Change tty_port(standard)_install's return type
Date: Tue,  4 Sep 2018 11:44:26 +0900
Message-Id: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Many drivers with tty use the tty_stand_install(). But, there is no
need to handle the error, since it always returns 0. So, change the
return type of tty_standard_install() and tty_port_install() to void
type and remove unnecessary exception handling where we use these
functions.

Change return type for tty functions. Patch No.01
  tty: Change return type to void

Apply tty_port_install() changes. Patch No.02~14
  isdn: i4l: isdn_tty: Change return type to void
  ...
  Bluetooth: Change return type to void

Apply tty_standard_install() changes. Patch No.15~25
  um: Change return type to void
  ...
  usb: usb-serial: Change return type to void

Jaejoong Kim (25):
  tty: Change return type to void
  isdn: i4l: isdn_tty: Change return type to void
  s390: char: con3215: Change return type to void
  s390: char: tty3270: Change return type to void
  tty: hvc: hvc_console: Change return type to void
  tty: hvc: hvcs: Change return type to void
  tty: mips_ejtag_fdc: Change return type to void
  tty: n_gsm: Change return type to void
  tty: serial: kgdb_nmi: Change return type to void
  tty: synclink: Change return type to void
  tty: synclinkmp: Change return type to void
  tty: vt: Change return type to void
  usb: xhci: dbc: Change return type to void
  Bluetooth: Change return type to void
  um: Change return type to void
  isdn: capi: Change return type to void
  misc: pti: Change return type to void
  mmc: core: sdio_uart: Change return type to void
  staging: fwserial: Change return type to void
  staging: gdm724x: gdm_tty: Change return type to void
  staging: greybus: uart: Change return type to void
  tty: nozomi: Change return type to void
  tty: vcc: Change return type to void
  usb: cdc-acm: Change return type to void
  usb: usb-serial: Change return type to void

 arch/um/drivers/line.c              |  7 +------
 drivers/isdn/capi/capi.c            | 10 ++++------
 drivers/isdn/i4l/isdn_tty.c         |  3 ++-
 drivers/misc/pti.c                  | 28 +++++++++++++---------------
 drivers/mmc/core/sdio_uart.c        | 11 ++++-------
 drivers/s390/char/con3215.c         |  3 ++-
 drivers/s390/char/tty3270.c         |  7 +------
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 drivers/staging/gdm724x/gdm_tty.c   | 11 +++--------
 drivers/staging/greybus/uart.c      | 10 ++--------
 drivers/tty/hvc/hvc_console.c       |  7 ++-----
 drivers/tty/hvc/hvcs.c              | 10 ++--------
 drivers/tty/mips_ejtag_fdc.c        |  4 +++-
 drivers/tty/n_gsm.c                 |  9 +--------
 drivers/tty/nozomi.c                |  8 +++-----
 drivers/tty/serial/kgdb_nmi.c       | 11 +----------
 drivers/tty/synclink.c              |  3 ++-
 drivers/tty/synclinkmp.c            |  3 ++-
 drivers/tty/tty_io.c                | 10 ++++++----
 drivers/tty/tty_port.c              |  4 ++--
 drivers/tty/vcc.c                   |  5 +----
 drivers/tty/vt/vt.c                 |  5 +----
 drivers/usb/class/cdc-acm.c         | 10 +---------
 drivers/usb/host/xhci-dbgtty.c      |  3 ++-
 drivers/usb/serial/usb-serial.c     |  6 +-----
 include/linux/tty.h                 |  4 ++--
 net/bluetooth/rfcomm/tty.c          |  7 +------
 27 files changed, 73 insertions(+), 148 deletions(-)

-- 
2.7.4
