Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353943E9CB
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628315; cv=none; b=hqIckkIIsw7gfKmyeNcZBLXydWrs6or7CyKm9SX7okpuwB2CtbHNyOIP0IjlLVc3z6K6ahKQYtT3fkC0aNU2e3Flgq5A3J3vP8fE5fvyRTZRqbpLfCzFqE2Hqdk3A9uDG3XZJeYHD2dx0DN3Yt/5sQZnkFH9C4boriuwdB3tLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628315; c=relaxed/simple;
	bh=RvzyzuDeI5cOZvfDayAq0PMVJoje2CsKhVuPzwQD44g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCK0CmGKOt6OKETIBCJ03P+eivTUiIgrOQEmYUH5nH/4wILVsDl/xvmBL4HbVizC6+vwKV2YRA6QKE1ilJBzvS8008FqevLutBjB3VJskzG4ZGKcgMRTqfZfC1U7mnW5PGtVcCn4Owd9c2rJhyOKl0VKd3aFTNa/OWOSbmTq6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLrdp9+w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLrdp9+w"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61k1h1702101
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=M33phUDkDF90UDdFx7+G+BgxH1lEtS6z59Ccjv7yS
	NM=; b=nLrdp9+wn+j490NJjkdlQvaRNRsyV7r2bxesRylk14Qsto+a5A6fNFW4p
	Q89R8auBJUXqi+/1a7BflJJkHrDDxoGvgb94ic7eUcBtTQS/d/EJf6eq1/YxR39x
	ZyqMahD97pEHEhT3lyp8IEu8pIp09OktJLCl2mPoORPSjr7DDiIqxKllyOTxYVq+
	ChQuiB0uhGf+HJoecWta7TczahwQtMezweiFgtSSJ3iXn8pj69E46Okn1WwWt8nP
	MFohHSrNKCwgDyRCLD38x9pKc0TmlXDkDDzuIqgZoYFrdscch+DD9OIDwMMsZlFK
	tMBC23T6FMjzsf4KLzxAPzTDk4yUw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx840vap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H65HMr2661167
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjh6yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H6wOuI30146946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 06:58:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6875820043;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4984F20040;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 0/4] s390/sclp: Misc fixes
Date: Thu, 17 Sep 2026 08:58:20 +0200
Message-ID: <20260917065824.2858737-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfXycXD49V5rEXz
 6Et4RonSjvelgJx3/gQw5AuxrUtshOoKTDWbbQIJLksxLaQxhRKuLR71pJzTbrNs+oT4h83akKA
 xiMsRcHfEQdbIiSk6uBcM/bBJ8tYvh3AsCVVB7UoPMz54EH6GySReLRE09k+TO83LFtxsZH+CVV
 DYUlbLXoyPmqfeisUQOxvaiC2nVlgLXqqSji0X+o6HK1AuF5rkyTtTHjmMlYY1kq+MbA14aXB63
 PHNtwg+1FmmPKXhBVyJuCrmDqZQd9i5yO4UuaJ7mZl13InpChRNLyq0KxI0pSW65TYZzDj26XKg
 rnchb7JMNH6qpsimGj8pw16wNm8o9JD9fLm/ahWdyJIYIcxWs+SaxpEen4TOK/F+fFOgvZDudut
 TxYVZfQq6vcgjsHeCf0XFeFkPkwjT+8NX164v6q/RVBLVqWypurdneTaOa/tBXHvG/1FXiDgFUe
 68rPrauhPhVvp4rKWzg==
X-Proofpoint-ORIG-GUID: AEJyjr59GI1-6rxfBjf33GbQwah-NPkG
X-Proofpoint-GUID: AEJyjr59GI1-6rxfBjf33GbQwah-NPkG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX8W0DfBzslPFH
 gPwAHeBWsxjAiR2GtQAVM52+MokDav8HLwsc6Vd1ss7DPSi654Y6eJKeH3LZ/hvHQhi+2S2n00v
 Lbdy3ViX+G6qd+A8pUAAkalKa6yyUQQ=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aab8f97 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=97JCGAZeZryCTmDfBgsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170086

