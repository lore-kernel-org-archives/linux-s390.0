Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B04235359;
	Mon, 17 Feb 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816737; cv=none; b=RoS7viI1sKtUoctOH7Qb1XTEeLxZiJnXLa8RDjlDCYiX90QX+imh2AdQjelz2Nkl9bxcd4DZXsosGNRG/oBrCr7UxkgUXefQWWFaDypJhVxTV0WTbTfkIu7G+Lj5HxxLRIXNHTXsXvLvjql5jplSJY2Dq7tU5cwNx42b/Xa18XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816737; c=relaxed/simple;
	bh=5khgD35fjPwEHUWM6/Tc1Rdzv1qWoYBP4oYEhlwM75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnLi3W2DgafaCPr5yrRSiwQyL+MJAxsTb8GMsyDHRB57RwbIFeR7dORcHBxIPvTEyZk4HVxa1sDSQNIelDrdmLrrceQLPWh2FupqPlsro2blr58RKGtQqYN4mDEt4em+g+rfbAOi/LVMuktT29eqUaGe1wH9ZSIYj+gs5ufz8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aqfLbHSZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aqfLbHSZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCNVbt030844;
	Mon, 17 Feb 2025 18:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zqBWVLibSN2BnE1MhuGrsYhIzK+bPL
	ENN2DgCYa3zGI=; b=aqfLbHSZ05m12NX0QHqoj2JANDUFRzv2NtiD1jKyEUvg6+
	f6ISN7Y2PSuDY793sEWcDRZ0Zh9zw2SYTCEli0IDzPFXwwXo3pqdwg8iRmGTL5BT
	p+mp6kAcCVAcwpnPfcoaQcArQnHMap4mfYPj8Aemyl+EOkVegeGfoaEJZ7Spm16c
	pIWG4Ks0vRBrnzVzJRoU3iZbpKpfp1+0M9MVMGbNT3hqqbxHq6izSgBozhXyfetv
	MIGqKVWH/PHvha4BRd9/eT2YX2N1skGscTUzSC35VN7uVmswsYVp/fMx3kBkQd7N
	8PnaunHTLsUEZwQUsUKqP6QdEUS5S+UtB5vhW37g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a506f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 18:25:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HIObQ7014538;
	Mon, 17 Feb 2025 18:25:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44us5a506d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 18:25:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51HGFOkL008133;
	Mon, 17 Feb 2025 18:25:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58tfjwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 18:25:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HIPKCM40108400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 18:25:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C9020043;
	Mon, 17 Feb 2025 18:25:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB0C20040;
	Mon, 17 Feb 2025 18:25:19 +0000 (GMT)
Received: from localhost (unknown [9.179.20.129])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 17 Feb 2025 18:25:19 +0000 (GMT)
Date: Mon, 17 Feb 2025 19:25:18 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, kernel test robot <lkp@intel.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/purgatory: Use -D__DISABLE_EXPORTS
Message-ID: <your-ad-here.call-01739816718-ext-0992@work.hours>
References: <20250213211614.3537605-2-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213211614.3537605-2-samitolvanen@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ULpRvCYuDWIoWXxio4zaoQsMVRNwQ262
X-Proofpoint-GUID: HUYvxhw7rzp0YxDkpSZyF3zHGveGiFl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=368 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170143

On Thu, Feb 13, 2025 at 09:16:14PM +0000, Sami Tolvanen wrote:
> The object files in purgatory do not export symbols, so disable exports
> for all the object files, not only sha256.o, with -D__DISABLE_EXPORTS.
> 
> This fixes a build failure with CONFIG_GENDWARFKSYMS, where we would
> otherwise attempt to calculate symbol versions for purgatory objects and
> fail because they're not built with debugging information:
> 
> error: gendwarfksyms: process_module: dwarf_get_units failed: no debugging information?
> make[5]: *** [../scripts/Makefile.build:207: arch/s390/purgatory/string.o] Error 1
> make[5]: *** Deleting file 'arch/s390/purgatory/string.o'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502120752.U3fOKScQ-lkp@intel.com/
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/s390/purgatory/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thank you!
