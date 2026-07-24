Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B541DEDC
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889621; cv=none; b=uvol9LSauEZbHVuWXKq/1uiKxy8ybdhkUGIKCQbhIrmLWHbC+mx5riRMxq4Cw2rVJfwPsx5EjoNMk6RHv3OP5ScAYdoaLU472+ypP5YPmNYSABdsxWZ1J9tXzByPR30LB/5HR3O6yQJb3d5DdRpNqPOh7U5ePjgHyLfhqUG3YFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889621; c=relaxed/simple;
	bh=a0pgS48EzeH49N6YAc8P8WMyJ8Y5lgxH5Rb75rXK3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGF98B65FWI2JGOh5ZcgojEZ7mUdaLh9jqnfOj3yCQI/qCx3YjIz66aUSQbV9ixuZAau7YjUQYsk5aVEn2swJ2XO9niuqPY3YO5MC9Rd4U7jd+GexQ5EVMhYq7o0GDUUjm5Wek5SoSpYBgfDWXentqFwA+AgwQRt9jajvcRrxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q+CRDuv7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q+CRDuv7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADXqa1547143;
	Fri, 24 Jul 2026 10:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3Xfdg+d9ymPVJirbM+Q0vBCjOZssZSMQwrWCkQ2R+
	Cs=; b=q+CRDuv7cWXg2pCWhI42DPnBUGFjK2zUUAr7AXg3//QUa89KYbeaFSVJ0
	+6eB6BGgt5ZGxesu7eTaNM57v/Hmv8QtwBydg8WtgpK9OLvHsdy9nz2DIlEcEp9B
	RyeuL4oiWu42iy6NwDrMWmwRdF8P/HW6qvnVyMWmK52EBSP2QXOhzlHLJSl+r7NJ
	OmNJfsc1aXrSiqK9JdNHwrRYweWJ3MwkElmiguqUpSvi4osaVj43+iW7guy3lxZS
	32ArLmnAmcchkQoHkiBcTBcAJot75+SbJl8CwvaNwyju1zgw54oR0CrdP2TA2QKD
	3nAnUrkcYoKGK2TswwKtIES52CvKw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahkjqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:40:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OAYhhj028300;
	Fri, 24 Jul 2026 10:40:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqgpa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 10:40:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OAeCNM27198194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 10:40:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9014820043;
	Fri, 24 Jul 2026 10:40:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F50120067;
	Fri, 24 Jul 2026 10:40:03 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:40:03 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH v3 0/2] Improve DIAG 9c observability
Date: Fri, 24 Jul 2026 12:39:56 +0200
Message-ID: <20260724103959.14861-1-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0TdCnrHOMpAaSyHNpzVmU25B1z2d_Wyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX7BWBTKicKo18
 l59V/VqEa1zKsNpRP04B7eYSbQ1d0DVJkdi+cnHioBES6Asn04qzr+FZ2fPN6o7vCY0CGhwR51L
 bSq0VNmwpd7lm2RqwMogFnq+i3auz553mHtVMl6BVegCnptit1Vsbrg9L32mN/QuLe1GH4mW/KI
 etm9lDHXBa0mut26O9a696rcUUBOM7iGHpKzWYEm56cW+FaOquwZe8gQlFMXZPVDLvlAXxgWjBL
 eKG8gjPV/BVRmi7w58QbWYzty3JQ41EHhWImEEZHVJXg0FxaQY7WtsFp/112bNUMy7y7IGm9rlq
 Fs8WqxiOpgqpY6WsZnGTUXTLHTWaZMP8j9NwJRCiOMdz+/kGzXg0s0bcOa9wJeCr1zjR4CyGxdO
 u0WsJAiN1/iwFhEyrrlz9PtKeJfx0fbB3Ve+ud769oTeAQbxYfL+9J4gc27GLKtaC0PlS1GHKQD
 4VKm8kQezmHuU/VY+qQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX67q8KmDXzC0Z
 fukny87t9TbmQUirJogIZ5Apu+5Vh7QyTDKLkRBkM3HsuoLJKDi9se+eFZGcIHBLw6nqeDJKl6A
 P5NcWQW8WnbVhSKDPNkS6jt+WqK+Ns0=
X-Proofpoint-GUID: 0TdCnrHOMpAaSyHNpzVmU25B1z2d_Wyv
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a634111 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=e05qxJdhFS1Mp7vzFoYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093

This series enhances observability for DIAG 9c directed yield operations
in s390 KVM by refactoring the handler and adding comprehensive tracing
support.

The first patch refactors __diag_time_slice_end_directed() to use a
single exit point with a result string variable. This consolidates the
control flow and eliminates code duplication in logging statements,
making the function more maintainable.

The second patch builds on this refactoring by adding a new tracepoint
kvm_s390_diag_9c that captures detailed information about directed yield
operations, including target vcpu, target physical CPU, and operation
results. This enables better analysis of VCPU scheduling
behaviour and helps diagnose performance issues in virtualised s390
environments.

Together, these changes provide kernel developers and system
administrators with better tools to understand and debug VCPU scheduling
patterns related to directed yields.

---
Changes in v3:
 - Patch 2: Remove duplicated target_cpu and target_vcpu fields

Changes in v2:
 - Add system maintainers to review mail

Ciunas Bennett (2):
  s390/kvm: Refactor __diag_time_slice_end_directed for single exit
    point
  s390/kvm: Add tracepoint for DIAG 9c directed yield operations

 arch/s390/kvm/diag.c  | 19 +++++++++++--------
 arch/s390/kvm/trace.h | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.54.0

