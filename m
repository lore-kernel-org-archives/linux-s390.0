Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9174E4C4C;
	Tue, 13 Oct 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902556; cv=none; b=MMCbkMMDTqDgJ/1DUPcoZ0ld/tK2OSQg+ivuxBqlOmiYHO58d+7s+8CSnuiYtmruEuXtF3Z72nfWCpxNTB1GUHCViTD8/RzdhvC027Q/kYwZGxyJKBXd/LpBKVDYv4pEuQio9Vz+Vkq3zf+CWbw6xpxRyya9LBAbLWnw28tAIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902556; c=relaxed/simple;
	bh=iuXhYjP9Wa9nV0DiqfGY9s4Yv4hL3lLzUHxs2KC0Ylo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7QJoX7B29t0YO84zFPTrWdgbG/yzKmoKyekA7xqv+33jxzeNSN6gKQrL6UfhRO3SooPhSnN5rxQTwVK3XCAGvO8nbrG7x589Hl4Jpw5D3YDJrIkTPOX9xQClEuEDK2aL/APbSwj4f9xw9HKu97eOMifpaUhknGfsInxe3B4pHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ILImfdsQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ILImfdsQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DD3MrB2017508;
	Tue, 13 Oct 2026 14:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cq6ZBJeQDKSIMUUSHarYeDzvFbY0ja299oCaNxXqR
	dE=; b=ILImfdsQ8gtPOW6lUhZQlLJEgcEjOYBUGSITtwj5VDWEqAKLp0ewcT5Dq
	PL1Yao8oCkc03ufUCydsrCyMfM++FahryMHoiNWnHyKN6D5fnKUq4Fqyr/x4tlaZ
	NcL91M9+BEOOeRhxxtOOpqZCFtishdD2vowuhgBCEWxh6/XGDr3tr6Qtep8MdByT
	dliLRKrmbS0gUIwtes/H9KAtW79T4WaKr5Eor8/eMCJmVrMI8Jx03XGFX1d/7Ab6
	5XqNoO5ScjlA/mSF5Tim4V6b5bD7ooEIQmNpojn5ykhdlyxh6r3IB19F7H5a5mmC
	9gklcaVvEcY+C+gZIERgRdl0md9gQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugermu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCUbY22667561;
	Tue, 13 Oct 2026 14:42:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vtgg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DEgTo664094502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 14:42:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11DEB5806A;
	Tue, 13 Oct 2026 14:42:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9B158067;
	Tue, 13 Oct 2026 14:42:26 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 14:42:26 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org
Subject: [PATCH 0/2] KVM: s390: fix ESSA addressing exception injection in migration mode
Date: Tue, 13 Oct 2026 16:42:23 +0200
Message-ID: <20261013144225.8885-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace4357 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=OLYqng0F8Bf9Jdo386UA:9
X-Proofpoint-GUID: KHikQuOI6SO5TP6TvSSg8tNq6dw79Zto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX8MtkDzvjbtuO
 srtlmR/pUh9E2CBeNYCDJKD/BOVR2tr5NIi5nRMc22gaUxIjcED1K9o20NIkeQxJv8jTQYP2gjO
 RCNGszfk3otFao9LFL/XDzUrH+zyrc4v7WT7tTudZOCdFVyK0fE/uP/6tIB6HAmg2NevAmta3S8
 AA7eZ+pdzRX/vlNhA4YAncpwYC1hMkjnHUGyfBR6LW94gVA1TwDvRUtEkug3elwwfzy0mqylzk5
 +CI1l1MBKAsdbPYzX5BV20NXjBionj/e8Pi62xs2zKr6UXyXn4De4FXvsXsAnn/HlYcxNP9bTMs
 pxlYaFAPtIiVbIGTX6GYQVYpIeJ0dnBNJLlFuTdx4nTB4wn7vDjguUHEkHOMZZYRaZ3CiM6waOc
 h8HBZsrs+hINm8TeirULnTBjDuZFKf6HtImzZ1evzYNmBYy++fDMJFwmdDSn7d9uxz3PLFEzXo1
 1F5bw6zClsBo111AHxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX3+peAP7Q9v/6
 tfqvFBdyfE+8QYv4pLN7pBTWcoTjOqKacrZi/nmjdwW7+9SV5GUOaPBtXHNLQH6iTqa6Qj81ayf
 b3INHntHrMX4p21qJ+zu83Zn4352uQY=
X-Proofpoint-ORIG-GUID: XwPoNiH0iyWSN6mnJBxa_3GZ_MceteqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130056

ESSA emulation in migration mode silently dropped addressing exceptions
when the guest page-table walk failed, so the guest never received the
expected PGM_ADDRESSING interrupt during live migration.

Patch 1 fixes dat_perform_essa() to return -PGM_ADDRESSING on a walk
failure, and __do_essa() to inject the program interrupt for that return
value.

Patch 2 adds a regression test integrated into the existing cmma_test
selftest.

Gautam Gala (2):
  KVM: s390: fix ESSA addressing exception injection in migration mode
  KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING
    regression test

 arch/s390/kvm/gmap/dat.c                     |  5 +-
 arch/s390/kvm/s390/priv.c                    |  4 +-
 tools/testing/selftests/kvm/s390/cmma_test.c | 79 ++++++++++++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.55.0

