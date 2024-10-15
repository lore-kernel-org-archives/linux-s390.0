Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670671E32D0;
	Tue, 15 Oct 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989688; cv=none; b=XqatZJYWq1gS6IIDYxk/Jn8jdE+QWDHtNLQROkkheAf2sr/upnj9MDB8rmiiHc/9FFrIBwuGX9a4LdBpmgz+umWFruLwMCturv2V2YgzpU1tcTPkXU0t8sqYCV2+PavSUfXDYxYF8UVvAftfVLcnxJ5jVhcpFwgD9OYFBCCLHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989688; c=relaxed/simple;
	bh=0GjnuafM8+MuY524RzRyuybMbh2e1W5adOorLwp9ITw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+pEJs9JD+Uu1lNEaGOTkYYZAqkaPP/kQInb8RONULWZrzKcETg+2NdcMzMpz2bBtZ0aaB6f1LgW7/Xttql6W7ErF2Rw6ZJWc6bWwOVaqLDeYqKAoFawO8GgXiHpIT2kjHmJis1NwukiDJAu2OW8txCv+aaRZH9n7ooRuz0865Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n//Oe3bf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n//Oe3bf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FApOv6013632;
	Tue, 15 Oct 2024 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6fsOagLG+nDf85J5DatB5patV9Oe55a8JmOALUnjE
	80=; b=n//Oe3bfyDbve1gkdx9BaQ38NYVprDivMQSdj9tpmCiLJzc62VAt2kfR9
	Yb1Ty5NicPsgEAnhJZaegaxTebyN2bUJfNeXJA1vg8Vlb+ASM70rej5dyGoM/6R7
	qbfox8En6vxWmXRtoEVJh2C0RJGbNsvs3YVcEmM4WRMzCHv0ksVzqZKHlwgWJoHk
	CApMVNrAPXXgHnQ2AXbv/5+b7Uf80iydpTGINVZWtBkWkAt+iD7IV+RcgqprW0pN
	8gO1IMGE9dStHo6eFFRMlNx6+cw23mZ5ZgcgJAWyEngQLWKRRgntzZqe/MEl9kc+
	ppAxyFZvogei+W/dwyPNfHBI7Vuzw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q0gg0n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FAsYRl020601;
	Tue, 15 Oct 2024 10:54:34 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q0gg0mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F943eJ005951;
	Tue, 15 Oct 2024 10:54:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650u092-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 10:54:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FAsUtj45154746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 10:54:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0981D20040;
	Tue, 15 Oct 2024 10:54:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC6A2005A;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 10:54:29 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7A0F4E0125; Tue, 15 Oct 2024 12:54:29 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH RESEND 0/3] PtP driver for s390 clocks
Date: Tue, 15 Oct 2024 12:54:11 +0200
Message-ID: <20241015105414.2825635-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iOuI4dTUGHzT8hkOBGbOW4ro6_dV7sy3
X-Proofpoint-GUID: v7l7l6wg5oaeQfeQFKftht8yVhUZCnBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1011 mlxlogscore=514
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150072

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock. The
second patch adds sending a udev event when a ptp device is added, so that
userspace is able to generate stable device names for virtual ptp devices.
The last patch adds the PtP driver itself.

Sven Schnelle (3):
  s390/time: Add clocksource id to TOD clock
  ptp: Add clock name to uevent
  s390/time: Add PtP driver

 MAINTAINERS                     |   6 ++
 arch/s390/include/asm/timex.h   |   8 ++
 arch/s390/kernel/time.c         |   8 ++
 drivers/ptp/Kconfig             |  11 +++
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_clock.c         |  11 ++-
 drivers/ptp/ptp_s390.c          | 127 ++++++++++++++++++++++++++++++++
 include/linux/clocksource_ids.h |   1 +
 8 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_s390.c

-- 
2.43.0

