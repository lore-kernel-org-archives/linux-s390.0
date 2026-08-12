Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FD359A6B;
	Wed, 12 Aug 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550139; cv=none; b=TEjpRpKkaMa97CiV0G1I84CCB0dCFZ3c9R07qaenaSDgHMHviVXVNUBcDYWuB/CF2gEEAc1vF+gcqDZ6npjHPa+FCuacE04qva9c3WKuwA6JDRcJWyFRCRzzKY0PTT0LQqCIbSxxAWEhf+y6qeOZ2gP+aMnQ92LDFzs4JHOEzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550139; c=relaxed/simple;
	bh=p2ttLgBSKSa0uyZf+aeGzILru7SRo/ogOkIL9vm7cFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ockQTNNdXQNb9CwjfNX+1CcFTkUu84KZysXbE3nzGSVeXk0w9Ie+jAaWQ7t6kGvKhRJ4ccv9Y0ObNzd7FDWNviLB7Ay6gCG0rIdvVS+j2+EfL95s9a1dBOasD6jVZ+bw8arTN4NSpigpNTZUk57wqj49mgrMjvDMhddlovrLqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZzZRRJY6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZzZRRJY6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1ub43594454;
	Wed, 12 Aug 2026 15:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Va6UGmcWkbAS9ZtTCFgaNjUxCgR1
	Y/Rl+mc5TEeBSNk=; b=ZzZRRJY6Xp2zFlbSPaB3IMc5pFvuUBW9DmvbquFWa1NJ
	Lo0Vlt1FpJnRwhLbmS9pLgNQ1djw5BaVqzsyxhW+qbfAKCun/1Dgh7U4Wp7NAiiO
	0CSjlDWJs5qBoIUA8lsoWQ9L4p4iEwEGA95twvPJythFKUJhTNSDdMjE0k9nieyd
	HhDcRCLmSVfzEgYqLSze0yC3XNnF47RyWPJf+UO+ZU2my/LVlwioDpowVEibXCxD
	Z2jH0IjT1lgbf1IKEMbVq6T6/eiZvUwrt0oHHB9t/NchsFoxtm3eIv0W+v0uakqm
	ZupRka7l88Yd3OYpj0F74RlUTm6MFbP/3gutzGP6vA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32gxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFfGsq010375;
	Wed, 12 Aug 2026 15:55:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gen95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFtUjj49545702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:55:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8682C20043;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F8D20040;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v3 0/2] s390/uv: Various fixes for UV secrets
Date: Wed, 12 Aug 2026 17:55:18 +0200
Message-Id: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33MTQqDMBCG4atI1h1JYgymq96jFInptA7UHxINF
 vHujS4L7ezeD+ZZWUBPGNg5W5nHSIGGPkVxyphrbf9EoHtqJrnUvBIC5lgHdB6nUD9ogbKyumi
 UVegUS0+jxzQf4PWWuqUwDf59+FHs608qChBgFLdKCmukkZcX9fOSU9PlbujYzkX5n5DAQat0R
 lfoyvKb2LbtA2Mr6+rzAAAA
X-Change-ID: 20260811-uv_secrets_fix-58a63b4a4ec4
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c9777 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-7hb4Qqz6WtcWSNxuvcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p-iYAKsDv_Lj_EwqS_0IEAXIQauc1hR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX6FChR9WKPLss
 uR++eAzwWBX0fryScA/eCVracMvLZaVh9VuHtj42Kv15MoXDZAsAvu5dGd85nozgnEXc0kRU1yR
 FswJ5njfUh3EhwaMdaK7kHsV836Zog5rX8YkxqNc8PXMJz4bOnKxbXftqYhB2No4zHye++u9tqc
 43rO4wvhJQjiZhkPD+z7xB7zv7g7VlEQy6cN/G3V83DIWCPsRZX1OVqLTVR+9itFHSH+Cu4Z2tI
 neNwyNq4d/ZVSmlgEL2KNnLRUL4qXGXlkJnr10SGEmcEv63VdbUSupIg4jnyrEYJYGr9Gb/CncM
 KTbqpnX5bc7JaPBVGGS+0gPqH8zWQQQO2Ssl4FKRvs7IwXgRnKgvA8BpC9tOWz7VOLRJn1POvZK
 gZQLe3KSQyiExDV+O8ayvhIkc4CZE5JZtmNqjwNaH5nOdfu7Uxsw2EMeu4NCg46TkNLgr8Mgi41
 NluNsoPIrKnf45WjtHw==
X-Proofpoint-ORIG-GUID: p-iYAKsDv_Lj_EwqS_0IEAXIQauc1hR5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX2SislPMseA38
 pp65+hFr7thHtAiUh/TGHt4Z44VQGfAno2IjWXTz7CtBEMgSZFyP9S6TsQOgoGTDuxr3GC5SNzf
 6wxoiZnXp9hUpPDpoGNaUmRMonHhl8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fix some issues in the retrieve secret infrastructure. First, fix the
issue that the loop in uv_find_secret cannot ran more that one round.
Second, fix a potential out of bounds issue in find_secret_in_page.

---
Changes in v3:
- Add R-b from Christoph for patch 1
- Improved commit message in patch 1
- Link to v2: https://lore.kernel.org/r/20260811-uv_secrets_fix-v2-0-64444968ec55@linux.ibm.com
Changes in v2:
- Add Ack from Claudio
- Add patch that fixes a potential out-of-bounds access in find_secret_in_page
- Link to v1: https://lore.kernel.org/r/20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com

---
Steffen Eiden (2):
      s390/uv: Fix loop condition in uv_find_secrets
      s390/uv: Prevent potential out-of-bounds read

 arch/s390/kernel/uv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-uv_secrets_fix-58a63b4a4ec4

Best regards,
-- 
Steffen Eiden <seiden@linux.ibm.com>

