Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18038E95A91
	for <linux-s390@archiver.kernel.org>; Mon,  9 Oct 2023 14:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjJIOmc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Oct 2023 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjJIOma (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Oct 2023 10:42:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9EDB0;
        Mon,  9 Oct 2023 07:42:27 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EUBcb026652;
        Mon, 9 Oct 2023 14:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7fnWlKPJKoj4VASmjK9ACHr6HLo9at3f6SJYN6VB+/g=;
 b=lIHTIOaVtGObqIqvdKgfiUY8meJ8hPsPUDePC7A5GNqat7Vhn5I/8wKQSeZ090tZ1X3K
 62B9KKZF2wYcOhPe/55y+3paxWHMejSVcedq3HLce7flNwTFPbpY3+XMrDXyAl5pW9VA
 0x+L0QvOTJUfwiUW7kEHrX38fFG3fNyQjfzwtG1aO/Nk+QYZlhpvnlTJGR0GwDFgeTNF
 9dnH+Vv5WTaVygAW3V7GZku5bln5YjO7rKPE7+DS44mpJhvrfwjwYBLNbMnc1Jw5l4Fp
 2Awpw4li6FVEKLHxDh19smKeyYJGwTtmfePGwFEywKG1E7Ut8oeyJugoZtvDsLcWz/j0 kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmkb2rh6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:42:22 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 399EUGpd027382;
        Mon, 9 Oct 2023 14:41:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmkb2rfc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:41:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 399E22gL028633;
        Mon, 9 Oct 2023 14:41:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1xstct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:41:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 399EfEfp10748488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 14:41:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A84520043;
        Mon,  9 Oct 2023 14:41:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41D3620040;
        Mon,  9 Oct 2023 14:41:13 +0000 (GMT)
Received: from MBP-von-Wenjia.fritz.box.com (unknown [9.171.26.104])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Oct 2023 14:41:13 +0000 (GMT)
From:   Wenjia Zhang <wenjia@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net] net/smc: Fix pos miscalculation in statistics
Date:   Mon,  9 Oct 2023 16:40:48 +0200
Message-Id: <20231009144048.73130-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qWt7nxs6MGw56aWagdEvt8rYs2Ljee3j
X-Proofpoint-ORIG-GUID: o1VqvTBPcqjZ3JHhvz5knBLAusTQMpsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090121
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Nils Hoppmann <niho@linux.ibm.com>

SMC_STAT_PAYLOAD_SUB(_smc_stats, _tech, key, _len, _rc) will calculate
wrong bucket positions for payloads of exactly 4096 bytes and
(1 << (m + 12)) bytes, with m == SMC_BUF_MAX - 1.

Intended bucket distribution:
Assume l == size of payload, m == SMC_BUF_MAX - 1.

Bucket 0                : 0 < l <= 2^13
Bucket n, 1 <= n <= m-1 : 2^(n+12) < l <= 2^(n+13)
Bucket m                : l > 2^(m+12)

Current solution:
_pos = fls64((l) >> 13)
[...]
_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m

For l == 4096, _pos == -1, but should be _pos == 0.
For l == (1 << (m + 12)), _pos == m, but should be _pos == m - 1.

In order to avoid special treatment of these corner cases, the
calculation is adjusted. The new solution first subtracts the length by
one, and then calculates the correct bucket by shifting accordingly,
i.e. _pos = fls64((l - 1) >> 13), l > 0.
This not only fixes the issues named above, but also makes the whole
bucket assignment easier to follow.

Same is done for SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len),
where the calculation of the bucket position is similar to the one
named above.

Fixes: e0e4b8fa5338 ("net/smc: Add SMC statistics support")
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/smc_stats.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index aa8928975cc6..9d32058db2b5 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -92,13 +92,14 @@ do { \
 	typeof(_smc_stats) stats = (_smc_stats); \
 	typeof(_tech) t = (_tech); \
 	typeof(_len) l = (_len); \
-	int _pos = fls64((l) >> 13); \
+	int _pos; \
 	typeof(_rc) r = (_rc); \
 	int m = SMC_BUF_MAX - 1; \
 	this_cpu_inc((*stats).smc[t].key ## _cnt); \
-	if (r <= 0) \
+	if (r <= 0 || l <= 0) \
 		break; \
-	_pos = (_pos < m) ? ((l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	_pos = fls64((l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*stats).smc[t].key ## _pd.buf[_pos]); \
 	this_cpu_add((*stats).smc[t].key ## _bytes, r); \
 } \
@@ -138,9 +139,12 @@ while (0)
 do { \
 	typeof(_len) _l = (_len); \
 	typeof(_tech) t = (_tech); \
-	int _pos = fls((_l) >> 13); \
+	int _pos; \
 	int m = SMC_BUF_MAX - 1; \
-	_pos = (_pos < m) ? ((_l == 1 << (_pos + 12)) ? _pos - 1 : _pos) : m; \
+	if (_l <= 0) \
+		break; \
+	_pos = fls((_l - 1) >> 13); \
+	_pos = (_pos <= m) ? _pos : m; \
 	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
 } \
 while (0)
-- 
2.40.1

