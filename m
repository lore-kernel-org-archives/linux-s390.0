Return-Path: <SRS0=yMf+=TD=vger.kernel.org=kvm-owner@kernel.org>
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 0/7] s390: vfio-ccw fixes
Date: Fri,  3 May 2019 15:49:05 +0200
Message-Id: <20190503134912.39756-1-farman@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The attached are a few fixes to the vfio-ccw kernel code for potential
errors or architecture anomalies.  Under normal usage, and even most
abnormal usage, they don't expose any problems to a well-behaved guest
and its devices.  But, they are deficiencies just the same and could
cause some weird behavior if they ever popped up in real life.

I have tried to arrange these patches in a "solves a noticeable problem
with existing workloads" to "solves a theoretical problem with
hypothetical workloads" order.  This way, the bigger ones at the end
can be discussed without impeding the smaller and more impactful ones
at the start.

They are based on today's master, not Conny's vfio-ccw tree even though
there are some good fixes pending there.  I've run this series both with
and without that code, but couldn't decide which base would provide an
easier time applying patches.  "I think" they should apply fine to both,
but I apologize in advance if I guessed wrong!  :)

Eric Farman (7):
  s390/cio: Update SCSW if it points to the end of the chain
  s390/cio: Set vfio-ccw FSM state before ioeventfd
  s390/cio: Split pfn_array_alloc_pin into pieces
  s390/cio: Initialize the host addresses in pfn_array
  s390/cio: Allow zero-length CCWs in vfio-ccw
  s390/cio: Don't pin vfio pages for empty transfers
  s390/cio: Remove vfio-ccw checks of command codes

 drivers/s390/cio/vfio_ccw_cp.c  | 163 ++++++++++++++++++++++++++++------------
 drivers/s390/cio/vfio_ccw_drv.c |   6 +-
 2 files changed, 116 insertions(+), 53 deletions(-)

-- 
2.16.4
