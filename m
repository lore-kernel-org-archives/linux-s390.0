From: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: [Patch] [S390]  Fix appldata build break with !NET
Date: Fri, 13 Feb 2009 16:58:05 +0530
Message-ID: <49955945.2080809@in.ibm.com>
References: <20090213175526.d0590862.sfr@canb.auug.org.au> <49954589.9060604@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070501050605060506030606"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49954589.9060604@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070501050605060506030606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

With CONFIG_NET not set appldata build breaks on s390.

arch/s390/appldata/built-in.o: In function appldata_get_net_sum_data:
appldata_net_sum.c:(.text+0x2684): undefined reference to dev_get_stats
appldata_net_sum.c:(.text+0x2688): undefined reference to init_net
appldata_net_sum.c:(.text+0x268c): undefined reference to init_net
appldata_net_sum.c:(.text+0x2694): undefined reference to dev_base_lock

The following patch fixes the issue for me.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
----




--------------070501050605060506030606
Content-Type: text/x-patch;
 name="fix-appldata-net-build-break.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-appldata-net-build-break.patch"

* Add CONFIG_NET dependancy for APPLDATA_NET_SUM.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2009-02-09 02:07:27.000000000 +0530
+++ b/arch/s390/Kconfig	2009-02-13 19:01:18.000000000 +0530
@@ -521,7 +521,7 @@ config APPLDATA_OS
 
 config APPLDATA_NET_SUM
 	tristate "Monitor overall network statistics"
-	depends on APPLDATA_BASE
+	depends on APPLDATA_BASE && NET
 	help
 	  This provides network related data to the Linux - VM Monitor Stream,
 	  currently there is only a total sum of network I/O statistics, no

--------------070501050605060506030606--
