Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB77DA66;
	Sat,  4 Apr 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262924; cv=none; b=eu4/al+pnsySZ0ShVmufk4UlG0CNHOwqb2unQYbZSUujxDPji0NW+4iNVoQl3hr6zchqupg4HROG+OCjns/KU2Slhab0aDWq77l0ns/O2K+4VO/vtW6AMF9swa/QvgRdX8u5Xq8RawGd6rhj+oqpN3e1KPjkEEwcpboGqV5HKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262924; c=relaxed/simple;
	bh=FfBojlygownhokdSvdiU030PNVpxcwTczk/bqJwru/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V9zUlyCRCJa4VtBRLTSo+Ca4J2QnHijXwNblwDa/QyXptezthE35Xiskz47DThZvpZBmCRki6DhZ5SWNiB1nXhdXBC5On/8HkCINNRMjqUdV5ffAzrr1aXgdVYEgXwbJ7i+g4OSqkIEIVCOvmCZr3wMKhpgED0DL3IvAVsYfzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TG02yWN+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TG02yWN+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633NKsv82643537;
	Sat, 4 Apr 2026 00:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=M76onyudBAEE7Mb5YKcoHKiB2i4OTyPG6eQQMfQ8dOY=; b=TG02yWN+
	j+oWpj+pg6B8YLZp9MCTPHhkBMB6UbVLjef8j9hM9xR6986RtbP11VstgvzbNM81
	OwKgp92960S4bcpvzEase+J97zxNW4hqanSZiijafgW74vNhnPHklmjPn7NeoGkI
	vPdHnbcGVfaEKKz+EG5FwOspmpiZNsyKC2Re8/08Ep2hWXMxeVvVuJ38xPzqlCIt
	U1gadU8eQ0n6HaiWSnf4PIX1lYkZIdaOx+EujkoAn+DaRz2elB3aN6fiwhWAtTm2
	45qxwEN0UbPwaPoqamLzigroc1OMVfTWIO3KgvwASS1t1RRH2xVMUvKf6coMZRJa
	6/dl5JTXCRBqQw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mshepj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 00:35:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 633NtCfs005910;
	Sat, 4 Apr 2026 00:35:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyg2te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 00:35:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6340ZGg429950586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 00:35:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0E6A20043;
	Sat,  4 Apr 2026 00:35:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52A2E20040;
	Sat,  4 Apr 2026 00:35:16 +0000 (GMT)
Received: from localhost (unknown [9.111.49.23])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  4 Apr 2026 00:35:16 +0000 (GMT)
Date: Sat, 4 Apr 2026 02:35:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 7.0-rc7
Message-ID: <ttcy1mq@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69d05cc9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=BQGVLAe2H83GsVTtJREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDAwMSBTYWx0ZWRfX5GrSEr1/WNP+
 CQECK+LNpL3zw6LOI6MZsSRDhsHzIaeBekGWZc3dUCviFMeBM3p7G7HT21M9/0EkOIVQlY9GsJP
 Ero923O0Igzh+vp9t62h2LuVd/wdtlIeLJ058MzL2jeCt0hUvo9AvOmQKG/sF86pauulbIO7b+J
 lpEIZEfWjeEvM724wakPZWR+vVsGiKp6MZFSDOzm0lhy9Frj/DlbWtx28GTYBJZ8QNOCbpTCtkS
 L1BU+MQl5AfDuO9LOilcu7Bz6lr/Qyr178adr3m3FwfPE/Erv3brZKvl6Q+EmZ6OXMPlVHEXhAG
 kEzkuzxOGkt9Yg3FisYVNwRT7xq+CRLugcPupF/MGTd1wb9Kc0PmdTBEyAxswOdEhE54F3VWc6H
 CrNJH4XVlH+NkaPUdRIttwFejFq8jWrWeesB9EyPnOk0oEBMyO/61ntaQVUp/KpsNg+4/K0aVLv
 L+wdGbBmbyNiyNptNsQ==
X-Proofpoint-GUID: NWJFui08UioQNCYwYye1E7CZ1GHFzRjX
X-Proofpoint-ORIG-GUID: NWJFui08UioQNCYwYye1E7CZ1GHFzRjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040001

Hello Linus,

please pull s390 fixes for 7.0-rc7.

Thank you,
Vasily

The following changes since commit 598bbefa8032cc58b564a81d1ad68bd815c8dc0f:

  s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute (2026-03-07 22:41:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.0-7

for you to fetch changes up to c8d46f17c2fc7d25c18e60c008928aecab26184d:

  s390/zcrypt: Fix memory leak with CCA cards used as accelerator (2026-03-24 20:57:31 +0100)

----------------------------------------------------------------
s390 updates for 7.0-rc7

- Fix a memory leak in the zcrypt driver where the AP message buffer
  for clear key RSA requests was allocated twice, once by the caller
  and again locally, causing the first allocation to never be freed

- Fix the cpum_sf perf sampling rate overflow adjustment to clamp the
  recalculated rate to the hardware maximum, preventing exceptions on
  heavily loaded systems running with HZ=1000

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: Fix memory leak with CCA cards used as accelerator

Thomas Richter (1):
      s390/cpum_sf: Cap sampling rate to prevent lsctl exception

 arch/s390/kernel/perf_cpum_sf.c       |  6 +++++-
 drivers/s390/crypto/zcrypt_msgtype6.c | 32 ++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)
