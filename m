Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723866;
	b=kK30Xj308g+b9gpsH3ywpkOx6/KRXB5UK5do753eZ7EBFij+y9NB/Wj7wV/H+lLLi1y9
	 mqZJ4nlgc0ojwhWVbEcsIDg5GC846L5HzZ5+GLygbw1B/OFWiRri41WY+91uhfnOdT7fA
	 bGFVQ2v1+9a4yy4OzfycMl7T2zJRE2nG2BZJrpbLOmoCQIN3u39JBKT/BXwHxqY7I5LVv
	 7tkTVaiGq+UZ2Jc1CF3GHLnUfh8cEXJJDFXYiKQ9UZM9Y+v3Qnusymq8luJh/hyMG58Pn
	 vPnr3HRjz0krIdCGNVb0eXMtxAkoWpZrl+CiPW8nOHYYtQt2bNRfePjIS+TUE7dc8eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723866;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GwfhP5LWWxixp0uLdZlxIW4UeNWIJ1egcYjLbbZ39hs=;
	b=WyjNXei/kFOQmbksJ1aGLb5cuUt/ShdHaRMnu/uVU05HtxNQT8QbpsINRq7Sfgnk0Dtx
	 5MxxJfLW6g8R44Tf+uW2mli2cRZpZSAE1ETz6rW4TiWzlUvHGU6j/4DBq07dcLp8Yf2o5
	 7TVsmkopmnbK79cxbyP+UTkpZrkgUHtX1/Nrh6mxMk926A1PFvJmRCwbrR/NfwvOxrXgR
	 cMVCzGLM21324rD9oaOyj6j64Yzza0ghZxixfYJVL5FdeoW1Vx58WqGqm8dzLk8MBdXIp
	 /4KYSeTU+dTr2YfSaMEzh2OatcRa429H5AKx7qQvi86b/WUPiqkOmyKY443oHRmTiRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOQA+TfD;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E7608362F;
	Tue,  3 Nov 2026 16:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190E7608362F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOQA+TfD
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EE65x2027511;
	Tue, 3 Nov 2026 16:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GwfhP5
	LWWxixp0uLdZlxIW4UeNWIJ1egcYjLbbZ39hs=; b=kOQA+TfD/QCkGY9t9Y7ACB
	9yDzdkvMjnHVPqqXCuuAMpaXtgn3nizBMr+m56osfDM/b1UUr0NHNr91Nyjqg4d/
	EXrNDGj3nEsAXMw+ZVIbEUuw4FrU8mdoleglqkLNrOlLOrskRwxKRgQmbeM0xi/9
	XD6+pxAw8T2ebQc1s5HfthNiN5OWTkbUsyuFHDZ+Rh0e2Q59U7//0W2KK2f2+n1r
	lZgHSga/AVz3u9Cpbzcj14AXVfKzxiFm2TjOLQF1NgXyyj6+1/UnPwzNQ//dmhdn
	DW86oczojOo7uXizoE9TberxjWRoJ6M3hGyIUK15EWyNIoV/LK68M6o82gRQZ8KA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826pyck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK46L2558213;
	Tue, 3 Nov 2026 16:37:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrc9urt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3GbQfZ4850412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 16:37:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EE6D58043;
	Tue,  3 Nov 2026 16:37:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C3A5805F;
	Tue,  3 Nov 2026 16:37:23 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 16:37:23 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Date: Tue, 03 Nov 2026 17:37:03 +0100
