Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CE22EED;
	Wed, 19 Jun 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837101; cv=none; b=tJsBHmv03zqUnHiRn/rU4X8FbcGAOi1uXBGA5ZPpaN1lgTA6AIKF5N0XAY9U6rwYDes5QA/06fDm+j77xSYlHHYYJe7fzicZgrnDAEetTX1FKDI9+FA1qTEVX+maumajGIj93hZgLgtjMy++6NPbBHfi15tQRqsWNKfQtpmO9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837101; c=relaxed/simple;
	bh=/9DsANoZpMIhEUvgy0ycyZC6LYEPxPq1b6mAqevwi3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+8nda70RZmZdTudH6i3+EoB7nPSdiccqLcEBCFL6XKzHYbNbspaivm6NxG8WYdc0KeNyTWrFQ8MCrDcbqWxdPhrsIAKywANri1AkAGO+NgVIC3iRuN3fnWn1ikBJjFio61uiLK8XOdmMt04MksimDpQ4I6MwNsaQxcqp7AWzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SEvQfVss; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SEvQfVss"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMStEG019644;
	Wed, 19 Jun 2024 22:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ypt6vFRUdg9HZFZ3BpzTkTt7m6T
	qWiwi+NRN8b+/aKY=; b=SEvQfVssLcPI/ZiDVdCfDhpJcAoL9MelTIMgIoOZMhl
	sEyo45PONXCcCJkiHldia9XiKbai2+lbCy3oL+E6EAHyDudeYdX+Wic5PKPGdvsL
	Xf4FzHGeppp1rxgk+SMSLnIlxw7sx0iUwCagLVBtYaWtx4bRdhBKWFglriOqGwl3
	pHcgjFxlG4JyozFq/SeJZ0W0BoJurBUg9GBNY0sPgyQP/n7oE7Ut0xSz6MobRjrR
	+h+ZOBrHSWx2sEyBkc5aYz1epLtH0ry3MPe5zuqIzcxlT8Xwsj+Zv3jl0yJPKbtG
	EMLtSNLKTVIqo7qDrDo6oXoAyI+fzDGZ6w9sF5p4r0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85cg15t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:44:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JKK3Om013477;
	Wed, 19 Jun 2024 22:44:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysr040bhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:44:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMipuD56426850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:44:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D0420043;
	Wed, 19 Jun 2024 22:44:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2021F20040;
	Wed, 19 Jun 2024 22:44:51 +0000 (GMT)
Received: from localhost (unknown [9.171.70.82])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 22:44:51 +0000 (GMT)
Date: Thu, 20 Jun 2024 00:44:49 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] s390/mm: add missing MODULE_DESCRIPTION() macro
Message-ID: <your-ad-here.call-01718837089-ext-7336@work.hours>
References: <20240615-md-s390-arch-s390-mm-v1-1-a360eed8c7c3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240615-md-s390-arch-s390-mm-v1-1-a360eed8c7c3@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: brJp8o4brIA6ndCo3vN0beNJ9gDiU1Kg
X-Proofpoint-GUID: brJp8o4brIA6ndCo3vN0beNJ9gDiU1Kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 mlxlogscore=707
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190169

On Sat, Jun 15, 2024 at 06:23:21PM -0700, Jeff Johnson wrote:
> With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/mm/cmm.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  arch/s390/mm/cmm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!
