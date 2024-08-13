Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61C193093;
	Tue, 13 Aug 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545770; cv=none; b=CRoJWeRt6ZmcOBQ4DnqOQOxPOb9xBCWioDcOtW5zBbZlyzm31VS36KgUT0iQq9GODy5khLZOnSl5i1E7+x2xXBzNqCcSmLOPG8DnL6kD82TOk1j87sAicpum5nWBDgwpNhiEPD5LOIwxrLBidX60Oj57FttLSjU0fUiS+Vf2HdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545770; c=relaxed/simple;
	bh=83be+hiFp+2z/6/BppN51FvR+Q3X/p3UKmz2eiR+zSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lvHpL+ojK0vC9ACKZ/uWTHccS5ms+/bQCKHpGLwzwLB4Kigt9SmDcJkEsr17qUeLtPdTcBNAOuODFM5PGMj/optoP153XApL2c7CJkR9ayDI2U2jF0vtGtKTboR1w3Khz8ZX6NO+r6UrW/3NAQYx6JNpmYQQ/GmE4vNwTxUn5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rm8tEQ5D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rm8tEQ5D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D4o7Gb023512;
	Tue, 13 Aug 2024 10:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=9cs0iIH5mLAAvMy2jiYnMLhLJ3D
	Aq0B9wOZe8l17h0s=; b=rm8tEQ5DENtGZrO4dXfZCUhKI+HXSQte1SiMSSRYPm2
	oAgckITdvNH+ttgYYzGP5GIJm26rxQbEo9Hwqnr4A8+DZg36eKktAoSgOpNbGLLu
	dWCNaOmf98uOm1NVu5ObgUHBa6b3rUV5QHD0236eweaumwDSdmsRgJY49FGRFZnU
	Pen1eGlxEk7CPD0mBQbnXbmtAcEx/A7fVM2ath/5yXPX2Te3xX3VCMboCsqo8VWD
	o0ct+4y7HVSBlea4ecpJIHRwS2VVGISBwAFsvw7v1BwKo1bMzdgyKlO/OvPyipDz
	rjUX89NHTTdXiKxTHoinyusLDOvs2h+zdoyJo4eGuqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8qhy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D9mPNC020882;
	Tue, 13 Aug 2024 10:42:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn832qg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DAga427536962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 10:42:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3E42004D;
	Tue, 13 Aug 2024 10:42:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13B72004B;
	Tue, 13 Aug 2024 10:42:35 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 10:42:35 +0000 (GMT)
Date: Tue, 13 Aug 2024 12:42:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 1/2] kobject: Export kobject_set_name_vargs() symbol
Message-ID: <patch-1.thread-d8267b.git-25e808605154.your-ad-here.call-01723545029-ext-2515@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zuNvirtg9kLjmqFuxPN5_UWciZQz1h8O
X-Proofpoint-ORIG-GUID: zuNvirtg9kLjmqFuxPN5_UWciZQz1h8O
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=966 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130075

The net/iucv module requires the kobject_set_name_vargs() function to
set kobject names dynamically based on variable arguments. Export the
kobject_set_name_vargs() symbol, allowing the net/iucv module and other
potential modules to use this utility function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408091131.ATGn6YSh-lkp@intel.com/
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 lib/kobject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 72fa20f405f1..96caa8bfdc40 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -295,6 +295,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
 
 	return 0;
 }
+EXPORT_SYMBOL(kobject_set_name_vargs);
 
 /**
  * kobject_set_name() - Set the name of a kobject.
-- 
2.41.0

