Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310254;
	b=UijTFnweDEk0A8IzRWiTj0jfcHmnEdVUFKBlYGfVhAnGKxpG1xKLb0c0nHcJtmL9Ph/F
	 ZC4uCWNqI/OgOWHqb5yyeEZM36+rjOXpi02p0ZU6nsADGr/tgYWloNKbyURjncDLcP1HW
	 ohcaD5O9j494Um446TUYbz0JyZjL+pMlWbvL5agtHRPxta9OrPo96HJ8PSAfC9EQ2VV5e
	 SwYkT+/14lo45Kl1j16uJdnQkcFwWMaG+AhZCq29cyORxHL510zpHpUexrts05fnC3L9c
	 hCocZ1H2Wl4cf/1BH25dED+fT3pKHmHdbcAhB9MxK5G7h8x0L19Aqf7Yz8UJuxIbDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jBTSAiDkVJXmNZOnYEnBYASE5Gk46kL+vGe8BiybrJU=;
	b=ay+d/SHK+zs/dNrHp2tv4fACAfhPQvRF/LauKV50wJn1ELC3PTRfLVt4uY0SdMrFG/fg
	 PGBPVwSVbMrQnz2eIrjwZBwfu2REqxCmUKwfyEGHO0gE4b9b+ftue4w+At3hBaNIZt+ba
	 4M0e26dcRZ4PRpuw0mz25b2xW1zXqpaB1tkCS53TCZePtTl6mh4tIRouRJMz07573cxBM
	 QaZZU5Z/HOIwzOHvuId35ZzYsgP8jXjd7xY2wf42f5+I34EW/akzDuyCieWnQ+848Ch6w
	 YEGpeAVQHJKW5gQqVXNRZ0I3EAkvBWbbkwl16Y+ZH1Or7WF5R4wrnARgJ+dgdA64vyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZM68s2IK;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68463606A32A
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68463606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZM68s2IK
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEroo536868
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jBTSAiDkVJXmNZOnYEnBYASE5Gk46kL+vGe8Biybr
	JU=; b=ZM68s2IK2zoqofy5Egt6finGlfdjhuJggsKjwCqEjjOcMMHOvhxyeAzpi
	Lkd7y5sn3i0VRdkGvyDcekl/q1Qq7wsYVnGIgZKK/OpJzzNhrlDrTWkNzvOA+PVM
	5RrugngX+B96A2GckF4oPFM8qBpoOSP/qXuQqNcKSrgYiobORRioauTE8wgHxB4t
	gpHzwBH8WvJqJ7s1hTfA7Tlsmv2N7SBu0scaqlfUYoePUl+rztq6HqNtyfZHlQaZ
	5tZn4Th/nBi9R3BoQH04PtjicFGXPbjLxd6CXwByZNqEssE8k6ZVo94fGH1P+IQ7
	gNXiD4jbi/2lo0AcyyW3trzjMnfRQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt4n0s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABK2CQ1679608
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq6jg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUlGP41746778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1FF42004D;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B577220049;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:47 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 0/5] s390/sclp: Misc fixes
Date: Tue, 10 Nov 2026 12:30:42 +0100
Message-ID: <20261110113047.238367-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX82gkL7DBIcIn
 hAGoKACd1a+UnGm8faPPdRQFsohCQdyhIm0nmQ0sb14gFsMWEOuDsQ0X9H9WGgkSeGYJ4sweFu3
 ayO2TNAXgQPq9AS23dz+nTrQ/tUVFDLbf2v86HhPo73cTaS/IrcH1ZYjnsjUZywSq/UxLGvm68q
 zM+Qox4gIKtgPeVU+ZEgXmEriZii3jRKRCXyGnTtBb2KOy0PnIOM7vgaMDkiJDgrzjbgElWP6nD
 7XQrNmmTcc0K0B/V1YkqgkwVTBrYidw8SdTqIkr5lDOWkqgRB8wLSzT9EDWO5vUM4DQfQkHcPkh
 CVSz5zBaxqqXInGBMQlCraHZfyoGZQM6Z2CPC6lFxvn5qgHRr1v0qBcuswwOaQN6xGE/Dox+Qi2
 E7MTY95PfI0cngaAk9XjjpgGJ7FSY5drox0Het/aqZqQjw/iPi2Fbk8sMnHdjPu0LLOyh39nzYL
 ETJVqkWSGWfE3u+YyuQ==
X-Proofpoint-ORIG-GUID: viLLM_pD0orwMMOchqMVmvBIzyw5G06o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX7jgtBpFa+vpe
 MaJWNTZTsDGcT23vwou2R/V1ULMfKY8j5WzTPNjOxC20pnbSpt7YZD4HwKDtEEBg0DcgIfGqpag
 z2RK8ko624Qe6d6ciZh9E8NlqYfw1K0=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af3006c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=OTwuIoJrVDDCSJmIxCYA:9
X-Proofpoint-GUID: viLLM_pD0orwMMOchqMVmvBIzyw5G06o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

This series consists of several fixes for the s390 SCLP driver.

* The first patch makes sclp_dispatch_evbufs() more safe while parsing event buffers
  contained in a received SCCB buffer.
* The second patch introduces the macro sclp_gds_for_each() to safely iterate over
  GDS {sub}vectors and serves to improve error handling in sclp_find_gds_{sub}vector()
  to prevent out-of-range memory read and potential infinite loops
  when a malformed event buffer is received from SCLP.
* The third patch reuses the macro sclp_gds_for_each() in SCLP TTY introduced in the first patch
  to replace manual and error-prone iteration over entries of a GDS {sub}vector to fix
  the same issues addressed in the first patch.
* The fourth patch fixes 2 potential illegal memory accesses when reading
  the value from a GDS subvector in SCLP event buffers sent by OCF.
* The fifth patch fixes race situations with in-flight callbacks and sclp_unregister() calls.

Changes since v7
----------------
- Fixed checkpatch.pl complaints in patch #2 and #3 as pointed out by Christian

Changes since v6
----------------
- Rework the patch "s390/sclp: Make parsing of received event buffers more robust"
  - Move event buffer header checks into the parsing loop to make code more readable as suggested by Peter
  - Add check for SCCB buffer length as suggested by Peter
  - Return with -EINVAL from sclp_dispatch_evbufs() if SCCB or event buffer checks fail
  - Improved commit message

Changes since v5
----------------
- Added patch "s390/sclp: Make parsing of received event buffers more robust"
  - Reported by Sashiko
- Rework the patch "s390/sclp: Introduce macro sclp_gds_for_each()"
  - Explicit cast of start and end parameters to void* removing the need
    for the caller to use extra void* variables for start and end, and also
    protecting from mistakes when using non-void* variables when calculating n
- Rework the patch "s390/sclp_ocf: Fix computation of length of GDS values"
  - Improved commit description as suggested by Peter

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

Alexander Egorenkov (5):
  s390/sclp: Make parsing of received event buffers more robust
  s390/sclp: Introduce macro sclp_gds_for_each()
  s390/sclp_tty: Make use of sclp_gds_for_each()
  s390/sclp_ocf: Fix computation of length of GDS values
  s390/sclp: Ensure no callback gets called after sclp_unregister()
    returns

 drivers/s390/char/sclp.c     | 43 +++++++++++++++++++++++++++---------
 drivers/s390/char/sclp.h     | 22 +++++++++++++-----
 drivers/s390/char/sclp_ocf.c |  4 ++--
 drivers/s390/char/sclp_tty.c | 21 ++++++++----------
 4 files changed, 60 insertions(+), 30 deletions(-)

-- 
2.53.0

