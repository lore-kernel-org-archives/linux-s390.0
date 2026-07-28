Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188E39CD1E;
	Tue, 28 Jul 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258443; cv=none; b=ePN3x//GoWYHSpgOZ/nNK7jkLbKih/CKIJwgtCkDKdKmk2R+0N2FwuL9hrAEPIRW7Vradz1BgBIEcbtF0av+mbzuY6iQSgIvHGNZJAihZEQcVXKjrBF20IOWRK1drsutDAOEBjkqOPjgb2Rd6EigNTMXYxyU6jg3nxMqw4CcFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258443; c=relaxed/simple;
	bh=hIvI11nOSu7atb9Lqq+9FR261JXTxF9nepvusj6EJbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoiyROhFdIi48upaph0jVAfGI2aJf+66kZBTZDOSH26DlHQPQdhG0LdlmSTClNBdarN9i7tx7NckKfJkl44DHUT+ZA8Piv44WEn4xQwHcjdj1WsXEOtaHZ4g3dFck8OpMKqhU7zEyGubnlXF9tCdgXRzIBEYIxZ/ylDnZPGx9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pMY3AQnp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pMY3AQnp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElfJU1459264;
	Tue, 28 Jul 2026 17:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8Zg8feFLdlKGUV3+6
	KUEhfIs/ihaEDKP127pDSK810Q=; b=pMY3AQnpGUq6qvXBt7HBQq7jC1NubwvwV
	b+vxnIUhygpgh22zURX/xFUKWwBa84LjRRRlX2KH5PYUqZ88jdVoxhUdj7pEcstb
	dfHJbqRdxby2vwr4ni+IfwoUfaJvLcvOjhB4Pu575xAQ6UshGtsPaTQQGvEaWHsy
	UNVKQookXCRKcmNPbBQA8qx1UrnPwFSRuRl0TLYVQoz6S0Jgxc/OCgn8CSZPpPzA
	57t7HgUGGaq46Kk9XXsh6/HjsqUbFy1ueyXokITBTFiyQi5y5tTYODqY4lBFW1lg
	IPguOk/9g/wwXCq6eZmbdzfvabX33IZWORrlikRzlIUhIqBiRl7TA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7egxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SGuHfY031377;
	Tue, 28 Jul 2026 17:07:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqb4gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:07:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SH7CDp47645058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 17:07:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 313802004B;
	Tue, 28 Jul 2026 17:07:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB9720040;
	Tue, 28 Jul 2026 17:07:11 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.73.241])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 17:07:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v4 03/13] KVM: s390: Fix race in __do_essa()
Date: Tue, 28 Jul 2026 19:06:58 +0200
Message-ID: <20260728170708.294400-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170708.294400-1-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: END7G7NzEIk-tSGit0pN3edRIaz2T__2
X-Proofpoint-ORIG-GUID: END7G7NzEIk-tSGit0pN3edRIaz2T__2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX0wjdv2jGeeW5
 KNbXlHY59boJe2HpkM4/9i/UBKdLeZxAJNNtI1S1wkcE5B8bW55aLBZP95sA3p3hyHsLJ3i6QZm
 VqWDVAFgVbCVVgSrMd+oem0+btzItFIojN5T0kiN1jLkZKlYYmNF3NSfHeqGs22Z7wrdi1aBFn5
 uXLyTq2u0atpRLu7k3SPiPhVBC35GQS8F0huV+pCduu8OG5qr4dx62c380NLQ1+GckGzF9ciOP0
 l/xfYficLtMBmk0t94zIplt0ZlOQMYCkds7/z1LdEV3TtlsTlwD67kjX1ea9gH+OqDeWy+UdOBO
 BSohHliZJj+GoXdsD6DrwaHxd+vdKDW6TzFQFeXLI+CPV8g/CaT0m7n9zYKqRYSQSNgA2innZje
 1F7pzcEiyWju7+vgoa0dH0Y+BYTZCE9cN+7MSEOW84Qi+YOHuGHuOqXQK5aw6K4TbvMGr6lOhTF
 cWAWPMkdL55rXfJLmEQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68e1c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Ucc7pKXXu02aIaGplMgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0OSBTYWx0ZWRfX65OY78UM/3i0
 7j7jbsFGNmfg4MBN1up0SgjTAZNIZMgKRMneSQ+RjyHF5sXXQWMzfPE+wYgsIQsCRYD82S8aa0w
 SVNPy3IHQd6z7jM17RkP4wkej9lSy30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280149

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 14 +++++++-------
 arch/s390/kvm/priv.c     |  5 +++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7bc6426f5f4d..100911ee793a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1300,7 +1300,9 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 {
 	int res = -ENXIO;
 
-	mutex_lock(&kvm->slots_lock);
+	guard(srcu)(&kvm->srcu);
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	switch (attr->attr) {
 	case KVM_S390_VM_MIGRATION_START:
 		res = kvm_s390_vm_start_migration(kvm);
@@ -1311,7 +1313,6 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 	default:
 		break;
 	}
-	mutex_unlock(&kvm->slots_lock);
 
 	return res;
 }
@@ -2998,9 +2999,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
-		r = kvm_s390_get_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		scoped_guard(mutex, &kvm->slots_arch_lock)
+			r = kvm_s390_get_cmma_bits(kvm, &args);
 		if (!r) {
 			r = copy_to_user(argp, &args, sizeof(args));
 			if (r)
@@ -3014,9 +3014,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
-		mutex_lock(&kvm->slots_lock);
+		mutex_lock(&kvm->slots_arch_lock);
 		r = kvm_s390_set_cmma_bits(kvm, &args);
-		mutex_unlock(&kvm->slots_lock);
+		mutex_unlock(&kvm->slots_arch_lock);
 		break;
 	}
 	case KVM_S390_PV_COMMAND: {
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ea5a99537346..b1ba24c346ef 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1261,8 +1261,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
-		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-			i = __do_essa(vcpu, orc);
+		scoped_guard(mutex, &vcpu->kvm->slots_arch_lock)
+			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+				i = __do_essa(vcpu, orc);
 		if (i < 0)
 			return i;
 		/* Account for the possible extra cbrl entry */
-- 
2.55.0

