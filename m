Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155A19047C;
	Tue, 13 Aug 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545768; cv=none; b=rxmBKDd8fXOSoLiCpI5PnZtg9aAl9Grg0bCTf6l30bPXDmW/GZ+Tt7fbbVO+W+jAIYSHzexRb86FNuhyvcrYZqV6IOy3JaJOq3NSBnnVLKF5/hB7Fqb+B3NhPkIcfj8LaIuHFJKkWVdiKT1kcXdkGMdAi0T/3H0z2vcNwqRa/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545768; c=relaxed/simple;
	bh=MDi3wX7fdnIhfxVAhywNcygwZLhp2wdr2IYZY+vX5/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jiDnzD0uFzW37a2gk7sj/5NF3SzpK5Ti0CIw51Odgv7Q4TnaP1vUgtT2LOgQFKBvrDpujX8Zh0l40oemw84XNaHJ7Hw8r6ojEH0P3bDRhvmySAUVUbFjYjyTkpLS4wlcU6CSqBHMAFbQEyWItfKMiBkdpGaHzYUlpc4sN1I3iPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RnUYI3xh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RnUYI3xh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D3oKlm006188;
	Tue, 13 Aug 2024 10:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:mime-version:content-type; s=pp1;
	 bh=zZeq7ELLiVK2BKMbyyTbAhZiNk9+sT69oslbmY2Y4E8=; b=RnUYI3xhRM2u
	nZMpcmEh8wkopcQ/caOkmOeQ9/v7Svtz9bU36c0lmidjulcmUbnl3F45IiEd/VxX
	Fv02ywkX9VlFA2VZyLDUtOvMwGyf2iciGhsYTVHSbJ5Sihf8UBV+0QV74hVUEqc0
	LFB/BaRjMfKW2MvSkHaBq1189SSiW4BOwjkHFWN4J0JwHFOnz21TWmWJXQ+iBID2
	bO6hLZYJ1IQi4uvD+HR/ey/8cYL4gMatGJbHSPx0df3gPQP+YQ5KgRr7n9B/X5yU
	TmIuDMqShQ4JDrPkp6GrjK8Cd+riH2GdEzChrtdkDsHlH5ygfCUg6Q7vxPHWapDm
	6RIHnBv2yg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwmpqf5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D71wVE011537;
	Tue, 13 Aug 2024 10:42:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhu3b6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DAgXUC46989596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 10:42:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B1C92004B;
	Tue, 13 Aug 2024 10:42:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E177620040;
	Tue, 13 Aug 2024 10:42:32 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 10:42:32 +0000 (GMT)
Date: Tue, 13 Aug 2024 12:42:31 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] Fix vargs handling in iucv_alloc_device()
Message-ID: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n9t5jSxnYPOzguEvvdg9Digfnc5Ho0Ue
X-Proofpoint-GUID: n9t5jSxnYPOzguEvvdg9Digfnc5Ho0Ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=624
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130075

Export kobject_set_name_vargs() and use it in iucv_alloc_device() to
fix vargs handling.

@Greg and Rafael:
Could you please ack the first patch so I can take both patches via the
s390 tree?

Thank you

Heiko Carstens (1):
  s390/iucv: Fix vargs handling in iucv_alloc_device()

Vasily Gorbik (1):
  kobject: Export kobject_set_name_vargs() symbol

 lib/kobject.c   | 1 +
 net/iucv/iucv.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.41.0
