Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBA3D564D;
	Wed, 15 Apr 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243158; cv=none; b=CLsLFLRSElMwblc+umyeCmXo6OAUICqSOBCfQKxAYZ4TcjrY0k7qIW1vtZGjVxpxQVYrtgk5oe8E3gARVyK7GnA+eovsu83S/2aP+FTRCh/WR+AA5XmIy/DMedI3puE+mV8SJvohfkO7CdknHLXhYFhzCo2gGARhNXBxfrAJNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243158; c=relaxed/simple;
	bh=0aXrKQddpzOuYQsyNQqoXAjXf8iTFBoN/KxME/xPAhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBxfMKd3FJ2+uHjReUdmbLSJEAj0Dwg1klUKdP2J6/kq4UhB0eu1Hdm76zlZgT80euszMWhDayh0QbIW/ABIRrCzzcTRQxx2iWmnz5kFSgGRApFGa48eVKpICoQ2f4wEPmQqP+R2Rr7+3t7vE/vEWe3B6ukwkE3MTHRGWwfAPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kjuZfmht; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kjuZfmht"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F2p9uK1833389;
	Wed, 15 Apr 2026 08:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EjMxopoA74uOD24fx
	385Z5fmryPNf92pbE8g+FFLVmU=; b=kjuZfmhtu4gMz6d+Jr031yrQbPwtV1+OU
	mqlR3PX6UBp99DxCHWDbn8twh8eqHfj0oX+ogrhGIgUnACN+4A4hAr3GK8fwtk2y
	9RyqbEkLIOp48XS5NHsQ9LqYH+62vKUYMhZAKCtxH86QHZ2nG7wXYT8rqzPn9XWT
	GButGJn3VfN6bJG9zd7H3hbSPLvEDDfgW4tz+YPwvcbEerT9Hij45YnReq4sO/uG
	//IGZvIel3b+KHoAZownNymL8Igp9AcGclAd2RFfIBu7NnMdD5zF3PWUmWjPsth4
	3nri3ukZ9KdR32EmH3IxJJdFZF9T4wMZtbdTjzq2S47tkHzUX83kA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rf5hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F4YX5U025837;
	Wed, 15 Apr 2026 08:52:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujn7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qV0U40370634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57C120040;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC622004B;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 2/5] lib: s390x: sie: Allocate physical guest memory via memalign
Date: Wed, 15 Apr 2026 08:45:42 +0000
Message-ID: <20260415085145.91197-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415085145.91197-1-frankja@linux.ibm.com>
References: <20260415085145.91197-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfX1fxQADB9aYH5
 lkHxpxoG9kSccQOcbAlhHc5HYbu0SH/xb2eZcRn3QbNaxX7J9hNk3bkIERNINmyX2/PhU+abEvS
 YNyi1vJkeZl7JeKVdtQVMfXR/ptO+vVZoDD+b4SuxWmzs3PDm+MqsE0qCn5Umk6+LQXq9WL4TSf
 tkqicgxRoW1tJoZjfAHnNMPcKK5y30ZAoBBVG79eqap2a53eijHVu6k+Aamma1aTQEnVQpPRw2C
 wtEMXcGNP38g8oxjc5ql5Eyc76C1aqF8EkQ2GYQ8iGmElToRhSCihIdtFAhKaZy7r1rdh6ChEFv
 OjB42TZB3HEnElcVeFbgijpySC3shKGhvPCpAt335fTlLq/hAv6hRipTgVehwvIpAV8KmBri1ai
 DeGBftXp0opF2opXp7Z7qpkHFb/p58lxEIMg4OxnuHkI5j1pK62MidLQQItZudtkROdlzEgajP/
 aA9hsRnxwFgwWI1ss3w==
X-Proofpoint-ORIG-GUID: O04gYTwyjknzgNiZWd9zkx7aVIwQawL-
X-Proofpoint-GUID: O04gYTwyjknzgNiZWd9zkx7aVIwQawL-
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df51d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GueWrYxDVtNpybNoHvoA:9
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150080

alloc_pages_flags() alignes the allocation on the same order as its
requested size. Since we use virtual memory for SIE we can instead
align to 1MB by using memalign() which is less wasteful.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/sie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index a397400b..a49c45c7 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
 	guest_virt = (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL * SZ_1G, SZ_2G);
 	guest_counter++;
 
-	guest_phys = alloc_pages(get_order(guest_size) - 12);
+	guest_phys = memalign_pages_flags(SZ_1M, guest_size, 0);
+	assert(guest_phys);
 	/*
 	 * Establish a new mapping of the guest memory so it can be 2GB aligned
 	 * without actually requiring 2GB physical memory.
-- 
2.51.0

