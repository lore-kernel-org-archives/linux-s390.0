Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D02B9A4;
	Thu, 11 Sep 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593986; cv=none; b=kZ1eC8Z6doCs94fyaEnX6ZqhbYwr4Sn7uwPI+EDy0BMx+2KmidN8cpiiQFP6BlroXF2QERk5rnnipin0SPQsFZXM0Ot0LjtNR2bTst66ykzRkRigiXmNALKJzmaldsKXL6teJdo7xcS9IM+2JOW7TzXC5VdtWA1JKwRk5wMYvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593986; c=relaxed/simple;
	bh=y5fhpW+JuXczx2vezKEQsYz9XLWBvaZtlfoBUr9ir/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGeLfmJRgS7V3G9LedaSvDlFEl5ez91b3FvE4CsEZm06W7+W+aFlPEyzeH6yebeO0bLuI5uQhXcR2AmPza3+o2eF6q0dcbapktvP9Dzg+HH6L7T2HFJn9OTVTUTpIg9pn0JOH16X5P2vXNB3YPsgxqnsermwQgePFOPgxPudFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fabs0CNi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fabs0CNi"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBrKsA008280;
	Thu, 11 Sep 2025 12:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y5fhpW+JuXczx2vezKEQsYz9XLWBva
	ZtlfoBUr9ir/4=; b=Fabs0CNijxTV1qVzC4PIcuRwS1Ihk0qPNmNoBAtRLVR4E+
	4RSIbLdOl9hHDA5Go8mAr149cLGPTUpUZ/I/vlN+2KyRAWsfnkYFbTBbM//bGCoE
	uW7SXHQZBI2xRWuBe8PVFWOfEP7D4nez0fa+PXszr6WbmrYP1I5nU4WEJuMmRLaH
	5keL7Djej0IR8CGRA092sDCWNQmhxglyv3uxDXUE5Prq0EolNVRftVZcixoPBVKJ
	W69ks/ws4p9pWP0xHcUX4qlTo0iaHLCMmvY7ECzMEnNhISYGsy6WCT2eQGGHap0N
	gE24OdKLIh3idMwjtgQiDoTB/d9QLz43b+Y+yHVg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd9ejf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:33:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAGbqQ017227;
	Thu, 11 Sep 2025 12:33:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmnk5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 12:33:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BCWvgU37749202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 12:32:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 574462004E;
	Thu, 11 Sep 2025 12:32:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2841620040;
	Thu, 11 Sep 2025 12:32:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 12:32:57 +0000 (GMT)
Date: Thu, 11 Sep 2025 14:32:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/entry: Remove unused TIF flags
Message-ID: <b70d881e-57f4-486c-a865-0cc01e024b69-agordeev@linux.ibm.com>
References: <20250911092806.3262481-1-svens@linux.ibm.com>
 <27e149cc-ff11-4007-a0fe-5f7b0e8263c5-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e149cc-ff11-4007-a0fe-5f7b0e8263c5-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0I3msJAhSbodChec0mhy-7PPsJVcxaPQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXwXzlb0UcaZ/c
 i+ddkXJL1COwKu0ExsWwR98A7l9Z/rdYAyxMZT2UszGDo+Krp7Hy0ceCA0D/hz+U/47ZZtsTdci
 9j/Fix9qbeY2NO5Lf1tIHST3ITvyqusOUbvFPCRtXA8lMRjThI8eDBkUz30qLi7RFSUSeiRqlkC
 4E0nwD9qiWxghK2Ko9Hk7ZvAq9CLTLkMNkcQebZ18opiFaJSP45kgsmEV4KQ+sIAnUJFOjpZIlb
 0ikcqXtyD3UZsFK64Ceh9f748ozKuml6BENwh85u0yIP4i/N5Gz/ISpQBa7egsTsLrg3ANAWfDp
 GfMoESFZ5+gqsAPz76UqdRlnPZ3IlAEbkKfLqW9LRgz6idaTVeHouT1HGXMqsS9S2a6vJ5Yp6a9
 HZMfDwVI
X-Proofpoint-GUID: 0I3msJAhSbodChec0mhy-7PPsJVcxaPQ
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c2c17e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=fA-yT-I32pntzDk8QcsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Thu, Sep 11, 2025 at 02:29:39PM +0200, Alexander Gordeev wrote:
> Which branch this patch is against?

Please, ignore.
I guess, it would go via Thomas tree.

Thanks!
