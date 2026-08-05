Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0934D384;
	Wed,  5 Aug 2026 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941452; cv=none; b=Pn88kB9y0a68TanlN8oZ6qZrvzko/mhTNUDmtQU/UJTQzcwHwXekIEQWlX5RLEz2W4y6/xme3pWly5axcs/1O1jNCnPaI8BxREkuN4Tg9iUIFRWjsjkmSHna4sRCB+uVocTYmqvQApJn7PJjK1QTUnFfykkq+nEQRxkJg6Jz6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941452; c=relaxed/simple;
	bh=mpjasIC0I5JGmwseiVAjNMx8wR3JEMMHNz52tv8wnuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qs2NFUFU6MG47mKHzBtXcbY2RYmClzoY7UNMDh3MED9oMY94GepB8oLiCCPcsm+0tfvr30U2EJXobj/xgK9KmruD2+NzgawmR/wHjhV4OC4fPXRbeKwAaXK2Fy9CijgnBnxA64PCA1VPrdAAXiCgltwETvzq6sQ+Ol8lDe/wLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q+/HoBz3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q+/HoBz3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHeLw3875404;
	Wed, 5 Aug 2026 14:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rUnAWqwBM7YIz9lWKs7Zt7T+4kBgh+vA87S0co58J
	XU=; b=q+/HoBz3G5TnEwUrI2J6EzlHQnhIqxrD1ctuj2WiVgSUgZsTK6C6DoY7U
	7j1jZNEHe/1AxWQqnVjrJw6TNJywO2FYNeA9q7Il9lNjTDhwO/NNdgK+yPY3xNMu
	OMr9Dq/US/irGVxLgb4j3x0Q55iSno40zWpYKe8LhAP07Fm5St6qG/j02Y4mWx4F
	UqKo4QBYs12EDhQXgvzss9dNu64eX5S7YqdoAaFaEWuVd+TO9ImIUEBN3dlJs50W
	I9POvYMgQY4Nrnhwyqf6N6yJeZJ0epGlHgeuWzBGYUSl7er/idkBFTXTfM/7KgHl
	dPmi6dXbg3ewNaaqQA07Noitk8Nfw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euu1nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675EfJ0I030934;
	Wed, 5 Aug 2026 14:50:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k702t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675EoXSo17301792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 14:50:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37EC92004B;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04C3820043;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 14:50:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
Date: Wed,  5 Aug 2026 16:50:30 +0200
Message-ID: <20260805145032.1409325-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KiC6CsdvbFTL3ibUDxBZq9VtZujWcDY_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfXyndEGAILQIUE
 1t+fr/n1iIMgh/s5D0kL6PZvpB8bRSYepsOARg8BewScw7JQ0ZpoSHOInrx0hzasvWbvn7hED8f
 puS4t3Ouz75BJqa4kZC2fiL/72b4ImU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX2wzspf4zgtnn
 XhNnZAD/iSKNAyx0GTe4IjpyTKVr9NMoCzQZ9tumv2fC+jHdnyKPQnZ0TcBzyupoMRWwnY8Fanm
 g6pLNbZ0Oe45vM+VXbkKnX0SWOmS7mttg0VhM9G+UM00oMUiiGv8Jnnvr5PuxNS1nn7M228uYuf
 AvWlKr47vCXesyOGOGh0vnfGdW2g1qzDPoI7D1oZxvQ1EioGAGnGWBrgGwGJTG2aTocFt5E54He
 FLaxzSVl46Xmy3FDxwveek77WKV9XB08aR4ADrZnBikrKKcPZlRCEJlH24uw+pxgWXlkHiXEJO4
 ZcXwrSE829x06rPs08GeJK6TwAmV5lwepa7ldVuM9bl4vjhWJHUWmTMBAnAAkgql5qJtVY77wWA
 ZQBm2oUkJaHPJyRgy8Ctwupmo0Eqend0LyVPttwN2uA6GHdI1mQqOS70HELqGfGowCpmCPw79+D
 sGQZ6dbkz5Md9Jo9T/A==
X-Proofpoint-GUID: D6YnxEV6vhox9fYCkQth8G-cg79femQf
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a734dbe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=jW6YlCM5X9v_IRLvDUIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050120

Enable CONTEXT_ANALYSYS for drivers/s390/net.

Static code checking for acquiring and releasing locks used to be done
with sparse. That was removed with [1] and replaced with a clang based
approach [2]. The new approach requires that each subsystem needs to be
explicitly enabled for checking.

Do that for drivers/s390/net. In order to avoid false positives due to
conditional locking, disable context analysis for specific functions of
the ctcm driver. All comments in ctcm indicate that the code should stay
as it is, and that such warnings should be ignored.

Disabling context analysis for specific functions keeps analysis enabled
for the rest of a file.

[1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
[2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")

Heiko Carstens (2):
  s390/ctcm: Add __context_unsafe() attribute to various functions
  drivers/s390/net: Enable CONTEXT_ANALYSIS

 drivers/s390/net/Makefile    |  2 ++
 drivers/s390/net/ctcm_fsms.c | 20 +++++++-------------
 drivers/s390/net/ctcm_mpc.c  |  6 ++----
 3 files changed, 11 insertions(+), 17 deletions(-)

-- 
2.53.0

