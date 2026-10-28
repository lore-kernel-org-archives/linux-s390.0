Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186228;
	b=ns+aovnSpFE5pQkRVZi88DL91nuKd4w42lNxktOfu24xlg/faYe5B8i+ijNWbfnvRpB9
	 QVZVWwyjMVvr0aIXUAJNYUOW2q+1RL3LEpkTqv/z08hEJq2+hPPbZqniY5TO2uY7kf36x
	 lIdXo0cFpIuWauRnoEfr1oBldeW+VO+lI1PLJHR2VZ5Mj6fnHfek8eulXBjxHXlQt2zJG
	 WTsMv/Qw+/AAD2Jc7VuA3USpNydLKPOIcctdnviuu4ObYOj25DBUBvppqJDkWR1QkG+qW
	 JPL4qmlrY/1HeIqs4RwGYjy0w9QVieLwTXGwsNvayf51hAB5+x70YBVdL9sa4F+BHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186228;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Chcvf6VlzJnLjBYUf8kAsZEyoPzwl/dgt3ThYcATBv8=;
	b=SmojPrXryecXNGrJpLq8BqvqEjWPEXrc5qXsPGaK9PQ7oNRWBmSscfSVer94wyx6ZdJ+
	 B0cu09QLU0VJQ4LZvf2Dx8u0CYrIx6n2C9mOfQgm7upxRAuWDWNUHnFLj76ikhb6pWog3
	 09vR461+O3baW9Pt7znzxIRQub4ZVVMpp5hQlopBb2/byY4X5uA9wag2sP+AWM0vEtUUC
	 jIQVo0VtCpehJkTT1ylUIElQsTEhul488R6IhV/cv+rPKv+TvxdBduonEdOsHgh43CBDo
	 9LPjszZjhzDqBIqQG6WXioLcs/tn7Bnhkvy1EKGzckm76BGnpWF9+yWnejUS2dKDbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QQVDF2gU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F018606A31C;
	Wed, 28 Oct 2026 11:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F018606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QQVDF2gU
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8i4vW978972;
	Wed, 28 Oct 2026 11:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Chcvf6VlzJnLjBYUf8kAsZEyoPzwl/dgt3ThYcATB
	v8=; b=QQVDF2gUWwDUr2CqaVGZ0V3vrtxshy5rf9b4G5reNL3uxJVYgpyVbPUP8
	R2/FPSK9b0t3Y8dD92s2Kis6/2LIjbyxnNnn2qeHSTz8pjbXuWj7/YC9dM+tf6Lv
	uI7G3ULobOKRe9tAJKmd3wtR9mwQtzHw0fqvEVMnbLETlV/6jymnMVc28qVdsOdc
	yPK6m18HyCYHkvHUh0/StGjPYx0qj+K+YssC9fXpLjtYS3oEZfVEOaUPNTEwSrWR
	GoFTqAl3HRWInCmCKdU/4Ap1X/H8UPU24+pFv8KQcAg2/mKZ1fGMnqhuqPQyeDAU
	Vzpm58SFAAhEwW7V2W5+GAUJvlrFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm644c37-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:17:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8YmDZ1291845;
	Wed, 28 Oct 2026 11:17:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pa0th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:17:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SBH3ln9437860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 11:17:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B94758165;
	Wed, 28 Oct 2026 11:17:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44D758162;
	Wed, 28 Oct 2026 11:16:51 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 11:16:51 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Cc: david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] KVM: s390: pv: remove misleading gaddr output from KVM_PV_DUMP_CONFIG_STOR_STATE
Date: Wed, 28 Oct 2026 12:16:51 +0100
Message-ID: <20261028111651.66917-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX3H34Vrr7gdBv
 F7qjuYxXeyFZ41EMGeqaufv/+30DTbW3oeGiliCLmvU7J9dcEje3zOuXRChrcHa9metW/QAWzS7
 Y+AaQ57qR/VdUdjXOdHQ667NDFf0H5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX2uVppNqS6bte
 j8Zab5s3Xoi4npullC4Y3qfQcUvkMO51JoSJVsUgMvNUpD0ZrB4SpkS9KZ7jHGgdqG63NwadyDF
 pxhk9OxbGkRJmc/aXHwQTjeVKkpCenrsc/BHl292HFFVYY4mNHeJHv+/9AosE4F9H/5aecqB3oB
 gUisJ3dgPhS4Hm7mh4SvYBYLi5WN/ClOpPyccb+XyuZHWwZRYNNsP0OZEwp/1ivPysskEfB09Rc
 aIOtATTvvEU5Sd/9232d/gh2l9BsN/q+QV3AdEiiitvBqdIUAbP3Xf/wkO1P1u6LknsA4qF2gEw
 jgVtkYYxXJVCfNO3PBFrpnyY0inQTLTmCbWEDr8SZit/EiNQwCqAapcZT276RJuY6/aq+3dCN4b
 C1HonsSYDGimTUO23u+kIdsiKQ5AA4kmTof+FT71WDLE0zfmdtaK3vaduiN4Xd+MPTTBByAibjN
 2eOjVW+hTe6TAQ/gRXQ==
