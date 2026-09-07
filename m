Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEE4F30E7;
	Mon,  7 Sep 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792330; cv=none; b=OBYBaNDjggoB5kXbLtlkeUTq2lRilhCOieCcGm40ykPuOoRT4H00On1UYVb8Cao/HsMvyiSMdKVY4nkjIFG6UkJn8DIx7ETVa34YlrWZ7NJkLvRv/sz2rV3EPw/t73+4/r9jdTAZ6Lz4gT3bJQ1sdcg+N/wv2+SG3yTWqDXwYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792330; c=relaxed/simple;
	bh=7KEvK2r5nReuxmEXXY+DweaqPsLLb5FbO9dEADvc/Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5kO+OUen5d7twDSPel7A9Oyq1UZIKPfLKiabaE3b8ACw8AKGY8xvxt+7MA2gwEV4NRoxvTd0XYOBoUN7RJZw3tDzkt6neVTI+VowmeUC4gMPdlKbJNTnO2BuFy0kTZlI8gh/8GLaqnzRESlxG8/zLAxerCf9m8oUMVeNy/S6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JIL0NPOR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JIL0NPOR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687E1Rss280857;
	Mon, 7 Sep 2026 14:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=j4ezVPVPq/Y0GA+y4NQpYhe/XCJlKsLHmSPblIhkF
	Vw=; b=JIL0NPORXIHif5VKEpBDS3Zf/6iyDnhP1NrOtIMOykjXIQNzK46PUMW8i
	NvfcaaXYWYpxM2hBG91jbDud4WKurOidhWVGj/n1G6uB74xo4andr+US58SRT4yK
	cRk0nB4mdFoOYGg0wJzIYDbVF6qh5sFGvweEw+gKhriRb1yLB5BNq+ElCHAoNnPp
	n6b8Oef5O8HbS++VrHvlI7+ruEFepacEqS85RcgGE6y0j5c0fStjBGJ/WBMxNcAr
	OKCr8JNGH4kptEao3qRKQ07XNCso48W2WXRbUlpYEyve86NtcU1TG/Pxyq++K6PH
	x3D3Taj0lK00O1i2SGKE/qEkn0WDQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjs9hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687EfGR7024241;
	Mon, 7 Sep 2026 14:45:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq6mkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687EjDTu47710636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 14:45:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A948E2004B;
	Mon,  7 Sep 2026 14:45:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61CD320049;
	Mon,  7 Sep 2026 14:45:13 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 14:45:13 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net 0/2] s390/ctcm: Fix timer bugs in fsm.c
Date: Mon,  7 Sep 2026 16:45:09 +0200
Message-ID: <20260907144511.3810194-1-nagamani@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: M3PTxuXPL730JIsKHv0V3vd1h6Z1KJiQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX6O2yZPB1kwDU
 NWz5yxktAj39Yio5FEzauR+FTQvHO190TxcrdSqFDd+p2dVmsouC69AWnnJP8s0mBk5UxEFhYB5
 4R3ykmsyTslXkFUPIDthpsG/UeExA5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX1RLHbf9xeP/l
 hRlyoe/HzYT+8RLd07/AgGhpIIm2WpsWFO1HQppC+P7U6i8eRhkML4OT3+18NSG813KRcs4Dl8Q
 OVlM4lUAriihsb/Sbv0JzEGAl5VagkIzi9rVQleyMyEZ3o4wvXZgU9TUVsJwg6pU59K2dpelijz
 ybsBHuFIH42hrPKJi1IuERNJjH+ZzGxq4wSvebLHw95QnFCjnfar8ZoHtxa3l/7TEbJlkCVP9lF
 LbcnVPb1i6GlF81PmN47lUV4ZxL5TPkPBDi39f5yUqK1hDytvanrHgauT+2lskxkWGDqCPoa2pY
 qPXuXKR20F1JVE9LIGETTxp5433l8UhLzg/hh2XFEldE3bN0HmKhaRMP8+x5VPb4EMGGmcAqqkp
 I7UbeFy9kpQ3OnGLf2Iks14thc55+9vGLxjHwLiiEuSzXzPs5N5UXNtXkaBaRi84a851x2Gb46y
 s8oH/lKb18Qf2PaxBYg==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9ece00 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=3qrFNP2tgWyxs8p2YccA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: RExddxdM6czKp8AV_HgEbOLx76E2kS-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070161

Fix two bugs in drivers/s390/net/fsm.c found by Sashiko AI code review.

Patch 1 fixes timer list corruption when fsm_addtimer() is called on
an already-pending timer - timer_setup() re-initializes the timer
list_head while it is still enqueued in the wheel.

Patch 2 fixes a use-after-free in channel_remove() - timer_delete()
returns before any running callback finishes, leaving a window where
the timer callback can access freed memory. Fix by waiting for any
running callback to complete before freeing the channel.

Nagamani PV (2):
  s390/ctcm: fix timer corruption in fsm_addtimer()
  s390/ctcm: fix use-after-free in channel_remove()

 drivers/s390/net/ctcm_main.c |  4 ++--
 drivers/s390/net/fsm.c       | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.47.1

