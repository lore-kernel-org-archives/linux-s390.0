From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw: bug fix
Date: Fri, 20 Apr 2018 10:24:03 +0200
Message-ID: <20180420082404.13949-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit fae764912153065ea55eda47f834e0764a54df94:

  s390/signal: cleanup uapi struct sigaction (2018-04-17 10:36:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180420

for you to fetch changes up to c25e3c8e91318ddc17261c7dff053e00a213f176:

  vfio: ccw: process ssch with interrupts disabled (2018-04-19 17:29:31 +0200)

----------------------------------------------------------------
A vfio-ccw bug fix (call ssch with interrupts disabled).

----------------------------------------------------------------

Cornelia Huck (1):
  vfio: ccw: process ssch with interrupts disabled

 drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.14.3
