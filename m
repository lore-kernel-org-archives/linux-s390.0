Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39434F7988;
	Wed, 16 Sep 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564938; cv=none; b=nZZ6077AxPTcs3jfNxQlfqpDaa8RVMUDlGhol5h0zW8h16YLJuqCNA2txUbpqBpNHi1O4bA9PGWoXPitu6PcRRSs61WJOfLziRHy0Z3vAUhXNwnTN9VQzLAy2A4s7kxVeCNFfd36iWQ6K81R5KIQWRcJVyqdvrD0XmkwA141DR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564938; c=relaxed/simple;
	bh=jHLMlugc2JLTKbTtzECNVkpDtxZK9iox0aFKmi2u7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU9Ko1JLp0GLh4OYqpHnK2uclknBsrRJz7ffAdvsSsfC1A4n+za+9ObY1g03Pu4jyB88Dcek+vBxO+ll7pbKsobZTN/76gJ4ronziI1vMIkzqCVGuYehOk+qdHZmMhKBT16CfNyGokIpqE+l62SZRsvmRFt7th/ydSj8iFMYrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=be6mOtRD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="be6mOtRD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCVfBv3765149;
	Wed, 16 Sep 2026 13:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e8iskxvOirQTImQgn
	7D23ItLgDWAWLzkJYB79GYOzLY=; b=be6mOtRDuoOFxFa/ZWzrD0JMKgb1K4ikX
	xc0d6RKLgk0NLFwNmhMHTjLFp6SXqq8iNUNqY63FNETQPDxwNbvpuTypZCzglB72
	SG1tGnV0Qs7ZvOniDHM47Wtpg+H15Xo7Qm3BBtW7oBleRpZPrChEQHABujNWhyeW
	O4JTuYIFYnOqmYozk1zSKiP+8AGaFj15B5EkNtrVEP3cw43g3yFjCiYvGPEz7Ya/
	/pqTo5XexuRsPT2fw5VL8KrkOapYZet/Gtm1JwC2WnZ5MwqeATEsrOODwtxlXvDG
	ktdfHLmZbylfRXwiQXBrLvVzLsI/5yDmnlPZE+LuFO1d4iisTH0FQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf54qhw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GCZLgb1491499;
	Wed, 16 Sep 2026 13:22:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywexgfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:22:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GDLw9551773912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 13:21:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40FF72004B;
	Wed, 16 Sep 2026 13:21:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E574F20040;
	Wed, 16 Sep 2026 13:21:57 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 13:21:57 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net v2 0/2] s390/ctcm: Fix timer bugs in fsm.c
Date: Wed, 16 Sep 2026 15:21:47 +0200
Message-ID: <20260916132149.4185912-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907144511.3810194-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wEc_hLDpTS9h51-ZFLL52cN-MB2hJyr-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfX6ul38Mt4sTYz
 B4EenqT644v7ARkW94v/Eycs4Q7gysjtDsDGp7NDkeLLox/atl2wUDv8Uf+JL7vYiSgersesMSS
 KsG5qdIjKtaFUjhibJ04Ir2Ya2UkBOc=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aaa97fb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=3rS-qYyT1ibZB_HPfVwA:9
X-Proofpoint-ORIG-GUID: _Q4rA5njxeD4CRoUg6MzBsvWq61vcUMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE3NCBTYWx0ZWRfXyP9+pOPWweKI
 b/Wwn29ueJJ+Tchjk3vv5Abv9FxfadKSpIirl7cP+rFxOpeydTqnhZHN2n3rHkDLUueqnFno5Ng
 X77cg0ow2Ty00KDSu5NufzPJ3NcpqIrK2CaB+hocmOkpZ+zeH8VhWQPXbX2VsMMIFXJvbz+moqs
 yB7mwnS19AlLC78fw3DmTowGRoOpI5A0S6iXmeVGFnYh3N9HqWJzFk4LVyq/QLpQSQ3gkD1bJKO
 2YTraTEE6ZLQNAz6ByhiAeg5w4Eq4U5TWglNqMiuVWe3KjED5QS1EShC/2c4U34g9O91q47PXWE
 OyHlPbv3bjAMwpujbUwoLat8G+W5NYUuVlBrQDThVeaAyfP24+s7ZgeL2ubaSaH+3GwvjKNx0Ld
 Xx+kpEaTiwTEIVtNNNz9NphxDT9zxQDWmGhmHvQTww309t+WJDQ3uIUDXBjQqrJUo1Bkz93rvEb
 QCyVSjVwn4bXxuypcjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160174

Fix two bugs in drivers/s390/net/fsm.c found by Sashiko AI code review.

Patch 1 fixes timer list corruption when fsm_addtimer() is called on
an already-pending timer - timer_setup() re-initializes the timer
list_head while it is still enqueued in the wheel.

Patch 2 fixes a use-after-free in channel_remove() - timer_delete()
returns before any running callback finishes, leaving a window where
the timer callback can access freed memory. Fix by waiting for any
running callback to complete before freeing the channel.

Changes in v2:
- Patch 1: fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
  in the commit message (Sashiko netdev-bot)
- Patch 1: call mod_timer() then return 0 explicitly, preserving the
  "Always returns 0" contract documented in fsm.h (Sashiko netdev-bot)
- Patch 2: add Fixes: and Cc: stable@vger.kernel.org tags
  (Sashiko netdev-bot)

Nagamani PV (2):
  s390/ctcm: Fix timer corruption in fsm_addtimer()
  s390/ctcm: Fix use-after-free in channel_remove()

 drivers/s390/net/ctcm_main.c | 4 ++--
 drivers/s390/net/fsm.c       | 9 ++-------
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.53.0

