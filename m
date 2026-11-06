Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983820;
	b=rsqenYNX32q2IqFKiIOu4RytNWSsh8/vpQbh3/WCGFF1VcsLIqhH6vCDGgkL2mD3CBEl
	 aEkmiNfTgwxvbVNaFIZcZ+d1W+knOJm4boWcSKOvqEBcZP/xMkNbPJYSzSTyltCnXXD7F
	 WxGpkm1NMr9g0F/HKJ7Vgo5GxmNMMJ5Wz0smwVMjkw0ssFGXGYsXfcsHempreSNilkKgK
	 pJ1ibD/TVxAuGmeJ79ihNAoSjVvTNQ3Zwn7u5q9DfNivzDUGTOatACG00v9MuzPF1V1Ag
	 MJX+Z59qNlIkmTPJHOiLX5JrvzGCYWx+Qzx+nTdV3+7bo+a8r2MMQZfzaExYst1f5HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983820;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aJwSL2VFHmOt9WAlbWJKZsdB6nZAWxUpPFj5b17idSs=;
	b=bX3w2M/nI3sPKt1O3yPeDtZl59/8LAFv7JkjB7+LMSAaiadXaBO5CFrSo5Kr/4qUB26a
	 CqA5MZNHLzCtiMME4D+PLV7BNqVh38LJO8p9V3RE5Zbt8Pw4pnJlZvAGmTUSODVa0QMhH
	 d1CPXCXk1286CyCWY/amQ0FZoRLUhoWRLXYRZ319rCj69LrINEHMjrbkCUgKGP3WMJzCN
	 lVGC796S7xytAG8KxGDwG5kj4dijXvSdAVo+gC7ARdNP469zK3NUZUOTkgqTa+C+lUslZ
	 TlcROlYFewvAeyONBnFcrNHKbTdx59qBoYq9j277uQqzfGabK+ypmMO4SnA+wpo/k1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MA98YEqb;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C94606A332;
	Fri,  6 Nov 2026 16:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C94606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MA98YEqb
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEFf02711403;
	Fri, 6 Nov 2026 16:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aJwSL2VFHmOt9WAlb
	WJKZsdB6nZAWxUpPFj5b17idSs=; b=MA98YEqbG79VunrXnwgPz9jYYwJPW6NrU
	zAhme8G1zQuaZLF/eGntzLVbFI5tlfJ4kw/eGyydlYXHw/XVWMp6OVujHx8akUhO
	r9gXeE/n/UjIMuzBLTpWJJILhWWCL2Rl+UboPRKBvkPUHcggcWwV1EZ20SmHrnJV
	SxdMPziMRLP54AoUF2qxjOYjZZBqGm5AAopMFBR64H+p1exOi4J/I7H3NNXb3wfG
	94G4/C7nAl9MzSVWsEPeznr2ski+bMbIc8qixNZmo+oddSY8UocMZ7u7kB6P+5fp
	1zDnJQctwUkBjC01JR8CUfsF6PYtUqjLwJU/pAe/bd+XGS8/ITqoQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95xpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xu62390175;
	Fri, 6 Nov 2026 16:50:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h149wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6GoDwh29426398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E133A5805A;
	Fri,  6 Nov 2026 16:50:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F86058051;
	Fri,  6 Nov 2026 16:50:10 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:10 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 4/6] KVM: s390: arm64: Declare enum vcpu_sysreg
Date: Fri,  6 Nov 2026 17:49:56 +0100
Message-ID: <20261106164958.431978-5-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aee0547 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=f2ZHDXJSDHO8LawQCdAA:9
X-Proofpoint-ORIG-GUID: h9ddg2JN9kkgXZxrBnLIz7wCCnnvSQRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX8wNvaC3WsTZT
 Gt823nW+6mHn7XysYY5WOizhI08feFKqoQofUTkdhcs8IbTzFoXGtwwMkU6gQHtOGFC/wl0hIga
 tGpURf2z+s6iolAYrsuefaKYyDvM+HqzB5YTLTm8oz0GCbt1rkldDTFigj5Mvm08pdy4Q90jSCa
 41VtPzTR03vq7frAjlA1B3fElHjFAeTnUOKtxWYb0gSVHXAcg1kuC7WIJ2/dbn+qdjQxDuYJnjI
 iPaVuiEM3xIKq+v7iJA3PZhuTee16VIv/BIo27rsETScrQEvLl+4RyZe7ISi0luWYV5jX1hdoW+
 CB7zM2GlXKLb3myVpUP1KsJULDEu5hhXLF/pgZTSIfVk+PwNUMRf9KVBTOx1u73Xn5OXIL1z79z
 GLJdv7j0UwY/J8x83+OfkTpDdvcFgxmbQh5GpxiQy4T22yy0rZ5scrDQCblYeV30YjM0zeWvfkF
 2XSw8zWnkg9D0yW2qAA==
X-Proofpoint-GUID: h9ddg2JN9kkgXZxrBnLIz7wCCnnvSQRc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX7osnxslQwxPz
 tTjCIPWhGCCJ5xXvFYD6LwFctkC2hsmpgt5xbSjt/a7O1L74bNkmtQTQB3v32pWzVgn4Ctbc3db
 MODVAeDUYkAzgOd4lylaq656xKkfDU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060066

From: Andreas Grapentin <gra@linux.ibm.com>

Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
been included in the first iteration of the header, since we will need
it to talk about system registers.

Since the definition of enum vcpu_sysreg is not shared yet, and not used
on the s390 side, this should not cause any functional changes.

Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index a3e40650d75d0..3e69724f17c90 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -8,6 +8,7 @@
 #include <asm/debug.h>
 
 #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
+enum vcpu_sysreg;
 
 #include <arm64/kvm_host.h>
 #include <arm64/ptrace.h>
-- 
2.53.0

