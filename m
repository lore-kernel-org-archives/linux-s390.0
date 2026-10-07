Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F23C1087;
	Wed,  7 Oct 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371285; cv=none; b=f73+6mYxQuKxGLLX8T4WWahZ55uvJUrrKCWku1NNdWrE9XHk9JOOnkBKJCs/Kufjcfwp3u4jNnSQsqhyLtWTTzZBRW+vnfSo7iB5fDA/IleAclzuyKkjbOK0Jp9CCbMpr41orSE+mW+eD1zQP815Jqqdd2LUO2pZ8UdUeDcSTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371285; c=relaxed/simple;
	bh=/+yskt7KKGGsmHdIZohuJzjh0T/3tUZpQ6W8ukFyeAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHVwNc++UMqVW2QDFTNxOgXg3J3utSu2UAG7LbwKiH+2hulSqVxpTooz9NY15Z0tOudgA96NMHw5tLZ6oZc1+B3q0QWRlezA1Pgq5wvuedPVHs+1YhH9tutt232SFdAEYb26+au53pAUtDxsndZ5xvz71HScto6kILZx1YC1gD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mrCZHNMt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mrCZHNMt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785tES2036290;
	Wed, 7 Oct 2026 11:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5R0xg5
	tB+cAtRFkO+5lX39khnRyby52LGoEILJZGnJo=; b=mrCZHNMt8iRdoXLDK9F0fB
	LKoXY9mlAtfGQKWif4eLuFapKf46ghEbYtFnCvD91ME08LoiFtBHqKFvJQSj5cYx
	Ao3+S1RGeqikW3G79iuvXTqC74e6QBcHVzuBYvuewNjnI9Ed4qoJ/5PwY1oH1Q/G
	HzedWaN7ZZzRA2eEsWZwb4JNsViccMZY5QQMMkDa1BUAt2/0m3wEZkhiaXbqLjT/
	0KPhgSQybE9h1BcUAmPXey/VW/bKHIAxT6tJ6/hlsT4A277aliUJz0YhkF1+DBrJ
	owuYEAmxA0ziwYJokKOfXn8O4Z96YmAujrSUBRYP9fZ9GRrAHcclIfTZbfb8ArqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w3sq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6977ls8a1605274;
	Wed, 7 Oct 2026 11:07:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgx76e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697B78Tj49218040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:07:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B352005A;
	Wed,  7 Oct 2026 11:07:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76FBC2004F;
	Wed,  7 Oct 2026 11:07:07 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 11:07:07 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 13:07:04 +0200
Subject: [PATCH 3/3] s390/pci: Add function handle to RPCIT insn trace
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rpcit_trcfh_upstream-v1-3-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vvAXDhv78mjVZ6gKa9FFXJwlxLqEhylh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX4Qj6AAUnKXXD
 wUM6xZx7CfURO8+Bw3//QlGqLX2Z1csyHAdPJ5fGV2rJh17f40pd8yvnnnZ4H7UBAh8+lXFawHz
 uR8/BJ8KSh12lxiq17+L+PK88ZD/KZQ=
X-Proofpoint-GUID: vvAXDhv78mjVZ6gKa9FFXJwlxLqEhylh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX6k8pISCWV4b4
 GCdgWkpZeoOdJSmdMp/Q4ItswiiL53xSa02z5T0SRk1hTOHRwpFrWQOc8KgJx8IZkrQ5QGakSpV
 dX8iK+/XNh2nrtPs8sIOKRsWftpLcbDIUW0jzTVFRvfPPfCCS4JEn/gRwKtK7ATUxq7OqDCcC9g
 suqC46O0XX3gD5S8A+daK7cYCvONfXi0P9oZKrJRmUu6ibsiMNsrk8T3MrfpNZentcqbqA78/yi
 rJ70T5PeTaiX+94I1+MTuQcbUiP8tnkKA8cCWtKWSpnRao+S7IyXwJRaSkDKDSTnIjlPKi58mVP
 9ehcNn0iMdWEZkY1bauOtSq2gyZoAMcTRE+nQ9Nzn1/dGcv0mCW9DKvRThvoZkiMcWj9GiNjt5I
 rmmo/7FWrAiI3mYKVhsotj5+xMMIRPYP2ezb1zvjA36HBl7kN2oX7JryI6iB70bqO4Zg/DW1m0A
 3ozZFf0j88scJ35Iwcg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac627e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=SMYiOtovO5ZYjaZj6uMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070044

In certain debug situations it would be helpful, if the insn trace for a
failing RPCIT would reveal the PCI function on which this was attempted.

Introduce a variant of zpci_err_insn_req() called zpci_err_insn_rpcit()
that accepts an IO virtual address and a range parameter together with
the req conveying the function handle. Switch zpci_refresh_trans() to
use that new error trace.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_insn.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 053afb3e7a99..ae9ed4aa2ec9 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -29,18 +29,40 @@ struct zpci_err_insn_data {
 	union {
 		struct {
 			u64 req;
-			u64 offset;
+			union {
+				/* PCILG/PCISTG/MPCIFC */
+				struct {
+					u64 offset;
+					u64: 64;
+				};
+				/* RPCIT */
+				struct {
+					u64 iova;
+					u64 range;
+				};
+			};
 		};
+		/* PCILGI/PCISTGI */
 		struct {
 			u64 addr;
 			u64 len;
+			u64: 64;
 		};
 	};
-	u64: 64;
 };
 
 static_assert(sizeof(struct zpci_err_insn_data) <= ZPCI_ERR_INSN_DATA_SIZE);
 
+static inline void zpci_err_insn_rpcit(int lvl, u8 insn, u8 cc, u8 status,
+				       u64 req, u64 iova, u64 range)
+{
+	struct zpci_err_insn_data data = {
+		.insn = insn, .cc = cc, .status = status,
+		.req = req, .iova = iova, .range = range};
+
+	zpci_err_hex_level(lvl, &data, sizeof(data));
+}
+
 static inline void zpci_err_insn_req(int lvl, u8 insn, u8 cc, u8 status,
 				     u64 req, u64 offset)
 {
@@ -128,16 +150,16 @@ int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
 		if (cc == 2) {
 			udelay(ZPCI_INSN_BUSY_DELAY);
 			if (!retried) {
-				zpci_err_insn_addr(1, 'R', cc, status, addr, range);
+				zpci_err_insn_rpcit(1, 'R', cc, status, req, addr, range);
 				retried = true;
 			}
 		}
 	} while (cc == 2);
 
 	if (cc)
-		zpci_err_insn_addr(0, 'R', cc, status, addr, range);
+		zpci_err_insn_rpcit(0, 'R', cc, status, req, addr, range);
 	else if (retried)
-		zpci_err_insn_addr(1, 'R', cc, status, addr, range);
+		zpci_err_insn_rpcit(1, 'R', cc, status, req, addr, range);
 
 	if (cc == 1 && (status == 4 || status == 16))
 		return -ENOMEM;

-- 
2.53.0

