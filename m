Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B281272E53;
	Tue, 19 Aug 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619285; cv=none; b=YCkXlb9xeSYtfL45nLaA3f1OjtZ2i3gP8gL7JkmNLklQV5Ez5zI/ZPb1p7VPTjaLti0To9JUPs+U+qRRKFCj8vBpjWoOlwb71qLsE4w7MCHLDhuB+fNNgP6EOdH828yNMz/G4oON3y17riJxE+kkkHVvfgo6zsAo+tBm4t67Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619285; c=relaxed/simple;
	bh=aOZqyF6r0ZNJ15innnz31uLzrImxXGEftRXbABW1cgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3jfmHwZmxpyOaX9jUimh1v6+sIjq2XM0diCSJdwPjoe2R3q1xDnwEhY9WkwXqLLwzspdXOns2q0eJVzSfr2TWAVWIxwIyJ7MlkMBrimck2O2bDIdP543lq6yvpTsPgM0ykHHiWjaR9R/BJM+vMtqSBQ6M4x252mWcXlFIJbunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K8/InV76; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K8/InV76"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JARCHT029140;
	Tue, 19 Aug 2025 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fye+OHNoGD4lXYyQACDiIUe5MYN9Xa
	HHY+ta4HK6mNo=; b=K8/InV76Xh82YoCdFs7afgsZEyttlHXt63Zh6YobeMZEfj
	EtEbXE30jaehfJyaeqUQ83sSm0POVwmx857TgqrX4heoLZlpueQcqDPttXgbixLh
	+x6fS5j6uHwtRnGEHpTxSUVUJQ2TIjIBGfjGCswGSqzL5RwHqK9HeQgT2wbUVsNm
	CV+/ZMTT7lP2wE4x53M8hod5yeuJ9GiUqyy+rbt+O8ogNoUX7+udpUtK76Do1m3K
	bdO+hEoQtooovRGyArJquMC7qTaD/oTN7MJSPmqTjx8Q2+gT15OG9GVahxAm+LTI
	MhJAb5unREIT+boWspoVlHOV5F0X1FCrbTBVaeAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny7tyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 16:00:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JFb7r6002336;
	Tue, 19 Aug 2025 16:00:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k7132mru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 16:00:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JG0oZx17891648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 16:00:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BC920040;
	Tue, 19 Aug 2025 16:00:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9264120043;
	Tue, 19 Aug 2025 16:00:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 19 Aug 2025 16:00:50 +0000 (GMT)
