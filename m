Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98719314D05;
	Wed, 26 Aug 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758712; cv=none; b=eBSgnbkW5HDT5mYYBOeSoeTOqip5c6qcqiNPlZMKvPm5tCjo0rOMLaZiT+UjmeB6SqGJt2jx5uyKOJj9Pker/T4jQKUuG2sLTsmKqu2h3ILI8O9FLOUzjd8vVXLOS9iPFFgF3LxOer0jK3pT+/TMWcHjLdpQW5VxqpqME10eoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758712; c=relaxed/simple;
	bh=4MhqiT5hoEwqAz0/+8ZR6nBkYPq9192xUEmsKZpyUq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBRpNjD5NPxTA5DfydHF1Gr3JVP+e5L+7FFalQc7A2D7+WoQby1mjBr6RB9yfYRsFcMus9jV9AdjwTvliePN/y0gfnE76qo+8FTJLvb1MTygv5XN+vEltxmObXevKDaD+DEcd1JR0bC9xmpqy/BKoHaIkHVgQvhwVJEC3HwGS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTwX/yZM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTwX/yZM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1Whv015895;
	Wed, 26 Aug 2026 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fdKZCDbyq0GS1HaC3wWwvjazkhGiWp
	6eXcwOZOda740=; b=sTwX/yZMaMRtRBvCKkwmti+KVirm8AvVcymbzXiK0jsMMx
	ERrQ2uADUHromlZH3wy+wRrASrSTU0535Kda0xE9cwdQAGmMDksIh4eAQn/qo8u6
	jMPHWZ99epA4je87wqfqyNLXGJUBLUNWN8A9E/LWyhFAc8eZdWLra+GZsnhNQz3i
	u5MM68/PM7j+3dG6GJBkZofAtsoaq4RGR995GxlYbPFMHgWIBz7bTs2IvhPwWe2N
	TA896OY+FgPWMLhqgYnLElmn8RbnyqY2lQJWTFzgUpbeKSCmr0ON/AaiQjbkBLM6
	ZK9oBx8+6is65Jof/LUkQVCSY2I9cgvA/HTCHvgA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4ymm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:38:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QFQIkM028139;
	Wed, 26 Aug 2026 15:38:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwauj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:38:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QFcMg944499304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:38:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7036B20040;
	Wed, 26 Aug 2026 15:38:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF0F2004D;
	Wed, 26 Aug 2026 15:38:22 +0000 (GMT)
Received: from osiris (unknown [9.87.128.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 15:38:22 +0000 (GMT)
Date: Wed, 26 Aug 2026 17:38:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Message-ID: <20260826153820.21444D43-hca@linux.ibm.com>
References: <20260826150702.949956-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826150702.949956-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QVdDxS6Ap4VX9KaGgRqLBtXqjbv7yeyG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyOSBTYWx0ZWRfX6UnHthZJll2h
 7g6wowt4xVxJTaekP+bfMVdyG7whMc03WLlaBcPh1MUzf99m7ItoOV6lzIag5nzWXacILyHsyn0
 V5TGRFm3eckTkv515liPj6MwY3IUF0Y=
X-Proofpoint-GUID: Tz_223l9y2EaZMN8r3dMkXa7wg0zrIZf
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8f0874 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sAMqwPwVMduqQpxATUoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyOSBTYWx0ZWRfXy552u8Ebbw78
 J/OBQw1AldPhB/NRqSk8huGQZ474N4Slx5jFcrdVaA79R8jgj4ueBeTok76ldwpr/+SbVM3vxCB
 RXTh/G2ETE7P0iu5t6xHY24USIi2ZkKd0u9b9PbSuvnKavVFhF/IV69L7srCnG3wqoeTuiEuejZ
 r5RiVSIs+CMUC8CdlIfee6eeowrKJKFVG7Qob/l5wSTqftgTiukJr4okBII4qdvIeQOtuiuomma
 Xau4B7hA+ENMLDudqOZtKH8Gi60Wv6ToDgsvsu5DgJrGpT3fiu1WytJltOh09Ns3nMi1XYm/Oz9
 gestz9oVIj9NoEO8hOZeaX8PiwUJyJY6q1f/B1KSYiaeCEd+NnTp2HFEyGRuxCbMgIS/n03jIFG
 dIQQHVm3elhAuzP1cTJtjpHwie47pK9lKvUqtEMsi0BKbcoq+4mbXtMSbDzPa0ouAiOJo7JPJ+9
 /jkzQc6gH3DQSPDySKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260129

On Wed, Aug 26, 2026 at 05:06:00PM +0200, Ilya Leoshkevich wrote:
> +static inline bool has_nonprintable_char(const char *str)
> +{
> +	for (int i = 0; str[i]; i++) {
> +		unsigned char c = (unsigned char)str[i];

What is the cast good for? Maybe this could be removed when applying.
Anyway, thanks!

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
