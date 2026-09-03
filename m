Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249834A64F5
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440875; cv=none; b=T2m3Ga6N4775/Omi0jfEK0qNpGUslvNoJRrZ9NEOUwsr43f4qvg3pWQY94E+o3gvlrEsf69m5lFNMXiFTeESnVSAKd7F357syYkMyhwJe09n0MosY1XaE+I30PJ5yaELCDdBlOEhpUhFYXjsZiFtKbu/RVxEt1dkjKuMPAf8gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440875; c=relaxed/simple;
	bh=jbkcro95Pbrd2rsOxy+BkORRqK0+plzk3yvfigVwLx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9nQScyoonwryqNpVBtMKlENXqUmqsZ6I4KDXvAqn0uKVKxKstDZxgXVuY2txGDkt0zVlrTH6ou/TyuFBAZc8Iqqpgo7gNvphIzHV78tmd42WwK6Zv+xhvzd9paoDLnhltcN1fwo2iAL71CXt5o8FGkbguPqenLUQoaO2SMHwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BYc18Q1L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BYc18Q1L"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AVjHR2617805
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yH7mn+Z1p/hIgMdcVvk0VSUcXd/LLnQP5pugy+HjM
	rU=; b=BYc18Q1L9sAC3MOqnleCBnXsVLAAYXVXGQ2HsQLf/0G8HseutKJ6tE9iQ
	Y/R4E2PPctDuAhD63RQJt6iIr6dDwQl1L6BomQm7o22cx+0pWJRNqn9ZrjV8vzFD
	MHantaup2QdIo27uWxpqcuOn+7e1fVTh1impBbdsKV0lZh0EaXHtzf7ZwUWwfqYS
	PIbvE8chCSSZgipkJRWis/UIL/ggcfRmWSitLnShGqyn6fr5U1+5NdX+ux9pV0mK
	P1Onupq2rE8wjsjYPbWW1v32/ctVdyDiOdldEz0IfKnXGOKBhUELDLiceWcWIrjr
	BrV0NOqfIGE2kwwOBQnnxTI5+BQkg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj4qkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683CuFp4025179
	for <linux-s390@vger.kernel.org>; Thu, 3 Sep 2026 13:07:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjar4wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 13:07:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683D7Ytc15728914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 13:07:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2779D20040;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B92120043;
	Thu,  3 Sep 2026 13:07:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 13:07:33 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v3 0/3] s390/debug: Fix several s390dbf issues reported by AI scan
Date: Thu,  3 Sep 2026 15:07:30 +0200
Message-ID: <20260903130733.709001-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZV2zfFUtNQC8MJdR0HExcCeel-JAaZrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX0AJS8hJKJmpm
 2WJvugak+64vJx/O6xKe5sLeVtEDtlrlIecq22k0y4BQthBOuWT/EoPUJYkNU03sFMoQv57mvZB
 SG13IjUWAzH2OIJ7n6lwUdGXb/xVRShN/NxVNhbcTPcXOJHkUdwSkTw7cz86Vt5CclM4B1Kz3b/
 nLMhCbpw0jUjOBL2b53L6VuDF6QvxBNTCcXUsbOsABle0sdvFZoIDhev8Ph33hlxxw+dFtETUYz
 /cgwE093J9Iz5YiqPFBykltrB22KCxl0jYT6iNTeSj6SQbOi9fAeY/IHFapO5xwXRdhIzNFF4IC
 yRwvj8iDlcz7+o7ryxQ/faH3E1wgOjMTefC0WhPbuMnd8Zec/vxpdBtLmeOM2DdcVKc5w7LURTK
 QHk0pDmuM+Z8B3EUB/N/k+9zFwx498qY3zEZ9QKDH8+B/arlA0UJawOn4jSYu4kAFGUINrLO3yC
 4XplxCTHuxgmDK4r+3Q==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a99711b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=dRcrNZYWpG77ggIxQPMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExMyBTYWx0ZWRfX/tE39BcrxnCq
 bYzpNxOXg+guC0nMoghx0UhjxvtDks846EcJoXF5FJPuTSfhrCqLgY5I5xZw4W9Rum9NI/xfS5Y
 wKQBzT/Llzm0gb3M7A2+8tL1qV7xDL0=
X-Proofpoint-ORIG-GUID: ZV2zfFUtNQC8MJdR0HExcCeel-JAaZrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030113

The s390dbf kernel parameter was added in commit a2cec6863709
("s390/debug: Add s390dbf kernel parameter"). This series fixes
three issues found in the surrounding code.

Patch 1 fixes a NULL pointer dereference in debug_set_level()
introduced by that commit: the NULL check for the id argument
was moved into the _debug_set_level() helper, but the newly added
debug_get_param() call was left in the wrapper ahead of it.

Patch 2 eliminates a duplicate override notice that appears when
drivers call debug_set_level() right after debug_register(), which
is the common pattern. With the s390dbf= parameter active and
many devices (e.g. many DASDs), this produced a lot of redundant
log lines during boot.

Patch 3 fixes a pre-existing race between debug area resize and
event logging. Setting pages to zero via the debugfs interface
races with concurrent event writers: the unlocked id->areas check
passes, but by the time the lock is acquired debug_areas_swap()
may have published a NULL pointer, which get_active_entry() then
dereferences. The race was confirmed to hang the system in testing
by running concurrent debug area resize (pages 0->4 in a tight
loop) against parallel DASD I/O.

Changes in v3:
- Patch 3: put back !id->areas check under lock in debug_flush()
  and remove existing !id->areas check before the lock (Peter Oberparleiter)

Changes in v2:
- Patch 1: Trimmed commit message; !id check removed from
  _debug_set_level() (Peter Oberparleiter)
- Patch 3: Trimmed commit message; !id->areas check removed
  from debug_flush() (Peter Oberparleiter)

Mikhail Zaslonko (3):
  s390/debug: Fix NULL pointer dereference in debug_set_level()
  s390/debug: Do not repeat parameter override notice on
    debug_set_level()
  s390/debug: Fix race between debug area resize and event logging

 arch/s390/kernel/debug.c | 54 ++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

-- 
2.55.0

