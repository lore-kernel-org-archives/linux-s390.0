Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CF4FB9C0;
	Fri, 18 Sep 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738337; cv=none; b=D/lZ22OWNLe6vmk8h5N3aQQQ2bMn1Gmj0imS6RZJjI1gzopEGtUAgaipgfZ27V8fBzjKkzaGGwpgjj0rMrfsDV4aXayIfZJllyaIzLEgsRzs6Kt+SHSwSjWbKVKmB/hayTLQCTNgeagKlb/dbXxpQbkFKl1Rp067JEEl3xrojXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738337; c=relaxed/simple;
	bh=QfQ8k6bv2crdYgt2de4mPlgLdFS3kW2o5ooo31+T+k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvfhTf0m4Y8UIWvjlq387RIbA09TFYmiDRH6QiqD+ll1mHcdN+TRI1/LB8LcNbdjpISvLR/is/5qdlgJd8GqTSfVCbWpSAC56vvMg3ireban+S9ve/TKKdTBuc5h5Yd++lX9CrMJQGo9DESfaggYnC9K1oWg/yCE3mAELtN5E8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TxuRd6GE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TxuRd6GE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1fgq803525;
	Fri, 18 Sep 2026 13:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RH7/ACgaLAD7xiHpi
	23Sm9CXa397B2KbF2Zs4gvs6bI=; b=TxuRd6GEvIDaUeTuWYkqIuTGCWsIJbI0f
	PAYs+vRgRT6tMsjwfK2YGOxQw9zFaMriFhZfvdyuSBDjYyEXlk3YTalTNonK9FUY
	h+lsaHq+qEdrQaGMCFiN9KWMfnsWcnmm+UHKDZfAZv38Y+GV0uACDWKiGiigWYIt
	GlrpGuT0GvkfCL3i0kY1lEYCU7mhMZjwpKlfMN2HM6XluFH5UxDMvD58NWmCJbsx
	nZbXkTNTZDTbtf5lnXfrN/CXd2nGtEfWAu+7ow7uJbXPNEi7RNssfRp4V5PbRcx+
	FJzWMJDeeAYZE0/nBBPPv9XEoWRzH4tBJDYLJNtRVE9hq72S+Yw2A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j8145-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDOCl1695830;
	Fri, 18 Sep 2026 13:31:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fek79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDV8ao51642828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBE220040;
	Fri, 18 Sep 2026 13:31:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E59020049;
	Fri, 18 Sep 2026 13:31:08 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:08 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v8 02/29] KVM: Add file back-pointer to struct kvm
Date: Fri, 18 Sep 2026 15:30:39 +0200
Message-ID: <20260918133107.1042730-3-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX9xIhu1g9ugrX
 rH4DjmJFGl8+lyQPTbtptshAtETCkgumxcoebAzSqdVptl4BKNfxgmwR5CWWeHNj7t4X+XFS8H8
 OoJ6tytuZd6znqTlmLnzkuow6Wvvvt7QOF3rDLpsGX9J9g+3p4Xomo8WC3nb8PUWtTi/mTaIYWJ
 h/LiiGRKzWIL/Z/rthHqr+/ZaXTt4zwM5qjoFvMS86ULz/cj7OZ7+tWCC+WY0V99GxVa9a+9KeH
 AWeh38cbWwX/lJj3E1pBPLHTuDZvVuwmZ80jHiEmW3zcOfp8VpIwkmOWAaCUjhtcVZV7IFU5I0l
 Of8O38piHZDqih2GmuoXZt1zG78Xl+UlH46BuLtjTDr6xLsRUc/RjbGTfmolG4xa0Y2Z55hqCvr
 00WibjrLsXQ/zdx3KxpQlpxxJyYxEw6L3GLKzhQisz7pKVLlLNikNfYme9U2e1hIIMppWnVYD6V
 FwyDd/RYi2DSNNZgTPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX6I+kRjZoQGyD
 vpYKSCuMscvu/Vxtyd30LkMGo8FBLEAp5tGdrIUeTJhqCCdShCZc9ERtbIZc2O96UMP7Bak0sR6
 /JYJ/q3d4yvfGTiBlulpDZ8UMOewdvI=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad3d29 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=q3OYOvv_GcRzabu4IdsA:9
X-Proofpoint-ORIG-GUID: hhakXsoQk_t-0CLSijhO_PAbfQM46rA6
X-Proofpoint-GUID: tNskIW43qKDl8CnCnNcc1c165n-p9K5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Add kvm->file as a no-reference back-pointer to the VM file in struct
kvm. The pointer is set at VM creation time and cleared under
WRITE_ONCE() in kvm_vm_release() before the file is freed.
Callers storing the file must take their own reference.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h | 6 ++++++
 virt/kvm/kvm_main.c      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a1bf6d4a8f46..2b56fb4e8555 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -784,6 +784,12 @@ struct kvm {
 	 * kvm_swap_active_memslots().
 	 */
 	struct mutex slots_arch_lock;
+	/*
+	 * Back-reference to the VM file for subsystems (e.g., VFIO). Holds no
+	 * reference to avoid pinning the VM. Callers storing the file must
+	 * take their own reference.
+	 */
+	struct file *file;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	unsigned long nr_memslot_pages;
 	/* The two memslot sets - active and inactive (per address space) */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0172ca94f82e..bab71d398236 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 
 	kvm_irqfd_release(kvm);
 
+	WRITE_ONCE(kvm->file, NULL);
+
 	kvm_put_kvm(kvm);
 	return 0;
 }
@@ -5532,6 +5534,8 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 		goto put_kvm;
 	}
 
+	kvm->file = file;
+
 	/*
 	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
 	 * already set, with ->release() being kvm_vm_release().  In error
-- 
2.53.0

