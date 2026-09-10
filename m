Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251E3D6CD3
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032735; cv=none; b=XLzeIobqO4LfE9LlWNTkFpMhhna997VLRdJnJGXKjUI0v+TzAAkzs5JcXFXIYMF+SVZfeyk5K1HLgPEu3PmaJP7HVWURqSWWUt8Zok1SUFI5RAxdbL8TWx72ZmnJoPN3h4YUxvYWTQl/t1I9CNA19Ab28SwUN1JW833r3qVAhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032735; c=relaxed/simple;
	bh=X3I6HYw3IMM8K+V0RxtLb4CvdzKxfl3IoOXxgG56cNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnN6r9ekV9qn0aHa1AG1TIPxwU7wCTNbQ1ynJwMdqc2VLLo3oGWqh/r0dXToWhtekSoQIGaySgfPZBzFEJ0RQ5xc8TwsK25OdtTpTzxYsnxsrpKbHUvwZteGqs6ZnK60vTfHSmSv1wBA/TClETH8YzoDlwOx6I1bMg4aiZlyyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WjB1J3sg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WjB1J3sg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91xZi2484083;
	Thu, 10 Sep 2026 09:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9hm6VbcLkhj2xzG9WReJQhQUxlp9
	8RfFKs/MyBo86a4=; b=WjB1J3sgNpSfUhCqEzMEbzwlld26GKEk2aLLh+uIYAzE
	JXREGS6yK9pYHqYHji5sz2c7oELU84yjzzWjc6jk7yJf01r9lIoV/XLgrz4fYmFF
	1m7rWzTDAcTzKIRSmiN+SNLIG/dy8SSonfPCMjVsBh2ETnWezXhiaaMZoXSFBxQw
	uzfVfcpS67IeaBs4UurPd33NfQ3iQyO4cnjELF2x1otTELC957rR8LCEN6Cab0sQ
	DKbW4lESyqPk6zet0vUagcK+TDUktGRLW5o1hvlJUARL0xcrX5qB0aipPb+sfYey
	q27NxciXzaL7pvzA8Zo42s0p6lTBYF00rN8pn2pHQQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sumkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A9QEx8022044;
	Thu, 10 Sep 2026 09:32:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bmbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A9W64C46924152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 09:32:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03FAC2004B;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF81320043;
	Thu, 10 Sep 2026 09:32:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 09:32:05 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 0/3] s390/cio: Harden pmcw/schib handling for dnv=0
Date: Thu, 10 Sep 2026 11:32:00 +0200
Message-ID: <20260910093205.3357827-1-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX930EL/TVyQMc
 58/t7jKXywGLOqFbBy+xoPYCGO5eCToGT77+jAWohdKZKKLLgSZN05X5tvebD984crpVEOkWuvy
 H/b4uPoLlymLi2+vnzeLdkr/9RjmW94=
X-Proofpoint-ORIG-GUID: n0yhWbgaPxY9gyrmLuvIZE2dtqeZPHHK
X-Proofpoint-GUID: n0yhWbgaPxY9gyrmLuvIZE2dtqeZPHHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX2Fq1ieWEccUg
 QlbczS3CBqYenhzfB6xnA8YQf3OoNTiQzXr+6X4PIEeopVCraEbRuNiy9Z9M60dTPU/+MCSB7i5
 2DVXTZBUvE7VcLA1LhJtkeyVyYLFZqsvMkHxhzJJsdAAFz1ufdRgLWlwXsbnJjz0ZAhtL9od0Ka
 uDsfdO3ytyQrjbuaRfrhqZSCrMplTBN8i99kNTMXb3DRvyBWKOwzRxOOPciwqHKeWFCAhdPDq7K
 IuhbsIlgMrEqybLzZbRzlPhPeWNE4a4e2M4ErJXs8UmIiA0GOHApe2gqr9kbDBq6LU7ESKggoDp
 gU9dG5gUneOQZymICEntE1FsgoVCM9BP28I/23xv5BsA1NiM5FvO/dyEMzKDAjjNKD/V+oPN+GA
 IZtVvO2PI7L65gkW1G3zIanAa3VoY/OADGbe9hhfEd3PfJLW6deZxjPYOgGhQjU1oh0VRxnzHLX
 NzGJGQgOUKh1ZM8rJdQ==
X-Authority-Analysis: v=2.4 cv=PIGaavqC c=1 sm=1 tr=0 ts=6aa2791a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nYgktii2EeDN6uVW9zUA:9 a=PRpDppDLrCsA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100108

For I/O subchannels, pmcw.dnv must be validated before relying on any
other PMCW or SCHIB fields.
Two issues exist today:
 - Some I/O entry points check pmcw.ena without first verifying that
   pmcw.dnv is set.
 - cio_update_schib() updates the cached SCHIB before validating
   pmcw.dnv, allowing an stsch result with dnv=0 to leave stale or
   undefined data in sch->schib.
 
This can trigger spurious, non-fatal error messages in the guest kernel
log when a virtio device is being detached.
 
Fix this by validating pmcw.dnv before updating the cached SCHIB. Also
clear the cached SCHIB when stsch succeeds but returns dnv=0, ensuring
that stale state is not retained.
 
Additionally, add pmcw.dnv checks before pmcw.ena checks in I/O entry
points and return -ENODEV when no device is present. Guard remaining
direct accesses to cached PMCW fields, such as chpid[] and pam, to
ensure they are only evaluated when the SCHIB contents are valid.
 
This was reported and discussed at:
 
Link: https://lore.kernel.org/linux-s390/20260612155407.199218-1-wbezenah@linux.ibm.com/ 

Vineeth Vijayan (3):
  s390/cio: Fix cio_update_schib() to not cache invalid schib
  s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
  s390/cio: Guard PMCW field accesses with dnv check

 drivers/s390/cio/chp.c          |  3 +++
 drivers/s390/cio/cio.c          | 11 +++++++----
 drivers/s390/cio/device.c       |  9 +++++----
 drivers/s390/cio/device_fsm.c   |  3 +++
 drivers/s390/cio/device_ops.c   | 21 +++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_fsm.c |  2 +-
 6 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.53.0

