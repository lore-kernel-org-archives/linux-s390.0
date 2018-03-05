From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/2] vfio-ccw patches for 4.17
Date: Mon,  5 Mar 2018 13:31:14 +0100
Message-ID: <20180305123116.4301-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 5628683cf77bc8dad3336a9b254e55f728f7c70e:

  s390/dasd: set timestamps unconditionally (2018-02-27 08:05:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180305

for you to fetch changes up to 9851bc77e62499957567e7c39a5beba7d6de6296:

  vfio-ccw: fence off transport mode (2018-03-01 17:35:50 +0100)

----------------------------------------------------------------
A small documentation update, and reject transport mode requests
(which we don't support).

----------------------------------------------------------------

Cornelia Huck (2):
  vfio-ccw: update documentation
  vfio-ccw: fence off transport mode

 Documentation/s390/vfio-ccw.txt | 79 ++++++++++++++++++++---------------------
 drivers/s390/cio/vfio_ccw_fsm.c |  5 +++
 2 files changed, 43 insertions(+), 41 deletions(-)

-- 
2.13.6
