Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A1431A23;
	Wed,  5 Aug 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928207; cv=none; b=iPTcDnUiOULSSlAQy+HXMcN18O1XI54YGJMiYm3YFkJIgAm+3CvI83W/jwlCPHoqO2ZrBTXn+r7TNSmdny7lQUgaCM9d8sU1HM/cj/Q+NjaRjopU+NFO8XyK2Q77KiftAo92b1K4EPWUqJIeLxpTQD56A5O3oaPFwj3OUI0GL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928207; c=relaxed/simple;
	bh=H4K9Lf6h7vrRNa6zflYWilgmfziFZZ78ar2HaDTBtzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkPB8vNhOflBDE69GieNYOi17fTYfXuYG6uhq3c9ziK64DUUBxFk/DdXAIN82qIAJXVld3leEvapfJ0dPW7YCAm4FBi2ha3DdHMfL2723Svgoe3AU55Hit7a1eBfos0tJ+p+zL8yzSXFDW9nTIbzJcm2I5NU/hqd/ktod5EqAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UmrPGith; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmrPGith"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758llfI3387417;
	Wed, 5 Aug 2026 11:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d9YMlqOU1UPa+83GPsqaERGMrVH+AL+F7NojWWkVw
	gU=; b=UmrPGithKZFOgWJT7yZ5aPKeBqJNJGCIX9zmoYPfwnaDntvF90hzK4yEK
	vNFNg4nsLNzWkAq64DFcaWfFnO/GxpEg+gI78xO0jSlo73vxSaFzDCIHrFUjFzrz
	VMxFHn/Q6lBd3Xbd/DabmsG5PxpvMsLqxml+H8Z7nsZH+Wx45ssIwYk2KDj4eVsW
	3NlDmGADzqz41MXoSsGlkyXiYulOD0FwDOdXTC/DSH2t035KwFbZBCef8S1dPYU3
	9uBcN5XkSanB23oWlnK0qrm77L6klTDliUwOOYERwsv0C2B4RBudpYcRMxro93bf
	5+oL/nHDvbHTkcLSf2TXcI9CEkyaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52p9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:10:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AuINZ011203;
	Wed, 5 Aug 2026 11:10:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe5b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:10:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BA12F066172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:10:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F12058213;
	Wed,  5 Aug 2026 11:04:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D6AC5820E;
	Wed,  5 Aug 2026 11:04:56 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:04:56 +0000 (GMT)
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
Subject: [PATCH v3 0/8] KVM: s390: More fixes
Date: Wed,  5 Aug 2026 13:04:47 +0200
Message-ID: <20260805110455.7200-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX3B38Q0px+m0E
 A0psmqdcnZnnYDC6LSsfxaZrHB1sXKlZVYqzrgSldZZ8+fazPOWa8r6+4IV/MpIahwMgpTlm+Bv
 wy8I5LWZr8bD/Gh1v1E75XKa6KMM9q4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX4wYXtegcaaNN
 3VxaX96KcQnXELDd+78a6HKD11kwbdn4zC4z8F8QQ/hErT613Qr49cTOwJQsP4Z11rvD6Y4EfT4
 Ysn+RP3+wIRhBoZwk1TvVIE5Yru7vebohla+aWPPjUaBQzyoJJOKdEA8ufdrqFJ8B2c3qDnjuI0
 yVjMBDD+nCdtkrHbipIGh4OcxHmuNRD9dKR8Y8kCufdzD+nIIAsR3x5m/0PqxoaN5IFHvMxjQNp
 426ABLYtq9U+AH5AlvNo+6f0HZDwLPn7OdmhT6eMpKkBbSYm67TcE7V77Yt6QJcO3SeVqMLzq6x
 fovGe7cuoHqZacAMQ0WlU6nopTr3eGUB6W0PV44hiPE+p1yuiLjaxAuwqZ5VRCaZOuzevQkC5GE
 Dx57JJVHJ8UZJIGRCtmavkb0uTfaC5jnaMYOmvypfU4PP+llo/d1z9JuyibiADaNoFZSfsF6rXx
 A5vs8iN4LTSNesvzNVw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a731a0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=MvOQ6Db1pLFbmf5m6wUA:9
X-Proofpoint-ORIG-GUID: XqGv2zj-Ssl9QB-Eudw1stLmtevd7z-K
X-Proofpoint-GUID: XqGv2zj-Ssl9QB-Eudw1stLmtevd7z-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

v2->v3:
- add length check fix for guest debug
- add RB

v1->v2: several sashiko reports added
- machine check stack exposure
- extend zeroing to pfault done interrupts
- old_data leak
- srcu protection missing
- guest debug allocations not freed on destroy
- uppercase patch title


Christian Borntraeger (8):
  KVM: s390: Remove user triggerable WARN_ON
  KVM: s390: Zero initialize data structures for inject_pfault_token
  KVM: s390: Zero initialize irq in reinject_machine_check
  KVM: s390: Fix memory leak in guest debug handling
  KVM: s390: Fix old_data leak in guest debug error path
  KVM: s390: Take srcu when importing watchpoint data
  KVM: s390: Free guest debug data on vcpu destroy
  KVM: s390: Fix length check __import_wp_info()

 arch/s390/kvm/guestdbg.c  |  9 +++++++--
 arch/s390/kvm/interrupt.c |  4 ++--
 arch/s390/kvm/kvm-s390.c  | 11 +++++++----
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.53.0

