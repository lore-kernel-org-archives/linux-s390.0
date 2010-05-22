From: Jonathan Nieder <jrnieder@gmail.com>
Date: Sat, 22 May 2010 19:58:45 +0000
Subject: [PATCH] fill out file list in s390 MAINTAINERS entry
Message-Id: <20100522195845.GA12411@progeny.tock>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Noticed with scripts/get_maintainer.pl -f fs/partitions/ibm.c

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 MAINTAINERS |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff0784b..8d0d34a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4813,6 +4813,9 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	arch/s390/
 F:	drivers/s390/
+F:	fs/partitions/ibm.c
+F:	Documentation/s390/
+F:	Documentation/DocBook/s390*
 
 S390 NETWORK DRIVERS
 M:	Ursula Braun <ursula.braun@de.ibm.com>
-- 
1.7.1
