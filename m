Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320723E832A;
	Mon, 15 Jun 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527375; cv=none; b=G34oSWS05heXDcqiso9EnhBmcHL8/wRwN9OCSChyROhuw65amkLrnIFJ6VXc4RypGHU50NkwpcuXicSsd/nPQklNi9pHWR5Af3eC+nBiyJ7z16CHkkkZMYeRAwpxOMpFPQQw5/mNXR18e6uuC4ONiUvszfuxlu7fUmE6l3TKC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527375; c=relaxed/simple;
	bh=oJlS2mz4O1/YtvtEpkHhV0auNodeEi0NGeFJ3xNxKHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG7+K4tlFlt2RGN5EHOXOUt6auRT6eAiZkxqNH6QHYzk4vmdXmlNZJutb3VRHPp4jLmcuDPHcSSyepulEpOg1eO69RUmnvgumvnW5Gp8Qc51SSrj7yE6KiGeX1ioa9m2oSxX9/6xv1RzqMNdqswWyPIO3eYFQfIX7CNZ1WndcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YNA24/82; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YNA24/82"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FApvHK2247527;
	Mon, 15 Jun 2026 12:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xcabFGR+Dym4W+g+V
	tJPS2dWUdSteh1rV0z+PzI20ag=; b=YNA24/82JHszqH0KPqkEulxPg7WBjfVU5
	pI39uhKYphxeb+3ONTWh3pyjBWHOg0Nbem1jJtfnUGpP6pk82/5X3i8NTaBFEVe9
	4sBshwPEK+OAnf238c7ftzW4/Ta838kWwXFZ9VvGBp/ANTEIM7kI0q6pcz0QwD3v
	AjYhjKn0YxJGyo0sDR9GMMue6nDH3sU9+8KtU4QEP/4yYtYQj+jcZBAfyJlHk897
	P/2lGZZ8lUYAABkLBqPreCkbEfBaIzGlNWfsf9P6M38DmXBAIEVQqGSYWX6jbqYB
	qREEnWKcZ+6qobbnxw9fUB+xlPLku8P3Wn8LRumv1n1qYMvgypEIw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0g2cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYgR5027596;
	Mon, 15 Jun 2026 12:42:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjxj1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgjTp15597856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79EEB20043;
	Mon, 15 Jun 2026 12:42:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 119062004F;
	Mon, 15 Jun 2026 12:42:45 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/17] KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
Date: Mon, 15 Jun 2026 14:42:29 +0200
Message-ID: <20260615124243.187614-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JLHPsMpsj3spMb8kefXTovtmvcfX1o2K
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ff34c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=p5bRbc-Dsex6zWGIe5sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXzkV0NHC6fZKF
 yJBHc74PAUuq1Ex8je8wzC7dxwBAsCm8eqsCCzqULYO/qhWDk7vVFRfKxFsVCi9e6U0MsCMt79o
 D6RAoxfKcSYker28LRAaBGNU74vlRjXs+a38LovT/+MFlInKUsIoBiGSUIks9NBn7JUInw4co+2
 czRsWykxTF3yK17DbFRQoGs2NELnGGXNxyMJHkkz7PDIiqbAPU5oEHaXatEJocKzfb5iiNM8lvZ
 EVaF/1d6dasae9Y1KrwL5ukgc65lqaDmmjOI5bJosOizh6nHbEeJT2MxN52YFzJzWrozn0rkLR6
 BvW8PbffkfM6HO8ggZ7q87beYz+ICsZVu9oPcoX+PY4IResi9TzhBB4r+69yqWuvJsBCus8Ysan
 PXC7harfFa7HJ8I0DtzrlGXr1Wp4/oNx5Y9Cb/K8vzw/9nCahgtxU+/m+zB4ejPtAWDIPVloDA5
 xz+WSILIFXHdyqD/FGw==
X-Proofpoint-ORIG-GUID: JLHPsMpsj3spMb8kefXTovtmvcfX1o2K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8ToqlVE/JhIp
 OUtdeD2vVQwOH526LXPs/czcKqpDIKehcfLkYIviU6QfwvOKISVrXEiziyzlHc3JpqXzT+IHc80
 sVmEI+i4lV/2JKkfoq9AYKMYEqIWltM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

Update the API documentation for KVM_PRE_FAULT_MEMORY to account for
its s390 implementation.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260527144358.186359-4-imbrenda@linux.ibm.com>
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

