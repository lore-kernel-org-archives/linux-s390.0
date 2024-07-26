Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E56168C7;
	Fri, 26 Jul 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007672; cv=none; b=DvKzEM8FaGPTWkjmd3yB5S9cKhIgvSgGlZsCvkYrMR2JzAD3HOa/D8rSx+q2l2yU+fjbzKbS1csBkNsTdMZ3k7kz9Be5b79p2jTQtma9r1GwgAX3eSloyoqydN8qP6vQyUvTm5y0RoR6vb+jOGcbsuAjQhdBbSCfIFzWDYl/jLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007672; c=relaxed/simple;
	bh=8bTNXc6ovszIgZOR8BUtR+RKoSwDzMh4FD3iphz25Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGM96HuF1z4ewZc8mPLAt+2PBk7M+Q5VES88BLTvsFRBzSoZ8qbeGL+RQuS3XLqNnG/et1+E5UaFAbFu4MbnQjkClfL8jTDiaYoQx7tMQJoHh72WPIEINyLyPttglcWtSYx/tFRHBcEZH+pPxAb5EtwBKsnrZpXkgNL3OllLYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7+zhrTf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7+zhrTf"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46QCUKfv004316;
	Fri, 26 Jul 2024 15:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=3bEacIXJ2MJjpxAm77pct0R0tpg
	c+ozmiPAknjEot2A=; b=L7+zhrTfbUt63DlO3S264RlqdR5+WZTKcCKQkGZ6OYa
	kbVTv7qd9uiMN8zs0FoEGKQB1UMMvSBXtORvlSLpEINhkYk5CgV3L2jku4deDJz2
	D4ASiDLvurASfZ4HWVzh50EwyvsB1ZS5JvltsseAAK97BTf4XNwHPTH/LhXcVWN5
	xg8rb+YrLSFtpZt/ntm+G7UC+fDFCZZH1DZFVywTVBciz1iLVfb/azReIqZmqOQ7
	xM9lehVwcrHJTqXhyFACroefH/o5K1DRuH/3svNpcS6KFWXbCxh7PIkJk65HIfOK
	ZmOJ2IFhs+kNuAwQHyR78dFVScMKfYjAdEstFiWueZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mbuj8gec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 15:27:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46QDKgGB007084;
	Fri, 26 Jul 2024 15:27:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx733wnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 15:27:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46QFRYjm43712946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 15:27:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B94D820049;
	Fri, 26 Jul 2024 15:27:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D1DD20040;
	Fri, 26 Jul 2024 15:27:34 +0000 (GMT)
Received: from osiris (unknown [9.179.0.168])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Jul 2024 15:27:34 +0000 (GMT)
Date: Fri, 26 Jul 2024 17:27:32 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] more s390 updates for 6.11 merge window
Message-ID: <20240726152732.24764-B-hca@linux.ibm.com>
References: <your-ad-here.call-01722003454-ext-3193@work.hours>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01722003454-ext-3193@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rxs0Jm2aqqMlDepQN1kkKwvT5etbFYtE
X-Proofpoint-GUID: Rxs0Jm2aqqMlDepQN1kkKwvT5etbFYtE
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=566
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260104

On Fri, Jul 26, 2024 at 04:17:34PM +0200, Vasily Gorbik wrote:
> Hello Linus,
> 
> please pull more s390 updates for 6.11 merge window.
> 
> Thank you,
> Vasily
> 
> The following changes since commit 66ebbdfdeb093e097399b1883390079cd4c3022b:
> 
>   Merge tag 'irq-msi-2024-07-22' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-07-22 14:02:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.11-2
> 
> for you to fetch changes up to 6dc2e98d5f1de162d1777aee97e59d75d70d07c5:
> 
>   s390: Remove protvirt and kvm config guards for uv code (2024-07-23 16:02:33 +0200)

...

>  arch/s390/kernel/alternative.h                  |   0
...
>  create mode 100644 arch/s390/kernel/alternative.h

Somehow an unused empty file managed to sneak in and survive reviews.
We will remove this file with the next pull request again.
