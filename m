Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246B47DD6A;
	Mon, 12 Oct 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814934; cv=none; b=ufRZ0aaEsLIePrwQ3TtTacjpp+bWTOhlioDOYt2YzXUUP+a86IFOow66S6YsdmZMGVmi1NUomcCgPnyDni+hhmayR5G2tXMAW6K4WOfnlLHWfFK4tvhdnUXKR0m7N4e0prPRoR7UqLyw939xTgRWxbT7yU1rIac8z/OC1MXtRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814934; c=relaxed/simple;
	bh=Zn3j6JNYXfVo4CwBLb3J4Sg9BsOGnPCt2pXQmOHoNXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WN1RdB7PZraPclSXf7C7Hm/WZHLZnp4u9DghO9pFljqocdsFABIt7zmL+G8AEnwTvU/N1BlDDnGFgwtjN8lxDJwd7Gww0MaHmUETWDJTmlOYIa9tTR2emLZRurE4b3s+fzYBJSItBrw9dOrG2HoEPT2vcYS/QSdzIE0lF//82ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YN3EgTZa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YN3EgTZa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCESe43209928;
	Mon, 12 Oct 2026 14:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h8rDk7
	XwzGxIwAp1PlUaBPqk98Y0d3mv0l9kA0Lp8Y8=; b=YN3EgTZajpY5RTwj2xb6jo
	06mOeXzesQZweFskzPrLSDAvOZmZZEDQFewig+475BMx+0WhQblpV3gFan/hz9Nu
	7r9gDHeBPLCOzEfBafvKCBrOQZSG4HRm9eiyrgjjXBz4fjZQYKVUT4/hefROrQJo
	1YUeTTqASSrt9Vyai69MEQOMRztvXcnbE43RCJxa8w1CD/uoXfVrNTNJrkk3O7LY
	skMCRidBh5l8qs53KL1+y+VLocXinS6GzV4UjR1hzXSAFvwLw1MtwjRfCY70GRCL
	FEz6+DUCSx5F1dXS3fqQU7wUPG6yMPb1Bohvd3ru6WgcUXk4xA6/sBGIpu1ICHCg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv090sq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4ruX1286228;
	Mon, 12 Oct 2026 14:22:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyd8wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEM2Sx49086866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:22:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3CF20040;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD002004B;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:21:51 +0200
Subject: [PATCH v2 3/3] s390/pci: Add function handle to RPCIT insn trace
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpcit_trcfh_upstream-v2-3-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX6D7QwOYMDr23
 TRsOln3BvwT8s37qEj0shTMOrXoIkDYUkiSVtuvBXjjFKXNb4JZa0K7f41c9SZwQ0SKBMPizwUi
 htIoyN7X/1AjKlgrugySzhfHZ0bKTLeWgAvgzNJPbtv2GGFPpRf4rA/56+ZADnEWJzTI0FPSfGJ
 sdonf/S2HUIGuOyt7SodnbJPRyomYx21mkC2INT0Dduk335usa2DDjIxCQOyG3bpNT2VvQheIdk
 /XPDhoam1m9vREqoKgUr4BBnYaBquTDwvSHyzbtN6oE4CTnisUkdscqWs3YvfJF7hA4C7b21HIG
 6x0pTw8qxueEW2g88MkBzqNIz1AvDEkoQvmdHV5mGVlF1jNOwBgh6RkIH5gEV1bTbLQsSNNi5+L
 i7fyAho0NZJGcfaJ0yusoWeNaC3Md/BLlmTokD5HmnURIx3fd1ns8IBAuS3H5xZ7tsWC2pzYai6
 GLGaNK2JxO5pEpRKLJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX/YgRby+ChcDK
 7GKAIa5hagpPX8PQ3HcgYZC9f7YoSbE+rESm3c8A/DNvFSstzta0FLNVqwYuMPnBLohCjePSknl
 bKi+AT9age3klO6JVMyY3wHYcx1QhBs=
X-Proofpoint-ORIG-GUID: ff45u_PE3LmhsFtjQo-euj3-sFMRJaSc
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acced0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=SMYiOtovO5ZYjaZj6uMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ff45u_PE3LmhsFtjQo-euj3-sFMRJaSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

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
index 3e55adc085c3..0626667cecc6 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -28,18 +28,40 @@ struct zpci_err_insn_data {
 	union {
 		struct {
 			u64 req;
-			u64 offset;
+			union {
+				/* PCILG/PCISTG/MPCIFC */
+				struct {
+					u64 offset;
+					u64 pad1;
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
+			u64 pad2;
 		};
 	};
-	u64 pad1;
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
@@ -127,16 +149,16 @@ int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
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

