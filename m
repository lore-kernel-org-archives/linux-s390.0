Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244F3EF0D7;
	Thu,  2 Apr 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142107; cv=none; b=IkVMm3unDoUtti5ayUlGlxjuBor89pdpxxue3vgKeP/USomog1kTB220fMFqcH9V4DbwT9iPGpwPFmQ0SaX7lb+ATzuL6RigJHgXom5vGDU5vyxku+cFdZIvJhFO+ShhIxkCRZ7xcgtRxYYj2xnrZVzqZ5HR/fjfQA5+F5M+CnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142107; c=relaxed/simple;
	bh=nDqW7xJp/BXGD2oIR9bHcAJ93KhVinqkEAitcoodf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJ2l5a7U5ukGc50Q4qtADGpoh+DZcSnpGYpdEpMzyZhbEIXA86/YknxoEjw6ebGvgy9hMDSYsmtNxWrVfKx84Ni4npkaalJk7Dy+1lZSg6rup+/msGw89Ng5zCeRKmXHdu752x1P34rjmceR2XYjBoeABKxfq44D6JM95gZnPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qfAmAVsy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qfAmAVsy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6322lsqe169440;
	Thu, 2 Apr 2026 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ph0zPbnMkeNMATBMksWQbfh9SeG8qD46s7X3F5DQT
	xI=; b=qfAmAVsy1OBSekBZJRRjOmjeAfHrGvy5bS3Yp56P4Ozs7QEzmYrmeBadv
	oBMXDscfpJfwzxi0RmO/BYhFnYJ2CRX35TzI9N46tltG7kASvYQYB/RCBILnIubi
	MRLuPzjre2o5Gf1YJVkxm/wdLv2wR02IAeu6+2AtfLXoUIK9959UxBTj4BFvXWzi
	479vKj50um8Cvg2nJG76LzHn5WDhG4DDV/JTuXqV1OZV7/KkO70YDXLjMQkYpMbF
	kugYfe52z9hKTU3JcW25ZTet8+hGThblUoQ7XPqZblQ547fGD1wTMuNQV+ceNzO5
	oAE377SNOc8d4aqMBtnYrhRM2lEtQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3d8th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632AsrSr006362;
	Thu, 2 Apr 2026 15:01:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyajbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 15:01:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632F1ac149021280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 15:01:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88A062004D;
	Thu,  2 Apr 2026 15:01:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C712320040;
	Thu,  2 Apr 2026 15:01:35 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.129.177])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 15:01:35 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 0/6] KVM: s390: Enable 4k granularity for memslots
Date: Thu,  2 Apr 2026 17:01:29 +0200
Message-ID: <20260402150135.196943-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJuL5Meo5WidHqn2_9oDTUN0A3JZyMs1
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ce84d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=vPUu-RJ6-liXp4XtDbIA:9
X-Proofpoint-ORIG-GUID: IJuL5Meo5WidHqn2_9oDTUN0A3JZyMs1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzMyBTYWx0ZWRfX5B2he3U5zHWp
 ko3SI9DicnkCNkqKCvPVdNDh4v2WurHKA8ZV2AFF9GQ4y11nayDLPGF5a0fgID8AY/MaplHnxHL
 eZHucRKdz50WQjzhQwy9YIOn/tdk9YRGUbC0Mtm+7VpBSJX+kCAhDoi1VnQJ54lntgG2Cs9O+rp
 cs9TKBvYB1kq6XV15fhUkTEuErC9R3heSJqvff8uBm1zwlpbC61ZyF8bEeQ9HnGhqPNDVQVvlCp
 2nEYu7SnsoE0cb/rk2ulIpATfRRyemFR/Tn1JvDTx/NvF5HNhVl92HKBM+RVloLbMFzTNAA65XR
 2lFbGX7AP9jcrJowt24Lmx59T2Xcpa7BqTkt5w2NNi9hQYWCmFHmNzQ35fEoeiCHOmB2RBlsVBr
 3mA5l3GCs2ssjzvSrMXmHUthHuAwABLOyc+6KwGxYZCP2W+uuF3olJE8NuleajWE0KmwT0eg9yz
 OlKh3Ohw3JJGhwF2qZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020133

Currently the memslot granularity for s390 VMs is 1M. Both the s390
core architecture and virtio-mem only support a 1M granularity for
guest memory.

Notwithstanding the official architectural limits, it can be beneficial
to support memslots with 4k granularity. With the new gmap code, this
is a quite simple change. This allows us to enable more existing
selftests and makes KVM on s390 more future proof.


v2->v3
* Remove more 1M-alignment #ifdefs in the kvm selftests.
* Do not remove the common tests from loongarch, since loongarch does
  not include the common tests by default.
* Opportunistically fix a potential NULL pointer dereference when
  memslots for UCONTROL guests are attempted to be removed (does not
  actually happen in practice).

v1->v2
* Fixed the first patch (thanks Christian)


Claudio Imbrenda (6):
  KVM: s390: Add some useful mask macros
  KVM: s390: Add alignment checks for hugepages
  KVM: s390: Allow 4k granularity for memslots
  KVM: selftests: Remove 1M alignment requirement for s390
  KVM: s390: selftests: enable some common memory-related tests
  KVM: s390: ucontrol: Fix memslot handling

 arch/s390/kvm/dat.h                           |  5 +++
 arch/s390/kvm/faultin.c                       |  2 +-
 arch/s390/kvm/gaccess.c                       |  2 +-
 arch/s390/kvm/gmap.c                          | 32 +++++++++++++++----
 arch/s390/kvm/gmap.h                          |  3 +-
 arch/s390/kvm/kvm-s390.c                      | 22 ++++---------
 tools/testing/selftests/kvm/Makefile.kvm      |  9 ++----
 tools/testing/selftests/kvm/dirty_log_test.c  |  3 --
 .../testing/selftests/kvm/include/kvm_util.h  |  4 ---
 .../selftests/kvm/kvm_page_table_test.c       |  3 --
 tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +-----
 tools/testing/selftests/kvm/lib/memstress.c   |  4 ---
 .../selftests/kvm/pre_fault_memory_test.c     |  4 ---
 .../selftests/kvm/set_memory_region_test.c    |  9 +-----
 14 files changed, 47 insertions(+), 64 deletions(-)

-- 
2.53.0

