Return-Path: <linux-kernel-owner+w=401wt.eu-S1753481AbZKPSl0@vger.kernel.org>
Message-ID: <4B019FC2.3060004@gmail.com>
Date: Mon, 16 Nov 2009 19:53:54 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] s390: ensure NUL termination by strncpy()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

For a larger source string, strncpy only NUL terminates when
the size argument is less than the size of the destination string.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/s390/kernel/ipl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Is this maybe needed?

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 4890ac6..d52fcb4 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1881,7 +1881,7 @@ void __init setup_ipl(void)
 		break;
 	case IPL_TYPE_NSS:
 		strncpy(ipl_info.data.nss.name, kernel_nss_name,
-			sizeof(ipl_info.data.nss.name));
+			sizeof(ipl_info.data.nss.name) - 1);
 		break;
 	case IPL_TYPE_UNKNOWN:
 		/* We have no info to copy */
