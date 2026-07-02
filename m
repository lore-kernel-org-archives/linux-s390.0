Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AB353A9F;
	Thu,  2 Jul 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005863; cv=none; b=Hdw0H8otMAKG/6SDFNlJPahLmKMRNruyJD8HDtUv2AmVpASgTe4ZMRpJsdutndnFVKVFZA/Cb1l/j9VrkIvY+C8//SIiEzZC5gssDnlmXeQXeBA35iiPVjwzUIUAIfAFKM712J787TRH0YLeK4DXH6HI06aM5u0w3A1pvfvMHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005863; c=relaxed/simple;
	bh=c+4cmXdX0yoYhb3G8lnmOYy5H5MN/0N23Kv1Xl2MhxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rt9bEAXDb9LaQ1K9mmZx2WYRL4iCJO3/+vHBw2uf+3k5+Lu7aExszifsUFN+shS4OZl/hBS05Q60Ja0n8KywoLOeja1lD9BC93J3eaTA08GasU44fTKNgFQmNT0Kqo0eUBr+Dy6amJzgEG+/Yq/CGofuRUXsEQf3+mqWotVdxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VunvHoCg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VunvHoCg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIOM34074843;
	Thu, 2 Jul 2026 15:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bIFHxQREBJF9rB5ph0jBs5JPRJQ5JhbDTL66ErRQ9
	tA=; b=VunvHoCgg2MRv4Q/61ch64GuJdWwYTEd9UzqBMCDuoNnBziLKbAQInXwD
	q9Hnu5cJrsniyK95quse4s3rUlX+gnJulON0R3CYC9+TDwW0jJzRCT8jAiGBEFo8
	K/VWyEIIDAjz240Obu8mWRwlpkaSsPC8OFO2leCkOT0NZ9tT/pIRHQBnHa8rugr+
	tpec8nzwerA44/QXhaXsXo8GZGhyD+O1ToPz0+/vphHc9A/MpKPnmTcJI/K3I9+O
	7boz7itYx9ljNc4xwtuY7H+eMDMgFDf5Hs4BB78hLeG6kDaDFhxZUm/OOP6ZoUvm
	AY17vLFurWELeOWlLU+eoUTuYco5w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n62pq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJiNd010734;
	Thu, 2 Jul 2026 15:24:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhymb1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FO87F35520818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09B792004B;
	Thu,  2 Jul 2026 15:24:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB9D520040;
	Thu,  2 Jul 2026 15:24:06 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 0/8] KVM: s390: Misc fixes
Date: Thu,  2 Jul 2026 17:23:58 +0200
Message-ID: <20260702152406.204782-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX/9EgRkGP8frh
 idHidwb/5+KAANgKNGlb7A1JmEdCtlJmPfc62fayupp6D27rFpLpFBVx/DxiXpdLytDuff1Wn/h
 YkYyXxp6i7lvOGjmOIFdvUzz6ToSuku3W2iVfA80f/nC6BgL794VNhi+7QRmHCrJhLYfC2fdDke
 +hEbCW2PBsG0T5F2bBDAG1AfYJUmz70McKy1mVMpjJkKbQFWuVFY3NMEgUa/rjd8jAG2niG9+nc
 FPyXd67ojOemIw4O5i4OKJKCMjHJxhzw66DLbqoOXa9lz73NxSNp6Ca1uX4tLdkKx3d07p4r7X7
 a4FOSo5FLxP+x0BfE+iWuzfjGSL8VKzU6q2I2Ud0CCKCoZzHoBnF/b55cssLkELuwS81p9hXtnd
 XImd9JiP2OUOlabnAlqOvyWzGSa0B57dAKgeK3wrynUbCmy6QHuKUfJxFTMD9ZX6X/z6Z2qeuZK
 wFz2VKgmepzJoB0dumg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a46829e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=vdH6cOajrEmJmKw5ZegA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: h8m9wmk6Tx7i8prPXs4W7Tl5qvlJb078
X-Proofpoint-GUID: h8m9wmk6Tx7i8prPXs4W7Tl5qvlJb078
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX+PM8zOL3L0tF
 u0+dp2ONu3+WTjuBgT4H64z+LQGcrUryo7aorPQflGJ2AggjhcaeFNLv3lI+8C5CDBQonKuGg1m
 CG8IZj+hS7TNVLljsQEUJesdVMJEbS0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160

Fix a bunch of small issues that came up during the previous round of fixes.

They are mostly extremely unlikely races, but they should be fixed
nonetheless.

Claudio Imbrenda (8):
  KVM: s390: vsie: Avoid potential deadlock with real spaces
  KVM: s390: Fix unlikely NULL gmap dereference
  KVM: s390: Fix unlikely race with KVM_CAP_S390_USER_OPEREXEC
  KVM: s390: Fix return value of kvm_s390_set_cmma_bits()
  KVM: s390: Fix race in __do_essa()
  KVM: s390: cmma: Fix dirty tracking when removing memslot
  KVM: s390: Fix dat_crste_walk_range() early return
  KVM: s390: Improve kvm_s390_vm_stop_migration()

 arch/s390/kvm/dat.c      |  2 ++
 arch/s390/kvm/gmap.c     |  7 ++++++-
 arch/s390/kvm/kvm-s390.c | 30 +++++++++++++++++++++++-------
 arch/s390/kvm/priv.c     |  5 +++--
 4 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.55.0

