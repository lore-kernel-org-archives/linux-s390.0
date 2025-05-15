Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954A289353;
	Thu, 15 May 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305709; cv=none; b=do+O8ciC6dVdniFW2hpXCaLHkzs+kQo1IFSE1EF7DmbavDIZAzlbKru0aFbQoAo755lHRTsM2sj4yJAO2tMzNYg3jFQlSMqBrvF+OSjD+zouk4QxRc4+j5EEFbmbfMcSWfn3sSg9A2AJ0kp7pgb80hS7r7BQJXHEcSjJIrgwRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305709; c=relaxed/simple;
	bh=as7f2bEW46UojcmgSSs9aSH2vABUJaYN2zNdona5Hbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCppkRiIGSNriujuVFQY4bj3/Jgv+9QbspmPWpsBbU73h1GMJGune3aAHPHSlCR0SBIxZEkHmVDOI0ll9TQqddGYOHU0BAVZ9nGt8pEcaI9A8tJMF6LniVO3w4c8vkIvUzo95kbCQuukqpnsQI73jBqc3ltz5jqqSwUKlFrCHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XkQiBuHP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XkQiBuHP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F9F3gL017659;
	Thu, 15 May 2025 10:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/u6sVXUmIl0OU5rt4LugTm5/9stFbB
	2bUferjR+mw2o=; b=XkQiBuHPhhAtMRAntWSEmOzxg3OF+K2lPQyR/xajWQmU8g
	8To+vs2el39XEiHidryFS+LYw8sZbwduyeFS1yZ3Gr05DRtKX2pp+Gmjs1O29Sd1
	ywiA8XSVGOOvYsi4QxyXT6/0lgSspnDHPf9JKtQ8PPMe5TGxdOn/KNuR+pIoQNlO
	4iWC76mc1U1GkNbdUooGpLqCE2e6gOmhcWljSPvFTmAssgK8BKJ9j2PzBFC+/NPz
	EysCI9xjJgsocmk+rjMiKMLJJAeYRKmxV99JDtRkDuJYBBWeWioIRHOgB2TkMHiu
	9wID74IIIDOb68bEEiGE0uiOXJ6eohUya62a2zqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjrcg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:41:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FAfddN013212;
	Thu, 15 May 2025 10:41:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjrcg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:41:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7F2G3021396;
	Thu, 15 May 2025 10:41:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrsp0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:41:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54FAfaHG58786254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 10:41:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B053820071;
	Thu, 15 May 2025 10:41:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE092004D;
	Thu, 15 May 2025 10:41:27 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 May 2025 10:41:27 +0000 (GMT)
Date: Thu, 15 May 2025 12:41:26 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Axtens <dja@axtens.net>,
        Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 0/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aCXE1p4+AiYhGAuV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1747149155.git.agordeev@linux.ibm.com>
 <53a86990-0aa5-4816-a252-43287f3451b8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a86990-0aa5-4816-a252-43287f3451b8@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dzjBTB1YXB_GH0AY4aIS8luY9AuQsR1r
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=6825c4e3 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=c33pmkp9q3dSwcthHBMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: eLYookaplGgxG-G1m8c7YaaHlMPNOwHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEwNCBTYWx0ZWRfXxJAAEzW9p62n eD0G3GXOh/v1Rdf6Tztkey5ALI1/qRAnIJOP/FnPMyDC2GVfQ7ZSXzO/adPnbR/GjqzUsyjJL5f bexw/87v0sS0Rjounzdo4P5zO906eIqq4pa46Dgr9RTyDm6iDVljI7a++lEclNZHoLX8HJr6Q41
 fCuHfMftHJPXRszy0B1DuwAPG+8VpkE2zVQQHM0VA0gEqb0sngRK3UjKoz3i7YgM5mr24PYF8aZ JfdbgXx69HalthV3AunVbN74Amv+aXo6ZI/krhACzd2f2YQr2OEIwrW/scs40CABp9Hv1g6CjTC dX/Z0bDYtSSMf/fb3zb2Z/rTtoLZVEhJgXOquXpk0ww7tgTWlCTeLAKd55GKBjlr67n/VcceMMM
 k5HC4K1hpEK2UNQMEiop5JficUKNKypkQSEETGISYmW4Sod/lzXv/XjNoaabrXGBXy0CAIh/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_04,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=376
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150104

On Tue, May 13, 2025 at 06:43:56PM +0200, Andrey Ryabinin wrote:
> Have you looked at boot failure report from kernel test robot ?
> https://lkml.kernel.org/r/202505121313.806a632c-lkp@intel.com
> 
> I think the report is for v6 version, but I don't see evidence that it was
> addressed, so the v8 is probably affected as well?

Yes. The problem is page_owner=on prevents bulk allcations.
I will send an updated version.

Thanks!
