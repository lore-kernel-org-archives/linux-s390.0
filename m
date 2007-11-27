Return-Path: <linux-kernel-owner+w=401wt.eu-S1759253AbXK0Q3c@vger.kernel.org>
Message-Id: <20071127162210.262064983@de.ibm.com>
Date: Tue, 27 Nov 2007 17:22:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/4] Latest patches for s390
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The following patches have been added to the 2.6.24 queue:

Christian Borntraeger (2):
      [S390] dcssblk: prevent early access without own make_request function
      [S390] Fix compile error on 31bit without preemption

Cornelia Huck (1):
      [S390] cio: Issue SenseID per path.

Peter Oberparleiter (1):
      [S390] cio: add missing reprobe loop end statement

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
