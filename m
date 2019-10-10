Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42079 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387664AbfJJNOi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 09:14:38 -0400
From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] treewide: fix interrupted release
Date: Thu, 10 Oct 2019 15:13:29 +0200
Message-Id: <20191010131333.23635-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Fabien Dessenne <fabien.dessenne@st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Harald Freudenberger <freude@linux.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>

Two old USB drivers had a bug in them which could lead to memory leaks
if an interrupted process raced with a disconnect event.

Turns out we had a few more driver in other subsystems with the same
kind of bug in them.

Note that all but the s390 patch have only been compile tested, while
the s390 one has not even been built.

Johan


Johan Hovold (4):
  drm/msm: fix memleak on release
  media: bdisp: fix memleak on release
  media: radio: wl1273: fix interrupt masking on release
  s390/zcrypt: fix memleak at release

 drivers/gpu/drm/msm/msm_debugfs.c             | 6 +-----
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 +--
 drivers/media/radio/radio-wl1273.c            | 3 +--
 drivers/s390/crypto/zcrypt_api.c              | 3 +--
 4 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.23.0
