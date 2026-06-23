Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CA388E59
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236658; cv=none; b=qi0/N6cSm680Wnqa8QnKPSahlDsvL5kHKgqeS0mEl4smiEOUjqGd046D5k7c1HWs4B+EddqgVrQylhdhAE3ycCBBwkxkP+InfDUAE87JSKvGMbMc7WKsVdnttvD+1r35f6FhmHwlCFTS/EHb4KGQvuVBeHwZjMOy+QzG6hlhiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236658; c=relaxed/simple;
	bh=FS2UT9OUjXdg/1xOm/L5y7vbr+SnMDm8nwWVvFMsE4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osnwVlydb5xeuDW6LEq21mhLqB1UhqFvwex+61E0RQS2J9q6jnopH2IA2kHNtztHifwPZOuEj3ZJYPtz2Jbk7hRsvcGAZjbdte46UzwQo/pS8DOX9spmMWJ3Uz+nvxcOaU14Xazu3k/aZb1V0eO97/CnezJLzUFG/00GAJ4B+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quGqRqtF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quGqRqtF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmQs42135881
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Lu4lyd/AiRc3Rw1knNAYtExQHueEGmZdlSbFv1yNs
	8A=; b=quGqRqtFOLDs582Ck8hkuIweCXL/DDTkFjsd++/sxklhJulC9/2AjF0wL
	jjvfz7FJEREoDyiEFQ6jEK35et4qFNKItKWEkHp5GamEy127oWmqbfefX8XaEX9s
	socvO2vzgc2mGNLO3ZUv9Sqy0ZUSG7rmYB74ZuL0lMpv1nf+2Hi3CeB8aMmZOcmd
	Vk++xX0sM2QhYbXxd9SITmOcENVcnk+xEJlOveNIJmc26r/NNSrp7vsNhPkJ8Gp/
	R47m8ng15Hg7GoSVxuAgSKgsdRoHgTI6SuUC8aqirT7YROod3wbjNIr2gyJehufX
	upP4AKmr1lMHj3PFNY/2p8J/0klMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqqy1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NHYjUk018201
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:44:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qcs2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:44:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NHiAsT35062104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 17:44:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D4E2004D;
	Tue, 23 Jun 2026 17:44:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 692D020043;
	Tue, 23 Jun 2026 17:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 17:44:10 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2] s390/monwriter: Reject buffer reuse with different data length
Date: Tue, 23 Jun 2026 19:44:06 +0200
Message-ID: <20260623174406.189869-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3ac5ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rDSoTJiU-zr-nubo3I4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX7csYIa1h/5Up
 PhRnSJDHTUzGVoIy+Gs0AZMkYTNX9wK9B+w5d1vbwAdHHHBjgC18RPFor4QS+6WD8Tpl7Y/RaWC
 V//ow2iRs6gZynN5EqepXCzBKBJ1XJP17jbeg4Um2mN1Bp03TzUE6i2obdxe5D3tQ1C8Et004AS
 yd/Ew1f5z7KFOTvhfiz7mQDxzuQ5f09wiu472qAqoqxb8fiP28pnRYsf8WmfStdEaVY3Og4PPW8
 dOr+L8mE6Kd68L0OMPF4miqtuNg8csjwiEB1p65rSrpRIvLD1VPeYYTiFn1USnjojWdma4qXeHM
 tgmzzWjssjeTvIpzNwZYf2M9F9iKd7SqqjDUzCZ9qtth7X1VAmRBOF4L8v4e9z+/2R9dUzPf4a3
 klQNJmai/M7XfeU7FhoQRVItbTkQTQ==
X-Proofpoint-GUID: EE8ZjFsz7cS3kRCXJf1s0vf4ZJnRo89n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfXxNf73BpVpoRu
 TZybDhijvaQoTnUGBwNR6UPSwZpzL3EhJDK5jpCdQgpZ/pj6RB9z0mnvIQ2K/4Grlvm1sI9WxgM
 kCQaWbYWdY1Ogv84cXsUrxU2O+j7FRc=
X-Proofpoint-ORIG-GUID: EE8ZjFsz7cS3kRCXJf1s0vf4ZJnRo89n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230142

When data buffers are reused, e.g. for interval sample records, the
first record determines the data length, and the size of the buffer for
user copy. Current monwriter code does not check if the data length was
changed for subsequent records, which also would never happen for valid
user programs.

However, a malicious user could change the data length, resulting in out
of bounds user copy to the kernel buffer, and memory corruption. By
default, the monwriter misc device is created with root-only permissions,
so practical impact is typically low.

Fix this by checking for changed data length and rejecting such records.

Cc: stable@vger.kernel.org
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 drivers/s390/char/monwriter.c | 3 +++
 1 file changed, 3 insertions(+)

---
Changes in v2:
- Move check into "else if", to avoid NULL pointer dereference after
  MONWRITE_STOP_INTERVAL.

diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index eaeb4a6384d1..ecf121a87f88 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -122,6 +122,9 @@ static int monwrite_new_hdr(struct mon_private *monpriv)
 			kfree(monbuf->data);
 			kfree(monbuf);
 			monbuf = NULL;
+		} else if (monbuf->hdr.datalen != monhdr->datalen) {
+			/* Data with buffer reuse must not change its length */
+			return -EINVAL;
 		}
 	} else if (monhdr->mon_function != MONWRITE_STOP_INTERVAL) {
 		if (mon_buf_count >= mon_max_bufs)

base-commit: f31c00c377ccf07c85442712f7c940a855cb3371
-- 
2.53.0

