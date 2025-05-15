Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC6117B4EC;
	Thu, 15 May 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319148; cv=none; b=tdivBMCCQ7V3ksIQkN+zJs0gjCtN6zdPzkuAz9h3gwP5ACHnp1Jx64AGPOzrsMEMW097K69NFLpDmXk6F+qNvSfKNkggPMlhheSiWGM3VjF9lJ3nSsEuk42LpWWgNP3qGrV7m3SNHHDH3rcCldnjnEVpOg3HXHjXbwmbmE74LnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319148; c=relaxed/simple;
	bh=7Gfdv02jJ3Il4Aj2m1lINDWNyCUGAIAdcHZ7i+nnBIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDpO+E6jvuMutO1hr46J0+QhNDfNPcNsr2CV+uglNlGFY0ExPpsZYh/VVe3th1LRSKxAMaRbsbtX2zBQ7OM43jifDJcWbok2M3q0xtrECXjivd7ZAHtsdOJvO3liO3m7K8aA7uth+lYl9FZy1paYvu8GuR2z2fSO4S0K+rlLCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WmU5zAaU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WmU5zAaU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg8sJ002405;
	Thu, 15 May 2025 14:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VEW6q6K77hbBMnPiQrFGgC+mDti52fcTnsB0C6Qja
	AM=; b=WmU5zAaUQrdWJdpRaPCcy/LYfjw7QzqX5ASFIerHXR+wy+3xWMz3ENYki
	Mj6fpwBtqp81E35Yfx4onLXQwoKaHkhEQCvFAGUN7wynLb1cRTrdjAA4dIgH/pfA
	SOqbw0tkgjhV9RkfbQlXHyqQkYTYw7R+gNEf6/zZGOeBrhCthdS/BR24TuciPHxr
	JfW88piu802UJTWqOQ5H524fbW4T89VrYbzr+dBAFOha7gX0SCkbMw4IjB4Bbp01
	HB8ikUaSrSECyHtYUEqPHLgDYwe1zwwJ5ugA9neb2BUT7ZlOKcMTfjBIA8Yp579l
	ZmrYhWW7TAu6sOWYFYiX8cODr8r3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6mxmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 14:25:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FEPbQJ021983;
	Thu, 15 May 2025 14:25:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6mxme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 14:25:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEL9Vm021574;
	Thu, 15 May 2025 14:25:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrtmt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 14:25:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54FEPYUv54591780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:25:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E3CB2004B;
	Thu, 15 May 2025 13:55:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B6E520040;
	Thu, 15 May 2025 13:55:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 May 2025 13:55:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id CFB7AE0697; Thu, 15 May 2025 15:55:38 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v9 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Thu, 15 May 2025 15:55:37 +0200
Message-ID: <cover.1747316918.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=6825f962 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=M4n5Zv9w_bjhLjlc4U8A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: gsjWp-Ng0dC36Dn2cBR5PS3eptApZOz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEzOSBTYWx0ZWRfXxmHO/rxvOS6Z 3fEjEqJhV3MG0Cl4RIn0X+tlTvzgH63kEaBU7Pf6gPK3R7u6sHrFJaENBG6tOAKgxduSdeiEMVq Mi/mFGc8J4pov1w/K5o3hWHd2YHZ4kbxtGvZLV+jK0COKPnCmK1J5oUJGiuqapxWqBy63x38TPk
 F5itjgMCxz21A0joByb3ds2Mak4sk6O8MjzIeJVqRwTKy2VfcXTgCw8OSS6Hi3/qxZarlSX7P3E wx2WamWYFoce12j03HoPx0FMPaLNKLhwWvEkllkaSI3H/Elr1A9IcQxsICkLwdBpSm6ObbAqTIh 7ftPBMdouk3FdIJAN779vddxznFJg4K7m8DlTUwaAzNKN9tMFGMTe41togkHfQ7T39WUb0GVdYF
 nRdwdoZdkpyIQ4rwX6c3jJy+Pwc2yH0nAC4oObHuF6Ecy6mxm7ow1jIEb82fy74/3wkRhW7r
X-Proofpoint-GUID: Hz4sHBe_8I6zp0zDv4Z_aaQ_3JO_OM53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=735 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150139

Hi All,

I dropped Harry Yoo's Reviewed-by from this version.

Chages since v8:
- fixed page_owner=on issue preventing bulk allocations on x86 

Chages since v7:
- drop "unnecessary free pages" optimization
- fix error path page leak

Chages since v6:
- do not unnecessary free pages across iterations

Chages since v5:
- full error message included into commit description

Chages since v4:
- unused pages leak is avoided

Chages since v3:
- pfn_to_virt() changed to page_to_virt() due to compile error

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 92 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 14 deletions(-)

-- 
2.45.2

