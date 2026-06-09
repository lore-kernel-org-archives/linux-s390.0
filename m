Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58A480346;
	Tue,  9 Jun 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017789; cv=none; b=ZsstKXN1vBpeVjAxMdoV8GriMNz2nQYO/2L8/8+p17PRFZuR5hx7AZyPxOL1tbLVwQLIYfMrAjMwAaw0qjo7g7tk3gB7Py47k1aPxZuDSzlrSkblTUJ1XlX5SiduuS3dslTvzhYOuD0URSTtABFWM26eja+qiG+kDgpYhbarPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017789; c=relaxed/simple;
	bh=ywroXiJ8dFkWwF67tR9A2ugD/H5yTqntJFR5DQKlZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOxGh380+1K2O/J+wIs3HTBE8fJL2yo0GcdtLK8UQyr62dqgbAkYpwzudIUe1K3JxSc9Dt/XcKcnE8TxcennZYGyhi6jwUkjiC/3/lT/Trgr8CmC3dTQPSyt3id+hy2GfCLCK8AjiZ4FrpoxF01mjbZJKEJY7P1O0Z/1f0ZKZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AKI632OS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AKI632OS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659BKWUf2552576;
	Tue, 9 Jun 2026 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/5CiXsicSM2TorF8BUaULMgG896NaalzKwuGsMaTE
	C4=; b=AKI632OSbV5V8isPgCSk7YRbq4YOm5BwsceSsBwXrWkI5cjQt4r/vVQ8l
	yQGdOHkcwoWjjVA2Itoa7hyRSq5g0V2DeJl1e7HHG014Mpsewy147OirlCFgXXl7
	XP8gLB28Kz1HVuIE4etRgJ2Bdy5QS5fKKY+pnwU8UPGx/e2pJVwy2PUaeGZLcaAW
	xppqdybECBbjuUxneJe4353OZvjGE3G1djMjf9xQmq8NI8nuPnvX+Xdq/UFJX+dH
	owTJfM2u9w/dxxVAqbt2mCALC8P5sKWMxd2maAuDVJ2u32IQLBL2FYzIFHqWgnQp
	oUprNnWdDP9EXU7uzKsliKgtnZM1Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhvsws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659F4b0D017685;
	Tue, 9 Jun 2026 15:09:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g2bsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:09:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F9WRo49938864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:09:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848D820040;
	Tue,  9 Jun 2026 15:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D31820043;
	Tue,  9 Jun 2026 15:09:31 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:09:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/4] KVM: s390: Add support for 2G hugepages
Date: Tue,  9 Jun 2026 17:09:26 +0200
Message-ID: <20260609150930.665370-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfX9ilqAB8hjJQi
 U1nXc/DoIewNyzDASj4AaE/2PdlLsn2W8gC3aAP+aSk0FydeZ6L7kYrO1BWn4NfKpcaak7T4mAI
 rU+9f65ZED5WwLq3KD+C4T4Cu+TvbA/CDkVSBZ/Twslu7Fy5b4qaew+9md0jnD0FDu1f2+lnOHX
 Vdx5yV3G8Y44oPWZmAN6aRCSFxBdK4mrUHhhTbo+5EdxZqnO6yamh0Eli25H/m+Hl5w+lsRFdOx
 TGqbVCUgkkH//E5P+mMgy6PGitc2mr+hPESAqawZmAEbchs/yzvtxUqw4U43Nr/51Th06AnPu69
 tBTwECw8n5RT3yRJ3N7IFo0wijAUe/G9CzwpoXqqK6znptkNa1I9IcGHWAgSy9BkKinsaS4o+n6
 j0cNHg8juG/9U9ZtSq5a7K+jccW6x0ioU4o5vgyIt8sriTbVDb+fhX1XtPB3nKqIEcpv863TcY5
 g2qKmp0/hUMqTpVqY7w==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a282cb3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=cQUOp6QBzeLWX7oB_rYA:9
X-Proofpoint-ORIG-GUID: 6vtSea_fsudot-PWUVPhZkZe9M214G83
X-Proofpoint-GUID: 6vtSea_fsudot-PWUVPhZkZe9M214G83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090144

Add support for 2G hugepages.

In theory, since kernel 7.0, userspace could already use 2G hugepages
to back guest memory, but KVM would use 4k or 1M pages in gmap to
actually map the guest.

This series allows KVM on s390 to actually use 2G hugepages in gmap to
map guest memory that is backed by 2G hugepages in userspace.

Nested guests remain possible.

v1->v2:
* Fix possible race between clearing the GMAP_FLAG_ALLOW_HPAGE_2G flag
  and gmap_split_huge_pages().
* Add documentation for the KVM_CAP_S390_HPAGE_2G capability.


Claudio Imbrenda (4):
  KVM: s390: Add module parameter to fence 2G hugepages
  KVM: s390: Add capability to support 2G hugepages
  KVM: s390: Allow for 2G hugepages
  KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability

 Documentation/virt/kvm/api.rst | 15 ++++++++++++++
 arch/s390/kvm/gmap.c           | 24 ++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.c       | 38 +++++++++++++++++++++++++++++++++-
 arch/s390/kvm/pv.c             |  5 ++++-
 include/uapi/linux/kvm.h       |  1 +
 5 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.54.0

