Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABA86329
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377043; cv=none; b=JpMq1vtbBwkff9Zs4osYmJVN3ruGX2doG7YnkiNNEbiHJ6xdlx4hisDawLTk906c0k981D989M0aTK5uYpg+WUrFUi9sqqgoxTZR2LW7eLQwe4bentIcMweP6IVOMKQ9AutWCQJzW1+rwX7HackeQq2Jv52I2R53a8iOVS2GRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377043; c=relaxed/simple;
	bh=hLOeKPNWoP6jiGbNvSV9CMoQQq1sNHOuf5J81A8t3Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuyP6/FmYZtWYF9CQFnR9JHorIbL2FLNDswmTi+ppsVxj5AEgV+rXdN9dCMCD5GzcUUfAk1e+I3WtIOfN0S9q6MdIN48x5g48FadAmNEuqT8Zo7R8D8znfnIkfaDf4CoTZ8Znnubm/kGHk0QYjo253l7niFBvUjpSUrL995ZQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PQbcUgdp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PQbcUgdp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8xtXV016316;
	Fri, 11 Apr 2025 13:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yn+wdr
	GulE5gb2JoCAjpEcDdTMkF5U4hAnQIl0O03UI=; b=PQbcUgdp3ytrWmZu4ncJjy
	8f7N/PTNpgL72KWX20fHjKj1c5jJc8KDHQpq9KUprUooPtNTJH7RXpYfxdzLeXZG
	xnfhsac0X/0WxXWIBgSu/q9xaph2lp3l6mFdNr8yVcppyJk6RimuOQEDpZ7Yh3wn
	7qPB56iwND8mWoDNHko/xL/5mtoRMBcamHy5s52gzj+MK5RQR/X8frgyEnefbiqi
	CjX26GieFZtxVT3NQDEtvxDcS4n7WG3xJgsKFkJKZuYb8CC1Q/0aNtwh71077ERX
	SZZwMhsQ6Wsy6C1YmLT3CGj/aI8HdFAkPa8dEQzA5sr5SvDohVjTT504Nc/XsSsQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn5qkmkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:10:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAfxuI018432;
	Fri, 11 Apr 2025 13:10:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m2wnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:10:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BDAZjq31588968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:10:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1411220040;
	Fri, 11 Apr 2025 13:10:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68D9920043;
	Fri, 11 Apr 2025 13:10:34 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 13:10:34 +0000 (GMT)
Message-ID: <34d5526f-2206-4330-9eab-3e156fe51be2@linux.ibm.com>
Date: Fri, 11 Apr 2025 15:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/24] s390/zcrypt: Remove unused functions from cca
 misc
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-12-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-12-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GW7-uhLc1-wj1UKIZY08aZdbQzsYeKeJ
X-Proofpoint-GUID: GW7-uhLc1-wj1UKIZY08aZdbQzsYeKeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=957
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110083

On 09/04/2025 16:02, Harald Freudenberger wrote:
> The static function findcard() and the zcrypt cca_findcard()
> function are both not used any more. Remove this outdated
> code and an internal function only called by these.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

