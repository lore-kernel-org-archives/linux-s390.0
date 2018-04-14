From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sat, 14 Apr 2018 16:43:31 +0000
Subject: [man-pages PATCH v2 0/4] some minor s390-specific syscall-related updates
Message-Id: <20180414164331.GA2504@asgard.redhat.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is the second version of "[man-pages PATCH 0/5] some minor s390
syscall updates" patch set, Message-ID
<20180114185614.GA12646@asgard.redhat.com>.

Changes since v1:
 * Changes proposed by Heiko Carstens were incorporated.
 * The patch proposed by Heiko Carstens regarding signum behaviour change
   was incorporated; however, I've tweaked it a bit, as in the end I
   decided that it worth noting the original semantics of signum
   argument, since the default handler for real-time signals terminates
   application.
 * Minor rewording here and there.
 * "s390_sthyi.2: wfix" patch was dropped as the change has been already
   applied in commit 2cd9bbfa48 "Removed trailing white space at end of lines".

Eugene Syromyatnikov (3):
  s390_runtime_instr.2: add a note about runtime_instr.h availability
  s390_sthyi.2: some minor additions
  man2: describe s390_guarded_storage s390-specific system call

Heiko Carstens (1):
  s390_runtime_instr.2: document signum argument behavior change

 man2/s390_guarded_storage.2 | 150 ++++++++++++++++++++++++++++++++++++++++++++
 man2/s390_runtime_instr.2   |  28 +++++++--
 man2/s390_sthyi.2           |  11 ++++
 3 files changed, 185 insertions(+), 4 deletions(-)
 create mode 100644 man2/s390_guarded_storage.2

-- 
2.1.4
