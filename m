Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519116;
	b=TMzqeeaxeZLK4vwjIYEVRyIY7G72KKwWYt2u0Z8/7lluSWl3IJWMLNtG34qE2tFGhWGu
	 9r/qXLj9U7TpnnSPBNgGTQBGZgePcwP/L9g+LCzyVcrARobLZJ7/Dd866AOp7giW9Mb+I
	 w4ni+dHI/CrzTe4cS2Qlk8tzLsgxxICeqT6kDbnaEpw+wpGgcMQ5zwcgH90VPQF+bnq7L
	 w+YxoRHm1Z5v9JbRhF+Vs9iRf+inG0ucXTl8CI2rgMWCBeQiecrxhsuoZjOc+SkHhHANU
	 FIX9QHa1jFOXg85g78g00EO+Au/1/nQE6HTUKjSo/g91e0SebNzPBMdR+SeTlkhODHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519116;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HIzrdxg5oNPolRQcXv/OvKZmKqZ0PQMID/Gy8WOIXPY=;
	b=Epz47BGGPwZetVcgXdf/itaKPXppwRV3SuE1/miZW34RIA6iy1ZtHyOnfDzixn9TQCE1
	 aH96TnO7g/0W4kQ4CElgrkWDXWNOVyzvfySQ3Nsu18xuPk7Bd/puzoBrrBJzpQuk7m+Jq
	 vtsSPLup0BFIHmea545cgO7eJFhnLFWUSeVOmehwbKIzK5/eoBH/1NnDHH1NlbSgktUfw
	 Nh05rKxXs4JwDqPwl/76XDnnmCKB0TSR6SmEipcgWL33Vc1j2TZeFqIRf5DSbtV5SM/CV
	 a4ZVhESjAYyXjEfGCSrboFEfsRRUpZbGdC4+EOdtwGhnSuy8cVBhbyGh6ngJeI/1FMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PBUJFw13;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78730606A31D;
	Tue, 20 Oct 2026 17:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78730606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PBUJFw13
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHENid3067465;
	Tue, 20 Oct 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HIzrdxg5oNPolRQcXv/OvKZmKqZ0PQMID/Gy8WOIX
	PY=; b=PBUJFw13lvtB9CDBgD9eiLDX39drqctt8hnpZI1FThwk5ht8yNDD2by8i
	TqjKiYvXhLgp7JsYijo76M/Xs9igsBiU2rP/fTDBMuiexTGa8+106kIv4UeMa7h8
	mZyHwgF8doFqpAD+zwcp2IhHBwMoXvI4szP9KM/PRXghngfjow2sCm+pw4j7am0X
	fTtek18sQVgz+NXiTko5zAYQ/tNuysXLUWir7qmt0hz57Nz/LTV8uqZ0XC8/5eHO
	fw+XFDqPU8HTYqVNbfeyVrYdLhrU4FbLrnXBPBVZ+CbZn+CjmyhsJr+AyZeY7ceT
	bG5agTXtGkvKeg9Km+SkAEfNH+/vg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59vbkv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:58:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KH4rgJ1795921;
	Tue, 20 Oct 2026 17:58:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gq9ne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 17:58:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KHwLJY27001362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 17:58:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4616D5805A;
	Tue, 20 Oct 2026 17:58:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9568058054;
	Tue, 20 Oct 2026 17:58:19 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 17:58:19 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 0/2] Fix error handling for async_pf
Date: Tue, 20 Oct 2026 19:58:16 +0200
Message-ID: <20261020175818.375700-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfX1bG11A86HdgZ
 w0yYqbHwy+ufoCLrlkkC9Qwq2ublcqbRAIXRBA4UaxGLvO2l6/QvxmT/aGCKHJtXfNjCXRYScm4
 ypHXb7G784KL+6LaenD81OR8SjatxYF80L547bunmBPN1W2AzpmGHn/MATqrdbBS8sPAledo2Yb
 DxNxO4cRQyTuAYT4w0XIoYax6bDBwLVBiGN7BzdzOOoVZR1tDEthnxeawq+GcYaJa38Fq2W52be
 dIE7vAAriJ7t7kmI2koo5GiIHvC4tFkfkkfU2jbupgD7wDLRkQc6QOL7nQQ1hACyc/5v1kDU7Xt
 cfQQyHfIocjTkbnqkq6ut4i1smye/JXSF6l6DzJrTB5hdR+2xgj/DsSEaueKkfHi0tx6DNUU7v8
 HA/kC93ByUmthqZ9KulEKnP5LAXGsf9rCnrr0CSgJOjidRQF4i/ueBeClvspad1AiuyaEzWNcGC
 oAGayC73Nw/d8HoqegQ==
X-Proofpoint-ORIG-GUID: ebKPFl1Mv8rN2aIPwOtBNweBe4pp7ip1
X-Proofpoint-GUID: 2LMV4pCp912SHRs-HirMFPY9wICDxhd_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfXyfrZAfE5/gv3
 o7eQspZgJjSn0kJZ1iJGBPhufRXT9Opb+z2DedGTChe7SVXesRrEsIP4ZR9kh+J6baOO+6GJTdu
 SmrkULnkkpDbWPQGQwNJ6b8EaGys2vQ=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad7abbf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=JYCxxj4wjfSeNEK2tAkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200070

Return mapping errors also for async_pf cases. Otherwise guests
will loop forever. Nothing critical just missing error handling.

v1->v2:
- !npages instead of npages == 0 (Sean)
- new block comment (Sean)
- fix testcase to build with 7.3 and 7.4-rc

Christian Borntraeger (2):
  KVM: Set up async page faults only for faults that need to wait
  KVM: selftests: Test that KVM_RUN fails for unresolvable host faults

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/faultin_sigbus_test.c       | 169 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   3 +-
 3 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/faultin_sigbus_test.c

-- 
2.53.0

