From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 0/1] vfio: ccw: bugfix
Date: Thu, 20 Jul 2017 05:19:49 +0200
Message-ID: <20170720031950.64438-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Conny,

I got a vfio-ccw bugfix on the kernel from Jason. The patch looks good to me.

BTW, is it fine with you to let the author sending the patch to you directly,
or you prefer we queuing a batch of fixes on our devel branch and send them to
you together periodically (say, target on a certain release)?

Regards!

Jason J. Herne (1):
  vfio: ccw: fix bad ptr math for TIC cda translation

 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.2
