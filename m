From: Jiecheng Wu <jasonwood2031@gmail.com>
Date: Sat, 18 Aug 2018 09:41:05 +0000
Subject: [PATCH] fix wrong return code of sysinfo_show() when get_zeroed_page() fails
Message-Id: <20180818094105.5124-1-jasonwood2031@gmail.com>
In-Reply-To: <20180818093800.GC3455@osiris>
References: <20180818093800.GC3455@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Function sysinfo_show() defined in arch/s390/kernel/sysinfo.c returns wrong error code when function get_zeroed_page() fails. The correct return code when get_zeroed_page() fails is -ENOMEM but the code returns 0.
---
 arch/s390/kernel/sysinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 12f80d1..1da471f 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -280,7 +280,7 @@ static int sysinfo_show(struct seq_file *m, void *v)
 	int level;
 
 	if (!info)
-		return 0;
+		return -ENOMEM;
 	level = stsi(NULL, 0, 0, 0);
 	if (level >= 1)
 		stsi_1_1_1(m, info);
-- 
2.6.4
