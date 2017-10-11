From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 0/2] vfio-ccw bugfix
Date: Wed, 11 Oct 2017 04:38:20 +0200
Message-ID: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Some bugfixes according to recent discussion.

Dong Jia Shi (2):
  vfio: ccw: bypass bad idaw address when fetching IDAL ccws
  vfio: ccw: validate the count field of a ccw before pinning

 drivers/s390/cio/vfio_ccw_cp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.13.5
