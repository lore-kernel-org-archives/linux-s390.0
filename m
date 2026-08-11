Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CF3C3F62;
	Tue, 11 Aug 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464888; cv=none; b=rI0HbVFkHVKKgxtKVZl8pWnI+G8+ZE2Ar+Ioi5vfUqUsWhks8+CbGgMOaxuneZSTb1/e9/WuwBRHVmBBbA/EH1xrAqNslUVoKeJdiYPn2Aew6w9jwlYyfNc19IPA4YbTazF/M9UseX/G+8gsthf05M0N3DBxjr0Td2JpSYCFky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464888; c=relaxed/simple;
	bh=lTvxNt/Ffw/Sjrxx+w3jlhccbEMH5EJamS1HrI715+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ifQ9jZkCDo7ipwB35To1podExiHK36e4j+Zz0SE04r5DeZlhzEAL2h0rBVLn/dzwcKqOVMXFoj8yh/s23vqPAczqZJ9yC+5/iVBGNYEWjkrjcTe7wnw6Kiu5eDnTY2PawRjRAg6Imo1O/oF+2IBwUjY0lcTMh+pK2SOX9qL6L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=owJ97Pqe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owJ97Pqe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDYCRM572144;
	Tue, 11 Aug 2026 16:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=PbyiJCxgh9stuqqlYwG9Ya6VuZ6X
	vz4Goun5t+TeDUQ=; b=owJ97Pqe4dZd573mSd3mk3z31BLENsijiRFxXBBeyZZj
	5PNDlJLmQ28ZcvEEq3TjoZiFaxPkI0mZrEcQywan1DT+uqpzyHTKxcPZfTI/hprq
	HG1h1Vog7Hvk0c624nrKbPRHpTkgVU9PlDeL/EFq3CmLXAolJqSfXwlxxNWbaNFF
	E8GvaMDFdYBgQqVp37g21CBu/IzNhXV2hkt7r+Zns/93ih/FeifMxbyftNN1je15
	vTg+x5kydmgWCqo0OaH0M9kDOS8knA1QTtmbV/hqBDPwW3EKRA8O9Xu+DOg0fqkM
	npnxNWF4dxqZTAB7J0woWVpJRPz7324uDA2gCn4bMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw578p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BGBGlW002898;
	Tue, 11 Aug 2026 16:14:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1fj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 16:14:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BGEdk851315144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 16:14:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC47620043;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A129820040;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 16:14:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v2 0/2] s390: uv: Various fixes for UV secrets
Date: Tue, 11 Aug 2026 18:14:20 +0200
Message-Id: <20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ6DIBAAv2L2XAxQaqSn/qMxBum2blLBgBIbw
 99Lvfc4k8zsEDEQRrhWOwRMFMm7AvJUgR2NeyGjR2GQXDa8FYKtqY9oAy6xf9LGLq1pzoMyCq2
 CEs0Biz6G967wSHHx4XP8k/jZv6skmGBacaOkMFpqeXuTW7eahqm2foIu5/wFj8yQk7AAAAA=
X-Change-ID: 20260811-uv_secrets_fix-58a63b4a4ec4
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b4a74 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hHXTDtkz-G352HbsO7MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: Tkw6UOHYNyrVnH_5jssJS95Gj5mQ2rKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX54yHVarHECmj
 r5w23JILLzkyUHlTiPJ/hJmykmJ85gCkdYOvO+1glqo5n2qXynozHSuEHWnqKrslcatvqYxm/Nf
 +u6HKmPUm2MYG1yRGxOudJw6YijyZGeCk6lR5uj15niOUmD+Uz+ELl+m39Xs0vmzZhEC+r7DEom
 7AcJAu8t8+tdqcP93FqemDKMmqHKi1lOYZO7knwUAH7j+hhXyatoNF3MDjQh10g5cPDGprkKkTf
 8th76R7d/tjQlzIW/2BSKh9ly7av1KWdxLGTNLJgiYkPA5rUiNkgFuT+CNSZijfNqyZnm/hDKBl
 NjvNZystKxEMh6CgYwvSuTn6FhsTUFUDmyPou5SPO2GR8S9bka8zwKRfXqR7540NNB6DhrfwVGy
 5HeFhDUslcM6YoAjfeUKZF01XMrDDN4jfjS6LCKIc5qNQMiZm4i6ANn56w3rf5/1UzADhdO6DhX
 Upq4DCtHranCbQBbVgQ==
X-Proofpoint-ORIG-GUID: Tkw6UOHYNyrVnH_5jssJS95Gj5mQ2rKc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzNCBTYWx0ZWRfX3E+0dtzRtgvJ
 PzJB47/Rgy1hkQ/xCBXZdcePcO+ARLEWDTuyAp9dLw9qWsivxkBstBJxQnjG0BM8UPcsgp4yGMq
 6K1UN2XH9jHaXAi9/FEKWJcvnC5vn2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110134

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
Fix some issues in the retrieve secret infrastructure. First, fix the
issue that the loop in uv_find_secret cannot ran more that one round.
Second, fix a potential out of bounds issue in find_secret_in_page.

Changes in v2:
- Add patch that fixes a potential out-of-bounds access in find_secret_in_page
- Link to v1: https://lore.kernel.org/r/20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com

---
Steffen Eiden (2):
      s390: uv: Fix loop condition in uv_find_secrets
      s390: uv: Prevent potential out-of-bounds read

 arch/s390/kernel/uv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-uv_secrets_fix-58a63b4a4ec4

Best regards,
-- 
Steffen Eiden <seiden@linux.ibm.com>

