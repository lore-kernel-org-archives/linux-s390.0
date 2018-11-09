From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:29 +0000
Subject: [RFC PATCH v1 02/10] s390/cio: Fix cleanup when unsupported IDA format is used
Message-Id: <20181109023937.96105-3-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Direct returns from within a loop are rude, but it doesn't mean it gets
to avoid releasing the memory acquired beforehand.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ef5ab45d94b3..70a006ba4d05 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -387,8 +387,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * orb specified one of the unsupported formats, we defer
 		 * checking for IDAWs in unsupported formats to here.
 		 */
-		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
+		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw)) {
+			kfree(p);
 			return -EOPNOTSUPP;
+		}
 
 		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
 			break;
-- 
2.16.4
