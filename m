Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295C38F259;
	Thu, 23 Jul 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828883; cv=none; b=VhcVFJn4Fx+ZJDHP0qfDSOJNemQB/xSdEeO+WCNYqyOmgIQBQkUu3q0uFf4PB4UHkzy6e855fR0rDsxriWfE14hq5ExHj9qLOJvg5qj1C/rlBXJS2Qn5r/Idf+45B3ZEqAht+SBydhLqRE7Fn72PP6Fix/p+CVUJ92cCt7Dk6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828883; c=relaxed/simple;
	bh=CsLpPdwJJZoTL+G3xS3ZccZNpgFVtHBdG2gha6G4H3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPazLTdj3Rp2QZ0Hr9z8DZsyaEtfjQJA9okT/DLajQQVHr7Os/ByJO0/MK/H5I48YfZkdb/WJP0+Iu2qj3LwhMNkXp3jJy/ipg8xbM0jSR+ATuHQSqVgMeRjJ4V8lsNPQchKxe+KGYP6U2mX9NXql3m9JSY6C3HINaEx6QJq9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VvkK5di0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VvkK5di0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHfdRV3681714;
	Thu, 23 Jul 2026 17:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BrONkhtlVLnrKFz+ad1SEB8m0VjNpjudET/OKWCMy
	YA=; b=VvkK5di0COgDhJi9k75SxhqLHFB9QNshqWFY/1GPOauzEUOEENJJsw4St
	4kBSFxlKgSwVA+N/JzjIk2h2SUvhIOWj3MxOkWALOH+m2TRqXMZFyhNaHF0eh3o8
	Iv96VcZ9qKx+9hd3RF8ioQHu9v476GkV20r/CJ3LE3FoAvgVCBvzX6ixLm190XV+
	+0dZICHe24/d2zbMUhcXpZ3PArN9qbGUGUeWH3eRUG0uwpacSpIl4Xag7ZUWvJx5
	LdHXqvi+iKvH7Xfar9nCGkxruCuRubBbRtgckNjFev7CopiiWvAHAA3sKhQoWaCK
	h0CrF29tRVQl74jz9QWFZuCbQpjyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abrxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZ440029784;
	Thu, 23 Jul 2026 17:47:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyn2um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHlsR031785352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:47:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98FA20169;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7F0F20162;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 9DA9B1627E5; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/8] s390/vfio_ccw fixes
Date: Thu, 23 Jul 2026 19:47:43 +0200
Message-ID: <20260723174751.1180334-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX8OqLE4A5HLiZ
 WDBlw9cb6Ev4164/pnMVv1Jswlwkq8YGOsvNYgeYb52r4GeWjhCCBufwZntlzOuRb1pwNdujZlO
 Wg3S7YYtBXIiFAuPzu7vTwdLWpExulU2n2sM83Q5ZF4Ui2A5hmwPYLwpRex2jobJh48f1vGhPs9
 f0faWpvq7JlO0+7mkcLSF6ZTIb8f09bTPRVBex+cRb/0O91p7qnyKBAussTP/aVTRwGWyzvcSPS
 qrAYmAlun4c9gDSO7b5fIjmpxx5+vE59ozKRoAwyIU+57hU+T+zd0Pw+L8Y8nRdcI7yxjIWG2EK
 JHokNBbfXMn841UBevRnzf9H2xg733jHVsM+FtkEIVaQLWqAFyWsDnENVcB8NIPtUgNdzalf3gW
 MIOuodOcxyIcrBkAMgoUFB7cKkxR+MpPigC2PcSm/BfJGPimyI8QKMd/kNM5aotahWt6QrQ/4kx
 WV0exNOL/Gme+/p227Q==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6253cf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-W5gkg908v1zLjHEBtAA:9
X-Proofpoint-ORIG-GUID: 39436r4qHGeI3_ajeZj3O9Q1U6XV8SfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfXwW/UFkmEJN4t
 itgQ5cD2BmOYcODFzo4F6lZwrOa+n+smmcb5eI81GL3BqQVb3fjgQi4EDwUV0SWQLz4pe/12Tz7
 Xm0wJrWq8McvrmZ9J9/7a3aUBioj1eo=
X-Proofpoint-GUID: 39436r4qHGeI3_ajeZj3O9Q1U6XV8SfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

This series addresses some pre-existing issues found in the
s390 vfio_ccw (DASD passthrough) driver.

v1: https://lore.kernel.org/r/20260714232208.1683788-1-farman@linux.ibm.c=
om/
v2: https://lore.kernel.org/r/20260720201931.976660-1-farman@linux.ibm.co=
m/
v2->v3:
 (Patches 1-4 are unchanged except for these first two items)
 - [FA] Added r-b to patch 1 (thank you!)
 - [sashiko] Fixed typo on error return from ccwchain_handle_ccw()
 - [NEW][sashiko] Fixed the idal size calculated by get_guest_idal()
 - [sashiko] Expanded clamps across region types
 - [sashiko] Replace cp_lock with cp_mutex, and rework intersections with
   the existing sch->lock and private->io_mutex

Eric Farman (8):
  s390/vfio_ccw: free all memory if cp_init() fails
  s390/vfio_ccw: limit the number of channel program segments
  s390/vfio_ccw: fix out of bounds check on CCW array
  s390/vfio_ccw: ensure first IDAW remains constant
  s390/vfio_ccw: calculate idal length based on idaw type
  s390/vfio_ccw: ensure index for read/write regions are within range
  s390/vfio_ccw: implement a channel program mutex
  s390/vfio_ccw: implement a crw lock

 drivers/s390/cio/vfio_ccw_async.c   |  4 ++
 drivers/s390/cio/vfio_ccw_chp.c     | 19 +++++++---
 drivers/s390/cio/vfio_ccw_cp.c      | 59 ++++++++++++++++++++++++-----
 drivers/s390/cio/vfio_ccw_cp.h      |  7 ++++
 drivers/s390/cio/vfio_ccw_drv.c     | 14 ++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     | 22 +++++++----
 drivers/s390/cio/vfio_ccw_ops.c     | 20 +++++++---
 drivers/s390/cio/vfio_ccw_private.h |  5 +++
 8 files changed, 122 insertions(+), 28 deletions(-)

--=20
2.53.0

