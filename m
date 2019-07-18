Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
Date: Thu, 18 Jul 2019 10:09:03 +0200
Message-Id: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Martin Hostettler <textshell@uchuujin.de>, Adam Borowski <kilobyte@angband.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

Not really harmful not to, but also not harm in grabbing the lock. And
this shuts up a new WARNING I introduced in commit ddde3c18b700 ("vt:
More locking checks").

Reported-by: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/tty/vt/vt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ec92f36ab5c4..34aa39d1aed9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3771,7 +3771,11 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct con_driver *con = dev_get_drvdata(dev);
-	int bind = con_is_bound(con->con);
+	int bind;
+
+	console_lock();
+	bind = con_is_bound(con->con);
+	console_unlock();
 
 	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
 }
-- 
2.20.1
