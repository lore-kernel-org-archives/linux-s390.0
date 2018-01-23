Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/3] s390: documentation update
Date: Tue, 23 Jan 2018 16:02:42 +0100
Message-Id: <20180123150245.30312-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: corbet@lwn.net, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The first two are updates that I had around for a long time, but
somehow forgot to send them out.

While looking at the result of make pdfdocs, I found that the output
for the cmf stuff looked a bit suboptimal, so I added a bonus patch
for that.

A branch based on the s390 features branch can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/cohuck/linux.git s390-doc-update

Cornelia Huck (3):
  s390/docs: mention subchannel types
  s390/docs: reword airq section
  s390/cmf: fix kerneldoc

 Documentation/driver-api/s390-drivers.rst | 32 +++++++++++++++++++++++++++----
 drivers/s390/cio/cmf.c                    | 15 ++++++++-------
 2 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.13.6
