Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241A20F08E;
	Mon,  8 Sep 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332241; cv=none; b=iL3RH5qrEEYPwa4pI29uamsmc2PXXGWaNs8j/jmHemd19jc9Rom8vRcXHlsfszLlNOZcuXSv6NOfQ/BTu1E5HAqCfmHiehiWnBTEQY/22HHcmDzI0+FtQRbhigTD+tDQfkBuyFNFTT5DCK1Vhj557ExYyuumJ9SkkyXcTQdLQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332241; c=relaxed/simple;
	bh=irYDIDTrzVZh6Sn9PiCfVrD/5XOw83F/P6HYBcbAzL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJgB2/ofm07Zs1b9r0MGX2/byhnQmizae8ej6HdxdVOf44zvqm8Nzxy01n2+aTJWIYZEg8ONb9eoZb13gX71tMr3fxsYKEJ7Tn1Nfob2pf/zIHiVsu2Ied/2YF5CT+EsrZftHbGg0adej06J96aXfFDoj6kpU8/m04HZDI0NG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SktIU6Kq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SktIU6Kq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880QJHL026934;
	Mon, 8 Sep 2025 11:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sssUFozWvogRSQf1i9QRZEmsQgeBeL
	Uk0jUvyE3BsBY=; b=SktIU6KqoCZK0Pja1ywrZV3i6AxGmK4NHvlUmyosKIZ7Jr
	5XyPDwHX+DKtKmRXxAk6uCsVPmyL18miGcT+tjQ+NiDfOAynZqls2WkWSgwNPnAb
	UHhzKius1ywVpB8tmuBzE7XQ1T5djU1gptkjoTLF7hfmJqCYRflepXtjrqd/XU+n
	CeEJkigBUrZrqDzkEuLKOZkUKv/2NEfN5k+vnx4NeGISZ+NoXxigiF5M3al+37nG
	5VHdmQWR0vn7oKSaSrEsLkOEmv3WWL4U85lTE+N5yraSf7DOx+kKqZ+eeBbbq9Jk
	xt+Oos0ZDLnASD20KF+8OjBsDnYc4iyHDjFkYvOg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwh3fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:50:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5889Iu04008428;
	Mon, 8 Sep 2025 11:50:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pdwk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 11:50:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588BoSER20709648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 11:50:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4D82004E;
	Mon,  8 Sep 2025 11:50:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4794020043;
	Mon,  8 Sep 2025 11:50:28 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Sep 2025 11:50:28 +0000 (GMT)
Date: Mon, 8 Sep 2025 13:50:27 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/hmcdrv: Replace kmalloc() + copy_from_user() with
 memdup_user_nul()
Message-ID: <90bd7438-f683-4b1f-b798-1fe7cdb0eab2-agordeev@linux.ibm.com>
References: <20250905110226.485009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905110226.485009-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wdmeKZF2enW1wevKYDXUcCbwCI2MN2jX
X-Proofpoint-ORIG-GUID: wdmeKZF2enW1wevKYDXUcCbwCI2MN2jX
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bec309 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=veLL925k-gW0ypMPMRAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXy/BOeUlUoxXk
 idw2pE9Yr7eRg5N3DhIVYXc3crk9jTU0ZDvk0LVfRGoHg+fHwDqvPtm7o6CitiTPmgvIm+uKekU
 hvnXDOB386L7G25fpg14wLjO/WdfbYae/kHKR61wU5Ba5MDdkS5Z7eIUilRcb+TMS6l4Xc6W0vi
 pqu3ryI038V0UerLtKzuToa934wVb854GR5e3PqXQGP7IUB3ur8KWOwLfuyD0myzhDCtZHaNGjU
 hLQbK9CT9ZYaOOvsSVST/t6nj3w+uWmlQ40MnjnN823dkgmr5Gs3CS/B/gHwraS2J5GeYn7IC6Y
 abwspAETEjSXMMm7coXpRW/f1pptH2BPUqAKWeo4OWvrYvcIrcwI703WvpfmOhfVvnz4Tp+HFPy
 M+Y+KSTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Fri, Sep 05, 2025 at 01:02:23PM +0200, Thorsten Blum wrote:
> Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
> improve and simplify hmcdrv_dev_write(). Remove the manual
> NUL-termination.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/s390/char/hmcdrv_dev.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Applied, thanks!
