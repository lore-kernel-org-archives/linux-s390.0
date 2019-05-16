Return-Path: <SRS0=lgIa=TQ=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/3] s390: vfio-ccw fixes
Date: Thu, 16 May 2019 18:14:00 +0200
Message-Id: <20190516161403.79053-1-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Here are the remaining patches in my fixes series, to handle the more
involved scenario of channel programs that do not move any actual data
to/from the device.  They were reordered per feedback from v2, which
means they received minor massaging because of overlapping code and
some cleanup to the commit messages.

They are based on Conny's vfio-ccw tree.  :)

Changelog:
 v2 -> v3:
  - Patches 1-4:
     - [Farhan] Added r-b
     - [Cornelia] Queued to vfio-ccw, dropped from this version
  - Patches 5/6:
     - [Cornelia/Farhan] Swapped the order of these patches, minor
       rework on the placement of bytes/idaw_nr variables and the
       commit messages that resulted.
 v2: https://patchwork.kernel.org/cover/10944075/
 v1: https://patchwork.kernel.org/cover/10928799/

Eric Farman (3):
  s390/cio: Don't pin vfio pages for empty transfers
  s390/cio: Allow zero-length CCWs in vfio-ccw
  s390/cio: Remove vfio-ccw checks of command codes

 drivers/s390/cio/vfio_ccw_cp.c | 92 ++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 27 deletions(-)

-- 
2.17.1
