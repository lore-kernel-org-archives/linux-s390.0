Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF193A4520;
	Thu, 18 Jun 2026 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784079; cv=none; b=Z/yuZnxxw8P/DCSTP0lsDPkKPrEH2R86CbQTBlnL1JQGtvF03RPW1mtpihum1eoHkoQaOrMrZo5otJI82X8Ed//HPP7VyE3HUhR6H5+R/dMNGiqzUrWIUwBv6hrgiokAIoCiC/BbOZ8zKcRcHDBQ1iCq37bMX48VQ968pnB44Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784079; c=relaxed/simple;
	bh=yYfY5SElGZ5gTCAcLjVoI1cPsqSVA28EH0TneFGbR2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZ7kCJyLwjTg5oO0PuxkN5Re2GQ2HqAyaeP73BLQtfRrQe3+4xxTpVRJHupFbIBPyJudCGc/4WX1QmCp1oypYFkFCkrW2jwSFeQxwx+qG3HOOQTg5PDmdnTlibNWcuXfBrWcoHZ6pufA/OjxRcXjQgcPCz3FMThVGzgYSsShu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jPtspq8v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jPtspq8v"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBINYb3203668;
	Thu, 18 Jun 2026 12:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wFdG8V
	PU1+1EjZdIP6f37Hh8+Y0VJi6A02g4lfbpL/M=; b=jPtspq8vspWpBJqW7Mc4HT
	TPcubN6UY0jBgCopuG+GFAdGSBI/7au312cryYVONQtJ9Xt1/RRE/X65/pY+pUji
	12tYtYwRZQkiwHcUTaZzcuTMTrFLnTckTaHySo7w9n4FhJdNfhU5ORzBiTxRg4GY
	uuBDKOp2r60LwRkdGBRsF9i1IV8Ya0UKcD5P5ZmomCdxlXpyW4n+BWewgFZ6k3qi
	QX1306NBogfKOYQ4Rv+3yGvjaswP/jjGvpKwJabpou1WpZI0yG0eH2nu0o8pekEX
	t9Dxbcsai3MbGLgsh7plJ2WQJH9VBULLJ/R3CUZOCOLZzrkgDdSgyrMYyfB3OVfg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfsjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnnTg024862;
	Thu, 18 Jun 2026 12:00:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1723jea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0lS651184010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56E32004D;
	Thu, 18 Jun 2026 12:00:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0734020043;
	Thu, 18 Jun 2026 12:00:47 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:46 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 18 Jun 2026 14:00:17 +0200
Subject: [PATCH v3 3/5] s390: Enable TIF_POLLING_NRFLAG
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-idledriver-v3-3-684061eecbcb@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a33ddf5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=c5jR2BqudvT-Uhvel0MA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfXzuayLMepXa4D
 dgBFNm+iFGXruoZVCTjkQKxbXAZEpDO8iBSGzhL3tbUt+4OtPFJhfbbhNpz7kwtiBUAPkEYMKwd
 xaocMRmPFursrtUKJk+C+K3+edbxCqHFbUKD33Qx8boQCD+inr32flII2aKqpEHbnoAZykCMFUB
 SbGsjK+WIgTfdL9yuPsiojjCvia0MuudhcYtAyJM6tphnIq8BJvjtMlOTymQUgq+cVXeg0e41NI
 vWPpcrwczxIKtMflJWt4f3R0dMslDuf8bfWXy9ND7B/NSoIEhdn0Kht8qeEgY0w68NKUW94P/WD
 3vwOdrAhDnp3LLDD6U0mMkbb5haDCfzuupg8floHWspZIYCu08b1vg6WWKIiL6S9DCmXfwjJTJr
 1K/LODOxZj5jWCDT5lpFVsRNziD1UIAk+3I6hfX9YeK4z0vUC008xiXg/O23uYTLqfGIdFiJTmw
 m0v3NlMzgYI+uAZa+cQ==
X-Proofpoint-GUID: advZQeY9NkTPkaVvS0NV60j2swkTYC7P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX9x7CwjwLzfXX
 CinKLejTKD0uGuxeE0che/sdkql0d0Zm2zx8Z757At+1mS9/uc0Q7XAOnY9ky1A1h541/5HMTLY
 AQNYqDBN6fS/uFDLVIbpESyhiLN29NI=
X-Proofpoint-ORIG-GUID: advZQeY9NkTPkaVvS0NV60j2swkTYC7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

Enable TIF_POLLING_NRFLAG to support idle polling state in the
upcoming cpuidle driver.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 6a548a819400..2554cef3a6a5 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
  */
 #define HAVE_TIF_NEED_RESCHED_LAZY
 #define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_POLLING_NRFLAG
 
 #include <asm-generic/thread_info_tif.h>
 

-- 
2.54.0

