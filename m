Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E57D413;
	Tue,  9 Apr 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650718; cv=none; b=XiE4DJLSiAZomiKNBvmVEfCEASGkBNreGsm2IqbRTt5Wmhr0xK7keeC7fjh3o5zKLm1ntZ2kMucQtuk7ByrMV3g/cGiUgPZjiSmY2im7HHPKxO8R9fU5FO3mLEInosm9kTYtyvxecYVZxlIiee2glYBcLNsJdqy7gzw58T9+cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650718; c=relaxed/simple;
	bh=l1v5E5H/ARIMqBmXKs16oujyTTKBZGMxBIN6eAzCkPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0XpDqk6UFD44HUelHHVsYHXxPAFRg1iZgKfY58ogg13fyHnxaPES2BFt5a2O3+kkAFSFODMVXA327cxfS/X7PMzaOhaz59rttRD9VDZm1i6iMls41EV42hps4EXVUubTlffHIn+ARONidAIkwClECRNHIW1skt5StepoCUoUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jIHd9F1X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jIHd9F1X"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4397gGCe031808;
	Tue, 9 Apr 2024 08:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=l1v5E5H/ARIMqBmXKs16oujyTTKBZGMxBIN6eAzCkPc=;
 b=jIHd9F1XFssyD+zDjvpAYRt2/CTHeiBJY1OSrs/9Cl1CNgPnoSO0gDx0CVar5ONlN5JW
 y0KImKkok3e3flS1zChyAMD7u37UoU2u64EM+fq1q+QIcpd770zforCJBr12/p0/u4Mi
 kk7cEu6dHDOwdT4c001iHlJMdPQxZS8Hw7FR5TensGrHbd/0znNlE1K1ht6cGQgGCnHa
 9xMMwW2UwurPJIweUUXyhYfwsP4gluOjBkJ6QKlKFMpCwlpCHkbJGP/VzrR05RK48vmE
 O9UYj2thsOxzSb5pC26NvOP3cWfwfpUuJVc0xSXNLJGs3KuWOm12pFeRdPokY2LiTyWS 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd1h0r25x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:18:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4398INf8030730;
	Tue, 9 Apr 2024 08:18:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd1h0r25r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:18:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4395mFSm029951;
	Tue, 9 Apr 2024 07:59:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7m4tpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 07:59:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4397wvjF54722858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 07:58:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22E132004B;
	Tue,  9 Apr 2024 07:58:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7187820040;
	Tue,  9 Apr 2024 07:58:56 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 07:58:56 +0000 (GMT)
Message-ID: <fbf1d5a4bfd77c6eac64669dba67f58cfd8c3f8a.camel@linux.ibm.com>
Subject: Re: [PATCH net v2] s390/ism: fix receive message buffer allocation
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        "David S.Miller"
	 <davem@davemloft.net>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, pabeni@redhat.com,
        hch@lst.de, pasic@linux.ibm.com, wenjia@linux.ibm.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Date: Tue, 09 Apr 2024 09:58:52 +0200
In-Reply-To: <20240408124609.4ca811f2@kernel.org>
References: <20240405111606.1785928-1-gbayer@linux.ibm.com>
	 <171257402789.26748.7616466981510318816.git-patchwork-notify@kernel.org>
	 <87cfb39893b0e38164e8f3014089c2bb5a79d63f.camel@linux.ibm.com>
	 <7e6baff2338ef4c3af9073c46b5492f271bdd9ae.camel@linux.ibm.com>
	 <20240408124609.4ca811f2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PbVInA8_1VS3A-wzmWkht-vzE2mfB724
X-Proofpoint-ORIG-GUID: ra2FIbrB45c2FDdsliPvx_DnOUx8phwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_05,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=614 bulkscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404090052

On Mon, 2024-04-08 at 12:46 -0700, Jakub Kicinski wrote:
> On Mon, 08 Apr 2024 21:05:47 +0200 Gerd Bayer wrote:
> > Hi Dave,
>=20
> Hi, from the Dave replacement service.

Hi Jakub,

> If there's a chance we can get an incremental fix ready to merge by
> Wednesday morning, let's try that. If we fail please post a revert by
> Wednesday morning. On Thu morning EU time we'll ship the fixes to
> Linus, so we gotta have the tree in a good share at that point.

I'm preparing a revert right now, as I'm not sure the review is at the
bottom of things, yet.

Thanks,
Gerd

