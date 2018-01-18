From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 18 Jan 2018 06:16:39 +0000
Subject: [strace PATCH 02/12] Add print_quoted_string flag to generate comment
Message-Id: <20180118061639.GA28769@asgard.redhat.com>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Because there are never enough print_quoted_string flags.

* defs.h (QUOTE_EMIT_COMMENT): New quoting flag macro constant.
* util.c (string_quote): Emit " /* " in the beginning and " */" in the
end if QUOTE_EMIT_COMMENT is passed.
(print_quoted_string): Increase alloc_size by 7 if QUOTE_EMIT_COMMENT is
passed.
---
 defs.h | 1 +
 util.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/defs.h b/defs.h
index 2311d86..51b1355 100644
--- a/defs.h
+++ b/defs.h
@@ -530,6 +530,7 @@ str_strip_prefix_len(const char *str, const char *prefix, size_t prefix_len)
 #define QUOTE_OMIT_LEADING_TRAILING_QUOTES	0x02
 #define QUOTE_OMIT_TRAILING_0			0x08
 #define QUOTE_FORCE_HEX				0x10
+#define QUOTE_EMIT_COMMENT			0x20
 
 extern int string_quote(const char *, char *, unsigned int, unsigned int);
 extern int print_quoted_string(const char *, unsigned int, unsigned int);
diff --git a/util.c b/util.c
index 49cb81b..9a99e1a 100644
--- a/util.c
+++ b/util.c
@@ -497,6 +497,8 @@ string_quote(const char *instr, char *outstr, const unsigned int size,
 		}
 	}
 
+	if (style & QUOTE_EMIT_COMMENT)
+		s = stpcpy(s, " /* ");
 	if (!(style & QUOTE_OMIT_LEADING_TRAILING_QUOTES))
 		*s++ = '\"';
 
@@ -576,6 +578,8 @@ string_quote(const char *instr, char *outstr, const unsigned int size,
 
 	if (!(style & QUOTE_OMIT_LEADING_TRAILING_QUOTES))
 		*s++ = '\"';
+	if (style & QUOTE_EMIT_COMMENT)
+		s = stpcpy(s, " */");
 	*s = '\0';
 
 	/* Return zero if we printed entire ASCIZ string (didn't truncate it) */
@@ -591,6 +595,8 @@ string_quote(const char *instr, char *outstr, const unsigned int size,
  asciz_ended:
 	if (!(style & QUOTE_OMIT_LEADING_TRAILING_QUOTES))
 		*s++ = '\"';
+	if (style & QUOTE_EMIT_COMMENT)
+		s = stpcpy(s, " */");
 	*s = '\0';
 	/* Return zero: we printed entire ASCIZ string (didn't truncate it) */
 	return 0;
@@ -632,7 +638,8 @@ print_quoted_string(const char *str, unsigned int size,
 		tprints("???");
 		return -1;
 	}
-	alloc_size += 1 + (style & QUOTE_OMIT_LEADING_TRAILING_QUOTES ? 0 : 2);
+	alloc_size += 1 + (style & QUOTE_OMIT_LEADING_TRAILING_QUOTES ? 0 : 2) +
+		(style & QUOTE_EMIT_COMMENT ? 7 : 0);
 
 	if (use_alloca(alloc_size)) {
 		outstr = alloca(alloc_size);
-- 
2.1.4
