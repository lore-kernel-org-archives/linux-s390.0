Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297D42E8C2;
	Fri, 14 Aug 2026 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705522; cv=none; b=EdUgUMRcrUaedldUCO3oob6KTlv8nPYoUDgzGErNyt/q/d+xm1w6gNY0NLOm9xvgXwENGJIMoepJK1gitkGlPlgUpuMTK0ctUkyYWDPalxU63bKkaFb4iheM50T1bh/DqAv2BKnO8bJUeusfKmqzjesgaz5aTJbGADuLfgIdcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705522; c=relaxed/simple;
	bh=EI9TMT+GH7IDL7pK60J6oqlXzebwQigA+bQiZrF7n3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=EDmQH9mYdjkHKYPOocvcez1Ra11T/tOMOtVZ92oFivGgeGhiyqb42ZTDH0/YYTqjpqt6dAiK09rIW+vlQehiiCaIjR/nzbr9AklY9ewQCJLfaldlYKDAjFPOzeRc9rQlhQlnig6Ez87vijx5Tp1ziAW8hAERip1kNhkHpk40RgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQQMmTEG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQQMmTEG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB29f6861778;
	Fri, 14 Aug 2026 11:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EI9TMT
	+GH7IDL7pK60J6oqlXzebwQigA+bQiZrF7n3o=; b=AQQMmTEGK0cmiU23mZP7qp
	xMcayd0lLHiJfMQdAbFWkKrnLiQ5VagDGE+J53Zta2VDcReTEoU580C5DP6n1em5
	DxopcQ5GIK7S7b0NJVD0UEER76yWe/r6kjPtouHLscldiTJP5agOmP+cul4hRZQ1
	ENxvgJGLvTt+JLn2a8YOHN8KMeEV4eS/sB9zRkABV4VR53T1+tVt721x9ZHCK/8E
	4IMQGWmknNzOlR2NB2Y2I9Pgu1gZ/pA2B2Yh4D1OXuMwmU1q/X1adKkyiYOjuQjY
	yH/5vgh2O1rAWa/IOYrAoDEnBorthgarfkMdey7GofWJ8l78mp4BGwOh8JV462gQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3b9vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:05:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EAuLn4020396;
	Fri, 14 Aug 2026 11:05:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqf62t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:05:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EB56MU11206974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 11:05:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31FB2004B;
	Fri, 14 Aug 2026 11:05:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8461C20040;
	Fri, 14 Aug 2026 11:05:06 +0000 (GMT)
Received: from darkmoore (unknown [9.111.12.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 11:05:06 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 13:05:01 +0200
Message-Id: <DKOM8NZZEMO9.2V09GEBFT62PR@linux.ibm.com>
Subject: Re: [PATCH v4 15/20] KVM: s390: vsie: Guard against invalid CPU
 address
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.vom>,
        "Vasily Gorbik" <gor@linux.ibm.com>, <kvm@vger.kernel.org>
To: <sashiko-reviews@lists.linux.dev>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-15-f19e49666315@linux.ibm.com>
 <20260812162330.9C0DA1F000E9@smtp.kernel.org>
In-Reply-To: <20260812162330.9C0DA1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ef667 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=JUJgEXfSvTArizhW0REA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PddwoHeR4WMZWHCJt4sZKkSEm6XCj_Iy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX6sJsfHAC7ZYw
 05Vt6HUqnUr6jtdcGcx3n19kP8VrVP4sosiQTdpFqf7sAXAYd0qogxBkEkipDLXoY9k/XqLB0Zv
 Scu96PLIOS3oQd7Op1ux3paFrHyxIAMuVMPH5ov1S/JJsfH9POH7SXqaamVPRljQv6ci7D/0Zat
 54ujqFRK3/VmtQEqNr7dXx65dVVdvrspWAX0JgTywka8UYnqBKxuLK71RnM17UucZRUguYYzObT
 Zu6Lnj2DtyU09d1Q4PSey0uedAwhaHdCGGqW9aRG5psSp81x92z2tYRWGpCWKQnj6KYyQnK6Uux
 R7JmhoxPtJTyYeqkjR0PJdB4kYu0FRN1G8mJ6xEfgD2vcUMLhOXDzKQub/pvuvOG+bnG0mCym0q
 izx1WxM31dDU3W5J0gZGTQ8X+aAmX0ke6dd7t//XEAklhJeNzjRp8LgU01ytJzxsV//x1AmRDXv
 abhh7OISW263RVH4omw==
X-Proofpoint-ORIG-GUID: PddwoHeR4WMZWHCJt4sZKkSEm6XCj_Iy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX1G3ZJYVVl9I/
 9cVbB41H66tYhdtu47xOAsfvlD35PCzGIddJLUfjfIfyiZ/xE786iaTqhXXwWwkElDEQKqQzbWY
 xl+lPScADfvFWS0Rb+VSjgAIIHBRQxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140083

I will remove this patch from the series and instead mask icpua & 0xff wher=
e
needed. The upper bits of icpua do not need to be checked.

