From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:08:41 +0000
Subject: [PATCH 0247/1529] Fix typo
Message-Id: <20160521120841.12889-1-andrea.gelmini@gelma.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/s390/include/uapi/asm/dasd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/dasd.h b/arch/s390/include/uapi/asm/dasd.h
index 1340311..9cd0e4e 100644
--- a/arch/s390/include/uapi/asm/dasd.h
+++ b/arch/s390/include/uapi/asm/dasd.h
@@ -226,7 +226,7 @@ typedef struct format_check_t {
 typedef struct attrib_data_t {
 	unsigned char operation:3;     /* cache operation mode */
 	unsigned char reserved:5;      /* cache operation mode */
-	__u16         nr_cyl;          /* no of cyliners for read ahaed */
+	__u16         nr_cyl;          /* no of cylinders for read ahead */
 	__u8          reserved2[29];   /* for future use */
 } __attribute__ ((packed)) attrib_data_t;
 
-- 
2.8.2.534.g1f66975
