Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216343FD05
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832098; cv=none; b=GIFzvHeLvi+ZkVTEyEzKOnIVfG4z8VM9pHmfTF7T2aTOH2NPu9IEDvRimC4A3TLT7Vx6ayAJ79z1XdcsBoboebI7BnEJQg1t610LNR34SVWIRou8oSU2GjPlVyPzVV8KwT1lccwhcwyFuo714qrVSkKkEW53vp9UVDQJ498kFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832098; c=relaxed/simple;
	bh=5t8MS45RYc2ofjYhWAh4ktKSYkCHf+rY2/l8CINpylM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHOZ8AUiqEPANnv4/i/DuSymnLDcfDSRefzP6+McarIxiKXkE31mfaXJGxdiWs4FbmRzhQQFQrSXR8YaiBa77EimTbpT9/Bpnyzdg4k06jFxUfZR0TSETU2hBXoXZJQ/OzRem+JUNsJAUaIgiloy9XmBoNea/HGs2tRnEhF4TDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Opionctb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Opionctb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9VX4d2607556
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WRCkQMJQHVGiO0zCUkloxXPbFsu7Ed
	Ya38NpYW0s2HU=; b=Opionctb64Fx/WMEgQK/rNV/ibOp9hTTshodqw5p82se+q
	sz6D+nnfTzGfhBdAv3jOyFMRVSz1XazqHrPZotJMzkS5YGcxSvXqv/J+M9jseiuC
	GOb9pclSqfIlLTik/slH1t9Lx53Gni317Rk7few2gcas9PjMRAFtR3ZNRnH/XhR7
	m/OZRebQcUUdp/Bv41MXaMvKv/+tNmaBMnO8n0kQPcTkOzwhiXdT5YOdsuulFrkk
	mVVlmEh66M1BNgJ81iOVXq+7dFU26RyUQ1tsCBjmg5HyG44Ilz6GDo513kgkdoHn
	rW9GMpxan627ZxDHKhRDr8oZS/fatp7ALq7sI6qg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g55626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RBuMhb018592
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhfsw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RC1UD545220290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 12:01:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 938372004D;
	Thu, 27 Aug 2026 12:01:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D4BB20040;
	Thu, 27 Aug 2026 12:01:30 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 12:01:30 +0000 (GMT)
Date: Thu, 27 Aug 2026 14:01:30 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/3] s390/boot: Avoid IPL parameter append past command line
Message-ID: <p02-03.g5fb840964ae7.ttkffvj@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-03.ttkffvj@ub.hpns>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AlCL-QtgNS_DgWvNWnMG_uMraD21TIZz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfX6TPLA9l7qlgI
 Qu1bfOl+DrM1vi6vO9cwV8k+EuCwvxoQPA9rDWO86XY9J54XIPLx2JQlNLPwZfbqnjZGykJRBx8
 v2JJfPi/8hq3jFminw7EH5E8xAbJnKI=
X-Proofpoint-GUID: AlCL-QtgNS_DgWvNWnMG_uMraD21TIZz
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a902720 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=l27wsS5qwOX4oZzckMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMCBTYWx0ZWRfXwvq6IvAD9b1+
 tMguEzmB3t3CxD+4w5NfDBWi/mF2fZzva/inzzxL+Ut3Gq/mfKtMB1p7a9tTsfGZ676Pb+8BvsB
 CXmmsemrsNTZ39A85aqd1ptiyf0FRasPUEBoQtJCHxT3ZBAIY1Rsx7CTNF90WV2HIWLLydWJXeO
 lpoMmPrVd7XgPa63tXxf4AwfLzxPYtStDh52NHwl2+17LxsvLlwIjQL6ETdXPBMpnE1iMV6GxMT
 As9/9c0JghdW2ah7XK2kGm7yLg9QWcdBZN0jf4YuvOaM5BopLPrt37idU5G0RU36tGUwmx4vGdc
 5M16pRVVVurVS8WLhOap0IsWlTyziZyXREXqTE1XS+EYZ0wdVQhCmZSlX3yQGAHy9gCfMdtxYXs
 er6Y72W0gr+01o6qlg0ZW1fnkodiTrnCN9IRzu6nkMxRRy+aRMTLwpU1818VBlSGF1Yp3TMDl/r
 3QAliCovwTa+UsTRl2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270100

A command line may occupy all but the terminating byte of
COMMAND_LINE_SIZE. In that case append_ipl_block_parm() passes a zero size
to the IPL parameter conversion helpers and points the destination one
byte past early_command_line. The helpers subtract one from the unsigned
size and write the converted parameter outside the command line buffer.

Convert the IPL parameter in the command line parsing buffer first. A
parameter beginning with '=' can then replace the existing command line
regardless of its length, while other parameters are appended only when
space remains.

Fixes: 5ecb2da660ab ("s390: support command lines longer than 896 bytes")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/ipl_parm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be7..8aa7639ae0cb 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -23,6 +23,7 @@ struct parmarea parmarea __section(".parmarea") = {
 };
 
 char __bootdata(early_command_line)[COMMAND_LINE_SIZE];
+static char command_line_buf[COMMAND_LINE_SIZE];
 
 unsigned int __bootdata_preserved(zlib_dfltcc_support) = ZLIB_DFLTCC_FULL;
 struct ipl_parameter_block __bootdata_preserved(ipl_block);
@@ -135,31 +136,32 @@ static size_t ipl_block_get_ascii_scpdata(char *dest, size_t size,
 
 static void append_ipl_block_parm(void)
 {
-	char *parm, *delim;
+	char *delim;
 	size_t len, rc = 0;
 
 	len = strlen(early_command_line);
-
-	delim = early_command_line + len;    /* '\0' character position */
-	parm = early_command_line + len + 1; /* append right after '\0' */
+	delim = early_command_line + len; /* '\0' character position */
 
 	switch (ipl_block.pb0_hdr.pbt) {
 	case IPL_PBT_CCW:
 		rc = ipl_block_get_ascii_vmparm(
-			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
+			command_line_buf, sizeof(command_line_buf), &ipl_block);
 		break;
 	case IPL_PBT_FCP:
 	case IPL_PBT_NVME:
 	case IPL_PBT_ECKD:
 		rc = ipl_block_get_ascii_scpdata(
-			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
+			command_line_buf, sizeof(command_line_buf), &ipl_block);
 		break;
 	}
 	if (rc) {
-		if (*parm == '=')
-			memmove(early_command_line, parm + 1, rc);
-		else
+		if (command_line_buf[0] == '=') {
+			memmove(early_command_line, command_line_buf + 1, rc);
+		} else if (len < COMMAND_LINE_SIZE - 2) {
 			*delim = ' '; /* replace '\0' with space */
+			sized_strscpy(delim + 1, command_line_buf,
+				       COMMAND_LINE_SIZE - len - 1);
+		}
 	}
 }
 
@@ -245,7 +247,6 @@ static void modify_fac_list(char *str)
 	check_cleared_facilities();
 }
 
-static char command_line_buf[COMMAND_LINE_SIZE];
 void parse_boot_command_line(void)
 {
 	char *param, *val;
-- 
2.53.0

