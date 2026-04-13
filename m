Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671423BB9E6;
	Mon, 13 Apr 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077280; cv=none; b=PfkMsKWtc5dh3Zx+KmP6hnfJRzXFANL5l38g0/vojWHXuCq3p7CSj7HSLeIjwP99+W7qLomsWfiEoUsIFhYL3xohW3U7di4Iz/k7s9ykuRCd/sx2rFXuAx7hA31jNcXwKEqdpEkSU8QlajgvqGHbFozPUd8RyMyceWvWG4fsF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077280; c=relaxed/simple;
	bh=XL9jVad1YLaEsarMOuZ1+gU6EzPnerA61UgovU85yTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9yWn53zr4Kt3W45HAanJHRN1rNW22RTj+1Ty5vv7pnZZfwprNT2YgZjHICKCgvORUjtUExGu+Fm/eFR1BIS37zpzGshyGBphgQbxGAUIovbjnCYFJ7xp3pwLs5v1nE1JNgUlGhWIMMMJPO1diuy/FcHDVIdcfcTVkRs7chSBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1u46R8A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1u46R8A"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D1srqD3645729;
	Mon, 13 Apr 2026 10:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YavI2z/zFVdlm8Th/
	FwensRL3BqBUT6wcGJyvjpok4E=; b=B1u46R8AfRWmxgKZrNW8k83bHJ6dYpBUb
	suQhtHZKMkxQ1GyG4DDACbDxj0/1AFfX8uHekLKNx9Aw2EpLMm8/5c8XkeIBW4Ck
	+uxIvdqGFF58mv01CMdu+medLYrxOTo20wubkAbHWQfN1KUOUzROTS8FZ9QzPTbS
	J2OxJruB0wQJa+Hlem/RmBXVHa9lJ5BkaeeV89YKlKW8XLj3xzA1xxcP48XKPhKF
	JD5gUOZSUAY6APLd7KwrG4+fqLBUMkesJcEuS1NVL6DfwaN25ZiKdG3Dcwl79e4A
	ZWfGTjHRlaoKsCTw6RB6RbUqIQ39EDlzILUutdyEesFF3jsoJhHnA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqq6rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D80Whf015153;
	Mon, 13 Apr 2026 10:47:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mscx26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlpcJ19202490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B390620040;
	Mon, 13 Apr 2026 10:47:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EEB72004E;
	Mon, 13 Apr 2026 10:47:51 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [GIT PULL 12/12] KVM: s390: ucontrol: Fix memslot handling
Date: Mon, 13 Apr 2026 12:46:40 +0200
Message-ID: <20260413104721.203024-13-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcc9dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sBp7wJ6TW6gTHNKeVeEA:9
X-Proofpoint-ORIG-GUID: ngPN6m51-912mWsx-QhxpuyiIH94HoTq
X-Proofpoint-GUID: ngPN6m51-912mWsx-QhxpuyiIH94HoTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfX+VFMnVTjMv94
 u+g/GWCunwBYSN6DVuxrcmLgESl1KdYFVgFpd7u3QbX1MiV4QnHoTZ0vBPfvp9p9pzMKTtn7Hb8
 2t1NNQJfxR/w6gl6cd9qmfvbbj9pXqjHVKw2KdSeOElLrbkKvul5VXryQnbpSyY7E/lssYgK3TZ
 pkrujs4zqYLwM77CmjTNdBJuW+Co2fmrIttrU+JPJCwAiHRB/oF0X9gaUePkBS8Oe9LdWXp/v0q
 pVA70S6hBC+yyFhTL7lwENPJlNAnuj417YtQCFuZmWlh15uuOf0nfyQxRW/E+yusY9TpkuTqH0l
 JA56MKJab2HcONGG1Q6et+bRufymnhNDwl4Vm+tOOmr5qbsO+YuNGQCmrQ3bxcAM19+yKSEPKRM
 ppsjEmWQv1KAXyYCWzM1UA+WPsRn+kTWdRF/6hObEEYXLHY2/edGEQIB8XUkMp+C3B6vFoQerpE
 hGuE9JMQlbKZCOPI/9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Fix memslots handling for UCONTROL guests. Attempts to delete user
memslots will fail, as they should, without the risk of a NULL pointer
dereference.

Fixes: 413c98f24c63 ("KVM: s390: fake memslot for ucontrol VMs")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 156878c95e06..63bc496d0c37 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5642,7 +5642,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	if (kvm_is_ucontrol(kvm) && new->id < KVM_USER_MEM_SLOTS)
+	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
 	/* When we are protected, we should not change the memory slots */
-- 
2.53.0

