Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D4356762
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733420; cv=none; b=XMxgsSAuWFYjwhCGYgNb8N4JO4EDUmg6d13FaYdnQics12+d/WvrM2BPzBhVhQjukeH44vRutHzit4AWFiophl1oHl5eniMWh7Lqwm0SMpoLuAJDgn0VwuRInE+LihvjZNpMzpC9aFaY7gQYLND+cRTMTC9Bdv+OBkEyetZQ8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733420; c=relaxed/simple;
	bh=DxvmDV5CjoJm5gv4M5ka/rRVjsiM9TkdLSt9pJ3cArw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uM+yG9jo1tKfw3l82EkNavZ9/seodEMeqpan7EFw47jAOZaaTvDc8RjZTX6wke+nZ/givlbLpZ/UBkGXlRB1b08Rc/03lcyPdkv3nerdfs9tJm+abRj9VTv7a6wmDVA/ZwJlB+tSbzhMIEjEaxSmx5zVCNKAe1+kGXMnkaRu6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtKhoQeg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtKhoQeg"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfff72401480
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0lqz0JXcE9JMQcYD012NFbB+k04C
	hrMP/rmBG2Qp0Qk=; b=gtKhoQegB9kOIma9olRBX89+Z6BdEUIMeOW/Ync35R53
	QxYl3MwsTkVzTVxtB/dtwAJTpIiHCggtE1bSuuBfOC3x83qh4oyShlmGeeDzzkJG
	oXuq/AJyIOg7WdEb1vbVHnbwbg2hszLDximJhNTeeyZUBNcmMhDnOFH3JNShkjd5
	79TQcEPpDmuQ0nkXzoibvRUQ4O4Fo1AmHazCOTnc6ZvJ1/WlfM2XLPEpcUBpkxnz
	bvthpCappZEISt1K0upw/DIRmoylC1vzB1sSZm6lerMc/7KcZuK98qu3Ie1Ky1pq
	FBdcFpQXlMbeBVTFkLXn9hghU0rkEirU2i8w0gOjtA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77ajv6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MF4eUv014293
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyfkhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFGr2162915044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:16:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF07200FA;
	Wed, 22 Jul 2026 15:16:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52B5200F9;
	Wed, 22 Jul 2026 15:16:52 +0000 (GMT)
