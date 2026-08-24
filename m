Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1E3AFD11;
	Mon, 24 Aug 2026 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565409; cv=none; b=aiHIE0EO6XCCRuyaN4zwexJ97mdG6Ml6Nh1rPMpEwQPfvXLEV2xnhvpOwLdB6boIdBpGaXjc95V3YvlDDUdIdmY0YHiEC+p2ZizILoaXzOWfKyR6nHut/CfKP1lERFeHHVSsyPGSOwekymN3etO56WgNHS0k/O0NmegHrxMbaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565409; c=relaxed/simple;
	bh=S+a2B7keG0XAuK6NVzh3vpdX5+mNcZs9yGbGARLrW4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLgcud9BQNz6FXv5RgdfNCmglL+6BLO3spW8EpHX6dnKXJ3Mt+hPFKWe0Y/CvsXse0KpWPzTBM4Pd9HYrwrLWJHiqI9A5sEc8rtdt00tgLpaejlYyPQ2Bwa9S2Dr8tCN9oczFGIse+b1fdpqjvLaIFoYcSxb40gcs6wXAOZ4rH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P3bC2Jg5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P3bC2Jg5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9VlQq1487533;
	Mon, 24 Aug 2026 09:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ryDdecWHKehuhgCSNE2lDrm72aioKP
	fPGMsHHjJRGOc=; b=P3bC2Jg5V7p3T5FzK4oIUr1NphnH8O0ifYPtAHWqxsza0R
	lpoP6PDxx043GDV6VrXbomK4aOEcIZh58Yp7UrEXkG//1mHUw8HrsL8H0+NHjJuR
	jknkQz52+T+8jqzp00lKPWbxN20jcnBPNGUH+9hvjjhzzIDogjZRrmlPrfoW3T3A
	w6U21r4BXZgI19Cuz48p/h3PBm0OhCp6lgiSv9T839uLUw25I4ZvMkjKKAuYoNua
	7nPaBJ4CJrV8Y/+XEmtf40UAqcMSvnwdkoO0OQIDrDAH1+Cd+d9lmJZegIDOS88O
	NofcIZVR4CVe3XapjLppsedqmoQ0xrLQym3hs2mw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4gem2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 09:56:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O9fJ7p015669;
	Mon, 24 Aug 2026 09:56:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvw8qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 09:56:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O9ubkM51904778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 09:56:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C82D2004B;
	Mon, 24 Aug 2026 09:56:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0600F20043;
	Mon, 24 Aug 2026 09:56:37 +0000 (GMT)
Received: from osiris (unknown [9.111.89.201])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 09:56:36 +0000 (GMT)
Date: Mon, 24 Aug 2026 11:56:35 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <20260824095635.11040Be5-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
 <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
 <20260818120130.1411942A70-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818120130.1411942A70-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1JgbhTBR0ba6zQHMYebi5vr-RzRcFwky
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MyBTYWx0ZWRfXwc212wIRAupV
 PVbJL3dltTgZMqcmb/tXogBsfJ2gxLKRLqp05p33LrmcU7RhmaNyO5Brw+8PwrCduU4dkxY9rrx
 GoJGrzEAQmjZRyw4nhgpzmyX0uevnXg=
X-Proofpoint-GUID: ijQB2z1bnbd_HwBTe79wNdiH4RW0g4ZS
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c155b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=ZjT8TfMUO59fnRzz4l0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MyBTYWx0ZWRfX3dM4LBptTZcr
 xjmPKJIC0Nl93s0MpPNNiGDKxsECC6g6vzQ3z4l7Mq80Zl6TLiMhj6WhCXmkSSVomMIl3O1kaiM
 gy9j3XYywqIoujNd0kirBgpIPGkNs6RDBR6g4211GUaT9sVXkDaQfN2uevo2WyUOM0Fpp2YhLA1
 Ci0BzMDSiDsCORBN/64EWeVm1UKe5p2CaXsW/3qDQsWdlDkoMDqg1g822RDTsTeew5rB8zk8st8
 FbK81r1PpA7CYFyIW4kbs4XbhE8WxhdV1JQwvO1BhTz6vNcktOLsiHWTaGDLaZyo69t7OHAA4Ep
 uxkbrw9fIbz+Tl7su4Nh9fCsJIUi/vFSTYOJS4GI298eN5WXlU0/pHaok74YO2CICOwaaLUFFem
 vI6gQ8Pom/JMVourmkAhfNQ6XYc/ZI82MMf7O9VB/+yP/pP92G6ooBdH7GXFEcF2CvqqvrL4ObO
 /qRESkWr7EnhUO5Kcjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240083

On Tue, Aug 18, 2026 at 02:01:30PM +0200, Alexander Gordeev wrote:
> On Tue, Aug 18, 2026 at 12:11:34AM +0200, Andrey Konovalov wrote:
> ...
> > Hi Alexander,
> > 
> > Should all this be limited to only s390?
> 
> The idea is to allow any architecture to opt-in. Once [1] is accepted
> this may look redundant, but I still see the benefit in having it.

What would be the benefit if [1] is accepted?
