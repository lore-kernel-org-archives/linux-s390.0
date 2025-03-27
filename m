Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E612C7FD
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089912; cv=none; b=qPDTgKq+v3YwF19TL/IRhxPHqzoLMKDUqJzLiovVpwR6Bl3dXFhbH4LNeiniS72SoE1IyyJnFwsZw6OHuf1yLW87Uk51QjEQ39SHY9de9LSkoEut1CNRwymuXLWucs5dmOzN12I2rBx4qFfG7yDz5SwnHUco0uKjftueVlfCgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089912; c=relaxed/simple;
	bh=IClEc0zrmZM36TpwHj+eCJg7HvN/1JogYiQ6t2Vd/5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umVw3VPC2MyMtTJWFUUVPJgfWw6LGblV28xL/t6LgL0HcyInyxZjRS3+Hn6kqOWF9czBWuFqWXdbPXGdMaL6d4LfAprRS3jxHSP/BEAbIl2Tz3B1+vcNz4Gq82+KoaqMaGJbYaN83laTjm1Ggue+CTKXxC9/OXPpQj+9s6xUYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7Cv7zaq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7Cv7zaq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDofBK029956
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5bdEmw0g4pZUXUXo8RyEoiPrxC+6ScEaiOn+Z64MQ
	9A=; b=g7Cv7zaqqPAMQaGNo774ytJF6Qsq8FI6sdfweLyB7x8DLN6Jd+ZeryBz6
	qvetkyjBVvUcF3yrWI1ko0cI7vBCNZHRwlnJw8lnLty5J/IcRxxIpfDffFbKaJG4
	2jKFoCUyINtz5o60Fwev3zJi46RWXkOHiavzhy8LQHjQRQ/gf0KyrA24+GKKrl2L
	IXP8TLVtDrSRG4O8eQlH39CMY5uDu6fiFWdhvSyYmARC8v4ypyJtag8ZHJAk6Xfo
	2UaAyPo+K9MOvb89K/DAShA2BKVqMqMSgkj4BoN4H8N0XOWDlmL/SNPlenXcz/Va
	l3NO6QAuGR6smo+dBqILsGvZjtXOA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29bju1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCKuWa009718
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkwt27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 15:38:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52RFcPs940042942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 15:38:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E33820043;
	Thu, 27 Mar 2025 15:38:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 070FC20040;
	Thu, 27 Mar 2025 15:38:25 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 15:38:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v1 0/1] Remove the need to alloc memory in uv.c
Date: Thu, 27 Mar 2025 16:38:23 +0100
Message-ID: <20250327153824.61600-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AznWXMBsMtYKpggd8DsSdlKKEMhAkvjP
X-Proofpoint-ORIG-GUID: AznWXMBsMtYKpggd8DsSdlKKEMhAkvjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=489 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270105

The pkey handler is calling the uv in some circumstances
where no memory allocation is acceptable. As of now only
the uv_get_secret_metadata() function allocates memory.
As this is exactly one page, lets introduce a pre-allocated
work page and protect the concurrent use with a mutex to
remove dynamic memory allocation and free. This page may be
also used with future extension to the uv code.

Harald Freudenberger (1):
  s390/uv: Prealloc and use one work page

 arch/s390/kernel/uv.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.43.0

