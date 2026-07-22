Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD40F725;
	Wed, 22 Jul 2026 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723237; cv=none; b=FQSsu8a+10QbSOVkuSiYNBrzBngRI3XafO6NAdBtJZ82cmDlJMf1iOlipFHgwYcdpdODJkFFBnIjiP+7g+Z2DWn4CA33kiuaUaYk+LIVu6juQZy4B/Eg3hlfpb+4MWRPPmWdASEG1vHwragtjFhRpTP0B4XEJSwJCMHcZ98GnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723237; c=relaxed/simple;
	bh=1lt5AIB1aE5HgOVHRdWyhADuOgJn6DcEw9y9oZ5GZV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz6sKjcP+ACvfD+TMMN6CYoYNCcqnnpeaCQtu2P8aXmyJ3V52+4pJBnUEpKOH6HxlYMDggxKIlZibixSwmxjjK0S0G9Qk534SoLHPs4v1OYHTQfFfaUSG6ogxxuTQGLuHe+n/TZwZhxV6hTMGzSL2kF/IXcRm3yAJte5EfNvxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Es0EHmtn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Es0EHmtn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9BuFt3566083;
	Wed, 22 Jul 2026 12:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=m4AMEIy4CZedwhaT8P6I7fvQ3zUjkF9eLEKWF7/nL
	b8=; b=Es0EHmtnpbWQR1gYlDYPSVWfwP+24G8zxksK+aJ9tXHPPGQ3B/Ulu/TY8
	+MFiS8uHs3LA+f5eASiWvpC5fa/hgDP9N0jLbk3d1SskkfbrO/4C8G7G/UUSJI2J
	kMZAfZVEWhERubxh7ukK/3VZ82hlqpjT33tq5gqWS+c3fDjXfZK4OMhIIRGgTwc5
	Q9p6YKg9gKMBA+xcdcNdL2k6UR2qgM+vIIdKsiJ0sqx/Se3G0JgJe8ge3W3a4w+4
	OHa11CukZQCgTIbHUl5Ay3blLSYXVbEroWA8hZj2QGPMVwO7+ioHb0+Fu8kX4FGU
	85yw9xkF0/QZNpwHYwBa/uSe5UzBQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g9k4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 12:27:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MCJb3t002973;
	Wed, 22 Jul 2026 12:27:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah7615-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 12:27:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MCR3fw42402248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 12:27:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B902C200B9;
	Wed, 22 Jul 2026 12:27:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF50200B8;
	Wed, 22 Jul 2026 12:27:03 +0000 (GMT)
Received: from dhcp-9-224-66-107.ehn-de.ibm.com (unknown [9.224.66.107])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 12:27:03 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v2] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries
Date: Wed, 22 Jul 2026 14:27:01 +0200
Message-ID: <20260722122701.20514-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExOSBTYWx0ZWRfX6snL96brDSQL
 6A5kB+agBg2+URrioq4TmZJ3eGbmKUoQEVHjvG4WsWrtwMJEhDCBPqrGACjhSjoG7qOOYaC8RvR
 yh4UIVzkNa1JM2yFuDW59s7BoGsber5L4LEzR83ForBiOu3Fg1bQMjPMQq/3qzu2ndy7+6LFq6M
 SH/EZnuoXirUfWwFK6fWChMgGTUbQoiEVzUQjM7vfmUZ+es/+POxC3ZLfW7vK+tJp2Jx3I0ewa5
 27v8PpGKrbrgQ/fmxQbHAZbv84FekBpM9bJTmS+WaCjeG5Igj6WX2IbyMDxVzPr87McSbPeDkZQ
 OzOtWrEHHNnVqRDwMx6vU0DRQNI8O2wO6ihM9K3cxrVKP59Y2I8KEcIsrAw6ngkZtR830PBe30L
 C6S09+o67R5elyJW1ozxvdracM8L+qDpyVrY3I9JSNdkHIYhs+NAEV6jI4/x3SuUGxYgzLfePPO
 hFlBAgrRfMvA6TpMaCw==
X-Proofpoint-GUID: V7WUvQjch_10IuBgfNp-ZGhmRKjgu52W
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60b71d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8
 a=9rZ5XDlJ3pyyg2uh-ysA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExOSBTYWx0ZWRfX9ZaLQw+W/pbb
 CHSwWR4i7Aryt36SdUpaKX3/qq+VxrvcG90LtnRJnNY2pAsKK5bB+FqrXHrAqrhEgqeBmTwqg/I
 Qo+W/YfGIQ6dRJWvwvidbWs1n+YI3F8=
X-Proofpoint-ORIG-GUID: 2L-4-8v4jWQ-V1YTYq684XkSYT9kJF3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220119

Due to a change in responsibilities, I can no longer serve as an SMC
maintainer and need to be removed from the MAINTAINERS list.

To reflect these organizational changes, promote Mahanta Jambigi
<mjambigi@linux.ibm.com> from reviewer to maintainer.

Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 MAINTAINERS | 3 +--
 file        | 0
 2 files changed, 1 insertion(+), 2 deletions(-)
 create mode 100644 file

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab8736850ea..f60ccc62e710 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
 M:	D. Wythe <alibuda@linux.alibaba.com>
 M:	Dust Li <dust.li@linux.alibaba.com>
 M:	Sidraya Jayagond <sidraya@linux.ibm.com>
-M:	Wenjia Zhang <wenjia@linux.ibm.com>
-R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
+M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
 L:	linux-rdma@vger.kernel.org
diff --git a/file b/file
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.50.1 (Apple Git-155)

