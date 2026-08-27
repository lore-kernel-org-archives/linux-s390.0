Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E3489878;
	Thu, 27 Aug 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845999; cv=none; b=qB5bNJFdHXKY9PrselDjs1Wgc4VwfupELq7rSWoTuVAjow8edV2jodXAge7eclgTvCTnsrzn3Tk4G+9IRJkx2SzFZVO9AeeI9M9MYFULEuNiTd59ASDN5iddIllmIoHLeYU9bMG85HVg4d/s9Pp1JBSJI0pHvEhmFtlyVj8a2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845999; c=relaxed/simple;
	bh=aLaB3JbC68o/lfKoiZLIi7D6VH6RdcwhTmKaukWkxLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYDBxg8YQX8eCcPtZ17hQidvoKgmej8GIFDaEoixQvHwPe14oxCMYRt5XI1Jz9Mijj6g135IIHI6zX/AN59XDsVVvNIoG48dRyrh4vUKpVm5B6w17b3dU2t8TcvV/hxPno7momgyz/Kfu1U0lDNJ3Ers/2sNd3Cqnk1j+tc26a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UgMDNQkT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UgMDNQkT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF52eu3355162;
	Thu, 27 Aug 2026 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+xfGSo
	RMOfeI3i0n9g0kyek9xzLfbjD2WB1TbWzIOn8=; b=UgMDNQkTkKX2vOY7k8v0uw
	bpAG+oKjR8X6kmkh+9G4Lu/CU+/FqzR7gq8CMXLfmqt4KcJhazYEDt5T4B0KkPna
	GpmLKvgpNWYsuJrVhLBjUr99QU0l+3WYUILioBSUoAzhw737P+bHEXGUGPhaajxT
	YnXehZZYCupay6M4d42JOwUSVIFRUhVAilkL0M6qWIDwUDC3W7wbm+A4spR9zbNp
	S+MuuqhTucNPEHZHXZU+NYigQnL90Dzxgg0elGzrhwQKLE0xURU15tbNxk9dVt1r
	n8Gqc1CRxKxlMg1NCcOch78W7I6jc0sjWalhJsal8jtI02+W/S6cFSyB5limv+Mw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g56f4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfguj006018;
	Thu, 27 Aug 2026 15:53:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr3NT31785676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A573E20043;
	Thu, 27 Aug 2026 15:53:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA8A2004F;
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:52 +0200
Subject: [PATCH v6 12/21] KVM: s390: vsie: Add helper unshadow_intercept()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-12-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=aLaB3JbC68o/lfKoiZLIi7D6VH6RdcwhTmKaukWkxLc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoOd92341Lv4jI2wSPqq2n+rNy2OODOd/17dqh8bB
 STeqZSd7ihlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAiD3Yy/A/8In3938Ub0016
 JfwbLi3//PkDy0ehaVPaV2i9bJv37mAkI8PVI7OS/H45M81/WOO53HeN6e7yStepiTOqEmf2vlD
 c384KAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: w74XMQod3-Vm-3mE6eH8KvkSBsRSUALg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX7BtGGNi+lGvw
 PR8SdzxrUCD53XLbk1ENH6H/2fyz/9APXrhJJmLEXuyx/z3auHRiHvLINm4QNqLH59rcwzmzUR9
 ejhkkaCUykBOnOzkZepXqz54wydM8d0=
X-Proofpoint-GUID: 4TFTwJ3BgQPypGi2BXLvVH1hqTc_hR41
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a905d6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=iW0MwhF_9mvIdrGbKFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1a3ew/Qjml9a
 1NEVKfDNLoANBFHXWohSQugalfmn+pdox35UzQZSKsOBJheIQg1B1v1DuTRvdoVA8us/uGihKcp
 z6GXd523uWe3quUh/djHUslZx0Zk8HW1CVx6ULpS0d6tJZFk9LKHf/bQKtYUs8xYuZ1nNYXmSBo
 hERI8wyJihdNTn5eAdvYMeZDDP1fbWiYBGBFsIsBwPpyLXUEKgXnMEx7s+t69RTJLaxB0/BgmG2
 tY0HZfIJV8xCzQUAhnrjNuv0cO/3M1NMVeWiIzqZnnOMfIpsS/bR6s2J8SvXgkvAJVi3NypuyNJ
 22GyGLGhvf1ekLWIG1EC7Gjl6/f+V+lvIdGxfKPWGpL5U0+Z5pFZ6NaBP+hCTa/geRAaNeniVXv
 BNK959T7k45UhgHf6vSuBYY0KgpLQYIp28y0jipD57ntEZFuPYzCFBIJ59FTqzwUimD0ffd9+LL
 CKV0mL5N7R9S5FE62Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

Extract helper method from existing code to reuse in new code.

unshadow_intercept() acts like unshadow_scb() but only copies intercept
information. Used where the rest of the scb is not yet shadowed.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 95baac9a1ccb..c42e2df4c0ab 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -565,18 +565,27 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 }
 
-/* unshadow the scb, copying parameters back to the real scb */
-static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+/*
+ * Only write the interception fields back; avoid clobbering the timer and
+ * guest-state fields in scb_o.
+ */
+static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
+				      struct kvm_s390_sie_block *scb_s)
 {
-	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-
-	/* interception */
 	scb_o->icptcode = scb_s->icptcode;
 	scb_o->icptstatus = scb_s->icptstatus;
 	scb_o->ipa = scb_s->ipa;
 	scb_o->ipb = scb_s->ipb;
 	scb_o->gbea = scb_s->gbea;
+}
+
+/* unshadow the scb, copying parameters back to the real scb */
+static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+
+	unshadow_intercept(scb_o, scb_s);
 
 	/* timer */
 	scb_o->cputm = scb_s->cputm;
@@ -641,7 +650,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	rc = prepare_cpuflags(vcpu, vsie_page);
 	if (rc)
-		goto out;
+		goto out_validity;
 
 	/* timer */
 	scb_s->cputm = scb_o->cputm;
@@ -755,10 +764,13 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
-out:
 	if (rc)
 		unshadow_scb(vcpu, vsie_page);
 	return rc;
+
+out_validity:
+	unshadow_intercept(vsie_page->scb_o, &vsie_page->scb_s);
+	return rc;
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */

-- 
2.55.0

