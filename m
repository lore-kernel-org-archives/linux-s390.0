From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] S390-virtio: Adjustments for three function
 implementations
Date: Tue, 16 May 2017 17:50:43 +0200
Message-ID: <d02fd34c-da59-0c33-d859-e49ecb4eb1c5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:43:21 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete error messages for failed memory allocations in two functions
  Improve a size determination in virtio_ccw_setup_vq()
  Adjust a null pointer check in two functions

 drivers/s390/virtio/virtio_ccw.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.13.0
