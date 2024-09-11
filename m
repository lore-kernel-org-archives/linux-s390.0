Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4B80604;
	Wed, 11 Sep 2024 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037838; cv=none; b=eC6gX0BcuIYJPJgs1Hjrjg06HZMFbU6EJ9p91K1oYVyxXS4W8QoKZp5Q/aCbAs4ENZg8kvqKhwN8DtUa4Vv+FW7wGYB7drcyjkapBVdc21uKcODXI5744DzDjJ8WtFH+85rR49f6gpJtE8bKyCEK0BqXiX4zcR8PAreE6Qxad/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037838; c=relaxed/simple;
	bh=KwbSe5MGegSex065WHnBMCli6sZ2OUC5B73gXG/u18g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kre65KtrWRX2PLZU1/wszT/x5dlvL02D4C0AmgFp9mdXzuZf+A+tnFXkBzKvmxgy9p/u2BnGRJMLRxAagtRCTArOk4HQzniVOGtbelQSATjuXrvd7EGqKLxTvA4bAlqS88R98oRhjLfCLIqktoKZm/1KBQXsGg+yks88q+Lyo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TlVLKmub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TlVLKmub"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B3nAqw028262;
	Wed, 11 Sep 2024 06:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Vam5u+TSjHrdX2WEXAxU5Xb2bR6
	7UPBM3OOe/bMVBB8=; b=TlVLKmubxRTVUa24E33yLDM6KWxhuBjYCIYQhc+OWct
	FILgh7ERCgepDI75u5xUzQ6bbwBCk0Y1LVgV7EThy2r3KgMf3/gm9pkTkZM1SEJv
	imbjk3M0X29axZDo/g+1ZaRuuQJ/8CFdweLKjoq/Tgc4TYG+kTPGYJF6cohsACPI
	2P+PL9ToPOtHAX6WCDLNFhXKSMDHV7REUWvgKmML/RxVjgQF4i48rj3oBvcJWkuE
	e41G38CayK00we0E20xfF7cAE09JA7XmMCP+INf6QyB6vIEoO1/EhA1fOG+oIyDD
	OdAwK7kFm2kq12ixHkATGSTtxuu9y6dkt39HT9BjqDA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qc6k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 06:57:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B382Fa019899;
	Wed, 11 Sep 2024 06:57:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25pys2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 06:57:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B6vAKi50069976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 06:57:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E3820043;
	Wed, 11 Sep 2024 06:57:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6703520040;
	Wed, 11 Sep 2024 06:57:09 +0000 (GMT)
Received: from osiris (unknown [9.171.6.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Sep 2024 06:57:09 +0000 (GMT)
Date: Wed, 11 Sep 2024 08:57:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        fiuczy@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v2] s390/vfio-ap: Driver feature advertisement
Message-ID: <20240911065707.6563-A-hca@linux.ibm.com>
References: <20240910113440.8107-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910113440.8107-1-jjherne@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rl07UQWr0gXqg8K0Jz40mOzHfM7TDu_C
X-Proofpoint-ORIG-GUID: Rl07UQWr0gXqg8K0Jz40mOzHfM7TDu_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=450 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110048

On Tue, Sep 10, 2024 at 07:34:40AM -0400, Jason J. Herne wrote:
> Advertise features of the driver for the benefit of automated tooling
> like Libvirt and mdevctl.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> ---
>  Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>  2 files changed, 47 insertions(+)

...

> +Driver Features
> +===============
> +The vfio_ap driver exposes a sysfs file containing supported features.
> +This exists so third party tools (like Libvirt and mdevctl) can query the
> +availability of specific features.
> +
> +The features list can be found here: /sys/bus/matrix/devices/matrix/features
> +
> +Entries are \n delimited. Each entry contains a key value pair. The key is made
> +up of a combination of alphanumeric and underscore characters. The separator
> +consists of a space, a colon and then another space. The value consists of
> +alphanumeric, space, and underscore characters.
> +
> +Example:
> +cat /sys/bus/matrix/devices/matrix/features
> +flags : guest_matrix dyn ap_config
> +
> +Presently only a single field named flags is defined. It is meant to advertise a
> +list of features the driver provides. The flags fields advertises the following
> +features:

I stumbled across this only now: sysfs files are not supposed to have
several key value pairs. Actually the file(name) itself is supposed to
be the key and its contents are the value. So I would expect:

cat /sys/bus/matrix/devices/matrix/flags
guest_matrix dyn ap_config

Which is also easier to parse. Is there a good reason why this does
not follow the general approach for sysfs files?
