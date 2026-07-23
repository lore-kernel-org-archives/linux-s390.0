Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAB3A5E7A;
	Thu, 23 Jul 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828892; cv=none; b=K4Fuy+VLivogZdskqpKZYw/HvzU5VdRr5hpIvPyRgaA54mcW5+1CiCzW6jiy/Ay8jDRrPJwyW7pteOXx/Vajz+vODoGvL4dbmXLT/TjMlDtm9BlTakeduo3wAldzH52Q7DJ+/DEQl6TFBIRILDp6gAnRfiMCgvMdnrSDA8JU+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828892; c=relaxed/simple;
	bh=vFswtA4p//bmZG11dIiJCPd2J48vRVwprbu6jW5ywp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au5at7VHon6ZBvXoBJ9E2cjjq+YDk/iSuXum7PwLMuez/4ND3IuO3eY5aO0E/4hjYDyE0FkQIfiKBWDjJFYVAajXPz49Uhgh8mxlbeFJ8Esbnq0fSuI/7biOqSnWstP9kFs8t2dm6wvhz4PZMKwrS5ePkLeYfbOGC7YhnRgoaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bjuMxpDZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bjuMxpDZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgJ8K3579843;
	Thu, 23 Jul 2026 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2UKf1h3GfCkMAo6UL
	EFfzvtbJkGh2SjHnacxPqPr60o=; b=bjuMxpDZkQGdrUALB1E6/nk2BBJC2Gsmc
	5mHbdp+vJ/M+/wAMRmBeGv++4VMy7WT29osyoEk+zPHEbNcDtNNApmdbdXAkqnN1
	+p8bTBmEpb2phbzgQp7UT+nbSVZDTa0CgmKGzmlQqA0QpbQZQXrTbpsZAONxQ2oA
	Fq/0iV6iPfK78keB2x1XonVihmAaaBF/RGabSKeGFhsPaFyOp8fZRYbxih0IKbbm
	xMVyP2c0NJ1Q1ykQLIX9XFPJTP9XUrJfO8gyXBobt1wtMxklzYB1CxQJp7nPV2B2
	wY3dkojdJkacL/maOzLhLrhL/4DF2QIS7yXP7AEMC6LDuvuhxEwng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gg8ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZ2vE009753;
	Thu, 23 Jul 2026 17:48:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gn5at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHm5GM53739850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:48:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDA5C2009E;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C118E2009A;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id A350A1627F5; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v3 3/8] s390/vfio_ccw: fix out of bounds check on CCW array
Date: Thu, 23 Jul 2026 19:47:46 +0200
Message-ID: <20260723174751.1180334-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723174751.1180334-1-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX03z3GPIDTCdh
 XYEh4LTNbptStZkGIZsysUaby774XxoKmux4TXkDs+Lw0VSeq53gxrPMqngMQG/5hXiuep6q22b
 4GF1KUulKDepq4zD295AgPOibKHLf4/XomeVTWqEnOEUAaWikxkNqxKit4DdPhLlw7nkZVWuvW8
 3HAB2ML+o1HPA2QTQnkBlUV80NkIRfCUwK1e3dtVl7P+L4WL784kTrfSzbDtYG7xwcKRSBYcCrX
 3GdOLHcf6bpjyNcXBO3GXdQFyOfYmjvDQvzKME80dkYUyifzWs5+bBPbvhWZKH8fc4O4rYWpmtr
 gEvBvRrJmyUxNNvd5ex86XXaAQ9YHzS3ouZGbUm1BASy2adgR39zGF/Ny8aqlSmSNN/V4akog9x
 3k38EtdjYc0zgMzmtpH0t3v0zxLsafXiqE9fMItRD1lLlHx5LR9Qowq2BjVAqfLlfWYU1Qdu7pa
 MDcCys6nj2s9f1Ctn3Q==
X-Proofpoint-GUID: uBGdCKDf5VZj0Vud60J0vMTuQEAHy2GU
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a6253d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ztfy0_AA8xUuwmIluScA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX/Sguq9W5dwni
 K5fn7MdFyjEX6T6/luEx6Z5AuIQBLBTcObmJkQQGEgLuKKBiZqNEVmCSBMdtTvo4rYTiFmTfCm3
 1SJVPz8OO6AuEUGGPYqK/SkgFiD4RTI=
X-Proofpoint-ORIG-GUID: uBGdCKDf5VZj0Vud60J0vMTuQEAHy2GU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

The routine ccwchain_calc_length() counts the number of channel
command words (CCWs) that are chained together in a single channel
program, and rejects anything larger than CCWCHAIN_LEN_MAX (256) CCWs.

The loop itself is "do..while (count < 257)", and while the logic in
is_cpa_within_range() correctly adjusts between the 0-index array of
CCWs and the count of CCWs starting at 1, this means it would look
at a possible 257th CCW before ending the loop and (correctly)
returning an error.

Fix this by restructuring the loop to break as soon as 256 CCWs
(thus indexes 0-255) are examined, without looking at memory
outside the range.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 1c2890d139c6..258a99930c6a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -393,11 +393,14 @@ static int ccwchain_calc_length(u64 iova, struct ch=
annel_program *cp)
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
 			break;
=20
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
+		/* Exit the loop when we reach the maximum */
+		if (cnt >=3D CCWCHAIN_LEN_MAX) {
+			cnt =3D -EINVAL;
+			break;
+		}
=20
-	if (cnt =3D=3D CCWCHAIN_LEN_MAX + 1)
-		cnt =3D -EINVAL;
+		ccw++;
+	} while (1);
=20
 	return cnt;
 }
--=20
2.53.0

