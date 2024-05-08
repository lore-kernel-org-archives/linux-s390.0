Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF93FE28;
	Wed,  8 May 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158770; cv=none; b=WJCB0m2ucEiLo4snZr9E+EBt5OdlvM/2BttCW14sQLqbWFhx7KH2Rm5KIVhJeVKYVlk6PPnUdHgKkWP29bBeP3VF0UV6atQ0ZQMd51hggOLoHX9MIXv+CTpTTzTtkVog1eSZYFH7kzQ7KyLV+zgVDO8Pc7+GWbnDCmNR5KxUw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158770; c=relaxed/simple;
	bh=0MZ0tjV7Ul6KSUNGIxLPXQPbF3k0DLBFg+YhzVaM3Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miyOb9qxRL2LnnJ034dxSYLwAQQfoB3ZYt9Je+TBvTmjK3OCCaGmcVa5jyWGRGJ3Y0eWDWKoOfsqLxFEst5ahv6lBLxnWOm6D0M+vjKUGJBUY70lgi+DPOC2u2SiDr+wQkOiW8e5H8qgl0txd7On1syJxnIyXxTJ2ggNF0wxw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dtHwmsaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dtHwmsaj"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4487f8Fn017224;
	Wed, 8 May 2024 08:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1Dg5GtNVQMK0o06UcR8VpHfUXdZTBwFRjHAqvfq3x1I=;
 b=dtHwmsajJR8FqMbJnGvQzN7l68rWK7dhO6nkXkK0MgarF1139dwUgai5I4WrHAKxwjR+
 NzaxwCXlblMKVM8i7We6b6YfQ0LcojtG//VQb+l+fh+7CiJ5ZS4PWM11erJJ1VOUUyZq
 6xHQKNTLOX4u1HK5bOzzfJcHVl6N24JS+u238CvRTGwh+2HMrIYggG5Fs7soobz2PTC+
 h9rkrFXC30ShGUclgHDk5yHSSVEmkvXIc37m2wydRTwg86bwbNCtBhPda2oUjhRFMgh2
 6/Wb8j3XzipyekLZ1zLsgqtqxJAR0C0W3GQxgox+HuqJe2QRxjI6E7opMLfyBIEky/kH 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y04qxr9kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:59:28 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4488xRjZ012582;
	Wed, 8 May 2024 08:59:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y04qxr9k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:59:27 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44886PaH017627;
	Wed, 8 May 2024 08:59:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xyshsuqec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 08:59:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4488xLpo54591766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 08:59:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DABB2004B;
	Wed,  8 May 2024 08:59:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BCD320040;
	Wed,  8 May 2024 08:59:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 May 2024 08:59:21 +0000 (GMT)
Date: Wed, 8 May 2024 10:59:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Jules Irenge <jbi.octave@gmail.com>, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, agordeev@linux.ibm.com,
        freude@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] s390/pkey: use kfree_sensitive() to fix Coccinelle
 warnings
Message-ID: <20240508085919.6522-A-hca@linux.ibm.com>
References: <ZjqZkNi_JUJu73Rg@octinomon.home>
 <5eea6875-e106-47f5-bee6-ce089b1213df@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eea6875-e106-47f5-bee6-ce089b1213df@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fdUt7adMf_sUwJSSMOYCCPRFNFTVBf2q
X-Proofpoint-ORIG-GUID: OqCJYUCUbm4dph_6srhHCiiY_UDU8f96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=450
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080063

On Wed, May 08, 2024 at 07:53:28AM +0200, Holger Dengler wrote:
> On 07/05/2024 23:13, Jules Irenge wrote:
> > Replace memzero_explicit() and kfree() with kfree_sentive() to fix
> > warnings reported by Coccinelle
> > 
> > WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
> > WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
> > WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> 
> Thanks, looks good to me.
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

Applied, thanks!
