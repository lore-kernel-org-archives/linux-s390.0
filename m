Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA944322F0;
	Wed,  5 Aug 2026 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927918; cv=none; b=cN4WgkYW76RyX6RdDh5GfBOhd2G/ciTMMVqaYv/uqFh8gKCMNs1W3AO93gDaLUje/Fi+ubSJd5NBDbQOxGac95dYJjCmO+ClC8kHElez7dbllCymJHihpWjoQ9yDSKGCdvwZdVLtNn4Mrsg7XqhJvbvK9NQOAVhTTxccfZ9swwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927918; c=relaxed/simple;
	bh=R9l0+bhM6k9nLdu9COLjX3W8E5NEi26reF/ukDgJA/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISMVJbtqO9sAVwkK5YftDi3lz3J3DJ0bL8ZH5P6EvgDf+9h3WQndCzSzagXmXodsrvliPBq8277ZlFSGr2Vs6LzOeaj56+g25py/yoWN4DcRggZxgkzRukwBXlUi1S/Vd70oMIba6KK7HH24UGWx0zbD5+UGlTgdq1wdfVOAMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z/54e4Cb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z/54e4Cb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lm7F1503330;
	Wed, 5 Aug 2026 11:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C3tHMc+aRnZ4TWquv
	HfESCd+txJ7FhvM8tSlns37Wbk=; b=Z/54e4CbVotxBw2QB5YzIUO6a23ahWBLw
	OAdrhlX1ue97iqClrcOSsbneHTZvuLmdhU597gvOUstLkFXpfsfTyzM3d0Pmg3Ta
	+JvrOtWiOCuvMnieHI1B3C6P6RGHA+htOnWotQIIbLdfLJzMl140gEs/74HfoVOm
	2XvVFeSzlPYyHR3cZd++0Z2KQd1RioF5tV5jln605yUG/6q0tyhca2j+sQ8cdxLg
	cc8U9q7+kFnuykymwHisH8m6hA1rWRLfS9DrtzwljhPRDk5cxK/Vy45XjCvju/6U
	0YEmoIy7qTRXJUIa98g1RdhulGwyQdDmLXvv0dkP6k3TuVR8Nvk0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtjxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuIXA027011;
	Wed, 5 Aug 2026 11:05:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtynyf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:05:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675B5EUw15139440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:05:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A79C58231;
	Wed,  5 Aug 2026 11:05:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23DE158223;
	Wed,  5 Aug 2026 11:05:12 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:05:11 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v3 7/8] KVM: s390: Free guest debug data on vcpu destroy
Date: Wed,  5 Aug 2026 13:04:54 +0200
Message-ID: <20260805110455.7200-8-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805110455.7200-1-borntraeger@linux.ibm.com>
References: <20260805110455.7200-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p0acmKKldYpokI-O1jsnmg-tstoNYng9
X-Proofpoint-ORIG-GUID: p0acmKKldYpokI-O1jsnmg-tstoNYng9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX6Ddwpxso/B+L
 uQTIV48faHl69VHFtBNQrsCSjGBCZHK2SrjSpnlF3jh8EeO1v3w4+TmH8oonxUDPQfa0tpBYT8v
 KQW+m4IvIgWED98psUyAd1xIyvl9QWQ=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a7318eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FN5RJEE1uaSDo9arrcAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX17dDQR33HuVN
 2STTiTpYpzA5UBmfMLbRW+3E95J0Otr7Y7bxH4bLWhPFh3qitZO7kqKwTcbGsmnofnK+mhSDuOB
 KscJ7AeEWnwR6x1bouNQRzoh5DlaYga7kqmzh7ToC8ZJiwad7LBb08mXaJFCaU036MtYDFfpMpr
 9vFMoVIgutVdGRdefpFgyqwGtbFwkXAEatBUw8NeOuVEifr5SmU9FO2Qtyv4HX/zKJKlCFJh/VS
 yxZ8mjqDggFa/im1NRq93ynhrHHXC64z6Cgds8XFwB1Jq7IUSOhC5DRu+M7sa8OLPSLZ8VWPem7
 LyYjTPFBe5rDDXmWE0maQK+sJNDlXWHw/fwbxG7zG+wn8TLg9LKYtjLKm3VuGBOks3UhZLMq7DW
 Yd5tzX6zbPFjWon48YMoGNo6CCa0uya5CeFKFtNdgWLiIY6kxhIHSrK6NQ+piI+el2q7a7ow368
 /ZImwafOasTDXIO/r8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

kvm_s390_clear_bp_data() is only called from
kvm_arch_vcpu_ioctl_set_guest_debug(), i.e. when user space changes or
disables debugging. A vCPU that is destroyed while hardware breakpoints
are still armed - the normal case when the VMM just exits or crashes -
leaks hw_bp_info, hw_wp_info and all old_data buffers, since generic KVM
frees the vCPU right after kvm_arch_vcpu_destroy().

That is bounded by MAX_BP_COUNT entries, so roughly 8 KiB per vCPU, but
it is unbounded over VM lifetimes. The allocations are
GFP_KERNEL_ACCOUNT, so the charge also outlives the exiting process and
pins dying memcgs.

Fix by clearing the debug data on vCPU destruction. Calling it
unconditionally is fine: struct kvm_vcpu is zero allocated, so for a vCPU
that never enabled debugging the counters are 0 and the pointers NULL.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e0548926dc49..ccbdb109e22c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3409,6 +3409,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
 	kvm_s390_clear_local_irqs(vcpu);
 	kvm_clear_async_pf_completion_queue(vcpu);
+	kvm_s390_clear_bp_data(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm))
 		sca_del_vcpu(vcpu);
 	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
-- 
2.53.0