This series consists of several fixes for the s390 SCLP driver.

* The first patch introduces the macro sclp_gds_for_each() to safely iterate over
  GDS {sub}vectors and serves to improve error handling in sclp_find_gds_{sub}vector()
  to prevent out-of-range memory read and potential infinite loops
  when a malformed event buffer is received from SCLP.
* The second patch reuses the macro sclp_gds_for_each() in SCLP TTY introduced in the first patch
  to replace manual and error-prone iteration over entries of a GDS {sub}vector to fix
  the same issues addressed in the first patch.
* The third patch fixes 2 potential illegal memory accesses when reading
  the value from a GDS subvector in SCLP event buffers sent by OCF.
* The fourth patch fixes race situations with in-flight callbacks and sclp_unregister() calls.

Changes since v4
----------------
- Drop patch "s390/sclp: Drop volatile type class from SCLP state variables"
  - There are several doubts to it being correct in all situations
- Introduce the macro sclp_gds_for_each()
  - Reusable and safe iteration over GDS {sub}vectors
  - Make use of sclp_gds_for_each() in SCLP TTY
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
  - Remove waiting for SCLP mask and reading states to become idle from sclp_register() on sclp_init_mask() failure
    - First, it is incorrect to sleep in sclp_register() which is called from atomic context
      - sclp_console_init() -> sclp_rw_init() -> sclp_register()
      - sclp_vt220_con_init() -> __sclp_vt220_init() -> sclp_register()
    - Second, it is redundant because no race situation can occur if sclp_init_mask() fails because
      in that case no events can be received from SCLP due to SCLP receive event mask update performed
      in sclp_init_mask() having failed
  - Add might_sleep() to sclp_unregister() to indicate that the function could potentially sleep
  - Adjust coding style of function sclp_unregister()
- Add "Fixes" tag where necessary

Changes since v3
----------------
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_{un}register() returns"
  - Shorten and reword the commit description
  - Replace wake_up_all_locked() with wake_up_all()
  - Replace sclp_init_state with sclp_mask_state in wait queue condition
  - Call wake_up_all() unconditionally
  - Add call to wake_up_call() in sclp_init_mask() after updating sclp_mask_state 

Changes since v2
----------------
- Add 2 new patches:
  - s390/sclp: Drop volatile type class from SCLP state variables
  - s390/sclp: Improve robustness of sclp_find_gds_{sub}vector()
- Rework the patch "s390/sclp: Ensure no callback gets called after sclp_unregister() returns"
  to implement Peter Oberparleiter's suggestion with a global wait queue and checking
  the state variables as its condition. It turns out the implementation with a single completion
  per struct sclp_register is inadequate because theoretically the callback state_change_fn() and receive_fn()
  could get invoked in parallel, however unlikely. Furthermore, the same race situation might happen
  with sclp_register() too. 

Changes since v1
----------------
- Drop redundant empty lines in sclp.c
- Make commit message more verbose for the fix in sclp.c

Alexander Egorenkov (4):
  s390/sclp: Introduce macro sclp_gds_for_each()
  s390/sclp_tty: Make use of sclp_gds_for_each()
  s390/sclp_ocf: Fix computation of length of GDS values
  s390/sclp: Ensure no callback gets called after sclp_unregister()
    returns

 drivers/s390/char/sclp.c     | 24 ++++++++++++++++++------
 drivers/s390/char/sclp.h     | 24 ++++++++++++++++--------
 drivers/s390/char/sclp_ocf.c |  4 ++--
 drivers/s390/char/sclp_tty.c | 30 +++++++++++++++---------------
 4 files changed, 51 insertions(+), 31 deletions(-)

-- 
2.53.0

