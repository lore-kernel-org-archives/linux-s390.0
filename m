Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfFLKQt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Jun 2019 06:16:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw: bugfix
Date: Wed, 12 Jun 2019 12:16:44 +0200
Message-Id: <20190612101645.9439-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 753469a23b42d0c4a2b28de35826af74a4d554ab:

  Merge tag 'vfio-ccw-20190603' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features (2019-06-04 15:04:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190612

for you to fetch changes up to 5398331c8c218cc9298fe95380b8b87a3a62defa:

  vfio-ccw: Destroy kmem cache region on module exit (2019-06-04 17:32:01 +0200)

----------------------------------------------------------------
Fix a memory leak on exit.

----------------------------------------------------------------

Farhan Ali (1):
  vfio-ccw: Destroy kmem cache region on module exit

 drivers/s390/cio/vfio_ccw_drv.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.20.1