Received: from li-c11aa8cc-2ecc-11b2-a85c-95df2f347b4c.ibm.com (unknown [9.111.60.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:16:52 +0000 (GMT)
From: Volkan Unal <vunal@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: oberpar@linux.ibm.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        meted@linux.ibm.com
Subject: [PATCH 0/3] s390/dasd: Restrict discard support to virtual DASD devices
Date: Wed, 22 Jul 2026 16:16:48 +0100
Message-ID: <20260722151651.292621-1-vunal@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wqt33aibhBJ19ozXhps9MMh7M2jCRMcb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX0C13+XW0g3I3
 Noc9Ibi4ZJAWVHhYE3By5nTaRywMaBTxPEMTs2n+dFGOE3FrFdoeXfIAHtP1TQZTIz3WzOEKpq2
 S6WYevKSHjwKrmo1p/oMYeFCxIoUIWk=
X-Proofpoint-GUID: wqt33aibhBJ19ozXhps9MMh7M2jCRMcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX7f9gUlEA074A
 H6C6w9JuqBXU/eVTUJ3k7V/Yp+RihtXAJxZVnaStyVEKnPwDFOARaUVjC2Y03SdX7SUsZsapTZ5
 IGMPRvYs6VSJtun4i0KIZ1XQiKXdaDzWV1BFUyhYgSrMSWu9qmMegBUQAypUctOeeva+1X2MeMG
 OESfvITp9GF5qAM2NzcblV6NIZCjIJppf0xHnGav6k9X5dTEJRG/i05fiIhxoyjePJdeaOQws1b
 LusPyX7LGlQNYAIXtItjqAIV6HuP3s9Q0TkD58DkQDTX6SHneRf1LCHCuZUsdDxKawMoggGpfK/
 Z3wARnI1R+gCkN1oDHSrn9QpU4mnEFwpiG9s+KJDGS/wWGhUC3JMVmgO+O9XRhvGds2K5PMxFqc
 7o1gGIvuejJPpXlksDlTUZSL096OK6YHbQEIjZbgce1rvov4XI+AqO9aY7TBIc6iakNQyyaTaOk
 ZcP73Fz7l8r2P568jVA==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a60dee9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=6zbxDcjN0FxANbZMyMwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220149

The current implementation enables discard support for all FBA DASD disk
without checking whether device is virtual (memory-backed) or physical disk.

Background:
The discard implementation for FBA DASD was designed to leverage z/VM's
discard behavior for virtual FBA disks (VFBA, CU 6310):

  - VDISK             -> discard causes page release
  - EDEV (SCSI/NVMe)  -> discard causes zero-write
  - Physical FBA Disk -> discard not supported

Discard behavior for Physical FBA should be consistent with ECKD disks.
In particular, discard should remain disabled for Physical FBA, just as
it is for ECKD. This change is not intended to affect the behavior of
virtual FBA disks.

Ex :
Before changeset (where dasdd is physical FBA DASD)
#cat /sys/block/dasdd/queue/discard_max_bytes
33550336

#blkdiscard -f -o 1048576 -l 1048576 /dev/dasdd
blkdiscard: Operation forced, data will be lost!
blkdiscard: BLKDISCARD: /dev/dasdd ioctl failed: Input/output error

#dmesg
[  271.893040] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=3, anc=1, erc=4, rsid=18
[  567.513852] crw_info : CRW reports slct=0, oflw=0, chn=0, rsc=3, anc=1, erc=4, rsid=19
[  621.254231] ctcm: CTCM driver initialized
[  621.313130] dasd-fba 0.0.9901: New FBA DASD 3370/04 (CU 3880/01) with 20480 MB and 512 B/blk
[  621.314748]  dasdd:(nonl) dasdd1
[  825.958866] 0.0.9901: default ERP has run out of retries and failed
[  825.958882] dasd-fba 0.0.9901: I/O status report:
               in req: 00000000fed88110 CS: 0x00 DS: 0x0E
               Failing CCW: 00000000005a5fe0
               Sense(hex)  0- 7: 80 00 00 00 01 ff ff 03
               Sense(hex)  8-15: 00 00 00 00 00 00 00 04
               Sense(hex) 16-23: e8 68 01 41 ff 99 0f 03
               Sense(hex) 24-31: 00 00 40 e2 00 00 00 00
[  825.958888] dasd-fba 0.0.9901: Related CP in req: 00000000fed88110
               CCW 00000000005a5fc8: 63400010 005A5FE0 DAT: 00000200 00000800 00000000 000007FF
               CCW 00000000005a5fd0: 43400008 005A5FF0 DAT: 05000800 00000000
               CCW 00000000005a5fd8: 41200000 00000000 DAT:
[  825.958894] I/O error, dev dasdd, sector 2048 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 2
[  825.961798]  dasdd:(nonl) dasdd1


After changeset:

#cat /sys/block/dasdc/queue/discard_max_bytes
0

#blkdiscard -f -o 1048576 -l 1048576 /dev/dasdc ((where dasdc is physical FBA DASD))
blkdiscard: Operation forced, data will be lost!
blkdiscard: BLKDISCARD: /dev/dasdc ioctl failed: Operation not supported


Volkan Unal (3):
  s390/dasd: Add device type defines for FBA devices
  s390/dasd: Restrict discard support to virtual DASD devices
  s390/dasd: Make FBA discard support conditional per device

 drivers/s390/block/dasd.c     |  2 +-
 drivers/s390/block/dasd_fba.c | 20 +++++++++++++++-----
 drivers/s390/block/dasd_int.h |  1 -
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.55.0

