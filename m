From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/1] vfio-ccw: start updating vfio-ccw.txt
Date: Mon, 15 Jan 2018 11:43:52 +0100
Message-ID: <20180115104353.27413-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

I started to look at vfio-ccw more closely again last week, and as
there will likely be some changes in the near future, I thought I'd
send out this doc patch at least (the file certainly can take more
updates, and I have some minor-but-not-yet-tested code changes locally).

Also pushed out to my vfio-ccw branch for people to rebase on top.

Cornelia Huck (1):
  vfio-ccw: update documentation

 Documentation/s390/vfio-ccw.txt | 78 +++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

-- 
2.13.6
