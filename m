Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86BA3E9F76;
	Wed, 20 May 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290244; cv=none; b=V6tt7QuLVVQTzu5pgg8oIzK8l+0um1vi8Eo/CnRBUsCwPSYraYyznDgqcL0Vha22UmWipAJZcA6ajFNHVUbJzC9uVRVJKoti9YeBRcPTCyNAy8jDZqkwfNBL4qp639p0ICEZhj9rHGIMzFQFubyMsplcEFBu/0Lf3wp+Onk6Gxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290244; c=relaxed/simple;
	bh=FjQeccB0HfpFZYyuynKTH5RgFHk9XbIVNvs05kM9s+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9Fxk3Ejfze6A8LkqUDUImQ+AcJVIYnwQyOA/FQ7aqGlukNzU6MVKilfxpZxcWnRCKIv3jr2Dq1AMlNs8DFtsHqW44TIZxt228+AhaeZOIa2HCEfwcZBrxWIU1Lr3Y8yNZMMMsnnZ9IYYfP2VeYkD5aCC4PodKZGRuabcTjDvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bdJ0WBPC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bdJ0WBPC"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCj1ow3783643;
	Wed, 20 May 2026 15:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nbd3iHoUzlIuxdqJ4
	GyJKHMfXggrDxgF67BeU0h1BoM=; b=bdJ0WBPCjhlt76WIt95O2+7CoNkPdvbc8
	nk2FGd459PMjccteh4AV92VTNBh13RXYn860NKkyVb/2UkWEDtHEkaeX0H9wxkVA
	EJ5YYsKf+Tjp4bxb24BB4BbXmnoP+4lfQIOuoSwkJzRoyO18ao9eoTk20Ft+HZJP
	CjHlmKL7aDncdnasLZk7IjTC+TO+L/ra2tMWOcB7TtqY7dp7s3aQ2EyzgtAe5p+7
	03lPsd2Hl2Q/+wGzCUnhDeMcIi690npnJM6RRThrtUY0stlVM/pfrrbyVKwzFkmW
	MZs4xo+2/Urarm2ve2WgLa/PpBUNtmDWOCX5eFnjih+dq376yBTSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y2sf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KF9Adt013203;
	Wed, 20 May 2026 15:17:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhqu3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:17:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFHBhO26018140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:17:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6AA120040;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4B2020049;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:17:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v1 2/4] KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
Date: Wed, 20 May 2026 17:17:08 +0200
Message-ID: <20260520151710.231788-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151710.231788-1-imbrenda@linux.ibm.com>
References: <20260520151710.231788-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfXywxslD09yGIf
 LU4aTuVzJvsMlDSudMpaEjEmCMUeY6Oy0jEO/hEk4wE/mtT4y8VGul4PB2RtY/4p2i0MSkvdHfI
 p1cvEOj2+QGtCCodgygLVAAjXgfjkJAGgMwpuUiQLPH8pb0tB03wa9902ILh2Lgu18fGXrzDdJQ
 lsnldri0xlE+OzCFNOorWwcERGS2rL7o89/BCXFjkV7UGPoZe5zlNx2SrQhv7NFzhJTXiCH4/Ks
 TtFuntP/bRSdFZltuynV/agMxiPfQoC9pwL7Vwq5/M2rUrMqd6miWC+K4+4sO29H09szd/6Hae8
 4sifTZhd8F8YR6/okvXYsuUCZItUZFu5XAc7SWXC/tIiCc6qwM25oi0ylSnIoUou6q9XSKAeDO0
 hiP4yktpphSBGoGQYD1OBAexlpLjwo8cnutxz/SClEjI8FZcXd09QBDWjghZh06T5NKLFN79NM2
 2TViZO//V32U51CPe+g==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0dd07f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=p5bRbc-Dsex6zWGIe5sA:9
X-Proofpoint-ORIG-GUID: DA3dNsTD2dX86b-T60hitX4wmNDBJSHJ
X-Proofpoint-GUID: xMFJ5QgvoKlInryWPibt-LUFeSYCuo1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200147

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

