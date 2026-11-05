Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888131;
	b=G1j2poI0jJKZeAuLA5pzIpzEFBScknfSIveXvlj+FcPPmiQU8eRWP3T3iUM/qACsPI+I
	 uOh0XAnoPIhyrAFBhdCcx1GEs9duOrQ4SoiF3qCawxsQxk9p/PBEk4vW2Ek0R3pzdvZ4/
	 2buIzwYbW33b+jfDyJkqlpd6Yvvuo7b1z7qVFG0BRjaR7OcTp0F5EiuK2Nls/g1KaP2Bj
	 +Z84SYlwKz+fM1sLXDfynmTKgzFMEI7xkKnYz2TqHw8Hjp1w3t2x9SV8XWsEaqg/6RiLa
	 I8FsUMKYTrsogOtuApRqE+7QhMf7OblK7TPzAjuZl+2OSMnS3YaBGRq3NrEEsTvFBVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AYCrl/o76CQIK0hYxKW+2eBH3mu3znrWT//PxWp7iBY=;
	b=WqyFhX16qxeJ/un6usB/f4WznLhs6B346G80ReRst6Q/Ty/nE2sRpPi29o4pgq8yEi5V
	 W2QzpnHrO3uowzMwH0qPfMzOyTnjL8+CfZoBFDg/WADN1/LF4KMTQZ9KJJOjo0JqGpN7/
	 JeYmjD8VfDV0RcrR6qhBtbZZkXY0iGXyG7PTjlb5jfyidB2N8zs5SG20BhVY6tUK7BBXt
	 74/s+9+2w6Xc3dyvV+wF6WMqBwnhxiCcOHTmCkLp9B7YMtvwcvfwQs18GW3c39Svym08E
	 mxgHIwbP2GbZbLFxCnkfBCt7g3bgOp0sQsLRbsOXuO/jzGPT/NE37moy7lCwEeCY0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QXwWR1bI;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84B606A334;
	Thu,  5 Nov 2026 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F84B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QXwWR1bI
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AECMr3166406;
	Thu, 5 Nov 2026 14:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=AYCrl/o76CQIK0hYxKW+2eBH3mu3
	znrWT//PxWp7iBY=; b=QXwWR1bIUaycaITbxxhkZhXDy+6WwusN5zXqBGlu/FSF
	HQ9vfw93ZouZ1DUNBveRBjyeR78XdVsBAcYRvaYtrGlywu8oEjq0cADc7wQ5H2LI
	fnk7dDDI4L47MATO7w71GHruKxrDVc79P3DclrpMtff1YiXxTyppS8hvMB9sv2PX
	JzZKKknmIZJHNufxY/7BFWcibEY3rt/O76EIRfJjA17jxD2VjNVpZt5bonIs9vmf
	JUfFV5dzXfNm7UOItnbGAE9ogW7cxJcLn+gYY1bSmU9+o0jQkopSV8Zdv1md9icM
	yXqx0NTYwwHV1aUcaGiKdW1SoLs7uMIxubZ2cs7Rhg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj2e9m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:15:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5DbfeV1476854;
	Thu, 5 Nov 2026 14:15:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6t98u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:15:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EFQbW2949672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:15:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A63DB5805E;
	Thu,  5 Nov 2026 14:15:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A48C358051;
	Thu,  5 Nov 2026 14:15:24 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:15:24 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Date: Thu, 05 Nov 2026 15:14:29 +0100
Subject: [PATCH] KVM: s390: arm64: Tolerate unused functions in extracted
 source
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-series1-fixups2-v1-1-55f59e6c4c7b@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNTXYh6Q920zIrSgmIjXYvkVLPkZFOTRCPDNCWgroKiVKAU2MTo2Np
 aAJLhddphAAAA