Date: Tue, 19 Aug 2025 18:00:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Ben Copeland <benjamin.copeland@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20250813 s390 allyesconfig undefined reference to
 `stmmac_simple_pm_ops'
Message-ID: <20250819160049.4004887A48-agordeev@linux.ibm.com>
References: <CA+G9fYuY=O9EU6yY_QzVdqYyvWVFMcUSM9f9rFg-+1sRVFS6zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuY=O9EU6yY_QzVdqYyvWVFMcUSM9f9rFg-+1sRVFS6zQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a49fb7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Oh2cFVv5AAAA:8 a=KKAkSRfTAAAA:8
 a=21D8NHQQAAAA:8 a=ahG22T8F7ss3M2HWSyoA:9 a=CjuIK1q_8ugA:10
 a=7KeoIwV6GZqOttXkcoxL:22 a=cvBusfyB2V15izCimMoJ:22 a=aE7_2WBlPvBBVsBbSUWX:22
X-Proofpoint-ORIG-GUID: 9Z9-gqwcFfsgViyTJkXM6n-D0d5Fvw5I
X-Proofpoint-GUID: 9Z9-gqwcFfsgViyTJkXM6n-D0d5Fvw5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX1w887gs6d+JU
 WJ2lF70BNWuAIYxgdFAMVinJZDtIPe9cHScfdEU9HCAWflvccCZ7J9Q0dPGPo9T7qpqiaeedKNO
 KhmrniIdTJ39NAVZF66mFYPN7+6tCko/7AhWQoDpu6YvHp2zaIujT8SPekyZWgrQfhlKRHRE4d1
 jVrqRnqM/HpFxDv1htpHx1IkTf/vH4/3Ejtj5XgBxduNQPA//BfK1t7O62YuPsuc0dpm5M+2IAu
 mr6Pv3CMQC/XPEcNniPgg2kZnRjWg5+LcfWqyG51KLKQsodtJpKnGoeBF83sdKkRVaIUWF/Ii4u
 InQuS2rZqU9p1v2snv0qU/EnSy6rhxZYbU+d3ZNS3zK5JsSOkxMzwgcu5VWr05h5macL6glvvc8
 oBBW3MKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

On Tue, Aug 19, 2025 at 03:07:56PM +0530, Naresh Kamboju wrote:

Hi Naresh,

> Build regressions were detected on the s390 architecture with the
> Linux next-20250813 tag when building with the allyesconfig configuration.
> 
> The failure is caused by unresolved symbol references to stmmac_simple_pm_ops
> in multiple STMMAC driver object files, resulting in a link error during
> vmlinux generation.
> 
> First seen on next-20250813
> Good: next-20250812
> Bad: next-20250813 and next-20250819
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> * s390, build
>   - gcc-13-allyesconfig
> 
> Boot regression: next-20250813 s390 allyesconfig undefined reference
> to `stmmac_simple_pm_ops'
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> s390x-linux-gnu-ld:
> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.o:(.data.rel+0xa0):
> undefined reference to `stmmac_simple_pm_ops'
> s390x-linux-gnu-ld:
> drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.o:(.data.rel+0xa0):
> undefined reference to `stmmac_simple_pm_ops'
> s390x-linux-gnu-ld:
> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.o:(.data.rel+0xe0):
> undefined reference to `stmmac_simple_pm_ops'
> s390x-linux-gnu-ld:
> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.o:(.data.rel+0xe0):
> undefined reference to `stmmac_simple_pm_ops'
> make[3]: *** [/scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
> 
> ## Source
> * Kernel version: 6.17.0-rc2
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: next-20250818
> * Git commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
> * Architectures: s390
> * Toolchains: gcc-13
> * Kconfigs: allyesconfig
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/api/testruns/29579401/log_file/
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250818/build/gcc-13-allyesconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/31RcVYdjsdhroYxXs4TJYixUCaE/config


I guess it boils down to these commits:

0a529da8cfe3 Merge branch 'net-stmmac-improbe-suspend-resume-architecture'
d6e1f2272960 net: stmmac: mediatek: convert to resume() method
c7308b2f3d0d net: stmmac: stm32: convert to suspend()/resume() methods
d7a276a5768f net: stmmac: rk: convert to suspend()/resume() methods
c91918a1e976 net: stmmac: pci: convert to suspend()/resume() methods
38772638d6d1 net: stmmac: loongson: convert to suspend()/resume() methods
062b42801733 net: stmmac: intel: convert to suspend()/resume() methods
b51f34bc85e3 net: stmmac: platform: legacy hooks for suspend()/resume() methods
7e84b3fae58c net: stmmac: provide a set of simple PM ops
07bbbfe7addf net: stmmac: add suspend()/resume() platform ops

CONFIG_PM is not defined on s390 and as result stmmac_simple_pm_ops ends up
in _DISCARD_PM_OPS(). The below patch fixes the linking, but it is by no
means a correct solution:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 5769165ee5ba..d475a77e4871 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -668,7 +668,7 @@ static struct pci_driver loongson_dwmac_driver = {
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
 	.driver = {
-		.pm = &stmmac_simple_pm_ops,
+		.pm = &__static_stmmac_simple_pm_ops,
 	},
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index ac8288301994..69fcc8f10ccc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1820,7 +1820,7 @@ static struct platform_driver rk_gmac_dwmac_driver = {
 	.remove = rk_gmac_remove,
 	.driver = {
 		.name           = "rk_gmac-dwmac",
-		.pm		= &stmmac_simple_pm_ops,
+		.pm		= &__static_stmmac_simple_pm_ops,
 		.of_match_table = rk_gmac_dwmac_match,
 	},
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 77a04c4579c9..d3e1eb35b231 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -669,7 +669,7 @@ static struct platform_driver stm32_dwmac_driver = {
 	.remove = stm32_dwmac_remove,
 	.driver = {
 		.name           = "stm32-dwmac",
-		.pm		= &stmmac_simple_pm_ops,
+		.pm		= &__static_stmmac_simple_pm_ops,
 		.of_match_table = stm32_dwmac_match,
 	},
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index bf95f03dd33f..c5554ede0ba4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -375,6 +375,7 @@ enum stmmac_state {
 };
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
+extern const struct dev_pm_ops __static_stmmac_simple_pm_ops;
 
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index e6a7d0ddac2a..d1710f26d65a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -286,7 +286,7 @@ static struct pci_driver stmmac_pci_driver = {
 	.probe = stmmac_pci_probe,
 	.remove = stmmac_pci_remove,
 	.driver         = {
-		.pm     = &stmmac_simple_pm_ops,
+		.pm     = &__static_stmmac_simple_pm_ops,
 	},
 };
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574..05524761fd51 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -381,7 +381,7 @@ const struct dev_pm_ops name = { \
 	const struct dev_pm_ops name
 
 #define _DISCARD_PM_OPS(name, license, ns)				\
-	static __maybe_unused const struct dev_pm_ops __static_##name
+	__maybe_unused const struct dev_pm_ops __static_##name
 
 #ifdef CONFIG_PM
 #define _EXPORT_DEV_PM_OPS(name, license, ns)		_EXPORT_PM_OPS(name, license, ns)


> --
> Linaro LKFT
> https://lkft.linaro.org
