Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1E470E95
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814476; cv=none; b=WEq4tbZYFxhFQKEEzXI8v/2V5JqC8a9Znh3+pNxtNQbjWxgVh6zzW7Mnj7Uy8i1OTvvw2vY7fCG8vqcOhw+3OaR+GC/P+IFXlkRYmTOBtUKxz4xnU71sUno41HMmDmubOLK1Xj6E4N6GTksiIa2nNK3jZbL/W1HqvgYo7m37fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814476; c=relaxed/simple;
	bh=X4//MKvPDEPeRudgMozNNMXAeWBptg5mMoHwwUF7ZiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvDYeNTGv3Z752aIDtGQxf/gRR1s7kGlpspvZteRHB/6CbVJwv5IlPTVBKAuBENxR7WwiJFGZ9dMEWIklasHryA9liQ2tx5CP4/6C5FkCjaSpMx5bzjWJvYK1TxZYQeazMc2jro01r0ugszrbQl/b+xSMFoOThQhBW/o6vPcMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ljCVpWz2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ljCVpWz2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBjKv3089892
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=eQvnCr5l6wEcnnl7WD5LXgxkM7Q0
	+En7LqvapTYdO+g=; b=ljCVpWz2Zj52WNdWEB/Rm+RYmvtOMFn6F4/bWgKDskhX
	Gx8SohHpgewFmyQWB5cViQh7bzTUoR3WNxJm5KnmuF9SJjwnnDPBm70A1Wk1NTz8
	P5qjLx5AqEl41QnIE8dUnxt6CDHcUFKE8JsmTH1W1tWFXYyHAzk7ume+cU0EZHId
	9+77B/5U3jAd2tk58Jgx1t0ALgGrUVRs9aI82NtWbKdbIA4DU7/knUsPawTpDRJ4
	jvjbLmInwYEqsDB1923niHg8PD+Jk6VSJ09LQ45WEiwHu2UJsVibOXBOjFlElqpH
	YYNIE9kOet5RBc5y30cuhazR66leaVpu5FdnlNw26g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abquq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZns007684
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gm7hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDllEO30343768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9364E2004D;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79E6520043;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:47 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 00/13] s390/dasd: ESE thin-provisioning performance improvements
Date: Thu, 23 Jul 2026 15:47:30 +0200
Message-ID: <20260723134743.672413-1-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX8DODmWrzqhzM
 8ALumyvXo3zssSbXtPEtWsJo/wgnjAclNbvmE48ccWAepz668H55pNwnEXZi6lTZPnCKPPk8U3g
 RzyPmWODK/XqktzM3g+W7FyqSbZLVP8A9amazt0LsoygWXQJWw5p07JoO+whu/J1VqBH0Ay1K+f
 OJ0a6021G9YhpTSFgyYxaOaCvVKB0sMFzWhaaMve931myvmzV8+FXEU2n2zxfBbWSQ6jWKO5ZB9
 ZYJDiCg8ElPPWJt/ke2J20y5RYgl70xawZSX2UiShplN/kXtKLhdnOGIf/2q3NOv+B5/Y7j5xRX
 xcgS8Q2+Gsb1VOvJZU8ZBcHQiVnkQCQD+uUkYzSD2ix5DHkr85OoV0D1tWsDMGz6eiCz1YRbmfH
 vRzaX+OO1f8NKXxNNs16TxVPp31ZvjPPaMWq8yMJeDz4Pg0o8PB9N5HEh9ek4+FjVf988EGILTr
 fC1YuPMCHKuhB5Jwfqg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a621b88 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=5ndY8bl1auYk5iEonmkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VeP3IyXrsCGejj8JIqnNcO_ZrbXxYuIN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXwK+r+IB9v3xC
 aUuwfVCXbVRwFbNiSnGmBxUnyg7d5yEBlee1S8wks/dc6E+3v1j/O1AWdhzCejg4Op4B/aWmqhZ
 OqLd8zhC+nxCn7q9m0pHPFiXpue5oOQ=
X-Proofpoint-GUID: VeP3IyXrsCGejj8JIqnNcO_ZrbXxYuIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Extent Space Efficient (ESE) volumes allocate a track on its first write.
Today the first write to an unallocated track fails with No Record Found
(or similar), the driver formats the track and retries the write.
That NRF loop dominates the write path of a freshly provisioned volume.

This series lets the driver write and allocate a track in a single
operation using WRITE_FULL_TRACK, so the common "write to a
not-yet-allocated track" case avoids the NRF penalty.
Because full-track writes are only a win while a volume is still sparse, an
adaptive heuristic (exposed through a single sysfs knob) probes
the workload and falls back to normal writes once the device is mostly
allocated. On top of that the series adds an on-disk format label so an
ESE volume can be recognised without querying the hardware, and re-enables
discard for ESE volumes so freed space can be returned to the pool.

The sysfs knob is 0..100. 0 pins normal writes, 100 pins full-track,
and the default of 50 enables the heuristic; the adaptive range
interpolates the heuristic parameters between the two ends.

Patch 12 releases whole extents only: a discard range is rounded inward to
extent boundaries and partially covered boundary tracks are dropped, so an
extent shared with a live allocation is never released. Sub-extent discards
that cover no whole extent are rejected rather than over-released and
corrupting data.

Patch 13 fixes a use-after-free: the CCW build path read the base address
and LSS directly from conf.ned, which the reload worker can free
concurrently with I/O. The values are now read from the copies kept in the
device uid / private structure, refreshed under the ccwdev lock when the
configuration is (re)read.

Stefan Haberland (13):
  s390/dasd: Optimize max blocks per request for track alignment
  s390/dasd: Add infrastructure for ESE full-track write
  s390/dasd: Add range-based format-track collision detection
  s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
  s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
  s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
  s390/dasd: Add full_track_bias sysfs attribute to control fulltrack
    write mode
  s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
  s390/dasd: Stamp a format label into newly formatted volumes
  s390/dasd: Detect ESE volumes from the on-disk format label
  s390/dasd: Report ESE capability and format mode at device online
  s390/dasd: Re-enable discard support for ESE volumes
  s390/dasd: Read cached unit address and LSS in the CCW build path

 drivers/s390/block/dasd.c        |  205 ++++--
 drivers/s390/block/dasd_devmap.c |   81 ++-
 drivers/s390/block/dasd_eckd.c   | 1168 ++++++++++++++++++++++++++----
 drivers/s390/block/dasd_eckd.h   |   55 +-
 drivers/s390/block/dasd_erp.c    |    8 +-
 drivers/s390/block/dasd_int.h    |  145 +++-
 6 files changed, 1471 insertions(+), 191 deletions(-)

-- 
2.53.0