Subject: [PATCH 2/3] KVM: s390: arm64: Declare enum vcpu_sysreg
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
Message-Id: <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=g/ibanxIB75ZFzYFkvX0YbHlme7U8HCYQeJwd5YWtQE=;
 b=owEBbQKS/ZANAwAKAXUg1t0k8konAcsmYgBq6g26BIIEJKEJTNtdYcV76pcsPbktt/o8EO2h4
 2b8Os1JyE2JAjMEAAEKAB0WIQRrKkreGscL2VvlPix1INbdJPJKJwUCauoNugAKCRB1INbdJPJK
 J5ekD/9cMksyLQPmDVNlC1Arak2CnnJ850ts1PRAdPzlkwEo/DfFXL2U1rbxwWgvqxDgvqAJr7d
 qFIHo5DqLHZb6lllUeZUzk9OAII/xbBeX5MFF60c0WD3sXbg5k46arnd+I9SK06wgCQJ7DN4ldK
 77AR3uOoEbXjCMUMKvA4BzSHt7FcQJNZvNszKiZBWqvinTukh2LTmkTm/i1C7OrUqmVwnP6XlH+
 +21Zkm3JptuXjHH9yylVo5Vah7fCfBBDiGAx6iU9O3GDxVg+g3XL+6DzpySWN818QdknAF0qENX
 gqiQdaTD40Ko5VamMYiuT17nZ7v9XkvXgfV7SrVBuwHtkWS0h42oHaWtxPIr2DhlGT/oMJgsTDS
 Ot38iMs77xjuyA+oZZ+bWHUB50eD3yyrssCm4f9wgfOUiMAWEbthy+gtaXCFsW6dqXk1fiVUrKC
 7WFRdG3Ql/N4Qhzs9xh272qV0TIbwDFzmd3JxrRRyvv6GpIYeE9/9idoX1vOrbbz1nzWcdKWK6W
 crtGIh5igrJ2erMqLdbqNtYAS9NqK+/GfY4WHMcjJqnFh8GgGQ5UQNxTBXy8SeGodWB2zPxiPHe
 o3yUsI3B/v2jMVPGB3wFG0wLsNl3vLjnHiewDFPKzJEshcVx7fgcIdS1HZwN5KiUfz20hdXGU7O
 pumQuj6HNZcFWJQ==
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kj1RmjLl0u63RRpWYeCq7ZZmyxw1geEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXyDYLvELqYJr+
 vlUw4L4hpKpHGxeLFwfOZBK9jxVFyk2yPhkyPmXLKzl8PelsNc2Pl46bFUwTOus285L5RtSTsFF
 OT/fcBIbeY3iu9iiixeaQAgPz6KFzitMCmNKZYh6OlcBIUG48JIC3aYUl0e3MxhiC2Nm2taDIb8
 8RZihWvXvigKcjagaZNkMCmTyWa3DhdwSfyg/iOCvXfE/JypGrlyq4g3s+OVCfL5qAwh623RVGN
 oXn7GN4/RzaRSxgH/+iD2v5jU9Jtz+GtHawICDLtqTYDMHu32tSVFd3NrCAo08S0G4Iiddeui8v
 CeXwoBzEvXk1h7Beu70UeghgGK/ORMNCiIm8i4XwMo/K0zdiWEy0ppD1Ml2LjvvzNOjRHt8IyAX
 9MiX6Er3856rbCnr6J0j9pU8KbrwLe0/cE6BJMNLUxiMzDhdm4OsDxvsCWSduAopOl2jTVRRM8B
 3T3ikppVgLJiswKCJgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX0PBW+xcdjIxG
 pPm3jTMyTcftlUMtUaNsHRpPvDsQgFLfomeRp6EtBebfRnbc0YhUwApDmeU5phZ0/pZjsx9gPfe
 gYzPYVlxo1/hxKug9h+moNw+4ZxL6+w=
X-Proofpoint-GUID: Kj1RmjLl0u63RRpWYeCq7ZZmyxw1geEO
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aea0dc9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HiePRu6x428vW_iCRwUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030064

Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
been included in the first iteration of the header, since we will need
it to talk about system registers.

Since the definition of enum vcpu_sysreg is not shared yet, and not used
on the s390 side, this should not cause any functional changes.

Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index a3e40650d75d..3e69724f17c9 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -8,6 +8,7 @@
 #include <asm/debug.h>
 
 #define vcpu_gp_regs(v)		((v)->arch.sae_block.gpr)
+enum vcpu_sysreg;
 
 #include <arm64/kvm_host.h>
 #include <arm64/ptrace.h>

-- 
2.55.0

