Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1863CB2CC;
	Tue, 28 Apr 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=gEnfU7JYAj6w0yvaCI14ubS5elaF8ytqVCwyVeKxQzLh8EWTDEILkQ9SI9H5Hjw91ZbxqT7dbeFWRcv3P4DtJpQzd9ztL9ZPhO4taufyw6Qwc+5A/cspQjUzvj8njp3cQAhRpgpGW+lwFITuoqav9+FrsnjUPD7ZttT8Jm9lbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=qkWhJvM2KfaD2CTFFEMvXKFfbm4En97C1tiACn+3Pdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3kPvilvVfXMg+ncgrAbJ9pBZyc7ia3tz9LyNLE7BF/IpKCNgECJOaQ7jd6Sfui3rDNAcHq5FtZannyUJgw9QQxaGiSGINoD2+B7iVak3TF2Pyy7e/cs3gVtbnCHsZqvhF0W+vjxK3k28dJmatlWRAEKcLXtHpCMGjsooUbmFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNk0eiT1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNk0eiT1"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7ZbwD3293550;
	Tue, 28 Apr 2026 08:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kh+0oe
	ceshKmn0rO0bKSNpT51u4W1l9P4nryzdCM6Dk=; b=JNk0eiT1895s0OjpjUkIOs
	CjvM+ztZR9skoZoBjqlrS2pnGBLHQ7BX9AyRWyJutwTBBBgrfnJur6vqqdBvMNoj
	5jNjCBBV8xxN6XmyA9yktuQDfne//eZMVus/hEBa8GsdbsbT/ut8Nww3pBsKasCk
	3mHi5aRMDx7RJdkOHmg6A4j1D7mn8me1CSEK/K2RwAQd9IybsIFTQkrwe7IgQq6+
	K+0Rc8sVTVcqeWaK1Cb9zJuUUwbBkrIm3LDuUeL1nP78ooJ/HWpN5FuEGHCEzi29
	1C/n92+EFsXwxjsU2XWul/QjsWx01Q0xKYen3xcT2XiAOISDIQT3m7QMZLP29SVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44mhex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88sQM026992;
	Tue, 28 Apr 2026 08:15:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g8nfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FXgQ49611066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB15220040;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BCD22004D;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:22 +0200
Subject: [kvm-unit-tests PATCH v5 1/6] s390x: snippets: Add reset_guest()
 to lib
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-1-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RH8dfsfCZRN4Cf6V8h4S8Wlq8Oewg0791ynba/ejYPc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpbYBh3p/WGlxVx51Cf2/FWRx6v2t2U+evqxXyJkv
 oBM+K2lHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzk/B2Gf1ZTNdv9n24te3bz
 4vxKITvl61vfxe2743yb4bn1k4lKX+Yw/NPmcqg5fvDU1GX6v88d2bjJhqXh3Au3H/XLl3eFlOn
 d3cIKAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZsUtW9Gyj0Y7wPOOBVtmSMBf4SK0gtxc
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f06caa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Cd5Zmu1nkpE67UhzTUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZsUtW9Gyj0Y7wPOOBVtmSMBf4SK0gtxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX5CCVUBEvIt5B
 8l9A4d7FbNNvFy4xXsAOIw5HnnpMj5krW0gdvs7HaS3G/AKjbBdRA50TnaNSZ1sTllQp2Vc6nqS
 Zdh/oQfzuBVpYptkZQgJICZH+CbHB9nx1zYDjLdAs2btwWG0GsCKcakdIowumk0BpB1EmZR8U0A
 +aOl1dApRYTHYjHKLvpxU6DmlFvJwQUWmfSUKC4WuDmMTsUejNjv3pD5hkzcD/odwHYt7bFx03B
 ax84K1/NzTYzlV0DPnATTZ9uNr3w5B0IuxfspdU+ZtUmQtsFzsZr5bmqIGtc1ehXhc6vPSVh6Wx
 /L52C11pKn9Ga5KaE27lRrObTBobJyzjlBPB3p9vKxTVwwLqyv73qDjPae8UIdMHTiSn1kxenfX
 rKu3z/talf3QLPDhukAoQCrGt8bV0ZjXXCjxhe25HpO6pXhz6HK+eZRZcdtbWW7zm8O3/9NEL9D
 Guy/FUJK4vSGtBsj/4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280071

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Extract reset_guest from spec_ex-sie into the lib.
After reset_guest() the snippet can be executed again.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/snippet.h |  6 ++++++
 s390x/spec_ex-sie.c | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa186c..6f611de510d8 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -83,6 +83,12 @@ static inline void snippet_init(struct vm *vm, const char *gbin,
 	vm->sblk->ictl = ICTL_OPEREXC | ICTL_PINT;
 }
 
+static inline void reset_guest(struct vm *vm)
+{
+	vm->sblk->gpsw = snippet_psw;
+	vm->sblk->icptcode = 0;
+}
+
 /*
  * Sets up a snippet UV/PV guest on top of an existing and initialized
  * SIE vm struct.
diff --git a/s390x/spec_ex-sie.c b/s390x/spec_ex-sie.c
index fe2f23ee3d84..75625ecffc4a 100644
--- a/s390x/spec_ex-sie.c
+++ b/s390x/spec_ex-sie.c
@@ -31,12 +31,6 @@ static void setup_guest(void)
 		     SNIPPET_LEN(c, spec_ex), SNIPPET_UNPACK_OFF);
 }
 
-static void reset_guest(void)
-{
-	vm.sblk->gpsw = snippet_psw;
-	vm.sblk->icptcode = 0;
-}
-
 static void test_spec_ex_sie(void)
 {
 	const char *msg;
@@ -45,7 +39,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("SIE spec ex interpretation");
 	report_prefix_push("off");
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation off -> initial exception must cause interception */
 	report(vm.sblk->icptcode == ICPT_PROGI
@@ -56,7 +50,7 @@ static void test_spec_ex_sie(void)
 
 	report_prefix_push("on");
 	vm.sblk->ecb |= ECB_SPECI;
-	reset_guest();
+	reset_guest(&vm);
 	sie(&vm);
 	/* interpretation on -> configuration dependent if initial exception causes
 	 * interception, but invalid new program PSW must

-- 
2.53.0

