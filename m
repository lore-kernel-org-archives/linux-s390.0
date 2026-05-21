Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5423CC7DC;
	Thu, 21 May 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368753; cv=none; b=QffZ0H1PzLcoOezGzJyKs7GdmUo2uEn22Tn6x/YQuW7wwoY+Sg50Om3Qc7i7W3JnBfj5Ig9h+KCMCRwZg9CI17ofdqMww4QEmGwgLcnOd9hc5kjtzO9qZvTmArdXcqIqz64V4ZXl7OAb0MGZkoOzdcsQ4cEO9ijFOsqUF+G9Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368753; c=relaxed/simple;
	bh=FjQeccB0HfpFZYyuynKTH5RgFHk9XbIVNvs05kM9s+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihvRk3uKw5N7OfYxJqIKw8d6/vQkTUUlrvfBg0/Jdxdt+OptGQBjwomqQe8sy8rVZKYRqcq9jXFR5m8eXzuY2EuGSDN8oADFyzUjmeWlIjjMGkpud0yEASlXSpsc50SH6oYco14ztwH34IJpodHlzZ7diQyTqyVyO02Er+9sFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZCdqgCw9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZCdqgCw9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8ffQB591905;
	Thu, 21 May 2026 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nbd3iHoUzlIuxdqJ4
	GyJKHMfXggrDxgF67BeU0h1BoM=; b=ZCdqgCw96rxUmTxkyOTvBFX7ua9HhXEC+
	lltAEUvmPRsWUKHituovvOmjOY36vS6vhHfxScCXdx/FEdzDZ30dUom2VHGsSn5E
	ZjfIF2oFccor26HSgyAjka6hnJEtJ4DKWklhaQ2CQIRpQs//kpC9rW0cE6be7S/9
	0XuGHfTxD73qaUTh+tF/Bugid68PrslvdCI8kQBIB5XHJhgy3p5u+/03x/FlkGwG
	AvLqkf5EQuDIu2FT0iekGtYsvAoCr7VD0Rwx/vQh4k0cdeEOAPWJFb85U0gQB5yB
	mm/nXG0FLet6GG566qsqfzjE9tafMnjC8AI+2epfLEOyWQUOTuiLg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h756ytu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCsAsM022535;
	Thu, 21 May 2026 13:05:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhv45q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5YEb31261092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D14FC20049;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AED2004B;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 3/5] KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
Date: Thu, 21 May 2026 15:05:31 +0200
Message-ID: <20260521130533.156491-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130533.156491-1-imbrenda@linux.ibm.com>
References: <20260521130533.156491-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f0326 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=p5bRbc-Dsex6zWGIe5sA:9
X-Proofpoint-ORIG-GUID: 5azQTb_KI5nx2xte53zOwohZoZ0GiMAG
X-Proofpoint-GUID: o4L2VhWttPuMG869TroGgYA5l0X0es6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX9MeI3Nz7J5OO
 Gquq/forzAfGZT/Dr5klXmXZ9ca2CDbT62gO70Scyh/XP2Wv+irpUvIMFc8g3RtLvEVBBg0kO7A
 +sWzCEr72slwpLmxAobH0e3Y4aPz02OXNq4fAEZ9p5cRdWt5IZ8VxrpDFeQVApvtwCFYtwOrML0
 kccfPzE5bPKQrjxf9t7v/M7Pf4Ewp9hq1PszmrckRNLfn0OI63XJZBzeGsppcTAkLiIG0nkYH16
 Qy4uzwmotLxpHI1fldowjgzEFXHKGF5jhyoW2cYn2luEEIO2nFvDA0ktZvYzl3sH5USoYizOjlc
 gryOvhU4eAEqtTvW3TfJr5dikxabydKPL1yqxxwdZW1vKpgrbPXoajE77KdfJBk6KVHF7IbpzZO
 Pm3sddHkURE4pZvtOrsi/EUtXbI9QR6FOJiydb4ejv0Z9DelMLFVKW9V930dtLCerNyGMJl9CXM
 +IlmdmgVh9v9S2+xnTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Update the API documentation for KVM_PRE_FAULT_MEMORY to account for
its s390 implementation.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..e7998feaa940 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6471,7 +6471,8 @@ Errors:
 
   ========== ===============================================================
   EINVAL     The specified `gpa` and `size` were invalid (e.g. not
-             page aligned, causes an overflow, or size is zero).
+             page aligned, causes an overflow, or size is zero), or the VM
+             is UCONTROL (s390).
   ENOENT     The specified `gpa` is outside defined memslots.
   EINTR      An unmasked signal is pending and no page was processed.
   EFAULT     The parameter address was invalid.
@@ -6494,7 +6495,7 @@ Errors:
 KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
 for the current vCPU state.  KVM maps memory as if the vCPU generated a
 stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
-CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
+CoW.  On x86, KVM does not mark any newly created stage-2 PTE as Accessed.
 
 In the case of confidential VM types where there is an initial set up of
 private guest memory before the guest is 'finalized'/measured, this ioctl
-- 
2.54.0

