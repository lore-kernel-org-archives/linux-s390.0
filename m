Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35A4756D2;
	Tue,  4 Aug 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860692; cv=none; b=KnCqtFG+WVdsh3K2pedesJ+TqKXGk+K1c2YqI9XNTfr+sg5y/L8mSEPaMZY468U/rqCYWRFqA1b5LUtEE6uC2C4eQTbk0LGA0P9iOAiS70mk0+vcXsE0g4+l3404fnVSDGF70BxW3Olg6UZvdNcwTqPEd7D6MJ9BMEeurRg0ApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860692; c=relaxed/simple;
	bh=Koldpl7RlKiY1VDfnOulBd9CfBg9JODF+ErV/qhmfL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMLn2jv/gt3oOooqgmitwxOSOjCGNaZj9DMu8pX+Pb9i0aRPtw9Qu0hBoNDy6wa6+yQOAfK06yEOnjobyTSo3VITktPRAcJ9YI0BPLrfoXJ51d7mJ8yd5Zb0FdxU4tycx/hBUwcJqx5h8JSwEF1L+ISOSCeSl2EgvRAjBW92R8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c5Vgn3YV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5Vgn3YV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FljVx3599248;
	Tue, 4 Aug 2026 16:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h6d19vk/GIxVgJK2N
	Hc7Ua6uHHPrp1tzzvcLL/jrtWo=; b=c5Vgn3YVjXH5CyZRS4WCMvc6kvvMt0zs9
	CJTNWklAexPhnYM7dXFbtM61CSJ32SlI02eNMuIwCJLbTHN7cPF5sgQfojSzes7I
	Ma87DYunl02WOMPAPs6seZN4ShFP1CEEe4li5Roo7+tyN+uC9JPR7dcIwBpElM5Z
	qY0v+pF7x8dLbX6B0NXqoTWHGR694U1uqNTNSPNihK/WOrnm+YOpUo2DvoLvUGfG
	ozoMSGfFBsrCQXKjyFgh5w5mdmIU2L4wInjc0pTlFt17IqC55hb1RAjYSMDA/SAl
	I6FH/rE0ihLIzA4l3eIxOBTSQk4ShiDjGA+dxlJxebuSDSAgk6ORQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqpr6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBJjv019714;
	Tue, 4 Aug 2026 16:24:47 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw2tgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOkjW26149466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB4ED5805D;
	Tue,  4 Aug 2026 16:24:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DD6458058;
	Tue,  4 Aug 2026 16:24:44 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:44 +0000 (GMT)
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
Subject: [PATCH v2 3/7] KVM: s390: Zero initialize irq in reinject_machine_check
Date: Tue,  4 Aug 2026 18:24:31 +0200
Message-ID: <20260804162435.28617-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804162435.28617-1-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ov_6JBaMzaYnEbJGnsakmTXLdK3tmhwL
X-Proofpoint-ORIG-GUID: ov_6JBaMzaYnEbJGnsakmTXLdK3tmhwL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXyf+NJkGG6PEF
 wnAKevGsn6sA0TQ4RJGmbAxScQIvaCxAbKtSOo+3Jgokri2ihUkLLYExLOABgnuvir0uWbhmux2
 vNoP4APsWaVqxB8xq49rdLpbykVpP1s=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a721251 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=51UJv2RdcPi40xg5ARAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX90MrEE50dNkx
 UeWhp1q20Figu/4lrwSguCg3H8hXN51wmHNEd1fNWkdLinqwubn4jqLvgMW9FPrmdJqS7G2XTK1
 WUWx/acRAuH9Eohp3XcabHY0JK29RKA5R2TxgY1TD35dJZbLJUSskS0/xAI29TkSKTOh8fICIXX
 P8LT+JWqRZhf6hEVjvjIN74kMCsmMsz5C/yWbGvBjq6wIPjYW4VYbZIlyHI/e/BBWHVtYNMQCiZ
 bQgs8RzY6Fsdy/S+uFKXf8Ot1ybfYZOMNxffOQ7QtI4iXPhAcJFcTgxzROuSLSc2nA2orKmGoMJ
 JJDD4WjuNsaglhkW6N312Igda5GvQflhf+pV8I9a9WdS0VfFBqaxa7roWa0taTdRQ+kdtlSckBa
 rAmcyfoU5W6QC8uzBc7ODBIIFGn+XoFmVvrq3DWEniXGcJgIMDRfSDRE1AbyXjCxZbNPqSMcP/T
 S66NmhnMHpHMWl6Wh9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040131

kvm_s390_reinject_machine_check() fills cr14, mcic, ext_damage_code and
failing_storage_address of the on-stack struct kvm_s390_irq, but struct
kvm_s390_mchk_info also has a pad word and a 16 byte fixed_logout array.
struct mcck_volatile_info carries no logout data, so there is nothing to
copy there and both stay whatever was on the stack.

__inject_mchk() then memcpy()s fixed_logout into the vcpu local
interrupt state unconditionally. This will reach the guest during
deliver and userspace during migration.

Reflecting zeroes is the correct behaviour here, as KVM has no logout
data for a reinjected machine check.

This needs a host machine check while the cpu is in SIE so not trivial
to trigger.

Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 23f0e0821474..009d6a845d59 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3109,7 +3109,7 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
 	struct kvm_s390_interrupt_info inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
-- 
2.53.0

