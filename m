From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 28 Feb 2019 08:35:36 +0000
Subject: [kvm-unit-tests PATCH v2 0/3] s390x: Report string cleanup
Message-Id: <20190228083539.146516-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For automated failure reporting we need unique report strings, to be
able to pinpoint the failing test. This series makes the reports
unique and cleans up sthyi reporting, so it is better readable.

This series is based on the skey fix, the pfmf patch will otherwise
result in a conflict.

Janosch Frank (3):
  s390x: Beautify sthyi report strings
  s390x: Beautify pfmf report strings
  s390x: Add prefixes for dxc afp emulator test

 s390x/emulator.c |  5 ++++-
 s390x/pfmf.c     | 21 +++++++++++++++------
 s390x/sthyi.c    | 52 ++++++++++++++++++++++++++++++++--------------------
 3 files changed, 51 insertions(+), 27 deletions(-)

-- 
2.14.3
