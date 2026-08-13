Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76583A872C
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619232; cv=none; b=Xm7ST95P6DfvPYSmeZp8JueFqWXDNYoMJ0lRHZxEMPY6w+KEQAT4PR4mjgKVxG6b5Gw9+PN2Wag7f9gDTVFeML75D8AAhrMKNh+kINri5QS3uVpbbl48/iJvUDBXqEAJ7G+0lM1tdMni+VURxQpftSvXR6X1N0DTZV5aNxTAmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619232; c=relaxed/simple;
	bh=JzKBoOGTPu8zXfwc/1o4MYFF1kamHK2Tb1gK2oY+FYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7OMoUnPhFeEXZHbj9ennoZ5wZacFwia6bPD8NFdNgW6WidoAXsnN140glcrmbgJrqQR8uWSmoC+BaaLwj3KOrbSad79sBDmcSQF9HqiyJmOA+vwdlOOChYYhE4+6yWDjHVrskW5dcHc/aPLYnjjnQ+wu5tJClyioAO9OJuv3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aF/u8uRr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aF/u8uRr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98m6v1916071
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1PRID5d4atlYzVzSIghj/XQ57nhbs+
	/J398DiY3omyk=; b=aF/u8uRr4FGw6lU6vaRZsAeWM8RYq+IwM0WG/aEvuMlbrn
	tpQS62UYEx/VWvMjrWJBwmR1GN3h0aAYAWy7NlUWiYL5t03ZCNg+8OSh7MZIuXvA
	iGK9BlO5F0ET7MvxGVzs9eFy1wpTWuhDr/FtYT/IEJWMTmMf/OKFWzn/M/DwCjrT
	XbT8UtyFYpxjS1ZIP5AIhctBIBmTSdsLf03ZYas01CyGqm7x0FT4t3OTe8hXE/BG
	tY9voI7qQOpMsm1DmkhhYfqyFlRFvXznMHAr49orKPLpBjZMdCCvMU5AGijfMr1Z
	a/LPv3dvJ9s7sQtkrtuopq1jzQfBAYT1LSU29nIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9ykma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DAuPal030768
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hanvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 11:07:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DB6uOb31654158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:06:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28B7B2004B;
	Thu, 13 Aug 2026 11:06:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E52BF20040;
	Thu, 13 Aug 2026 11:06:55 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 11:06:55 +0000 (GMT)
Date: Thu, 13 Aug 2026 13:06:55 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/ipl: Fix NULL deref in dump_reipl without re-IPL
 parm block
Message-ID: <p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns>
References: <c00-02.ttjpfvt@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-02.ttjpfvt@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX3MteDEwRiYhY
 MUx4NVp6es2B9EMHOX3+D6sVxZngyVBy5efFSZA4hVwTDu//zZ5Yx9GuPC0ynYsGSveIKKeOu+l
 Lv711QjnlJ1bz7EoKnXvit3Lb8x+/SVDHHx6o90MP+DqEpLXnZgqcp2+fgwQadizYzFOLTEhRz8
 nd9g+EIrgzY4GMMknERWSkG549mtl/YlLnUYM3Pq6C1Ym3v4CKMiP49NLVawoLJRbSKL8l0juoe
 676ICPYzGE3wBFH5P0VeCT1uKbtvb2TUETymCGtZ3JRjNIqrCD+Uy06cn4Q7aWm29p8lHktHnlU
 Mu05QrBSQs9NvcclActxwTWwPcdKrbgYVKVkUSSDSFQBAYALjGYUj7AUgUfDks3ZQRB3x2QkdKI
 5NAvolV31/lB+MUHxYHrq3TAQHn4JSJ7GfavCQYNTikGhC//vpwD0VpyivB9RjHDJpSDXkCbRa1
 ghVFwEDnvqQ+sHcwO8A==
X-Proofpoint-ORIG-GUID: 8jVzgQ0FakA9s0-SvDG9FoKiivvSz1HS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX8F0NAlNFp3LE
 lJ9tvsvdmfw0sh018EEopbXwvOqErG+tY6Hvs5z9XHsIiQT7tmwTEH+lIHIhr8MVzgPTnMu1g7x
 uU/vzj+cyUdOnutte+b4DxQabLFIu+I=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7da555 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mYyS6GfB0DZBLucIghwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8jVzgQ0FakA9s0-SvDG9FoKiivvSz1HS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130077

Unlike kdump, which passes the re-IPL parameter block through os_info,
the stand-alone dump passes it through the IPL parm block address and
checksum in lowcore.

Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might not
provide an IPL parameter block. In this case reipl_type_init() selects
IPL_TYPE_UNKNOWN and reipl_block_actual remains NULL. Nevertheless,
dump_reipl_run() unconditionally dereferences it when preparing the
lowcore fields. This may happen to work by chance when address zero
contains readable lowcore data. A zero IPL parameter block address is
then stored in lowcore, causing the stand-alone dumper to enter disabled
wait after completing the dump.

Explicitly store a zero IPL parameter block address and checksum when no
re-IPL parameter block is available. This does not change the behavior:
the stand-alone dumper completes the dump and halts, while valid re-IPL
parameter blocks continue to be handled as before.

Fixes: 099b76513992 ("[S390] Automatic IPL after dump")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 7024fc413715..68fdd5616dfe 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1929,7 +1929,8 @@ static struct shutdown_action __refdata dump_action = {
 static void dump_reipl_run(struct shutdown_trigger *trigger)
 {
 	struct lowcore *abs_lc;
-	unsigned int csum;
+	unsigned long ipib = 0;
+	unsigned int csum = 0;
 
 	/*
 	 * Set REIPL_CLEAR flag in os_info flags entry indicating
@@ -1945,9 +1946,12 @@ static void dump_reipl_run(struct shutdown_trigger *trigger)
 	    reipl_type == IPL_TYPE_UNKNOWN)
 		os_info_flags |= OS_INFO_FLAG_REIPL_CLEAR;
 	os_info_entry_add_data(OS_INFO_FLAGS_ENTRY, &os_info_flags, sizeof(os_info_flags));
-	csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
+	if (reipl_block_actual) {
+		ipib = __pa(reipl_block_actual);
+		csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
+	}
 	abs_lc = get_abs_lowcore();
-	abs_lc->ipib = __pa(reipl_block_actual);
+	abs_lc->ipib = ipib;
 	abs_lc->ipib_checksum = csum;
 	put_abs_lowcore(abs_lc);
 	dump_run(trigger);
-- 
2.53.0
