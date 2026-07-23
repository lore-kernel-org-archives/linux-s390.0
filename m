Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425F48BD40
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811190; cv=none; b=jhRfJy6iJ31A3yDh5hbAYH8CuLm1cUs8H3hB2apCjozrBGbB60UdmkiQAX0zBxJMNpd5y8QhwLDdpeUEhX/Nd3veS+HMnKzesnorEKwdHpDL5+tnED+o2GUVPCdvmLpIDaPMO4HIeQnWqt8rbvefszRCtYP2jB+CaeDxR8EbTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811190; c=relaxed/simple;
	bh=uln6z0IGJOtrc3XTISuMYLylBjGx3OmrcA3U/0H55lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmt2FPtzOA65ioRJRzoxVxdfZjv3LIamSxv6EMFIITZ5JttmWmxCcIriAYqtD13usm7jyi1tpLWbHlpZzbtBy4BmDPYvDDyOQ0StMFJB8cOl80tpMxahakLp13wTkQF3XY6uYGVSzzmM0om1dxbz2bUtUzUgB7v7HmePKNEz380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eJz0TYIc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eJz0TYIc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BulX2505716
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=W3W5pku1WKS6bXWoLnegy/z7t7WYmS
	CO7mw9asundNg=; b=eJz0TYIcgfB1cr6gAmc0fxQiK2vu5fXjzH/XTWVeKjswLz
	1B7/6+ws1B9nbtqdEn0VS2tERjAFsz/50kR7lPZM07UxZuCEGIdkj5zGLqjz7Vcp
	nXNcVr6u1BcAOVHnHcV84TJmUco3eGLvmefd8OSzqBSxoNb7vnXHnwjPY/Pc3atL
	d9Izi5wTJLjN2wvW5A0kNR2smFHWr7Q+J5sK0y7467ET1Dk5RSCMLwrXCxvqQFzW
	VQUrSL9YtoCfhkRhG7Mw2Lhn97XI8KocTmkcTHwSo9l+EbA5cNXrB4mtHrWaLE5S
	NyJkPQOtmzylE5D+3kf1n0CYd38VbuU0FHq9woVA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kf00y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:53:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NCnh3r031797
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:53:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wc8vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 12:53:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NCr3jU27001400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:53:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2040200B2;
	Thu, 23 Jul 2026 12:53:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFFC7200B1;
	Thu, 23 Jul 2026 12:53:02 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 12:53:02 +0000 (GMT)
Date: Thu, 23 Jul 2026 14:53:01 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/ipl: Improve readability
Message-ID: <ttimp4d@ub.hpns>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a620eb3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=8HJMNE-WD3Ejd7u3PcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX5XZbsy+o5Jsk
 UyzNKXJ0rS5AAugspjETKTHKhFAxbo/HmxWuRE8v2R8oG92Qr1BxMFWlXCcEPUIDQbc/jIiiBT4
 mpelbxwSm3HeidPw6mNm3g+NE/0PVAgwImW9aL7qamXAtqgNLtsB3uwm258LjZ7VIAcK9psHe+e
 HaP/YbDIyxO/8Ohatn2oAgj+ynSjMXL0Z8HQIIygCiCK+DQ29wwjO5kW3ZzZbLSw15hJs0UM4CQ
 0mKz1csO/wHHgVIxtwYyqibAGfpjWppO/g53ypl8fsgbD2feLA+AHP1oSpWIQP+ANoxdeYMjegb
 KJ1vKOBRiGEj48dAMSVB+88Tg3FaRLYT35xNKsPQoFQ7E5Fswlzob83umzF42P0j/CTb3A+1pf8
 a9Z1uQjD0dffTZqQDbXoNmCw2kpcgIthjHbx7OQQSsWy4XDJabozTh0jqs9wm7b1jFi7CVvkhKy
 z6mPgwcT7/kzzk7ja/g==
X-Proofpoint-ORIG-GUID: Yvo6KixT9ThGHpvYhDhFLjjiPxGqI7UC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX8jKgCOWz4u3l
 vq67K1e4/YBcZEhepMvsNHX6TEDwaI47mCZdoeuusMI0I/v+CScDNCVk0JozcBCjyXC/r+lhGBw
 4MMyDy4QYhDAduox9cZ4aycBgaer2Qw=
X-Proofpoint-GUID: Yvo6KixT9ThGHpvYhDhFLjjiPxGqI7UC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230125

On Tue, Jul 21, 2026 at 08:47:26PM +0200, Mete Durlu wrote:
> Improve readability of s390 ipl code by openly writing static struct
> definitions, reformatting list definitions and using ARRAY_SIZE() macro
> in suitable places.
> 
> No functional changes, only coding style changes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
> Mete Durlu (2):
>       s390/ipl: Use ARRAY_SIZE macro
>       s390/ipl: Improve readability
> 
>  arch/s390/kernel/ipl.c | 58 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)

Applied, thank you!
