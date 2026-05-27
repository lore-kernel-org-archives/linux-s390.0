Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DD4014B8;
	Wed, 27 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893052; cv=none; b=e34Y+LC1ZBd5J7N8pRVLMGT3ma2ZP4tYVxtWc8S7acAWGqd6DO47TsZ6qBdkuOKSzZXiBaCm7ubBYc193qiHYIi3JHWN9hD8Mp3M8cbOfnwTR/kUByfU11o0AKbW7Y8XCGZK6+KqSVXCVwrqpGsXjdh3IH17ityKbpELBpB0DcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893052; c=relaxed/simple;
	bh=kO+mXNFFDRU+2JIjEiBuyWgD0QOydgPe169+WTbJk0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBitD8XjpYET6R6lLJ0jVeQxm5bHgzf275eMCYWi3au84twdnL5uiSazBnpIJLxUvgGctXULXTSPgVzaQwtuqCiLYyhoO0r1lry8LozxHQwLHJ6gGnK+f8mw8FNyVTZvwVeel1oPvlAGgRH5xjlpFWAFiEXcihEC37A64+BjdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UiLlZqX7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UiLlZqX7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCU1qM3811085;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1qyhOKdT864rczWC/5/TCzwp10KrtXPDDZ3APSXiv
	Mo=; b=UiLlZqX7x8r0NFWkLpbc6H2yKjwTsld95jDL+vtjbAfZ+wYqbgLDbRU2M
	hbu4+ZMGMVUnLURZaYDDuXU4E4iP5BGd0bLhUxkAcpLJThHwrLxh8P3TE0Blpgla
	2jS8TuQznHnt41JgiBH4GPnOBRJpGzXuRUcQm3lyDhDUgJRYBRw2xekJYFCcCpGa
	9MVF6twehjhlSRMIEQj35bxy6OpD+0fT50HHkFIuoKteH2+0pfORVdRIhtuPtjGE
	Q2Dmj/OAp6IXVjoeQVyGkyl5aY5o7WYL++RwKP8uLV1XyQRXANZtMq2K094DTDCG
	SJ1MbAoX5YK7A+0vOgeYgMvIfLsjw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4qc1uk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd3K5021383;
	Wed, 27 May 2026 14:44:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbkfgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REhwfp50397508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:43:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B16B820043;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0AE20040;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 0/5] KVM: s390: Implement KVM_PRE_FAULT_MEMORY
Date: Wed, 27 May 2026 16:43:53 +0200
Message-ID: <20260527144358.186359-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX724cHuPCjyCI
 tsY33qpuX6hXghzD+8Y8ejACOHRygEpGZ77OXw4CLStP0xM0v1eJB1HUg9WlrJcYEqD52n46BcE
 gyCRlxjMcQIpjRfFLFZii+jjkeumydg5NF7QFSYWT7XtjlLkAgg2HguN91lvy3X9lLUaYhBx7/t
 3x7L5V3bm3gBuDelpR/a425699tURxHqKc8UEJ9bPzbf6FvoU8XEOEM6U3kxII+wrGUZieWWptB
 uMEAIPXahqozDarzJ9SSKZKja7cDYOzZZ+yYRUVBUzKdCLFZ1bnWmO1EqVdDUaBCObRJZHX+pxa
 Pb+E1q0J8k6MreYDFu/HWC07PUv2ugZJ5eiMCGBAcXgjG6xfGHjIrlsb+tjvwhuvUqN42QJ5St+
 nanjBiQzOxDzGjU5wZq2AqjTe1SHahoeq+gAPhywxz6p/YLazDiHjJngnAS1A2F1eVYL17i//z1
 A/oo8yuGJezKGkO8HsQ==
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=8YE8oK4BZoqmkRg4UKQA:9
X-Proofpoint-ORIG-GUID: -TclanOx1RCbsmd6UjOfEcNroFyhbIUg
X-Proofpoint-GUID: 9p5aEL6YN2Rke9yJvW0z6L2RwtIrgdUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270144

Implement KVM_PRE_FAULT_MEMORY on s390, and update documentation and
selftests accordingly.

Faulted-in pages will be marked as accessed, unlike x86, otherwise they
will trigger a minor fault when accessed. Avoiding such faults is one of
the points of KVM_PRE_FAULT_MEMORY.

This series depends on some kvm/s390 functions that are slightly buggy
at the moment. Those functions are being fixed in a separate series.
Even without those fixes, this series is not buggy, it's just a bit
inefficient in some corner cases.

CCing x86 people due to changes in the documentation and the selftests
just for completeness, since the selftest has been acked already.

v2->v3:
* Fix typos
* Correctly indicate page size in gmap_handle_minor_crste_fault() also
  in case nothing needed to be done.
* Pick up and acked-by

v1->v2:
* Add the crste_region3 flag in struct guest_fault to keep track of the
  page size used to solve a fault.
* Rewrite the s390 version of kvm_arch_vcpu_pre_fault_memory() so it
  looks and behaves similarly to the x86 version. No more loops, better
  handling of hugepage mappings, and more correct error handling.
* Remove the assertion vcpu->run->exit_reason == KVM_EXIT_IO from the
  selftest, as it is redundant and x86-specific.

Claudio Imbrenda (5):
  KVM: s390: Track page size in struct guest_fault
  KVM: s390: Implement KVM_PRE_FAULT_MEMORY
  KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
  KVM: selftests: Fix pre_fault_memory_test to run on s390
  KVM: selftests: Enable pre_fault_memory_test for s390

 Documentation/virt/kvm/api.rst                |  5 ++-
 arch/s390/kvm/Kconfig                         |  1 +
 arch/s390/kvm/dat.h                           |  1 +
 arch/s390/kvm/gmap.c                          |  2 +
 arch/s390/kvm/kvm-s390.c                      | 45 +++++++++++++++++++
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/pre_fault_memory_test.c     |  7 +--
 7 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.54.0

