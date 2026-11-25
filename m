Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624729;
	b=R9R5Y5JW9aMSI13Z3DnDmuZrG8zGdjYq+LJPohiDX1+7lJJiaMtYSz3vhGubQ/hRbloi
	 4kfJZSZv23NO96IRg68jPdRRQjqKgIwnmNpqmmZj01cHWKom9r4uda9vwNuV/w9MRYWWz
	 h7/0QA6ZFXZ4z8GIg1GWb3lS+zwfjc8C1/1Og+lQpsWfG+pYZwvI01NuXzUleNPM3x1nQ
	 LMg5kbLUmsTqu8Eubg5f/Dn/kVqyvz1uaqNbqPwYBiQe5ipvNF9xQvfpChhTycX5BbwIT
	 qnZdU1e5HNX61c+gk4uT50yt0gcH5jiOBSzSCgkjxm7LneWYzYKqCXTcOP5v2nRaK0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624729;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3uQdJ6rV8k3reRLBa46Xd9o+oKOl5yWAWTXPljeiM74=;
	b=TEgqsjdmWudlpoXGye4PdBwDY5tpxR2pptF2ZrzIef68tstl9XQ/rZGnTKfsaXCM5Zbd
	 u6h29RXXYVHV3pc39Fx8TknRhMidsIZnjclqUoaGYC7IRwj0W6AuMAqwgsKQPMkQ+xV+r
	 wCADc9EMoTwueQvoGtCtP77hWqNB4O5kG0INYgXNH9l1jlPYCJTyL1seojUA2bDSOqisc
	 064eseJRcpbNpRKIqVHke88gelRjl++mRvGIymokhz/SOj+U+jRYR8s+pvWbGI6K3b7Jm
	 jT59fWpJxBZb/Bgy+lBaJCOQsZGRxyWchQeZphQgY1L2/BP0qxgLa1wViLGb442nsGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pqxntqOe;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A798606A681;
	Wed, 25 Nov 2026 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A798606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pqxntqOe
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYY51232290;
	Wed, 25 Nov 2026 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3uQdJ6rV8k3reRLBa46Xd9o+oKOl
	5yWAWTXPljeiM74=; b=pqxntqOeoTAaFClFpfy1BmRkhaOPZqKar9oKJ787UVMs
	7NZC1S0wr02law3ETAjq3eU1iA2fN9LkXNgq4TK0vcsel0bXoWaqn+NVMCTEQ2iW
	NPssWXtPWnR+NlThLd4NyRBHSu7S3rNFCvgL7FeBRTn1c/lZ9UaHJ7Gk90TmUtb7
	AsEvT0nl68iC+oVBkKcY/xVQERyr6Tl05dYE6KNIiap0kdhWqtRk+H2MrJLRvh94
	wHgEr53GQfR2MOxtUomkbWSFuS8ajGiWH/L1Qx/5wMNQjZJ0mxUhd8xd6bBprAjs
	AwT556HJW/fIQdeWYZq/RfScQw3WfXhkgDbTDRPe5Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3de9e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYF162435687;
	Wed, 25 Nov 2026 16:38:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a414qgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APGcf0s52560274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 16:38:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C65962004B;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BFDF20040;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH 0/2] KVM: s390: Enable vCPU kick infrastructure
Date: Wed, 25 Nov 2026 17:38:35 +0100
Message-Id: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNT3bLkgtL47MzkbF1jY8vkxDRzc4OkJAsloPqCotS0zAqwWdGxtbU
 A1fAn/1sAAAA=
X-Change-ID: 20261125-vcpu_kick-339caf770bb8
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.comu>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b070f16 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=dkvufIKfOG4BufSMdHwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX6F1nzLBBl02Q
 4XdUf24kryiD5pjBlGi6ZvPukmTuOtdsldPlafaRhQBB8xYOOV4IWkWGsMEGgWKUQdFIF3JXckB
 t+vr4E296EyQGiTsr66Ig1flo2cvv7o=
X-Proofpoint-ORIG-GUID: IS5w7AXF0TtL0KBtLvzBjfHlyQ8nZI0i
X-Proofpoint-GUID: IS5w7AXF0TtL0KBtLvzBjfHlyQ8nZI0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX1Yo9c0GBNlDp
 j85Y4fgbLrb9cfv/PfYeMR9ohiHmrMMr3Ibo9/hPjY77GB/6umWu2B8mi3qHoZ9BZGCLyz4ZQD/
 34eUi1Jz1KBL2OpXyIFpbHZwkOGMTPyV/6JxQcgN2qlb12yAThQ5yKwvlBoaF6SBnYEKQLQfr1N
 0MbbPNrf1LFr2iOPUFOU9IjxKlV5iP4Cu1Uilr2uE6zG215TXrGCBy1xORG2kjm8bAm4vcJFqSf
 dMlMHPWW5wpv/55Z8+hyV7HUYeM+dlaY+XR4yc5YjfuJtBj/92DP96zu/qF/KcpPPh0BVXUyLes
 t+DYHcW6iZrLL+3z6dGU6fO0SxZtiyGcOwXSi3K5uzgNRtfwp/lW8kyYXdK3cW3O2oA8CJRfEzt
 qs2Rsg3dxemM/39qAM2L1kEGcpFVcD409aFLKyEQco66CMGbYoIiRHYtAOR4m2YkMusn3FtdW+Y
 YB2/pgCA7PKkHYNYtbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250066

Future extensions to arm on s390 will require the vcpu kick
infrastructure from KVM.

Today that infrastructure is compiled out on s390: Commit 0266c894b51c
("KVM: put back #ifndef CONFIG_S390 around kvm_vcpu_kick") guarded it
with #ifndef CONFIG_S390 for exactly one reason: kvm_vcpu_kick() calls
smp_send_reschedule(), which s390 did not export, and therefore the
s390 KVM module failed to link.

So Patch 1 exports arch_smp_send_reschedule and patch 2 drops the
CONFIG_S390 guards around __kvm_vcpu_kick() and its inline wrappers.

As this is a non-invasive change  and eases the integration of future
code I send it in beforehand. These two patches need to come in before
arm patches which add the sharing of code using this e.g.
vcpu_power_off, vcpu_suspend, ... which will be used in the near future.

Native KVM/s390 is unaffected. It keeps its own wakeup and request
paths and gains no callers of the generic kick. __kvm_vcpu_kick() is
now compiled into the native module but unused; it cannot send an IPI
for a native vCPU anyway, as native s390 never sets vcpu->mode to
IN_GUEST_MODE. Then kvm_request_needs_ipi() declines and the kick
would result in a plain wakeup of a halted vCPU.DITME: cover title for vcpu_kick

	Steffen

---
Steffen Eiden (2):
      s390: Export arch_smp_send_reschedule
      KVM: s390: Enable the generic vCPU kick infrastructure

 arch/s390/kernel/smp.c   | 1 +
 include/linux/kvm_host.h | 4 ----
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-vcpu_kick-339caf770bb8