X-Change-ID: 20261105-series1-fixups2-8ce6cc54a21f
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=yCJ8zGH+ys0Hbi94LcD/skXHomxBfRnUILXn21GG6fM=;
 b=owEBbQKS/ZANAwAKAXUg1t0k8konAcsmYgBq7I96JowTaCmMZeVHPm0wzskK+pz7jLWynmv7v
 PMRsqKugR6JAjMEAAEKAB0WIQRrKkreGscL2VvlPix1INbdJPJKJwUCauyPegAKCRB1INbdJPJK
 J9eqD/98WkIoZIeqbaWO1pF4HvruVvBayNPYCt1u+ayvQxp99lfsgRTWT+TaWI9fGrtinWpeiEv
 Nva7qI/uB2SPUTLQbRt9DB3z7D1at9mZRkxz2DwzWiDe91ww4P0HrhwHnqBnazVdnVdsXchAiok
 4789G9Uy6u5lYkGoWtDWYcrCxs6ET7wTXzTFftNKDUfiy31IoLA6Dd4lQCOUozRMKmDKC40H96R
 accVrdi8BomJ9ZMFCKIv9rELHGvhw9tL41BQuNuruJvnY76G7uPFc3DRuQNRLvU/t/fYIdT7V4x
 A8jMgnFrhGvqRedFDWB9Dr4veZAPMSmeMkxkgr/O4VplxHNXvBmF5zVlA/fmpD9Mh+zBLv/oYfE
 1s51PqO9CTpko8rOLBo81uQkCz1N5ezgnboJgIk0tUAcJyhHWntYARlfg2GcxkzAjA3ZrVFKlem
 kVRaNjJ4UgFGUwbRVc6LFaarKf9LaoqAzF1Qyfed/edfgtPaNu3Zu9KZ/mClt7rxAHKHhKDI9RG
 1qOYLraSw59Tv8zy9kNdwjBoato5dp7pMdXu9BDvofmBdEoUJ+FAkQTBpzC4SwQxuewoIArJx/M
 rEEkbajLrnB+HG33eXCt47QlMqjPOj53HP2ec2gEJAzjZonzIMtEzaRbuzahLqAnRNsABGrV/mb
 g9AqUxr8UYqYxQA==
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JqCHrPexS5atIXJlMebujOw8HEeRsmlZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX0WE0RHBivj6E
 loA130TDGlYpmTxfbUG/k7i/VTEkUqXotLiO3wB6A+ODExk9lQNcQ/YKm1xWR6mFB35Mw6uQDOd
 r+GhBis0uTvNKTPim69fQXk0LPZ+Hac=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec8f80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=R7EaXgVFCislUhSyr_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX1UU9DjYlv7Wu
 Vqt09p0Zh4AOdmrwEhnDntSlbkFqKmvAxoAh9fsCAgUj4PWMhtQzf4ISMMy2GzRudJFmrqjL3Wk
 YUVgW1vWJAayE3TrC/CLFumcnJ2lBzB5wU61v7yFIF8bJuHtHyD7QIJVOE9AviZjq2dWVSpI9qF
 01m17tlKnwZcsjlEJBdzcxW8T2ibp94d93G1bmsX7+cdUmBmF7jMwjyiNPC083bmLojYbO0A6+X
 +XIjFpESC1kEVOvmAR8xvoMiQkiJ22R+RvQ9YKbQkVYAjgBg6EgkFcn2W9K/iepvRyy7EVwzS8p
 nqcSGRtAVjd46ULkQlo/BcsEx9AxFvMB6/g1zmOFNlOf9g4K/ucXdCgniarjoKM1eyU7JW8Kq9w
 s6Q4FyryGPiKOTPkjaXbIifNfKismd0S3kjWwXc8yAZb/evf+EQ1o6Pphu5Go9EpaSMBlj2BIXF
 n25bNqBRmxBxPsNHeWw==
X-Proofpoint-GUID: JqCHrPexS5atIXJlMebujOw8HEeRsmlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050056

Extracting static declared arm64 functions with no consumer on the s390
side into the generated sources causes compiler warnings when subsuming
the generated sources from s390. This causes spurious compiler warnings
that make it harder to extract larger, more cohesive portions of the
arm64 source.

Update the extraction logic to wrap the extracted source into diagnostic
pragmas to disable -Wunused-function for the extracted block. This
allows us to share more freely, and also opens up more paths for future
code sharing with a separation of extraction and definition of consumers
in separate commits.

Obviously no functional change intended.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/copy-arm64c.awk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/copy-arm64c.awk
index 640a7bcb7e23..a318be97c419 100644
--- a/arch/s390/kvm/arm64/copy-arm64c.awk
+++ b/arch/s390/kvm/arm64/copy-arm64c.awk
@@ -42,6 +42,9 @@ BEGIN {
 	print "#endif /* __INCL_GEN_ARM_FILE */"
 	print "#undef __INCL_GEN_ARM_FILE"
 	print ""
+	print "__diag_push()"
+	print "__diag_ignore_all(\"-Wunused-function\", \"tolerate unused functions shared from arm64\")"
+	print ""
 
 	file_header_done = 1
 }
@@ -78,5 +81,10 @@ copying {
 }
 
 END {
-	exit error || !found_marker || copying
+	ok = !error && found_marker && !copying
+	if (ok) {
+		print ""
+		print "__diag_pop()"
+	}
+	exit !ok
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261105-series1-fixups2-8ce6cc54a21f

Best regards,
-- 
Andreas Grapentin <gra@linux.ibm.com>

