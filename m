Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596E24336D;
	Fri, 24 Jul 2026 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871500; cv=none; b=a6lDBLZvNFpy5r+vndsaTCAyDorICp4GDe+e8iN3zJzzwBY9r9W3xLUe27YiQvAtlihaSzVASfKh8Uhtct+2rPeNA+V7CevtH9YYOl+PJSJ4I8V/McOdEDzlMAb9FRUlJw2Ov+bsJ5Nwtd4VBLdbYxraueDdpOS8qSuhCJvao1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871500; c=relaxed/simple;
	bh=6nhvuYf8tDtra3dJk99mncdqcY5qPnfdTYaWbf1kGxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEwOqS987immTZPYfLKbQ6IsQzafB58fg3wd6D7AKElK0Nwf7amI5hBYjwwC5NhC0WmY4rbuPX9I5yO1FCgs6UAnk5RRGH1iCEhlicvMcTggXqgeYyXgmPWF3RWaYKOJjqwfEnl6Jdd9vggWqSIMudGx+EMAgJ2Qu7tRxyFIlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kPoo+OfH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kPoo+OfH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5C9kY914853;
	Fri, 24 Jul 2026 05:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0SbQfHxCGUwVM+wRZWUxosP9y42p9D+v1GY0hgpW+
	EY=; b=kPoo+OfHstL7jdizCGP8pun257AwKZKiuffO8ZEy/hftm4M5byXYG473S
	+CYqZgTn5TtIppfWJO82Y4z3RGdjvO+CoU4aCAX0saPP5BfOR72amTvIW9GIisF9
	r68tG7QYcbm8V6WNJ2XawMGQNf716hoOFmj3qV1rQkhtiCUY5aBR8o/Rb/84/wPB
	QTUr4AH16zQV44crVYxE3MUL3KNXY1J+IJpFTfFeMLtQrHuKBSoJnS76MTYKF4rG
	AFSB7RLcO9mXOR7dWCW6qQWuCHCZNztsdn0KPxtaaGY4d4zNJOAa3pjE/MFkAxTu
	tMR6/vDRQCBunv7bkczTb/Mz1D0Mw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahjhqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 05:38:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O5YciI000575;
	Fri, 24 Jul 2026 05:38:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqfs2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 05:38:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O5c4ut11796970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 05:38:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DA98200CA;
	Fri, 24 Jul 2026 05:38:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5684200CE;
	Fri, 24 Jul 2026 05:38:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.111.143.111])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 05:38:00 +0000 (GMT)
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
Subject: [PATCH net-next v3] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries
Date: Fri, 24 Jul 2026 07:37:52 +0200
Message-ID: <20260724053752.3084-1-wenjia@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uS2Mm8HCJxFNbjbxvK5pbwCMGe6vuXPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA0NSBTYWx0ZWRfX+ZTkzKM0wEAX
 wLTcT7u+MrOwKLkWzu+DN/6Fp0eLlvQgqP7ICPCOByXsptNSAsEmWL/9NiWakzcg91YXL3EzwRv
 sNw5bTfk3G68+DhOq1ijwTrPOJK46+VDJ2g+6MgKL3K5hx3Yrck5BCtP0WP27y/JPjeNavVORdP
 OM1bDTTM7lR9aof1c1l3/RDiVhhj4zqT/11hPpcorL7ztwNq7SsQTc1PTAyQihCMTLhbZU8OcKG
 vinAXqlkb6ytXbsRMMtWJUF4+iXuhNDdumFQ1yoFJ+pSUhc2zKaKOFwKNDzgO4N3qmB1FOuhqLz
 sFystHSNd/TjRp8lzfcNy/GK6vn4jI5vAMqcUCMGDg5jpmysgFOZUh101lYbs+WcUs2VihzdSjj
 wPGp/GcWCCzz8i/tufkf4vik4aLQxw8O0ghbh/ZgdFzazVb5RHeHpWEVyBKhvVi1N5kRTXz2Vj7
 kraA/ojrlr2vPpI+QCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA0NSBTYWx0ZWRfXyU5tmcTsITMy
 v6gPhP72EdcoX7NVLdzgzubXvcXIStrmFOSxin4fGVjyRblOV8meJKgJ9szuA/cOHFOcJRr4qQC
 c5iSnsPsMSbKitnLo/MMp/I1I11/G/0=
X-Proofpoint-GUID: c5nJ6oBNBNBnA37WjMIgqUP2quwE47F5
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62fa41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8
 a=Ccpp6hyrmyWRenCNi6kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240045

Due to a change in responsibilities, I can no longer serve as an SMC
maintainer and need to be removed from the MAINTAINERS list.

To reflect these organizational changes, promote Mahanta Jambigi
<mjambigi@linux.ibm.com> from reviewer to maintainer.

Acked-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff93f3954fd1..031db6fa5522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24632,8 +24632,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
 M:	D. Wythe <alibuda@linux.alibaba.com>
 M:	Dust Li <dust.li@linux.alibaba.com>
 M:	Sidraya Jayagond <sidraya@linux.ibm.com>
-M:	Wenjia Zhang <wenjia@linux.ibm.com>
-R:	Mahanta Jambigi <mjambigi@linux.ibm.com>
+M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
 L:	linux-rdma@vger.kernel.org
-- 
2.50.1 (Apple Git-155)

