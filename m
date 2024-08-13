Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD1E19AA43;
	Tue, 13 Aug 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545774; cv=none; b=jtt+Dqqh4767rChYd7yeFgjCuIMsawzphjIgYAGzGtmfGCc1A2FeSw6nM95uvIALk6uy5FMPmXTtrd08Lal3sr8M5zT/PZVQOnwW0fZ01Wf4OoHNTNtSAO0Hixe/XPAckQjezAb6OP+dYKgepuE/c3dOmB7x3tiHbqasROQNPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545774; c=relaxed/simple;
	bh=HHD99OW6sanwLllsBoGvw+1p5avfWvke7Qfu0klB1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QqDQq20Mo1HEehU47y6iYnLIeYEA59iF3u0nyFp4yDhkXViLyXmOirlV8FI59GuMy9mkpvRv7nVSm0AYHuDKwYz8n5SqOqenXtpYeltqGuHGZMM4d4lawMKOTvTUZ/y8v8EqVjTU+tzQUz/p9XrNL1MiHziaCAJTqySjkTVPR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F52oh2kQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F52oh2kQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D2vxAv017177;
	Tue, 13 Aug 2024 10:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=yVSv49OAm1G8dHAIFYYh/NW64We
	bx8O91RwfCMFotZQ=; b=F52oh2kQEWD5YJFaqOhZcS0451vSjLAW+Sr5cw4gMRa
	NObGeqOD/pf7ZQJ/YCShVsTN4FjyADn2rSmf8dBTUvdP6Pd3ApEezCGCHXeENM9f
	MFb83I6HDaay4+5x6L2pph4MaYLBQ276oRll35Oq2mVz+3c7qhzAIOVCXvTFZLYL
	1ZIKsZwKHq+qKPZ4LrTgc9OXr2E2+1CmKoCl38v8T5W+ofF81scdgyZVPBRJvVRs
	6Vr/G7xpGdL1NiKUIlHkD94O4AoY3F0bG7k3Rko33/LueuWlLsEiDgd6/vDAlyDr
	R2o6QFiLUX5FhdAfv1/3DsAi2w8+o+HCLMyUwG4vtpw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40xr5ddctn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D8ZAe1015654;
	Tue, 13 Aug 2024 10:42:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1mk10d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:42:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47DAgc6r21692822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 10:42:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB202004D;
	Tue, 13 Aug 2024 10:42:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FBB420043;
	Tue, 13 Aug 2024 10:42:38 +0000 (GMT)
Received: from localhost (unknown [9.179.17.215])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2024 10:42:38 +0000 (GMT)
Date: Tue, 13 Aug 2024 12:42:37 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/iucv: Fix vargs handling in iucv_alloc_device()
Message-ID: <patch-2.thread-d8267b.git-d8267bded9e9.your-ad-here.call-01723545029-ext-2515@work.hours>
References: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-d8267b.your-ad-here.call-01723545029-ext-2515@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iS5q3r6dfPawnZCEblCop_7PS4B8j45C
X-Proofpoint-GUID: iS5q3r6dfPawnZCEblCop_7PS4B8j45C
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130075

From: Heiko Carstens <hca@linux.ibm.com>

iucv_alloc_device() gets a format string and a varying number of
arguments. This is incorrectly forwarded by calling dev_set_name() with
the format string and a va_list, while dev_set_name() expects also a
varying number of arguments.

Fix this and call kobject_set_name_vargs() instead which expects a
va_list parameter.

Fixes: 4452e8ef8c36 ("s390/iucv: Provide iucv_alloc_device() / iucv_release_device()")
Reference-ID: https://bugzilla.linux.ibm.com/show_bug.cgi?id=208008
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 net/iucv/iucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 1e42e13ad24e..64102a31b569 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -92,7 +92,7 @@ struct device *iucv_alloc_device(const struct attribute_group **attrs,
 	if (!dev)
 		goto out_error;
 	va_start(vargs, fmt);
-	rc = dev_set_name(dev, fmt, vargs);
+	rc = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
 	va_end(vargs);
 	if (rc)
 		goto out_error;
-- 
2.41.0
