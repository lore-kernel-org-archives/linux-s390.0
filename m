Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/7] vfio-ccw: fixes
Date: Mon,  3 Jun 2019 12:50:31 +0200
Message-Id: <20190603105038.11788-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 674459be116955e025d6a5e6142e2d500103de8e:

  MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390 (2019-05-31 10:14:15 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190603

for you to fetch changes up to 9b6e57e5a51696171de990b3c41bd53d4b8ab8ac:

  s390/cio: Remove vfio-ccw checks of command codes (2019-06-03 12:02:55 +0200)

----------------------------------------------------------------
various vfio-ccw fixes (ccw translation, state machine)

----------------------------------------------------------------

Eric Farman (7):
  s390/cio: Update SCSW if it points to the end of the chain
  s390/cio: Set vfio-ccw FSM state before ioeventfd
  s390/cio: Split pfn_array_alloc_pin into pieces
  s390/cio: Initialize the host addresses in pfn_array
  s390/cio: Don't pin vfio pages for empty transfers
  s390/cio: Allow zero-length CCWs in vfio-ccw
  s390/cio: Remove vfio-ccw checks of command codes

 drivers/s390/cio/vfio_ccw_cp.c  | 159 +++++++++++++++++++++++---------
 drivers/s390/cio/vfio_ccw_drv.c |   6 +-
 2 files changed, 119 insertions(+), 46 deletions(-)

-- 
2.20.1