X-Proofpoint-ORIG-GUID: Udo1BYQBfgR6g23_FTzjB1bBW9PZRSDc
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae1d9b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=iGVm0XFYRraa2BqvpJAA:9
X-Proofpoint-GUID: Udo1BYQBfgR6g23_FTzjB1bBW9PZRSDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280044

A comment in kvm_s390_pv_dmp() suggested gaddr is an output parameter
for KVM_PV_DUMP_CONFIG_STOR_STATE, and kvm_s390_pv_dump_stor_state()
wrote back uvcb.gaddr through the pointer accordingly.

However, api.rst does not document that KVM_PV_DUMP_CONFIG_STOR_STATE
writes back dump.gaddr and QEMU does not use it. Furthermore, the
write-back would not have reached userspace in any case: dmp was passed
by value to kvm_s390_pv_dmp() so copy_to_user() in the caller always
copied the unmodified input gaddr, not the updated one.

Drop the write-back and the misleading comment, and change the gaddr
parameter of kvm_s390_pv_dump_stor_state() to u64 to reflect its
input-only role.

Fixes: 0460eb35b443 ("KVM: s390: Add configuration dump functionality")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/s390/pv.c   | 16 ++++++----------
 arch/s390/kvm/s390/s390.c |  7 +------
 arch/s390/kvm/s390/s390.h |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/s390/pv.c b/arch/s390/kvm/s390/pv.c
index b18abd0e29ef..a9bc32d5be6f 100644
--- a/arch/s390/kvm/s390/pv.c
+++ b/arch/s390/kvm/s390/pv.c
@@ -901,10 +901,9 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
  *
  * Stores buff_len bytes of tweak component values to buff_user
  * starting with the 1MB block specified by the absolute guest address
- * (gaddr). The gaddr pointer will be updated with the last address
- * for which data was written when returning to userspace. buff_user
- * might be written to even if an error rc is returned. For instance
- * if we encounter a fault after writing the first page of data.
+ * (gaddr). buff_user might be written to even if an error rc is
+ * returned. For instance if we encounter a fault after writing the
+ * first page of data.
  *
  * Context: kvm->lock needs to be held
  *
@@ -917,13 +916,13 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
  *  -EFAULT if copying the result to buff_user failed
  */
 int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
-				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
+				u64 gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
 {
 	struct uv_cb_dump_stor_state uvcb = {
 		.header.cmd = UVC_CMD_DUMP_CONF_STOR_STATE,
 		.header.len = sizeof(uvcb),
 		.config_handle = kvm->arch.pv.handle,
-		.gaddr = *gaddr,
+		.gaddr = gaddr,
 		.dump_area_origin = 0,
 	};
 	const u64 increment_len = uv_info.conf_dump_storage_state_len;
@@ -934,7 +933,7 @@ int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
 
 	ret = -EINVAL;
 	/* UV call processes 1MB guest storage chunks at a time */
-	if (!IS_ALIGNED(*gaddr, HPAGE_SIZE))
+	if (!IS_ALIGNED(gaddr, HPAGE_SIZE))
 		goto out;
 
 	/*
@@ -989,9 +988,6 @@ int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
 		}
 	} while (buff_user_len);
 
-	/* Report back where we ended dumping */
-	*gaddr = uvcb.gaddr;
-
 	/* Lets only log errors, we don't want to spam */
 out:
 	if (ret)
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index e4912db67adc..1f975ebeca82 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -2522,12 +2522,7 @@ static int kvm_s390_pv_dmp(struct kvm *kvm, struct kvm_pv_cmd *cmd,
 		if (!kvm->arch.pv.dumping)
 			break;
 
-		/*
-		 * gaddr is an output parameter since we might stop
-		 * early. As dmp will be copied back in our caller, we
-		 * don't need to do it ourselves.
-		 */
-		r = kvm_s390_pv_dump_stor_state(kvm, result_buff, &dmp.gaddr, dmp.buff_len,
+		r = kvm_s390_pv_dump_stor_state(kvm, result_buff, dmp.gaddr, dmp.buff_len,
 						&cmd->rc, &cmd->rrc);
 		break;
 	}
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index aa0d1d062f8d..5d6c36c6ba34 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -316,7 +316,7 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
 int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc);
 int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
-				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
+				u64 gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
 int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
 			      u16 *rc, u16 *rrc);
 int kvm_s390_pv_destroy_page(struct kvm *kvm, unsigned long gaddr);
-- 
2.56.0

