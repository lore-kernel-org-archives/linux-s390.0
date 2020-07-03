Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgGCJxC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 05:53:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw fix
Date: Fri,  3 Jul 2020 11:52:52 +0200
Message-Id: <20200703095253.620719-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 9e9f85e029a2ee4167aacf3ff04e4288a5e5c74e:

  s390: update defconfigs (2020-07-01 20:02:38 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200703

for you to fetch changes up to d8ca55addb9315ecd9fc4397f4c94d3f1980161c:

  vfio-ccw: Fix a build error due to missing include of linux/slab.h (2020-07-03 11:41:31 +0200)

----------------------------------------------------------------
add a missing include

----------------------------------------------------------------

Sean Christopherson (1):
  vfio-ccw: Fix a build error due to missing include of linux/slab.h

 drivers/s390/cio/vfio_ccw_chp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.4
