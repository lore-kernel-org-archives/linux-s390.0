Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40974 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbfJJNOj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 09:14:39 -0400
From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] media: radio: wl1273: fix interrupt masking on release
Date: Thu, 10 Oct 2019 15:13:32 +0200
Message-Id: <20191010131333.23635-4-johan@kernel.org>
In-Reply-To: <20191010131333.23635-1-johan@kernel.org>
References: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Matti Aaltonen <matti.j.aaltonen@nokia.com>, Mauro Carvalho Chehab <mchehab@redhat.com>

If a process is interrupted while accessing the radio device and the
core lock is contended, release() could return early and fail to update
the interrupt mask.

Note that the return value of the v4l2 release file operation is
ignored.

Fixes: 87d1a50ce451 ("[media] V4L2: WL1273 FM Radio: TI WL1273 FM radio driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.38
Cc: Matti Aaltonen <matti.j.aaltonen@nokia.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/radio/radio-wl1273.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/radio/radio-wl1273.c b/drivers/media/radio/radio-wl1273.c
index 104ac41c6f96..112376873167 100644
--- a/drivers/media/radio/radio-wl1273.c
+++ b/drivers/media/radio/radio-wl1273.c
@@ -1148,8 +1148,7 @@ static int wl1273_fm_fops_release(struct file *file)
 	if (radio->rds_users > 0) {
 		radio->rds_users--;
 		if (radio->rds_users == 0) {
-			if (mutex_lock_interruptible(&core->lock))
-				return -EINTR;
+			mutex_lock(&core->lock);
 
 			radio->irq_flags &= ~WL1273_RDS_EVENT;
 
-- 
2.23.0
