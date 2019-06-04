Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue,  4 Jun 2019 09:58:57 +0200
Message-Id: <1559635137-20900-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk@kernel.org>

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/s390/configs/defconfig          | 1 -
 arch/s390/configs/zfcpdump_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c59b922cb6c5..18cff2e4607d 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,6 @@ CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_BPF_JIT=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 7dc7f58c4287..d92bab844b73 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -24,7 +24,6 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 # CONFIG_IUCV is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_XPRAM is not set
-- 
2.7.4
