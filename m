Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647424B26;
	Wed,  6 Nov 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884461; cv=none; b=gY8mU2zmP/xHdCEYNCSIXjNhy3wPJoLLkjKsxrQ3t60ilfHRKmEgqDsJYEqeISRr+yBIO8pLjVddFMf4lG0+b33NGAVJ7XdnZPy8xJzKLrKvSdv76dCGReBGAm2h6pq2KrcwAO+yxCiWsx/VVT87iUkZ8JZbnICzYSKgNJT5eek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884461; c=relaxed/simple;
	bh=5WMMMuBI6TaqFmg1xL+ZkasoDgh6qnlv4Z5Tze14V80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0vF1Kia4peEKr+YLnujWF16mjDezitte8DwlCONXHZMFXWApfNaQovFof6CxmE1KuuWBNWGf3sO9r89R+2rXDu9XS6OIx830M2toJSoux1j4sKhubmL4Nykiuw74alckIZ5XYFMmsbQJ1V+C109+9QY7Q4QDuKP4VZOjIpTwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X2fG2MLD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X2fG2MLD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A699rv1028007;
	Wed, 6 Nov 2024 09:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ozs9IAlbCsa6gS6g9uSm31LBb7hVMq
	y7jEmcZPcprdU=; b=X2fG2MLDZcZK0+HE4ZsjqTnY78e7iUk4Czc9GJBU3pPyWj
	NrBYfO/zmO5mOhZSycq+T/jEQ+i4HEgCbFdo96lgdlqX7RdjPXT3vp4PFkbwwQsZ
	FXYPSsXC/ah9p3G36CfkAqb/SwhTsXnmTxLDRtN5b1U8lVXKNVdyDht/X0yjFRz2
	f0wIvhFlONAzKDJQYjs++J2FWIBNCYLuJZxv8pwug/sr/kgl1kn8q020LRxCbw7P
	l32wFKn682R+LE2+vJdutL0K5JHaYNM6iIF0wgKEn1YR+kxIPkqrCLeAy3v4O5GI
	Jm70Va/qaZlsOENvdzuymNTUigOYkLFQDavlvYUA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r5k380d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:14:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A665mrL013158;
	Wed, 6 Nov 2024 09:14:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140wsga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:14:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A69EEq018809336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 09:14:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DB0320043;
	Wed,  6 Nov 2024 09:14:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B20B20040;
	Wed,  6 Nov 2024 09:14:13 +0000 (GMT)
Received: from osiris (unknown [9.171.89.178])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 09:14:13 +0000 (GMT)
Date: Wed, 6 Nov 2024 10:13:45 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Ingo Franzki <ifranzki@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com
Subject: Re: [PATCH v3] s390/uvdevice: Support longer secret lists
Message-ID: <20241106091345.16507-B-hca@linux.ibm.com>
References: <20241104153609.1361388-1-seiden@linux.ibm.com>
 <20241106081004.16507-A-hca@linux.ibm.com>
 <a74cfc12-f404-47ca-85a8-164da22bdbfc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74cfc12-f404-47ca-85a8-164da22bdbfc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wOrLnhMjQ9dUQ5Xw2VI_4d4nDLgW9GuA
X-Proofpoint-GUID: wOrLnhMjQ9dUQ5Xw2VI_4d4nDLgW9GuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=461 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060073

On Wed, Nov 06, 2024 at 09:54:33AM +0100, Janosch Frank wrote:
> On 11/6/24 9:10 AM, Heiko Carstens wrote:
> > On Mon, Nov 04, 2024 at 04:36:09PM +0100, Steffen Eiden wrote:
> > > +		copy_len = sizeof(list->secrets[0]) * list->num_secr_stored;
> > > +		WARN_ON(copy_len > sizeof(list->secrets));
> > 
> > Is this really possible? Without checking the documentation I guess
> > this is not possible and therefore the WARN_ON() should be removed.
> > 
> 
> This happening requires a FW error, no?
> list->num_secr_stored is reported by FW and would need to be >85.
> 
> We could clamp it down to 85 secrets / 4k - sizeof(header) with a
> WARN_ON_ONCE() to catch FW problems if that suits you more.

If this would be an *error* why even add this check? We have tons of
code without doing sanity checks for firmware provided values - where
should we start or end?

So imho: either remove this check if this would be firmware error,
unless there is a good reason do keep this check, or if this is not an
error convert to WARN_ON_ONCE() and limit the copy_to_user().
