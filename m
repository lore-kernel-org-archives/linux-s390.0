Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDD156CF;
	Mon, 16 Sep 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490326; cv=none; b=vDZzePnexTgLuiBOZ+ftR+6aaKdSMmD4uEqaWwpyzNGmZOVQNWURzGkADsuwZrCILhuEjvypuAIubROHehXOTgBnzbPUZYZxcS3UPyLudsCrM+0dKsEV2PbbRCFhkEpSoZiN69Ar/RKV5n/EPf4gPA/u7Ex4qQ+i09YMC8ukxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490326; c=relaxed/simple;
	bh=NmfAQOXEE3dO0eUHDUy5kfZ+WO/TyDCpnReMbW6JAW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9sjKhldUDUz/QyspysmYgVqdPpGPUiWZMX0B8bKbz6OSMNAdRYYjo0dHjjkdaJs9i5zrGwWXwqmS/GHauldMme/NbNenp17sktcwVh4zi3qIx/0JWsWwEO4jKSSow51YErvaIkZB3eFkaMiOhye9rgNvzplyBWuRogZBDO3aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHixEdyM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHixEdyM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCb7to031645;
	Mon, 16 Sep 2024 12:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=q68QjCWRIuBYRlwPIFB86bdXXFD
	lw3nA02qr7DSKKZM=; b=FHixEdyM3ifbQnQKjaOQnKoCJ0CpQa8Aid6r2Qt3Ero
	3L7zQwynHPEICHeaZfYfeRFwjetT7aaLJe9lGFNVQQYQY9aCGyZcHJD4G7r199z+
	993DJn47QYqRu81ls/WtrOH2wE/TFzOGAQYteh+vebrzNMZBVSnORZ7cgpQt6S4K
	QAXjJaCG0Qxn0bYB1lbGByh1r1wvFnx09/FVwFW/O00gQ1gMhZXizO0cHxB46eSO
	rbrLPHgA7pfW4EhG+iaVDz8bHc6qhqNl4V1UzspfgDg+7so1wt1PMpv6mbHN3/Qj
	dVUJJCdWZ7VPz8NucWKy5YEIsvqaTtbznA+CyAcd93A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj1x6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:38:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GAjO36001905;
	Mon, 16 Sep 2024 12:38:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtufmum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 12:38:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GCcc5117170690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 12:38:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 591512004B;
	Mon, 16 Sep 2024 12:38:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC43E20043;
	Mon, 16 Sep 2024 12:38:37 +0000 (GMT)
Received: from osiris (unknown [9.171.58.79])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 12:38:37 +0000 (GMT)
Date: Mon, 16 Sep 2024 14:38:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        fiuczy@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v3] s390/vfio-ap: Driver feature advertisement
Message-ID: <20240916123836.20933-C-hca@linux.ibm.com>
References: <20240916120123.11484-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916120123.11484-1-jjherne@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pMjDZsboRXQxuH2_zbqwFpCtEeOUHEoy
X-Proofpoint-GUID: pMjDZsboRXQxuH2_zbqwFpCtEeOUHEoy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_08,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=568 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160077

On Mon, Sep 16, 2024 at 08:01:23AM -0400, Jason J. Herne wrote:
> Advertise features of the driver for the benefit of automated tooling
> like Libvirt and mdevctl.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 30 +++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++++
>  2 files changed, 43 insertions(+)

Applied, thanks!
