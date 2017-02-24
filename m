Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] Documentation: Update path to sysrq.txt
Date: Fri, 24 Feb 2017 10:42:14 +0200
Message-Id: <20170224084214.6889-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Commit 9d85025b0418 ("docs-rst: create an user's manual book") moved the
sysrq.txt leaving old paths in the kernel docs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/media/v4l-drivers/bttv.rst          | 2 +-
 Documentation/s390/Debugging390.txt               | 2 +-
 Documentation/sysctl/kernel.txt                   | 2 +-
 Documentation/virtual/uml/UserModeLinux-HOWTO.txt | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/media/v4l-drivers/bttv.rst b/Documentation/media/v4l-drivers/bttv.rst
index bc63b12efafd..195ccaac2816 100644
--- a/Documentation/media/v4l-drivers/bttv.rst
+++ b/Documentation/media/v4l-drivers/bttv.rst
@@ -312,7 +312,7 @@ information out of a register+stack dump printed by the kernel on
 protection faults (so-called "kernel oops").
 
 If you run into some kind of deadlock, you can try to dump a call trace
-for each process using sysrq-t (see Documentation/sysrq.txt).
+for each process using sysrq-t (see Documentation/admin-guide/sysrq.rst).
 This way it is possible to figure where *exactly* some process in "D"
 state is stuck.
 
diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
index 3df8babcdc41..5ae7f868a007 100644
--- a/Documentation/s390/Debugging390.txt
+++ b/Documentation/s390/Debugging390.txt
@@ -2116,7 +2116,7 @@ The sysrq key reading is very picky ( I have to type the keys in an
 This is particularly useful for syncing disks unmounting & rebooting
 if the machine gets partially hung.
 
-Read Documentation/sysrq.txt for more info
+Read Documentation/admin-guide/sysrq.rst for more info
 
 References:
 ===========
diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index a32b4b748644..bac23c198360 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -85,7 +85,7 @@ show up in /proc/sys/kernel:
 - softlockup_all_cpu_backtrace
 - soft_watchdog
 - stop-a                      [ SPARC only ]
-- sysrq                       ==> Documentation/sysrq.txt
+- sysrq                       ==> Documentation/admin-guide/sysrq.rst
 - sysctl_writes_strict
 - tainted
 - threads-max
diff --git a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt b/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
index f4099ca6b483..87b80f589e1c 100644
--- a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
+++ b/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
@@ -2401,9 +2401,9 @@
 
   This takes one argument, which is a single letter.  It calls the
   generic kernel's SysRq driver, which does whatever is called for by
-  that argument.  See the SysRq documentation in Documentation/sysrq.txt
-  in your favorite kernel tree to see what letters are valid and what
-  they do.
+  that argument.  See the SysRq documentation in
+  Documentation/admin-guide/sysrq.rst in your favorite kernel tree to
+  see what letters are valid and what they do.
 
 
 
-- 
2.9.3
