Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from smtp.al2klimov.de ([78.46.175.9]:40442 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgGIS14 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 9 Jul 2020 14:27:56 -0400
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] S390: Replace HTTP links with HTTPS ones
Date: Thu,  9 Jul 2020 20:27:42 +0200
Message-Id: <20200709182742.24724-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net, linux-s390@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 Documentation/s390/monreader.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/s390/monreader.rst b/Documentation/s390/monreader.rst
index 1e857575c113..21cdfb699b49 100644
--- a/Documentation/s390/monreader.rst
+++ b/Documentation/s390/monreader.rst
@@ -146,7 +146,7 @@ start offset relative to a 4K page (frame) boundary.
 
 See "Appendix A: `*MONITOR`" in the "z/VM Performance" document for a description
 of the monitor control element layout. The layout of the monitor records can
-be found here (z/VM 5.1): http://www.vm.ibm.com/pubs/mon510/index.html
+be found here (z/VM 5.1): https://www.vm.ibm.com/pubs/mon510/index.html
 
 The layout of the data stream provided by the monreader device is as follows::
 
-- 
2.27.0
