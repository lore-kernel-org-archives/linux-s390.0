Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FF3DA7D5;
	Wed, 18 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842946; cv=none; b=TNZYGF3HsgP5OO1YP4lIw3qPj+me0i7YULtY3Q+omB/Iv94rYZ82lGqjn90fD46yje7gcalTv0dv6pIfkmHZ/4w8oGv0HweqQWRwTRjxFwYektcI4Ld2Rf2F7zlXMjVCGS29EeSswGHMLvQDeqNkmkdj4CUgn4QKFYwaGYCIFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842946; c=relaxed/simple;
	bh=3yyaO6yYS+EHro00XNs8zvtdtfkSDO4PzepxX/HvxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXZCoocIvJPbejtHgOMdvXA5VXKDLZN+QQSweQ8m4xStgAqjScYJinBBsyPjkTKSe8Ko5EPzGHRFpEwN2OC5CoG+3e1PEx5P1lV+w6FyAj0NuGa8QCxsnc13I5YlfH1FfQh5gHhYGn8AgASra/6WbeKr8hnVQ7fw9RR0xAT60LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HIo9BxBD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HIo9BxBD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IACEtW967663;
	Wed, 18 Mar 2026 14:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=odGkIRC8E2VlKgR7K
	fozLJ6bfmDzMFDRHWxsVPkpPvI=; b=HIo9BxBDlkXOX/R66e31IEMwVpV2L+C9t
	DvfMZB2pxxp8slOYyZthBiVBykeyrwQRIgH/KuinZ1m0g8lDHv3eiyneQfpho2xB
	RHkbSRA4acOhjsZPL5uYSV7CN6cJ1tOCize4j+2A0cyrRp2PCW6PNp4hcRSS18Lj
	QX3ONPMKoxQngE4+GxhnmaNQ5F6Yvcxe5NlxY/WOdSoBNDHmv9UTe+HTRfl9TFFJ
	lSgIE+3yTkBrIYxQQo/JvSO3X7GwpdYVLyaiisOOD1guS1gLYekaYuBopiCxEQu1
	+3L8VjSOQecSlHQP6Zcdrdo4AbEItXi1YIJ4JZxFJtocMkrdfefqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d1q0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:09:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IAJXBY032397;
	Wed, 18 Mar 2026 14:09:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jx4e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8uZi49742314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F9D20040;
	Wed, 18 Mar 2026 14:08:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D340F20043;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 7/7] KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl
Date: Wed, 18 Mar 2026 15:08:53 +0100
Message-ID: <20260318140853.119460-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140853.119460-1-imbrenda@linux.ibm.com>
References: <20260318140853.119460-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bab1fc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ikv_JcFPPU8SThzKSe0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfXwQ8/8axzL1ei
 HVYHgc6nv0dzD4tQ/uvmOcz5Z48Taw+5gbT6q7p1bWbUIEMj2cEHPqWoZTYQijz6Oos7OawpZHm
 iDpevR7BrPvim8PUAKzVHOzSH9f8J2wN2rfMFsIZ18npY4vh3pdXq0cOckfwVSenquord94cSXC
 +T6ajed8Mge+i5l/3OmuTUXhIAg9Y0oet2SglGz634WCtg6rDCsHRCR0la78kQghAiHQtTskLIR
 mx5zs+uLuxXloLvp9646TlaP74QJVbCfdXm9H9TYR7W25qaMBdRAaNQo+itS867J4IhcKF9ZdBb
 HVQWUX2cAL2ISx6eekHJKENmUvutUqc4G4kYUzm2Gxzcx66BKczJenaCh3L+wflimspMh+A6IZv
 ZtbL029B7hOEZykS1I687s4Bs0ZZd7t7WCYUkmKGe+weLiMhQ2ipCBKnDP/7x8fO8FW8pYsHFdW
 ygLwjcz2/jnVY5ehOyA==
X-Proofpoint-GUID: hTpXI0e9Rp5QWFWb0lCfXJIAdhtKEsVR
X-Proofpoint-ORIG-GUID: hTpXI0e9Rp5QWFWb0lCfXJIAdhtKEsVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180116

A previous commit changed the behaviour of the KVM_S390_VCPU_FAULT
ioctl. The current (wrong) implementation will trigger a guest
addressing exception if the requested address lies outside of a
memslot, unless the VM is UCONTROL.

Restore the previous behaviour by open coding the fault-in logic.

Fixes: 3762e905ec2e ("KVM: s390: use __kvm_faultin_pfn()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ebcb0ef8835e..aebc74974ddf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5520,9 +5520,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_S390_VCPU_FAULT: {
-		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = vcpu_dat_fault_handler(vcpu, arg, 0);
-		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+		gpa_t gaddr = arg;
+
+		scoped_guard(srcu, &vcpu->kvm->srcu) {
+			r = -EREMOTE;
+			if (vcpu_ucontrol_translate(vcpu, &gaddr))
+				break;
+
+			r = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(gaddr), false);
+			if (r <= 0)
+				break;
+			if (r == PGM_ADDRESSING)
+				r = -ENOENT;
+			else
+				KVM_BUG_ON(r, vcpu->kvm);
+		}
 		break;
 	}
 	case KVM_ENABLE_CAP:
-- 
2.53.0

