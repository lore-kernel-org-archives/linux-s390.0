Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084389;
	b=eNlbyT/v7roQbuxyzGyDJYjrEJX8zsNHAUJpIiyXY2lV9flkFWxKTMy8JF3QiBzVMzlv
	 IPExV7vmmGQYAHWL7rPBIxyotYyqOSpCMvJz55zPqeH7T6zAbIVTHQnl8z6qnH4uJOjEF
	 e5qI/BsQh6WDDge9LPex/Sl7OGKIQldzZOci+QiujM/axZir6kSRk+pLfx5p88BOfJSsx
	 NCoU+J50NjlMqyhRLp5Kg+zhw9wPMqQ2t0lRcPNdK3cDP5ntBJrgf/fxAVOMfcH0kgpY9
	 PS6gKiQBm4SEdyhLG2S4Ls4pVgIaWpV9MEv4U9lXsg0pOdRGXn+jHZzTztzmT4ax+qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084389;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SM4bBw2BhdMHfH6XJ7qEaeI3kYUDVXt12gszmRfKruA=;
	b=OBDzmvFTsAlfWLwsUC0maSSbILUnxrno3PT/Gg5CaAkppq5vuHJZY4yjT5KJoxXUH/oU
	 a6ebcCBTCXGHz1DjdhLf04UL0trSF/b1SOn2BE0WpvbI4hTMCCD2Ah93E4i2nB8i9ABGO
	 a73TtHqer+AAXwS5G9KvSn3gmfagdaiUs41l8o0zrfK9KQpneMIWOLQ9BXapM48f2O2Z3
	 4Ze8OkeGxKBK83W7+3OJgCWbLMkzX+RJhiIbWnLSWzRL2G34qhvO0r0lad3oRx0crDJzX
	 ObNprlIVm95r7pyKj4BLW+2cvwIWqDRl3ulz1tQnxMyi6hEf225Ixt4tNUHUD2dfHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oyMR7rnL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8843606A325;
	Thu, 19 Nov 2026 10:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8843606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oyMR7rnL
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uYPs1805575;
	Thu, 19 Nov 2026 10:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SM4bBw2BhdMHfH6XJ7qEaeI3kYUDVXt12gszmRfKr
	uA=; b=oyMR7rnLMLY6q7zuBDO0A+5EwMfNLes3areWamrt1GBawVTc4iu75c8zL
	lV4bk4/kCUzriyhqlBb1NZyi8oG32paBgmCdFPTR/j22vWC6E1xDzz3NbS8tnlIR
	oIGyl//mF3maczzRrqujVyIk7lMTOZqkRB/TWXrWJvsZgDDBhQns97b7z0N9yesN
	NIgzVFc+iM/uk1beethWoDmB1UMNVo85t/D/2pMRzXizHwfBHUpNJP53/rKquBzr
	YvpvySYpsQeBaVq3dwtmZuxFQ1oWqhzVSf5TkCKR53EVj2h9w4hrZgF82OHXGk9i
	ykAXPG7CpImkvLr6ANMNDB768KemQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rra91-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJATUdN2580312;
	Thu, 19 Nov 2026 10:33:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvpy2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJAWBML31195720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 10:32:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5175A58062;
	Thu, 19 Nov 2026 10:33:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28E2F58066;
	Thu, 19 Nov 2026 10:33:00 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 10:32:59 +0000 (GMT)
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
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL 0/6] KVM: s390: More fixes for 7.4
Date: Thu, 19 Nov 2026 11:32:53 +0100
Message-ID: <20261119103259.7523-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-GUID: -se_W8OL1cn9inIPxZMCKpYW9NoArjKn
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afed060 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8
 a=N5GQnBkg8z5QXmIh938A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX5bAu3U3gKtyQ
 cX1m/cK1g7noOuzXyp+SloSHQwQPTZ9Hh43a9Yj5o2TXtxToeR6L9tOyizIizjJuEPJ/RYUrTYX
 ZRX1xTt6NJceQ677IHrJdg5sBg5sXNg=
X-Proofpoint-ORIG-GUID: -se_W8OL1cn9inIPxZMCKpYW9NoArjKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX2xTi3txjHcaZ
 Oe4KMt+C7K0JgokCKJ4rBuqP05ul7MlNrvfR5P3Yw4JlALHZjWp9e+/LeFueSsp5vQhzVxjCrv2
 uz+rfF39c+ExHuykITXttFQ6QeLMhjXt1HD7PXUgCqGx6u2x0nAIgGHptHOGBgCPPkZ7F285PS4
 p/HYLLXzpLaqyDVZk8+/BWfH8Y75copy42lO0AVBEQsLIEZMfdjrBsMbjienhLUQqH4muoBd3Gs
 qO8AyKB26ujY7y4ad47CDOxG3g4O1ib7QhWcWKNUswmxhZMPJl9FPwpCQ96NtsdHcxh/IyiSvEi
 7JNiT61ms1JjN9AatEp+MgCVxscfFgBD0Bzhwhm5RtqGf3lpOhBd2ByzSPBUwMMra2HhdqA+wQs
 aJ2DbhYJdQqpahiKj3eS7Ob/8SdESfl5luvERKG5NXuxkD7CY+u4ftUDXDzEe9cXttYhJIWWD1q
 puQAvhxypeI29jdX0wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190041

Paolo, if you pull this, you can ignore the first pull request for
kvm-s390-master-7.4-1 as this is included here as well
(https://lore.kernel.org/linux-s390/20261106164958.431978-1-borntraeger@linux.ibm.com/)


The following changes since commit 62aef2c04e0e69a9b88affa74ff699ce5c4e8652:

  selftests: drivers/s390x: Select uvdevice tests using the target architecture (2026-11-05 16:40:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-7.4-2

for you to fetch changes up to 6761f65e6823876534a9c3eec4cee1674dce415d:

  KVM: s390: vsie: Fix pinning using the wrong flag (2026-11-12 15:11:08 +0100)

----------------------------------------------------------------
KVM: s390: More fixes for 7.4

- Additional memory management related fixes
	- sashiko: https://sashiko.dev/#/patchset/20261105153705.208516-1-imbrenda%40linux.ibm.com
	  The finding on patch1 is not relevant in reality
- Improve the arm extraction script to tolerate unused functions
	- sashiko: https://sashiko.dev/#/patchset/20261105-series1-fixups2-v1-1-55f59e6c4c7b%40linux.ibm.com

----------------------------------------------------------------
Andreas Grapentin (1):
      KVM: s390: arm64: Tolerate unused functions in extracted source

Claudio Imbrenda (5):
      KVM: s390: Fix UCONTROL inconsistencies
      KVM: s390: Move some skey functions to headers
      KVM: s390: Fix idte_crste() clobber and table type
      KVM: s390: Improve unmapping of large ranges
      KVM: s390: vsie: Fix pinning using the wrong flag

 arch/s390/kvm/arm64/copy-arm64c.awk |  10 +-
 arch/s390/kvm/gmap/dat.c            |  26 -----
 arch/s390/kvm/gmap/dat.h            |  54 +++++++++-
 arch/s390/kvm/gmap/gmap.c           | 190 ++++++++++++++++++++++++++++--------
 arch/s390/kvm/s390/vsie.c           | 133 +++++++++----------------
 5 files changed, 258 insertions(+), 155 deletions(-)
