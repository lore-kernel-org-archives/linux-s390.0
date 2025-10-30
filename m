Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CD27FD7D;
	Thu, 30 Oct 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836126; cv=none; b=ZkQV1Gurj5GJzkCzIOfYrfHnMpQ4+iB8z39ksl0s6e00UbciONCKAOrdn92IgiUiVoS1DiX96jYifkW44i1E5eWxeSD8vS5N/60VzeZi2ZSay1itTzYErQLAk5xfsVSKO9vBa3GN5JssH//6zRFcy9SByPMktbBBIEllwv+EMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836126; c=relaxed/simple;
	bh=o6lu6QydXplpa453DsA76dcOeawB8zRmXZzUXrS0XDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+/epnF+9h5QfBiSFoxpPBC/MOYEyfNMoRo8ymtR5j4KGiCbtC6lFXAfLaddto8wiOxCJk4NsldRcuHuetC0NY7CRIUqBZFp7HUltgzURio/o0z7mnoWnHSNg54fPsGctoNHS3f0zq7w6HDEInvYmbGi9vfJVPdsk1HP3dQw4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M92nI7JD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M92nI7JD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDADVQ003305;
	Thu, 30 Oct 2025 14:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PjzyxOO3ljwrWLzxHKYkz0ZaromW3OhRhgdBvzSjn
	Gg=; b=M92nI7JDK0C3voI1ojGRzDTU8RZBm4Az1TgZnMbgb9xjxAqUuMrpOaHbp
	DHOl7zDygZ0P1mqHIBj1JiLXJuQdV17FL8eEY5l9a6fBgh1sZPndGCaPPBqS2snc
	JggtT0IDWwde7mAozuLFI3L4OzuWiSKxEcaSGEgOOZR9eJuACePKBm9EJNehyli5
	m75mEY2QPQnHxnt/CmCqfNXM67j2M0XP/2W5njbCuMaJqcfc9s7cn2aYYupF0HEo
	XpI0tle8/jk4ttPVmtUEeoD8W2svqC8/iMOHnFINqHKPsHWgbEQBd8DjOtc0iBMd
	6ttry/Gl62cUxWWaoz7WKYyIZzZpg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8s2nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:55:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UD8brr023836;
	Thu, 30 Oct 2025 14:55:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx99nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 14:55:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UEt5f251642848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:55:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A88620043;
	Thu, 30 Oct 2025 14:55:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A7CE20040;
	Thu, 30 Oct 2025 14:55:05 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 14:55:05 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Luiz Capitulino <luizcap@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>, osalvador@suse.de,
        aneesh.kumar@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
Date: Thu, 30 Oct 2025 15:55:05 +0100
Message-ID: <20251030145505.2764038-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=69037c4f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=a44tTfYfhnqc_Lg12qoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iMMC-bQfclUX4SL_LRv1u-0FsUQmA35x
X-Proofpoint-ORIG-GUID: iMMC-bQfclUX4SL_LRv1u-0FsUQmA35x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXyKmS31ZKoikD
 DpRLyjcWCZHMaGqL2jmly+DRIIPTCimQSXJjpHHNpP7Cw3e2AaoyZfZ1sPYZ5g0TiXZj7Cqhvnw
 mGX5jmEtnBngBH/C0jxc53+9dxOiGwuUA00Uq/DOBY5OS64GI/3UMaikh/l+RXbRyWUypJN45eK
 tCf73BmX5IVqcgRZXyPlInSMlYtuOB80HH42T9cqGAhmzQMCfPeLeaYDTpCNG+vVyyiav5/uNJC
 KXQdlYLDQcav/rhq9tjeIHUXGqV676+NOToVyZztGuuNS11lRDTUxGqKn3fvE5lTqyLh5UJZqzf
 g51j3moXpQ8+OvJFI1MjsJI7fNNiwvf4+kCxKIJN9jNLhXKF6DJQVn8HQ2t2lrACrtOJOk5ydwF
 OU1dlQsNQppL7T0dqHSMugBcJJUy7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
crashes. The problem is that kernel page tables are modified without
flushing corresponding TLB entries.

Even if it looks like the empty flush_tlb_all() implementation on s390 is
the problem, it is actually a different problem: on s390 it is not allowed
to replace an active/valid page table entry with another valid page table
entry without the detour over an invalid entry. A direct replacement may
lead to random crashes and/or data corruption.

In order to invalidate an entry special instructions have to be used
(e.g. ipte or idte). Alternatively there are also special instructions
available which allow to replace a valid entry with a different valid
entry (e.g. crdte or cspg).

Given that the HVO code currently does not provide the hooks to allow for
an implementation which is compliant with the s390 architecture
requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
basically a revert of the original patch which enabled it.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c4145672ca34..df22b10d9141 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -158,7 +158,6 @@ config S390
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_KERNEL_PMD_MKWRITE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_THP_SWAP
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS2
-- 
2.48.1

