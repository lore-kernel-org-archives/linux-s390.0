From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390x: add the proper defines for data types
Date: Thu, 22 Jan 2015 10:51:50 +0100
Message-ID: <1421920310-1499-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-sparse/>
List-Post: <mailto:linux-sparse@vger.kernel.org>
To: linux-sparse@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch fixes several issues when compiling code under s390x
(64bit) with cgcc, e.g.
/usr/include/gnu/stubs.h:8:12: error: unable to open 'gnu/stubs-32.h'
by providing the proper defines.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 cgcc |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/cgcc b/cgcc
index 8e38174..d7b1c99 100755
--- a/cgcc
+++ b/cgcc
@@ -279,6 +279,12 @@ sub add_specs {
 		&float_types (1, 1, 21, [24,8], [53,11], [113,15]) .
 		&define_size_t ($m64 ? "long unsigned int" : "unsigned int") .
 		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
+    } elsif ($spec eq 's390x') {
+	return (' -D__s390x__ -D__s390__ -D_BIG_ENDIAN' .
+		&integer_types (8, 16, 32, $m64 ? 64 : 32, 64) .
+		&float_types (1, 1, 36, [24,8], [53,11], [113,15]) .
+		&define_size_t ("long unsigned int") .
+		' -D__SIZEOF_POINTER__=' . ($m64 ? '8' : '4'));
     } elsif ($spec eq 'host_os_specs') {
 	my $os = `uname -s`;
 	chomp $os;
@@ -294,6 +300,8 @@ sub add_specs {
 	    return &add_specs ('x86_64');
 	} elsif ($arch =~ /^(ppc)$/i) {
 	    return &add_specs ('ppc');
+	} elsif ($arch =~ /^(s390x)$/i) {
+	    return &add_specs ('s390x');
 	} elsif ($arch =~ /^(sparc64)$/i) {
 	    return &add_specs ('sparc64');
 	}
-- 
1.7.1
