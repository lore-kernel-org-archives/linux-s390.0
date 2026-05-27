Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0B400E19;
	Wed, 27 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893054; cv=none; b=UTq+qEMRhk7+xIC+q2M7ogvxM/bVTM9oP6r8wCA6Jj9lw94r0xbgYQYG72FnlX5FoqbBbGRkHuOOlS6E7h/WngIWrirW+G1WmhBMUNOSI80/Hbn8hMm9EW38sgBi7yn4KGDaWOFWy6kr55Wgs1LfHcO+ApeE+UiEVilurHWzUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893054; c=relaxed/simple;
	bh=cU0xorK2ua1kep2b1OWcJuac0RINbn0aDFuJbUaNTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+q0EUUwvK9NNprASuQ70xR8Z2xaolvyGI4njGhXy9VNt64a/Km/pkY3R81FmzMqOHIILFqPzczZBYxncK5mcJn4akrl3LqhL6C52t2zt/AmUV2Tjwm1fbs2Eo+LNFsBdM6lfK9LpGR5G/6dY/Q6q0VoM49VHm8602mRTQOJRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fOV3vSEp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fOV3vSEp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCaIbv3850935;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AJYMLGH/fWC7uqxjk
	aiAtJCxKimPjCHxKmmQv86PRQw=; b=fOV3vSEpxCerwnFbwM2I6GJF4lgVeETRO
	chg7sWAcTxFeFVre0He0rU5VRlvvGLmUJPR0M4UbKA7Y4oiAMWRJ99WOCHoPVFj0
	7hcgYNNI2Rt9c0WxAypYHfWpIX58bpztcoA+blzYOefsoaTAkUiEyA5/D1jh+we7
	bAPcy0si9QNA2PuucuznXcMLOWcH53EQBXF0Qv/6Ipk8MkGB5O1prtzNZBnmHXk4
	Q2rebDUDGSEAXrhwZ+VptFO/itBzydfbqWI/EUuiLIHWCg8wF5wKBdZeNAzWQdFL
	hjy5JB59/dvGIwHc4wprjqhp23Mg+U5zj1a/SlyqAM+PogZvbvBQA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdgndv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd4ld000618;
	Wed, 27 May 2026 14:44:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3f4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REi06c50594278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:44:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89F620040;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD2202004B;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 5/5] KVM: selftests: Enable pre_fault_memory_test for s390
Date: Wed, 27 May 2026 16:43:58 +0200
Message-ID: <20260527144358.186359-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=f1nrkDJSyVtqXGSnAM4A:9
X-Proofpoint-GUID: HvJlXv20jNQbJ4xlqCncbhiXPFF-l_Ha
X-Proofpoint-ORIG-GUID: MT0UQ_PVcczQy7XpaH6_HVrkfPa7NaVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX/BV8+xRwpHiN
 qdHd4XysGNKFdqdrQA02PRPqW3I0cWSuAsBpOkSfTuUtvL7XYvyEE5caYEv9241gdKF7NNrDQx6
 4KKs1FgudJ39FdxO7+ofSk27N05Qkt/2fnMaGisjVna3T6FSCSF6fA8kHGyxlEXideyA7NtFVn4
 tmP6bU3oy2ztbUNINj9Pb9TnfX82L8B2C+MUS8/ZjPlpdKWAOKZeehBqL7sxvZ2CfpY14j0I6WL
 o/2oLsuJxVHyCDUH1VacUs5z8R4Wo5Ta7WyPLTRKQCJs81huyf7+4H+RPatiLK0QGoB0JlR1ZGE
 TkQCxdyK91jYbQM79R9Q++vCITtZr6pu5rLSVagkGllQF+cvNahMJjwSn3/w2zFVtaZpUqs7I9K
 GV3AnjeNGSgQk1utEyz5ThRJztHCYLEU6rBz+/Cg4SEh619jJO9UYtM9KaUlt0/FEOAJzTgZD2t
 RYg9dwNqA4q+la8uaCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270144

Enable the pre_fault_memory_test to run on s390.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..fff939db89cd 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -210,6 +210,7 @@ TEST_GEN_PROGS_s390 += s390/keyop
 TEST_GEN_PROGS_s390 += rseq_test
 TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
+TEST_GEN_PROGS_s390 += pre_fault_memory_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
-- 
2.54.0

