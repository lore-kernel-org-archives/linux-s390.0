Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB342885E;
	Fri, 31 Jul 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502922; cv=none; b=NEGXqNsLxLELbQdj/h1FOu++lty4ezFp5rfuvAbdma5j10lO8hHxVK5Q2K4WYI4x0PVkXOeun2sBDkGL3PmPbWBoQ8Uq7VBqZM2fsomG98m8NOFS85iBPx1Wca5PFh7+824bUcNPNWxW1xXyPTnA3nGU+IXtnLpfKXR2Ck/JCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502922; c=relaxed/simple;
	bh=lrLXFoXGkCQqajiFzpvyyVTqja9Wibw9Q7qbE7OIzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZX/nA5uTcdTi5KkgyWjCPgJx0r2C88E5pLtYWZhk9AQK53zWsOBRJNpuxfsrnvpn5MqUieiMDS7RvGyPau2qNVlyOCE6auJ4K6p51NDbnqpHIZGEkSCxVw1NiyeJns2UEbsOs7lvh9bKeJJf/j+YHeuUEcBwvUpJ/o79YYluEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dw2+/Fn5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dw2+/Fn5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlwux1791087;
	Fri, 31 Jul 2026 13:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J5ryilsnnfEEjhv+w
	mZlP5DZ1N22K6iGMAkWi7r5uEo=; b=Dw2+/Fn5Awu+CRQZ3YSgczx7y61a90hBL
	wUAt9roIyOvoJ2Ggu5I43riD0Sg/+GGl7tDFp4P/TAX8pybq7obLdDWVneE8PBW0
	onENaYhMIaoLQI+JFPKYRPUPvWs0vz6c0haZrzUcEz7jOVyFQwZac3VQZWLYs8z5
	YsdgZ84bUAJ1dBqhNvTRjAqXkKYDgWp/ZvCfCfQaO2MLfBke8ofX1IMUcGj7RZqp
	mqGolj7H4F9dHk9OUi9dBNsFJ0wzkn+2+jpEK+gRbYEbR+0+xrn1Lejau3u0zLBU
	ZTT5CONUaZCIQxBPc7SBiwODNhGUT1jI105blVgqM7jKPNluzctGA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdc2wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuN2k012675;
	Fri, 31 Jul 2026 13:01:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkfxyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1ofQ29688252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7DC2004E;
	Fri, 31 Jul 2026 13:01:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9E6620040;
	Fri, 31 Jul 2026 13:01:49 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:49 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 11/14] KVM: s390: Return -EINTR if a signal is pending while faulting-in
Date: Fri, 31 Jul 2026 15:01:35 +0200
Message-ID: <20260731130138.173983-12-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wm6OJOhQB3Ql0eCsDxMledhVgvpqi3J3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX8pxKPRkuragD
 cmygZq8SkRX6CKUT477UmKyvVV/n+7ArI7+0UrOX+qvUGD1dGD+2sPHd7nqClPm1Z5MNh7o/skQ
 K4YSY1UUehM4Gn73HpnaR5pbQDBRCHI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c9cc5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=4yawSYOjwzvXb9KGJXwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2s/Dh+2e9aKH
 1GVNkyh+vdRc5MYsVMbj49jGasGGgLqYwzT40dg37CLCAGNE8tc69Y3Sr3zaE0kNk4r+KAqXz5o
 I6FjqLkB3PDBaJpErbKUivDNl/alE3PQwg+JAVXBdQmwIMxQOEXGsQEFqzJZFaJcZ1eIM/6A0wJ
 Y7TFnsfOFgAyj9qR2MtP9gbZWGVPNWifOkaqoUsdLkGn2h2c42fE9dv1VWqIttnqFn/eMI5v/UO
 IRC1s81KAUBr0WKSKm5fi+OF1LBFGy836ROk0Y8IKhgJP85nsS5qghn2hA6WIzOd75QgQ76RB54
 MB2h9DvP7w+CSPGQ9KcLJO5ZNLK5w9b2p20aYktgIkribOl7Zri8j6fAllkeyoSwQ7SD1HLbey7
 dTzn+kBJqRR0eajGoTfrng+pA0l6gl4SB36h2/vGdaLY4L9nEEWuXPP9Ni9E9woWjxwMDKkaNt0
 m9n6I9Mn5ILykqqiUBw==
X-Proofpoint-GUID: Wm6OJOhQB3Ql0eCsDxMledhVgvpqi3J3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

If a fatal signal is pending while trying to fault-in a page, return
-EINTR instead of -EAGAIN.

Also fix unpack_one() to handle -EINTR properly.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c | 6 +++---
 arch/s390/kvm/pv.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..3cc45f7f5b2d 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -91,9 +91,9 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		/* Access outside memory, addressing exception. */
 		if (is_noslot_pfn(f->pfn))
 			return PGM_ADDRESSING;
-		/* Signal pending: try again. */
-		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+		/* Fatal signal pending: bail out. */
+		if (is_sigpending_pfn(f->pfn))
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..dc204b521052 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
 			return -EAGAIN;
 	}
 
-	if (ret && ret != -EAGAIN)
+	if (ret && ret != -EAGAIN && ret != -EINTR)
 		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
 			     uvcb.gaddr, *rc, *rrc);
 	return ret;
-- 
2.55.0

