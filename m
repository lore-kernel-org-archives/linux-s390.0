From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 19 Feb 2019 08:49:10 +0000
Subject: [kvm-unit-tests PATCH 0/3] s390x: Report string cleanup
Message-Id: <20190219084913.198737-1-frankja@linux.ibm.com>
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
  s390x: Add prefix for dxc afp emulator test

 s390x/emulator.c |  3 ++-
 s390x/pfmf.c     | 18 +++++++++++++-----
 s390x/sthyi.c    | 45 +++++++++++++++++++++++++++++----------------
 3 files changed, 44 insertions(+), 22 deletions(-)

-- 
2.14.3
