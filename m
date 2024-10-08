Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235914EC59;
	Tue,  8 Oct 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397381; cv=none; b=PgMD3H9Edno9zxTrOQEajYW6BuRm3SjOt8CgCuGlEFe+MyAi31wW42urV7CzvJWDYDaLUUPnim7xBMGvGr3LFFqgaIvxi9yT8m4zWbpRM2ZpGBH23BX9+fF2Pupr+mU48oo4WJBTU7pCZU5jnGVQd3TCy++bE2LQxTrfF833IVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397381; c=relaxed/simple;
	bh=0/YnJspMX6J81VA8xxI9V7NSuLJDpJF01rZgKUpPriA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts1zqiHgIE2W9TjkBdK2P92zSC2KjemsihRw8br0/ehl9kCCiCq6LJIyQ9Rtq6jabgCidbkgz3s7hJJxR4JaW7hOcgl3bnMfnHgpuO4JkJWHMuGcHY+XD2ABqERFGYxuKwef8N05V587bdvxhOo9iZ9FphvxPqCax+jTogrsNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FgWyaZvQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FgWyaZvQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498AnfMs003643;
	Tue, 8 Oct 2024 14:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=M8JqB+WKh2j4Amcs4cgH3B1LeIF
	XSY4yAJ26NyXHtFA=; b=FgWyaZvQ16/sxO8tfAhW8uO2g6OK3uKp/+MiGq64UFh
	sXYo2/9rMkkpgqCymDA34ZMuB5Os21Rr7oVlOLSMMu/vwKjYPD8wx2t2CGXZ2keL
	An7NJuOaRyV4FA7nmg7ud+OB1GaxMADRbmOarYLE88YHJWlUCkbN3l9PSdjOOg53
	3NPk31YTiIarfs4ESVKbBVBPP3+OFZQ70UOfbKKPZewPASw8cDNP0gQcYMGlJSDd
	rkonbksL5Qv5Nys94tYO4N0Hh0CziR1GcRi9SO2/zvhgoMG6t57+PoaoZ2vZABIz
	L7goG44mXt9DpEp1o8EwX8A3cEtceCjIUR4KsK1Hz6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axsapk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:22:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498EMtoh018428;
	Tue, 8 Oct 2024 14:22:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4253axsapf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:22:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498E2iqY022848;
	Tue, 8 Oct 2024 14:22:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0vdw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:22:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 498EMob642664206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 14:22:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B81442004D;
	Tue,  8 Oct 2024 14:22:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B992004E;
	Tue,  8 Oct 2024 14:22:50 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Oct 2024 14:22:50 +0000 (GMT)
Date: Tue, 8 Oct 2024 16:22:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Antonia Jonas <antonia@toertel.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, toertel@gmail.com
Subject: Re: [PATCH] s390: Correct typo CYLCE
Message-ID: <20241008142249.27223-A-hca@linux.ibm.com>
References: <20241003115648.26188-1-antonia@toertel.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003115648.26188-1-antonia@toertel.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6MyIgrmjgZbRYCCP0hc8mNYLSmU0wYkp
X-Proofpoint-GUID: CAKCv8laFQgCmGhSjjYY0CVGNZyqlOpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_12,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=352 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080089

On Thu, Oct 03, 2024 at 01:56:40PM +0200, Antonia Jonas wrote:
> Signed-off-by: Antonia Jonas <antonia@toertel.de>
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
