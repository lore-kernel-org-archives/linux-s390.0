From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:16:41 +0000
Subject: [strace PATCH 03/12] print_fields.h: add macro to print hexadecimal array field
Message-Id: <20180118061641.GA28845@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* print_fields.h (PRINT_FIELD_HEX_ARRAY): New macro, prints target
array with QUOTE_FORCE_HEX.
---
 print_fields.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/print_fields.h b/print_fields.h
index 0af087a..b2c6a30 100644
--- a/print_fields.h
+++ b/print_fields.h
@@ -107,6 +107,15 @@
 				     sizeof((where_).field_));		\
 	} while (0)
 
+#define PRINT_FIELD_HEX_ARRAY(prefix_, where_, field_)			\
+	do {								\
+		STRACE_PRINTF("%s%s=", (prefix_), #field_);		\
+		print_quoted_string((const char *)(where_).field_,	\
+				     sizeof((where_).field_) +		\
+					    MUST_BE_ARRAY((where_).field_), \
+				    QUOTE_FORCE_HEX); \
+	} while (0)
+
 #define PRINT_FIELD_INET_ADDR(prefix_, where_, field_, af_)		\
 	do {								\
 		STRACE_PRINTF(prefix_);					\
-- 
2.1.4
